# kadaliao/homebrew-tap

```sh
brew install kadaliao/tap/sessift
brew install kadaliao/tap/tizi
brew install kadaliao/tap/smd
brew install --cask kadaliao/tap/open-super-agent
brew install --cask kadaliao/tap/tizi-desktop
brew install --cask kadaliao/tap/suck-my-disk
brew install --cask kadaliao/tap/kitfold
brew install --cask kadaliao/tap/kaixinguo
brew install --cask kadaliao/tap/islander
brew install --cask kadaliao/tap/quickedit
```

| 名称 | 类型 | 说明 |
|---|---|---|
| [sessift](https://github.com/kadaliao/sessift) | Formula | 搜索、浏览、恢复多台机器上的 AI 编程助手会话（目前只有 macOS Apple Silicon 的预编译版本） |
| [tizi](https://github.com/kadaliao/Tizi) | Formula | 填好机场订阅就能用的代理工具：国内直连、海外走代理。这里装的是终端版和命令行（macOS；Linux 只有 x86_64，支持 Ubuntu 22.04 / 24.04） |
| [smd](https://github.com/kadaliao/suck-my-disk) | Formula | SuckMyDisk 的命令行：看空间被谁占了、按预选清理，可输出 JSON 给脚本和编程助手（macOS 26 起，Apple Silicon 和 Intel 通用） |
| [open-super-agent](https://github.com/kadaliao/open-super-agent) | Cask | 可以自己部署的常驻 AI 队友，这里装的是 macOS 桌面 App（Apple Silicon 和 Intel 都有，macOS 12 起） |
| [tizi-desktop](https://github.com/kadaliao/Tizi) | Cask | Tizi 的 macOS 桌面版，自带终端版（Apple Silicon 和 Intel 都有，macOS 13 起） |
| [suck-my-disk](https://github.com/kadaliao/suck-my-disk) | Cask | SuckMyDisk：认得出项目、渲染帧、开发缓存、本地模型和应用的磁盘空间工具，告诉你哪些可以放心删（macOS 26 起，Apple Silicon 和 Intel 通用） |
| [kitfold](https://github.com/kadaliao/kitfold) | Cask | Kitfold：统一管理 Claude Code、Codex、Gemini CLI、Cursor 等 70 多个 Coding Agent 的 Skills 和指令文件，同时装好 `kitfold` 命令行（macOS 15 起，Apple Silicon 和 Intel 通用） |
| [kaixinguo](https://github.com/kadaliao/kaixinguo) | Cask | 开心果：无广告的红果短剧 Mac 客户端，GPU 直接绘制，安装包约 10 MB（macOS 12 起，Apple Silicon 和 Intel 通用） |
| [islander](https://github.com/kadaliao/islander) | Cask | 岛民：把菜单栏图标藏进刘海，鼠标移到刘海上时在灵动岛里显示（macOS 14 起，Apple Silicon 和 Intel 通用） |
| [quickedit](https://github.com/kadaliao/quickedit) | Cask | QuickEdit：极致快速的轻量编辑器，同时装好 `qe` 命令行（macOS 13 起，只有 Apple Silicon） |

升级：`brew upgrade sessift tizi smd quickedit`。其余桌面 App（open-super-agent、tizi-desktop、suck-my-disk、kitfold、kaixinguo、islander）自己会检查更新，`brew upgrade` 默认跳过它们，要用 brew 升级就加 `--greedy`。

卸载桌面 App 时连数据一起删：

- `brew uninstall --cask --zap open-super-agent`：会删掉 `~/Library/Application Support/open-super-agent` 里的对话和设置。
- `brew uninstall --cask --zap tizi-desktop`：先在 Tizi 里断开连接再卸载。会删掉 `~/.config/tizi`（订阅地址、节点等设置）、`~/.local/share/tizi`（Mihomo 核心）和桌面版装到 `~/.local/bin/tizi` 的终端版。
- `brew uninstall --cask --zap suck-my-disk`：会把 `~/Library/Application Support/SuckMyDisk`（磁盘索引、清理记录和恢复命令）和设置移到废纸篓。
- `brew uninstall --cask --zap kitfold`：只删设置和缓存，留下 `~/.kitfold`。那里是技能库，各 Agent 的技能目录都链接到它，确定不用了再自己删。
- `brew uninstall --cask --zap kaixinguo`：会把 `~/Library/Application Support/开心果`（观看记录和收藏）和封面缓存移到废纸篓。
- `brew uninstall --cask --zap islander`：会删掉设置、手感参数和菜单栏布局（偏好设置和缓存）。
- `brew uninstall --cask --zap quickedit`：会删掉 `~/Library/Application Support/QuickEdit`、偏好设置和窗口状态。

## 版本追踪

`.github/workflows/bump.yml` 每 6 小时跑一次 `scripts/bump.py`：逐个查上游仓库 GitHub 上的最新 Release（跳过草稿和预发布），有新版就改 `version` / `url` 里的版本号，下载产物重算 `sha256`，提交成「<名称> <版本>」推到 main。也可以在 Actions 页手动触发，或者在本地跑：

```sh
scripts/bump.py --dry-run      # 只看哪些过期
scripts/bump.py                # 改写文件（可只跟名称：scripts/bump.py kitfold）
scripts/bump.py --check-readme # 检查 README 有没有列全所有 Formula/Cask
```

上游改了产物文件名时脚本会报错跳过、工作流标红，这时要手动改 `url`。新增 Formula/Cask 要同步加进上面的安装命令和表格，否则 `--check-readme` 会让工作流失败。
