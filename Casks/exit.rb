cask "exit" do
  version "0.4.0"
  sha256 "0d3ec948301d8556b61ad4fadc08b9a65ae5176603e26afd01216ad04ca10697"

  url "https://github.com/kadaliao/exit/releases/download/v#{version}/Exit-#{version}.dmg"
  name "Exit"
  desc "窗口关闭、打开、最小化时在原地播放 GPU 动画，特效可以自己写或让 AI 生成"
  homepage "https://github.com/kadaliao/exit"

  livecheck do
    url :url
    strategy :github_latest
  end

  # 0.4.0 起应用每天自己检查 GitHub Releases 并更新，brew upgrade 默认跳过。
  auto_updates true
  depends_on macos: :sonoma

  app "Exit.app"

  uninstall quit: "io.github.kadaliao.Exit"

  # 自己写的和 AI 生成的特效都在 Application Support/Exit/Effects 里。
  zap trash: [
    "~/Library/Application Support/Exit",
    "~/Library/Preferences/io.github.kadaliao.Exit.plist",
  ]
end
