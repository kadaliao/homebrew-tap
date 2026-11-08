class Sessift < Formula
  desc "搜索、浏览、恢复多台机器上的 AI 编程助手会话"
  homepage "https://github.com/kadaliao/sessift"
  url "https://github.com/kadaliao/sessift/releases/download/v0.3.3/sessift-v0.3.3-aarch64-apple-darwin.tar.gz"
  sha256 "e86f21ded036f17b35a74d5ffb9306882e0c24466c01efd53efefdb5b234531e"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "sessift"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sessift --version")
  end
end
