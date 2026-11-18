class Tizi < Formula
  desc "填好机场订阅就能用：国内直连、海外走代理（基于 Mihomo）"
  homepage "https://github.com/kadaliao/Tizi"
  # 默认是 Linux 的包，Mac 在 on_macos 里按芯片换成自己的。
  url "https://github.com/kadaliao/Tizi/releases/download/v1.2.1/tizi-linux-amd64.tar.gz"
  version "1.2.1"
  sha256 "1531850143b33ef5f3969f09a2c9ebb685900d8ed0a1aad998f1a52201fd3450"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/kadaliao/Tizi/releases/download/v#{version}/tizi-darwin-arm64.tar.gz"
      sha256 "0d7f6c19203c84dbf91aeee16b89efba59d6cee81e43646c553c6b2c54eb37e6"
    end
    on_intel do
      url "https://github.com/kadaliao/Tizi/releases/download/v#{version}/tizi-darwin-amd64.tar.gz"
      sha256 "431f7d9414445a1a6df86d622f48ae1c6170c0eefe5d66dc69cd3f3982ff549e"
    end
  end

  on_linux do
    depends_on arch: :x86_64
  end

  def install
    bin.install "tizi"
  end

  def caveats
    <<~EOS
      更新请用 brew upgrade tizi。
      Mac 上想要桌面版：brew install --cask kadaliao/tap/tizi-desktop
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tizi version")
  end
end
