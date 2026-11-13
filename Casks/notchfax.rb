cask "notchfax" do
  version "0.2.0"
  sha256 "260e721ebd72dd4bd38fdcdc05aecebb944665aac63f6a034dd770b55af3fd64"

  url "https://github.com/kadaliao/notchfax/releases/download/v#{version}/Notchfax-#{version}.dmg"
  name "Notchfax"
  desc "把刘海当出纸口：那年今日照片、大头贴和给陌生人的匿名传真"
  homepage "https://github.com/kadaliao/notchfax"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Notchfax.app"
  # 命令行就是 App 自己的可执行文件，按名字 notchfax 调用时走命令行。
  binary "#{appdir}/Notchfax.app/Contents/MacOS/Notchfax", target: "notchfax"

  uninstall quit: "com.kadaliao.notchfax"

  # 传真身份、线路和收到的传真都在 Application Support 里，删了就换了一个新身份。
  zap trash: [
    "~/Library/Application Support/Notchfax",
    "~/Library/Caches/com.kadaliao.notchfax",
    "~/Library/HTTPStorages/com.kadaliao.notchfax",
    "~/Library/Preferences/com.kadaliao.notchfax.plist",
  ]
end
