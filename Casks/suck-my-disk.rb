cask "suck-my-disk" do
  version "0.9.0"
  sha256 "8bd67a8654f062772b35b31a0d3c289c6870009bdf0736ccb1f5982109f13ede"

  url "https://github.com/kadaliao/suck-my-disk/releases/download/v#{version}/SuckMyDisk-#{version}.zip"
  name "SuckMyDisk"
  desc "认得出项目、渲染帧、开发缓存、本地模型和应用的磁盘空间工具"
  homepage "https://github.com/kadaliao/suck-my-disk"

  livecheck do
    url :url
    strategy :github_latest
  end

  # 应用每天自己检查 GitHub Releases 并更新，brew upgrade 默认跳过。
  auto_updates true
  depends_on macos: :tahoe

  app "SuckMyDisk.app"

  uninstall quit: "com.kadaliao.SuckMyDisk"

  # 索引、清理记录（含恢复命令）和设置。
  zap trash: [
    "~/Library/Application Support/SuckMyDisk",
    "~/Library/Caches/com.kadaliao.SuckMyDisk",
    "~/Library/HTTPStorages/com.kadaliao.SuckMyDisk",
    "~/Library/Preferences/com.kadaliao.SuckMyDisk.plist",
    "~/Library/Saved Application State/com.kadaliao.SuckMyDisk.savedState",
  ]
end
