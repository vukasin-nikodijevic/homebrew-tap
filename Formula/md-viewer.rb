class MdViewer < Formula
  desc "Render Markdown files in a native window with GitHub styling"
  homepage "https://github.com/vukasin-nikodijevic/markdown-viewer"
  url "https://github.com/vukasin-nikodijevic/markdown-viewer/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "4b8bf7c023c3d75e57a511ae2062637f4cf1f6964e03f52008b361db8ea45c34"
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
