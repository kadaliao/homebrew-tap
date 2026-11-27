cask "opentodo" do
  version "0.1.0"
  sha256 "93f9e9a559c9b33a63b4b5a4dac541a9de106ffae376cf551c4e3be8b3bcd9ff"

  url "https://github.com/kadaliao/opentodo/releases/download/v#{version}/OpenTodo-#{version}.dmg"
  name "OpenTodo"
  desc "开源的多端待办清单，同步服务可以自己部署"
  homepage "https://github.com/kadaliao/opentodo"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "OpenTodo.app"

  uninstall quit: "com.liaoxingyi.opentodo"

  # 任务都在 App Group 容器里的数据库中（登录同步过的，服务器上还有一份）；
  # 另外三个是应用、小组件和分享扩展各自的沙盒容器。
  zap trash: [
    "~/Library/Containers/com.liaoxingyi.opentodo",
    "~/Library/Containers/com.liaoxingyi.opentodo.share",
    "~/Library/Containers/com.liaoxingyi.opentodo.widgets",
    "~/Library/Group Containers/HMDAVG9B8J.group.com.liaoxingyi.opentodo",
  ]
end
