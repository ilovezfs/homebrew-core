class Libmtp < Formula
  desc "Implementation of Microsoft's Media Transfer Protocol (MTP)"
  homepage "http://libmtp.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/libmtp/libmtp/1.1.12/libmtp-1.1.12.tar.gz"
  sha256 "cdf59e816c6cda3e908a876c7fb42943f40b85669aea0029a1ca431c89afa1a0"

  bottle do
    cellar :any
    sha256 "e4a3cdc99e98442b56cb2b7ffc5eb73d5846b55381b6606c0e5960da16bf5c0d" => :el_capitan
    sha256 "6ba664bf6548074b9ae973b534e6ab61a07f4e83f4a6e5de68b0658eefb69411" => :yosemite
    sha256 "9c61ba0beccdce922eea28c04d20e7d4c025bc2bd6d5716e6ee9fe447eedeec3" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "libusb-compat"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-mtpz"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mtp-getfile")
  end
end
