# kadaliao/homebrew-tap

```sh
brew install kadaliao/tap/sessift
brew install --cask kadaliao/tap/open-super-agent
```

| 名称 | 类型 | 说明 |
|---|---|---|
| [sessift](https://github.com/kadaliao/sessift) | Formula | 搜索、浏览、恢复多台机器上的 AI 编程助手会话（目前只有 macOS Apple Silicon 的预编译版本） |
| [open-super-agent](https://github.com/kadaliao/open-super-agent) | Cask | 可以自己部署的常驻 AI 队友，这里装的是 macOS 桌面 App（Apple Silicon 和 Intel 都有，macOS 12 起） |

升级：`brew upgrade sessift`。桌面 App 自己会检查更新，`brew upgrade` 默认跳过它，要用 brew 升级就加 `--greedy`。

卸载桌面 App 时连数据一起删：`brew uninstall --cask --zap open-super-agent`（会删掉 `~/Library/Application Support/open-super-agent` 里的对话和设置）。
