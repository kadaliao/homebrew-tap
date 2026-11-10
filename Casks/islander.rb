cask "islander" do
  version "0.1.1"
  sha256 "524c28e933e2d2a5178cf6071874fd389de66f5fe5e15f93653598bf1a086766"

  url "https://github.com/kadaliao/islander/releases/download/v#{version}/Islander-#{version}.zip"
  name "Islander"
  name "岛民"
  desc "把菜单栏图标藏进刘海，鼠标移到刘海上时在灵动岛里显示"
  homepage "https://github.com/kadaliao/islander"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Islander.app"

  uninstall quit: "com.kadaliao.islander"

  # 设置、手感参数、菜单栏布局（哪些图标永远隐藏）都存在偏好设置里。
  zap trash: [
    "~/Library/Caches/com.kadaliao.islander",
    "~/Library/Preferences/com.kadaliao.islander.plist",
  ]
end
