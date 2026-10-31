class Sessift < Formula
  desc "搜索、浏览、恢复多台机器上的 AI 编程助手会话"
  homepage "https://github.com/kadaliao/sessift"
  url "https://github.com/kadaliao/sessift/releases/download/v0.3.0/sessift-v0.3.0-aarch64-apple-darwin.tar.gz"
  sha256 "b0cbc934d7d7ebf1d7e0b5fd0555f784f1422305180e40d4ddacc8c8fed4c2ca"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "sessift"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sessift --version")
  end
end
