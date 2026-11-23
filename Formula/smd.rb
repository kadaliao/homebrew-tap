class Smd < Formula
  desc "SuckMyDisk 的命令行：看空间被谁占了、按预选清理，可输出 JSON"
  homepage "https://github.com/kadaliao/suck-my-disk"
  url "https://github.com/kadaliao/suck-my-disk/releases/download/v0.9.1/smd-0.9.1-macos.zip"
  sha256 "093fe06a8aaae986a49a362da1497d71bc86f8f7917d39966c15b60465e9d0af"
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
