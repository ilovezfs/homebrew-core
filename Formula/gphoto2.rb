class Gphoto2 < Formula
  desc "Command-line interface to libgphoto2"
  homepage "http://www.gphoto.org/"
  url "https://downloads.sourceforge.net/project/gphoto/gphoto/2.5.17/gphoto2-2.5.17.tar.bz2"
  sha256 "aa571039240c68a053be710ca41645aed0239fa2f0b737b8ec767fef29e3544f"

  bottle do
    cellar :any
    sha256 "28856ab94ba2f28245649734265ac41cb29911d78818bd5aea0dddbbfc005510" => :high_sierra
    sha256 "1c1e980bde3f0cd72de42d9196254ffbec516b4ee667232090f0f68bb9284a73" => :sierra
    sha256 "f663e168d3e139ea2544e560aa4666441622a95bc425fa755c7fbd6060c5aaa0" => :el_capitan
  end

  depends_on "pkg-config" => :build
  depends_on "jpeg"
  depends_on "libgphoto2"
  depends_on "popt"
  depends_on "readline"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gphoto2 -v")
  end
end
