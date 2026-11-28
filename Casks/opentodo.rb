cask "opentodo" do
  version "0.3.0"
  sha256 "190661b2b38b576d77e0e8d10c9eb47c9841430543d3e46f3300ed7e49695d13"

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
