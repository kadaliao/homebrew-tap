cask "exit" do
  version "0.4.2"
  sha256 "b65a4c69b63c57c0a26bbdddad681abc8a32c473ff49a66861dac9eda9cafd7a"

  url "https://github.com/kadaliao/exit/releases/download/v#{version}/Exit-#{version}.dmg"
  name "Exit"
  desc "窗口关闭、打开、最小化时在原地播放 GPU 动画，特效可以自己写或让 AI 生成"
  homepage "https://kadaliao.github.io/exit/"

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
