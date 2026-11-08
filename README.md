# kadaliao/homebrew-tap

```sh
brew install kadaliao/tap/sessift
brew install kadaliao/tap/tizi
brew install --cask kadaliao/tap/open-super-agent
brew install --cask kadaliao/tap/tizi-desktop
```

| 名称 | 类型 | 说明 |
|---|---|---|
| [sessift](https://github.com/kadaliao/sessift) | Formula | 搜索、浏览、恢复多台机器上的 AI 编程助手会话（目前只有 macOS Apple Silicon 的预编译版本） |
| [tizi](https://github.com/kadaliao/Tizi) | Formula | 填好机场订阅就能用的代理工具：国内直连、海外走代理。这里装的是终端版和命令行（macOS；Linux 只有 x86_64，支持 Ubuntu 22.04 / 24.04） |
| [open-super-agent](https://github.com/kadaliao/open-super-agent) | Cask | 可以自己部署的常驻 AI 队友，这里装的是 macOS 桌面 App（Apple Silicon 和 Intel 都有，macOS 12 起） |
| [tizi-desktop](https://github.com/kadaliao/Tizi) | Cask | Tizi 的 macOS 桌面版，自带终端版（Apple Silicon 和 Intel 都有，macOS 13 起） |

升级：`brew upgrade sessift tizi`。桌面 App（open-super-agent、tizi-desktop）自己会检查更新，`brew upgrade` 默认跳过它们，要用 brew 升级就加 `--greedy`。

卸载桌面 App 时连数据一起删：

- `brew uninstall --cask --zap open-super-agent`：会删掉 `~/Library/Application Support/open-super-agent` 里的对话和设置。
- `brew uninstall --cask --zap tizi-desktop`：先在 Tizi 里断开连接再卸载。会删掉 `~/.config/tizi`（订阅地址、节点等设置）、`~/.local/share/tizi`（Mihomo 核心）和桌面版装到 `~/.local/bin/tizi` 的终端版。

tizi 和 tizi-desktop 由 Tizi 仓库的 `scripts/update-homebrew-tap.sh` 在发布时生成，不要直接改。
