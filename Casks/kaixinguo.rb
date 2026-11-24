cask "kaixinguo" do
  version "0.7.1"
  sha256 "445d36bf9ca232ebec0370b66e63fdcc0d0db20063a1a2fc13656a37a94ccaf4"

  url "https://github.com/kadaliao/kaixinguo/releases/download/v#{version}/kai-xin-guo-#{version}.dmg"
  name "开心果"
  name "Kaixinguo"
  desc "无广告的红果短剧客户端"
  homepage "https://github.com/kadaliao/kaixinguo"

  livecheck do
    url :url
    strategy :github_latest
  end

  # 应用启动后和之后每天自己检查 GitHub Releases 并更新，brew upgrade 默认跳过。
  auto_updates true
  depends_on macos: :monterey

  app "开心果.app"

  uninstall quit: "com.kadaliao.kaixinguo"

  # 观看记录、收藏和匿名设备都在 Application Support 里，封面缓存在 Caches 里。
  zap trash: [
    "~/Library/Application Support/开心果",
    "~/Library/Caches/com.kadaliao.kaixinguo",
    "~/Library/Caches/开心果",
    "~/Library/WebKit/com.kadaliao.kaixinguo",
  ]
end
