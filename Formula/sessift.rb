class Sessift < Formula
  desc "搜索、浏览、恢复多台机器上的 AI 编程助手会话"
  homepage "https://github.com/kadaliao/sessift"
  url "https://github.com/kadaliao/sessift/releases/download/v0.3.2/sessift-v0.3.2-aarch64-apple-darwin.tar.gz"
  sha256 "1cf041b35a7c0c9e7f4ebfe523a3f67d46026cf0be76191860293fb5763b649e"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "sessift"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sessift --version")
  end
end
