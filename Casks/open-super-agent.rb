cask "open-super-agent" do
  arch arm: "arm64", intel: "x64"

  version "0.24.0"
  sha256 arm:   "4651e159c430d2c8987ec22c076dbab09951a0db00fa3c0900ce96ac06d16dde",
         intel: "23dcda232ba7086d52be9da4d349a3edfad545eb10c77b16e2e4b77724086dbd"

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
