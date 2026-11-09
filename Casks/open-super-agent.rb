cask "open-super-agent" do
  arch arm: "arm64", intel: "x64"

  version "0.12.0"
  sha256 arm:   "6cf6fbba4d5867744ef093c04d0e8ef2e932053c5cf65a0848cda946ea18b576",
         intel: "edf24a91ead57cd7226ff4b765e1205f0da633f8b09fd118214d46145024c35e"

  url "https://github.com/kadaliao/open-super-agent/releases/download/v#{version}/OpenSuperAgent-#{version}-#{arch}.dmg"
  name "Open Super Agent"
  desc "可以自己部署的常驻 AI 队友，带一台能看、能接手的电脑"
  homepage "https://github.com/kadaliao/open-super-agent"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :monterey

  app "Open Super Agent.app"

  uninstall quit: "com.kadaliao.opensuperagent"

  zap trash: [
    "~/Library/Application Support/open-super-agent",
    "~/Library/Caches/com.kadaliao.opensuperagent",
    "~/Library/HTTPStorages/com.kadaliao.opensuperagent*",
    "~/Library/LaunchAgents/Open Super Agent.plist",
    "~/Library/Preferences/com.kadaliao.opensuperagent.plist",
    "~/Library/WebKit/com.kadaliao.opensuperagent",
  ]
end
