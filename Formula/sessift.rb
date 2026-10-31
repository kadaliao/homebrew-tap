class Sessift < Formula
  desc "搜索、浏览、恢复多台机器上的 AI 编程助手会话"
  homepage "https://github.com/kadaliao/sessift"
  url "https://github.com/kadaliao/sessift/releases/download/v0.2.0/sessift-v0.2.0-aarch64-apple-darwin.tar.gz"
  sha256 "6343d629cd41e63c68a4ae4418ed9801e22cc4e5d211694c745f853a176aa178"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "sessift"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sessift --version")
  end
end
