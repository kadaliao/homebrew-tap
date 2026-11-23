cask "suck-my-disk" do
  version "0.10.0"
  sha256 "b50dde001ff8ea274e92d628dcb19d6ddc62ceab1657d251f0460fb117c275aa"

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
  # 命令行 smd 在 App 里面，跟着 App 一起更新。
  binary "#{appdir}/SuckMyDisk.app/Contents/Helpers/smd"

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
