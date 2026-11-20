class OpenAgentDocs < Formula
  desc "人和 AI Agent 一起写的文档服务器：Agent 经 MCP 读写页面、回评论，人在浏览器里编辑"
  homepage "https://github.com/kadaliao/open-agent-docs"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # 发布页的压缩包里是一个目录，二进制在里面（网页已经打进二进制）。
  on_macos do
    on_arm do
      url "https://github.com/kadaliao/open-agent-docs/releases/download/v0.3.1/open-agent-docs-v0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "8c5fbc49582c4241fae25a91d0ce15657ea45bd60c45a4fe8399a321e749a3f1"
    end
    on_intel do
      url "https://github.com/kadaliao/open-agent-docs/releases/download/v0.3.1/open-agent-docs-v0.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "18c81e481586797f36c31b7613e6cd8fee82dff51ab90a95b1cbc73725a2d4b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kadaliao/open-agent-docs/releases/download/v0.3.1/open-agent-docs-v0.3.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b9c5d941b65c1966b035d243eba71cf2fbb465746f0db8a974f5fe89c09edae7"
    end
    on_intel do
      url "https://github.com/kadaliao/open-agent-docs/releases/download/v0.3.1/open-agent-docs-v0.3.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a1fe7e786c59303f3b228b885ef3a3debfc670ee29fe10379fecd073a4021679"
    end
  end

  def install
    bin.install "open-agent-docs"
  end

  # brew services start open-agent-docs：数据放在 #{var}/open-agent-docs，只监听本机 8848
  service do
    run [opt_bin/"open-agent-docs", "serve"]
    environment_variables OAD_DATA_DIR: var/"open-agent-docs", OAD_HOST: "127.0.0.1", OAD_PORT: "8848"
    keep_alive true
    working_dir var/"open-agent-docs"
    log_path var/"log/open-agent-docs.log"
    error_log_path var/"log/open-agent-docs.log"
  end

  def caveats
    <<~EOS
      先建一个管理员（密码在终端里输入），再当服务启动：
        open-agent-docs user add --email me@example.com --name 我 --role owner --data-dir #{var}/open-agent-docs
        brew services start open-agent-docs
      然后打开 http://127.0.0.1:8848 登录。数据在 #{var}/open-agent-docs，日志在 #{var}/log/open-agent-docs.log。

      只在自己电脑上用、不想登录：OAD_AUTH=none open-agent-docs serve
      各语言的 SDK（Python、Go、Rust、JS）：https://github.com/kadaliao/open-agent-docs/blob/main/docs/zh/sdks.md
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/open-agent-docs --version")

    port = free_port
    pid = spawn({ "OAD_DATA_DIR" => testpath/"data", "OAD_PORT" => port.to_s, "OAD_AUTH" => "none" },
                bin/"open-agent-docs", "serve")
    begin
      output = ""
      30.times do
        sleep 1
        output = shell_output("curl -fsS http://127.0.0.1:#{port}/api/v1/auth/config 2>/dev/null || true")
        break if output.include?("mode")
      end
      assert_match "\"mode\":\"none\"", output
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end
  end
end
