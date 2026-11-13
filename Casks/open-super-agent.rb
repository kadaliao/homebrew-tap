cask "open-super-agent" do
  arch arm: "arm64", intel: "x64"

  version "0.20.0"
  sha256 arm:   "06a081dce9e4f77017a4da82f5dc729a128056a90ed3c6fa7ab9b4479c3ac407",
         intel: "c027313e45f7c210e12a2ca4dc87c80188bb4cdf91357cfacfae3205d358dcca"

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
