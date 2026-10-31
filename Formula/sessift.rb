class Sessift < Formula
  desc "搜索、浏览、恢复多台机器上的 AI 编程助手会话"
  homepage "https://github.com/kadaliao/sessift"
  url "https://github.com/kadaliao/sessift/releases/download/v0.3.1/sessift-v0.3.1-aarch64-apple-darwin.tar.gz"
  sha256 "1d582f05474694a989db0f327f9e5deb34d2fe3a545b1a1cac5a8f8aed816e4b"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "sessift"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sessift --version")
  end
end
