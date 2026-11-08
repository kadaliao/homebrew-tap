class Tizi < Formula
  desc "填好机场订阅就能用：国内直连、海外走代理（基于 Mihomo）"
  homepage "https://github.com/kadaliao/Tizi"
  # 默认是 Linux 的包，Mac 在 on_macos 里按芯片换成自己的。
  url "https://github.com/kadaliao/Tizi/releases/download/v1.2.0/tizi-linux-amd64.tar.gz"
  version "1.2.0"
  sha256 "77f82683941ab42d335f4f2d175247874d763ace3d13824998abca3c82fe5322"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/kadaliao/Tizi/releases/download/v#{version}/tizi-darwin-arm64.tar.gz"
      sha256 "8ac5e7c40ecf79c20422d32fafb5956adc8ccf8e01a1598763e53db1bf23c5c6"
    end
    on_intel do
      url "https://github.com/kadaliao/Tizi/releases/download/v#{version}/tizi-darwin-amd64.tar.gz"
      sha256 "34597b3299fd256146cbc20350527c910a036588470515e982aa96ee5e789954"
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
