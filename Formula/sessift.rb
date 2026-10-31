class Sessift < Formula
  desc "搜索、浏览、恢复多台机器上的 AI 编程助手会话"
  homepage "https://github.com/kadaliao/sessift"
  url "https://github.com/kadaliao/sessift/releases/download/v0.1.0/sessift-v0.1.0-aarch64-apple-darwin.tar.gz"
  sha256 "0719bb753fabad31e5ef40feadc911682308c88a40100a9960e4c2758b1bff5b"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "sessift"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sessift --version")
  end
end
