# Homebrew formula template for yapi-mcp, intended for News777/homebrew-tap.
#
# Generate the concrete formula with:
#   make homebrew-formula VERSION=v0.6.0
# which fills version + SHA256 values from the release assets in dist/
# (or fetches checksums.txt). Copy the generated packaging/homebrew/yapi-mcp.rb
# into the tap repository and push.
#
# Download URLs only resolve publicly after the v1.0.0 visibility flip;
# that is expected and by design (see ROADMAP M4.3/M4.6). The `#/<name>`
# URL fragments make Homebrew store each platform binary under the common
# name `yapi-mcp` so a single `install` block works for all platforms.

class YapiMcp < Formula
  desc "YApi MCP server for AI coding agents (search, resolve, compact context)"
  homepage "https://github.com/News777/Yapi-mcp"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/News777/Yapi-mcp/releases/download/v#{version}/yapi-mcp-darwin-arm64#/yapi-mcp"
      sha256 "fac6d699e44fe8d62491691171f859c459bb18a38e12894d825f20da2e289ea4"
    else
      url "https://github.com/News777/Yapi-mcp/releases/download/v#{version}/yapi-mcp-darwin-amd64#/yapi-mcp"
      sha256 "10921464684bb84d84f52afa8251ec3152332977e8f35b4314f9f7ed063e9bbd"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/News777/Yapi-mcp/releases/download/v#{version}/yapi-mcp-linux-arm64#/yapi-mcp"
      sha256 "453e0ae12dd8d8cc46db1529523a3cefd9df86a5d38668b8c231452c384e7b13"
    else
      url "https://github.com/News777/Yapi-mcp/releases/download/v#{version}/yapi-mcp-linux-amd64#/yapi-mcp"
      sha256 "f739330a47e19bd4dcb2dfff2ce395f95b44704619fcc48f03fe08fbd59ad39b"
    end
  end

  def install
    bin.install "yapi-mcp"
  end

  def caveats
    <<~EOS
      yapi-mcp is an MCP stdio server: configure it in your MCP host with
      command: yapi-mcp and your YApi credentials as env vars.
      Read-only by default; set YAPI_ENABLE_WRITE=true to opt in to the
      experimental write tool.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/yapi-mcp --version 2>&1")
  end
end
