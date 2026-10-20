class MdViewer < Formula
  desc "Render Markdown files in a native window with GitHub styling"
  homepage "https://github.com/vukasin-nikodijevic/markdown-viewer"
  url "https://github.com/vukasin-nikodijevic/markdown-viewer/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "4835ecf395b45c393fd6dd19059277ed05dab5ffe99c6dcf68a6b2a4ca7dc1c6"
  license "MIT"

  depends_on "go" => :build

  on_linux do
    depends_on "pkgconf" => :build
    depends_on "glib"
    depends_on "gtk+3"
    depends_on "webkitgtk"
  end

  def install
    ENV["CGO_ENABLED"] = "1"
    # webview_go asks pkg-config for webkit2gtk-4.0; the repo's shim maps it to 4.1
    ENV.prepend_path "PKG_CONFIG_PATH", buildpath/".pkg-config" if OS.linux?
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    # Must not open a GUI window; the usage error is enough
    assert_match "Usage", shell_output("#{bin}/md-viewer 2>&1", 1)
  end
end
