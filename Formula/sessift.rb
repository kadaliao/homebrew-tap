class Sessift < Formula
  desc "搜索、浏览、恢复多台机器上的 AI 编程助手会话"
  homepage "https://github.com/kadaliao/sessift"
  url "https://github.com/kadaliao/sessift/releases/download/v0.4.0/sessift-v0.4.0-aarch64-apple-darwin.tar.gz"
  sha256 "9defc753b27e9477a637d544187ff6c99a95e98089ff0fa771eab175c61b5ac0"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "sessift"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sessift --version")
  end
end
