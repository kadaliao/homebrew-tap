cask "notchfax" do
  version "0.1.0"
  sha256 "599131dc54b19ac9d83cfb643ff04e20dc85f9a41957fb12ea7deda890089141"

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

  uninstall quit: "com.kadaliao.notchfax"

  # 传真身份、线路和收到的传真都在 Application Support 里，删了就换了一个新身份。
  zap trash: [
    "~/Library/Application Support/Notchfax",
    "~/Library/Caches/com.kadaliao.notchfax",
    "~/Library/HTTPStorages/com.kadaliao.notchfax",
    "~/Library/Preferences/com.kadaliao.notchfax.plist",
  ]
end
