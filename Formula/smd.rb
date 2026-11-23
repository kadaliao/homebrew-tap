class Smd < Formula
  desc "SuckMyDisk 的命令行：看空间被谁占了、按预选清理，可输出 JSON"
  homepage "https://github.com/kadaliao/suck-my-disk"
  url "https://github.com/kadaliao/suck-my-disk/releases/download/v0.10.0/smd-0.10.0-macos.zip"
  sha256 "a1dcce93c38f37dc4fe842a92b36f9329b10c2003de302fa8e54442cffddce67"
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
      smd 和 SuckMyDisk App 共用索引和清理记录。
      App 里自带同一个 smd，并且跟着 App 一起更新；想要 App 的话，换成它：
        brew uninstall smd
        brew install --cask kadaliao/tap/suck-my-disk
    EOS
  end

  test do
    assert_match "smd things", shell_output("#{bin}/smd help")
  end
end
