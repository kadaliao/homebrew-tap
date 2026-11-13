cask "docket" do
  version "1.0.0"
  sha256 "8609b40a2b796e687346f546486426aa9eed64cf7144a6937163df426934f35d"

  url "https://github.com/kadaliao/ai-todolist/releases/download/v#{version}/Docket-#{version}-macOS-arm64.dmg"
  name "Docket"
  desc "清爽、快速、带 AI 的待办清单，可自托管多设备同步"
  homepage "https://github.com/kadaliao/ai-todolist"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Docket.app"

  uninstall quit: "app.docket.desktop"

  # 本机的任务都在 WebKit 存储里；连过同步服务器的话服务器上还有一份。
  zap trash: [
    "~/Library/Application Support/app.docket.desktop",
    "~/Library/Caches/app.docket.desktop",
    "~/Library/Preferences/app.docket.desktop.plist",
    "~/Library/Saved Application State/app.docket.desktop.savedState",
    "~/Library/WebKit/app.docket.desktop",
  ]
end
