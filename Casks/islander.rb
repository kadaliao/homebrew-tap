cask "islander" do
  version "0.2.5"
  sha256 "efa35742f754045bbc6651c01347698d704ccc7625d4a1be594edb51939f1b4b"

  url "https://github.com/kadaliao/islander/releases/download/v#{version}/Islander-#{version}.zip"
  name "Islander"
  name "岛民"
  desc "把菜单栏图标藏进刘海，鼠标移到刘海上时在灵动岛里显示"
  homepage "https://github.com/kadaliao/islander"

  livecheck do
    url :url
    strategy :github_latest
  end

  # 应用每天自己检查 GitHub Releases 并更新，brew upgrade 默认跳过。
  auto_updates true
  depends_on macos: :sonoma

  app "Islander.app"

  uninstall quit: "com.kadaliao.islander"

  # 设置、手感参数、菜单栏布局（哪些图标永远隐藏）都存在偏好设置里。
  zap trash: [
    "~/Library/Caches/com.kadaliao.islander",
    "~/Library/HTTPStorages/com.kadaliao.islander",
    "~/Library/Preferences/com.kadaliao.islander.plist",
  ]
end
