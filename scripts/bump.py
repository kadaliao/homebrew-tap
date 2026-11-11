#!/usr/bin/env python3
"""把 Formula/ 和 Casks/ 里的软件追到 GitHub 上的最新 Release。

只用标准库。对每个 .rb：
  1. 从 url 里认出上游仓库（github.com/<owner>/<repo>/releases/download/...）和当前版本；
  2. 查 releases/latest（跳过草稿和预发布，和 livecheck 的 github_latest 一致）；
  3. 有新版就只替换 version / url 里的版本号，再下载每个产物重算 sha256，
     其余内容（注释、格式）原样不动。

用法：
  scripts/bump.py            检查并改写文件
  scripts/bump.py --dry-run  只报告哪些过期
  scripts/bump.py --check-readme  检查 README 是否列全了所有 Formula/Cask
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import sys
import urllib.error
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
REPO_RE = re.compile(r"github\.com/([^/]+)/([^/]+)/releases/download/")
URL_RE = re.compile(r'^(\s*)url "([^"]+)"', re.M)
VERSION_RE = re.compile(r'^\s*version "([^"]+)"', re.M)
SHA_LINE_RE = re.compile(r"^\s*sha256\b")


def http(url: str, accept: str = "application/vnd.github+json"):
    req = urllib.request.Request(url, headers={"Accept": accept, "User-Agent": "kadaliao-homebrew-tap-bump"})
    token = os.environ.get("GITHUB_TOKEN") or os.environ.get("GH_TOKEN")
    if token and "api.github.com" in url:
        req.add_header("Authorization", f"Bearer {token}")
    return urllib.request.urlopen(req, timeout=120)


def latest_version(owner: str, repo: str) -> str:
    with http(f"https://api.github.com/repos/{owner}/{repo}/releases/latest") as r:
        try:
            tag = json.load(r)["tag_name"]
        except (json.JSONDecodeError, KeyError, TypeError) as e:
            raise ValueError(f"{owner}/{repo} 的 releases/latest 返回格式不对：{e}") from e
    return tag[1:] if tag.startswith("v") else tag


def sha256_of(url: str) -> str:
    h = hashlib.sha256()
    with http(url, accept="application/octet-stream") as r:
        for chunk in iter(lambda: r.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def current_version(text: str) -> str | None:
    if m := VERSION_RE.search(text):
        return m.group(1)
    # Formula 没写 version 时从第一个 url 的 /download/v<ver>/ 推出来。
    if m := re.search(r"/releases/download/v?([^/\"]+)/", text):
        return m.group(1)
    return None


def arch_map(text: str) -> dict[str, str]:
    """cask 里的 `arch arm: "arm64", intel: "x64"`。"""
    m = re.search(r'^\s*arch\s+(.+)$', text, re.M)
    return dict(re.findall(r'(\w+):\s*"([^"]+)"', m.group(1))) if m else {}


def expand(url: str, version: str, arch: str | None = None) -> str:
    url = url.replace("#{version}", version)
    if arch is not None:
        url = url.replace("#{arch}", arch)
    if "#{" in url:
        raise ValueError(f"认不出的插值：{url}")
    return url


def bump_text(text: str, old: str, new: str) -> str:
    """只在 version / url 行里替换版本号。"""
    def repl(line: str) -> str:
        if re.match(r'\s*(version|url) "', line):
            return line.replace(old, new)
        return line
    return "".join(repl(l) for l in text.splitlines(keepends=True))


def refresh_sha256(text: str, version: str) -> str:
    """把每个 sha256 和同一层级里离它最近、还没配对的 url 配成一对，按新版本重算。

    Formula 里 url 在 sha256 前面，Cask 里 sha256 在 url 前面，两种顺序都要认。
    """
    lines = text.splitlines(keepends=True)
    arches = arch_map(text)

    # 先找出所有 url 和 sha256 语句（sha256 可能跨行：arm:/intel: 两行）。
    items: list[tuple[str, int, int, str]] = []  # (kind, start, end, payload)
    i = 0
    while i < len(lines):
        if m := URL_RE.match(lines[i]):
            items.append(("url", i, i, m.group(2)))
        elif SHA_LINE_RE.match(lines[i]):
            j = i
            while lines[j].rstrip().endswith(","):
                j += 1
            items.append(("sha", i, j, ""))
            i = j
        i += 1

    pairs: list[tuple[int, int, str]] = []  # (sha start, sha end, url)
    pending: tuple[str, int, int, str] | None = None
    for item in items:
        if pending and pending[0] != item[0]:
            sha, url = (pending, item) if pending[0] == "sha" else (item, pending)
            pairs.append((sha[1], sha[2], url[3]))
            pending = None
        else:
            pending = item
    if pending and pending[0] == "sha":
        raise ValueError("有 sha256 找不到对应的 url")

    # 从后往前替换，前面的行号不受影响。
    for start, end, url in reversed(pairs):
        stmt = "".join(lines[start : end + 1])
        indent = lines[start][: len(lines[start]) - len(lines[start].lstrip())]
        keys = re.findall(r'(\w+):\s*"[0-9a-f]{64}"', stmt)
        if keys:
            width = max(map(len, keys))
            sums = {k: sha256_of(expand(url, version, arches.get(k, k))) for k in keys}
            body = f",\n{indent}{' ' * len('sha256 ')}".join(
                f'{k}:{" " * (width - len(k) + 1)}"{v}"' for k, v in sums.items()
            )
            new_stmt = f"{indent}sha256 {body}\n"
        else:
            new_stmt = f'{indent}sha256 "{sha256_of(expand(url, version))}"\n'
        lines[start : end + 1] = [new_stmt]
    return "".join(lines)


def packages() -> list[Path]:
    return sorted((ROOT / "Formula").glob("*.rb")) + sorted((ROOT / "Casks").glob("*.rb"))


def check_readme() -> int:
    readme = (ROOT / "README.md").read_text()
    missing = []
    for p in packages():
        token = p.stem
        cask = p.parent.name == "Casks"
        install = f"brew install {'--cask ' if cask else ''}kadaliao/tap/{token}"
        if install not in readme or f"| [{token}](" not in readme:
            missing.append(token)
    if missing:
        print(f"README 缺少：{', '.join(missing)}（安装命令或表格行）", file=sys.stderr)
        return 1
    print("README 已列全所有 Formula/Cask")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--check-readme", action="store_true")
    ap.add_argument("only", nargs="*", help="只处理这些 token")
    args = ap.parse_args()
    if args.check_readme:
        return check_readme()

    bumped, failed = [], []
    for path in packages():
        if args.only and path.stem not in args.only:
            continue
        text = path.read_text()
        m = REPO_RE.search(text)
        old = current_version(text)
        if not m or not old:
            print(f"跳过 {path.stem}：不是 GitHub Release 产物")
            continue
        try:
            new = latest_version(*m.groups())
        except (urllib.error.URLError, ValueError) as e:
            print(f"✗ {path.stem}: 查最新版本失败 {e}", file=sys.stderr)
            failed.append(path.stem)
            continue
        if new == old:
            print(f"  {path.stem} {old} 已是最新")
            continue
        print(f"↑ {path.stem} {old} → {new}")
        if args.dry_run:
            bumped.append(f"{path.stem} {new}")
            continue
        try:
            updated = refresh_sha256(bump_text(text, old, new), new)
        except (urllib.error.URLError, ValueError) as e:
            # 多半是上游改了产物文件名，需要人工改 url。
            print(f"✗ {path.stem}: {e}", file=sys.stderr)
            failed.append(path.stem)
            continue
        path.write_text(updated)
        bumped.append(f"{path.stem} {new}")

    if out := os.environ.get("GITHUB_OUTPUT"):
        try:
            with open(out, "a") as f:
                f.write(f"message={', '.join(bumped)}\n")
        except OSError as e:
            print(f"写 GITHUB_OUTPUT 失败：{e}", file=sys.stderr)
            return 1
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
