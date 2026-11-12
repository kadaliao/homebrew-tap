cask "quickedit" do
  version "0.4.0"
  sha256 "12ee0dda84e54df175ea9530b1845edcb27b45c7c8ed4f53214d07cfbb1eeece"

  url "https://github.com/kadaliao/quickedit/releases/download/v#{version}/quickedit-#{version}-arm64.dmg"
  name "QuickEdit"
  desc "极致快速的轻量编辑器，为灵活编辑而生"
  homepage "https://github.com/kadaliao/quickedit"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "QuickEdit.app"
  binary "#{appdir}/QuickEdit.app/Contents/Resources/qe"

  # 应用只做了 ad-hoc 签名、没有 Apple 公证。去掉 Homebrew 加的隔离属性，
  # 不用去「隐私与安全性」点「仍要打开」。
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/QuickEdit.app"],
        writable_paths: ["{{appdir}}/QuickEdit.app"]
  end

  uninstall quit: "com.kadaliao.quickedit"

  zap trash: [
    "~/Library/Application Support/QuickEdit",
    "~/Library/Preferences/com.kadaliao.quickedit.plist",
    "~/Library/Saved Application State/com.kadaliao.quickedit.savedState",
  ]
end
