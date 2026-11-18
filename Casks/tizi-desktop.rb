cask "tizi-desktop" do
  version "1.2.1"
  sha256 "8888757de26d6e33e07ef57f3758e187c419a3dc33ddcc7973f62cb7043e31e7"

  url "https://github.com/kadaliao/Tizi/releases/download/v#{version}/TiziDesktop-macos.zip"
  name "Tizi"
  desc "填好机场订阅点「连接」：国内直连、海外走代理（基于 Mihomo）"
  homepage "https://github.com/kadaliao/Tizi"

  livecheck do
    url :url
    strategy :github_latest
  end

  # 应用内自己更新（连同 ~/.local/bin/tizi 一起），brew upgrade 默认跳过。
  auto_updates true
  depends_on macos: :ventura

  app "TiziDesktop.app"

  # 应用只做了 ad-hoc 签名、没有 Apple 公证。去掉 Homebrew 加的隔离属性，
  # 和 install.sh 装的一样能直接打开，不用去「隐私与安全性」点「仍要打开」。
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/TiziDesktop.app"],
        writable_paths: ["{{appdir}}/TiziDesktop.app"]
  end

  uninstall quit: "com.kadaliao.tizi.desktop"

  # 首次打开时应用会把自带的 tizi 装到 ~/.local/bin，一并删掉。
  zap trash: [
    "~/.config/tizi",
    "~/.local/bin/tizi",
    "~/.local/share/tizi",
    "~/Library/Preferences/com.kadaliao.tizi.desktop.plist",
  ]
end
