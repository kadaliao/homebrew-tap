class Smd < Formula
  desc "SuckMyDisk 的命令行：看空间被谁占了、按预选清理，可输出 JSON"
  homepage "https://github.com/kadaliao/suck-my-disk"
  url "https://github.com/kadaliao/suck-my-disk/releases/download/v0.6.0/smd-0.6.0-macos.zip"
  sha256 "ca0dc558c4d19c259c9c0c72eff2114dd367f13337cc3be661f4a4dc2345a1f6"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on macos: :tahoe

  def install
    bin.install "smd"
  end

  def caveats
    <<~EOS
      smd 和 SuckMyDisk App 共用索引和清理记录。想要 App：
        brew install --cask kadaliao/tap/suck-my-disk
    EOS
  end

  test do
    assert_match "smd things", shell_output("#{bin}/smd help")
  end
end
