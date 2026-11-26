cask "exit" do
  version "0.2.0"
  sha256 "4e20d80e676eb5403532fbb9c05f791629fc66a86b3f26c17845bdbc5c303fd7"

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
