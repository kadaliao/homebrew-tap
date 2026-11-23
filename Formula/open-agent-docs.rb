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
      url "https://github.com/kadaliao/open-agent-docs/releases/download/v0.4.0/open-agent-docs-v0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "58811275775a25affd47562b119b0ceccd67066a7caddc1e86cb12daf65eb6cf"
    end
    on_intel do
      url "https://github.com/kadaliao/open-agent-docs/releases/download/v0.4.0/open-agent-docs-v0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "cdbb988ef5eec7dc28128b4b237ede1b024ac8cf61ccfb0183aa2cc36c5faa2d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kadaliao/open-agent-docs/releases/download/v0.4.0/open-agent-docs-v0.4.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "415c97604bd809802d1d65c6af97fe12bdc02a7bf6f500eab9b3c0e0b4ae3874"
    end
    on_intel do
      url "https://github.com/kadaliao/open-agent-docs/releases/download/v0.4.0/open-agent-docs-v0.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "83d0a9e00068f2fa1b5850746734aa2f21901b114720501574dbe77f62e776a9"
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
