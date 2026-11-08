cask "open-super-agent" do
  arch arm: "arm64", intel: "x64"

  version "0.9.0"
  sha256 arm:   "e9b3abfedf1de114b856d2abbf92bfaae4f56f139a1d3eec6ab26fb3aa99c260",
         intel: "8c7d129ba626f3dde7c46eaab7de832a91016ddc88e0bdb157c1bb7c5d7b62e6"

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
