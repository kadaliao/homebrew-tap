cask "open-super-agent" do
  arch arm: "arm64", intel: "x64"

  version "0.27.1"
  sha256 arm:   "a8bfe3162764180c62af8443bac483a280b395267740860c90a2abd853d674cf",
         intel: "89369f00c80db25b3f38c174e594d4dead077df6041f81801f9b329f1bc55a44"

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
