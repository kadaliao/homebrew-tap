class Ocu < Formula
  desc "让 AI agent 通过辅助功能树操作 macOS 应用：命令行、MCP 服务和内置 agent"
  homepage "https://github.com/kadaliao/open-computer-use"
  url "https://github.com/kadaliao/open-computer-use/releases/download/v0.7.1/ocu-v0.7.1-macos-arm64.tar.gz"
  sha256 "a5460a225273a791558251d7b0149d73e02a1499885968f9e9465e7e590d3305"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    # ocu 在自己所在的目录里找 ocu-mac，两个要放在一起。
    libexec.install "ocu", "ocu-mac"
    bin.install_symlink libexec/"ocu"
  end

  def caveats
    <<~EOS
      给运行 ocu 的终端或 App 打开「辅助功能」权限（截图回退还需要「屏幕录制」）：
        系统设置 > 隐私与安全性
      然后运行 ocu doctor。
      MCP 服务：command = #{opt_bin}/ocu，args = ["mcp"]
    EOS
  end

  test do
    assert_match "usage: ocu run", shell_output(bin/"ocu")
  end
end
