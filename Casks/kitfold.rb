cask "kitfold" do
  version "0.5.2"
  sha256 "129adde0435b1cf647074babcf68003aaeb743316586793362209d6e374351eb"

  url "https://github.com/kadaliao/kitfold/releases/download/v#{version}/Kitfold-#{version}.dmg"
  name "Kitfold"
  desc "统一管理各种 Coding Agent 的 Skills 和指令文件"
  homepage "https://github.com/kadaliao/kitfold"

  livecheck do
    url :url
    strategy :github_latest
  end

  # 应用每天自己检查 GitHub Releases 并更新，brew upgrade 默认跳过。
  auto_updates true
  depends_on macos: :sequoia

  app "Kitfold.app"
  binary "#{appdir}/Kitfold.app/Contents/Resources/kitfold"

  uninstall quit: "app.kitfold.Kitfold"

  # 只清设置和缓存。~/.kitfold 是技能库，各 Agent 的技能目录链接到这里，删了链接全会失效，所以留着。
  zap trash: [
    "~/Library/Caches/app.kitfold.Kitfold",
    "~/Library/HTTPStorages/app.kitfold.Kitfold",
    "~/Library/Preferences/app.kitfold.Kitfold.plist",
    "~/Library/Saved Application State/app.kitfold.Kitfold.savedState",
  ]
end
