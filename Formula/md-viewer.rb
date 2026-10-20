class MdViewer < Formula
  desc "Render Markdown files in a native window with GitHub styling"
  homepage "https://github.com/vukasin-nikodijevic/markdown-viewer"
  url "https://github.com/vukasin-nikodijevic/markdown-viewer/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d281c8c1f98d72e4432228320ed919a434fb435cac4970028ee1818c98add834"
  license "MIT"

  depends_on "go" => :build
  depends_on :macos

  def install
    ENV["CGO_ENABLED"] = "1"
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    # Must not open a GUI window; the usage error is enough
    assert_match "Usage", shell_output("#{bin}/md-viewer 2>&1", 1)
  end
end
