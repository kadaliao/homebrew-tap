cask "exit" do
  version "0.3.1"
  sha256 "1bd2a1981ef5381d23a0997007e62fc772c7146dae5d003e5fea700d9063e7eb"

  url "https://github.com/kadaliao/exit/releases/download/v#{version}/Exit-#{version}.dmg"
  name "Exit"
  desc "窗口关闭、打开、最小化时在原地播放 GPU 动画，特效可以自己写或让 Claude 生成"
  homepage "https://github.com/kadaliao/exit"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Exit.app"

  uninstall quit: "io.github.kadaliao.Exit"

  # 自己写的和 AI 生成的特效都在 Application Support/Exit/Effects 里。
  zap trash: [
    "~/Library/Application Support/Exit",
    "~/Library/Preferences/io.github.kadaliao.Exit.plist",
  ]
end
