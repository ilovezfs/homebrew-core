class Libbson < Formula
  desc "BSON utility library"
  homepage "https://github.com/mongodb/libbson"
  url "https://github.com/mongodb/libbson/releases/download/1.5.0/libbson-1.5.0.tar.gz"
  sha256 "ba49eeebedfc1e403d20abb080f3a67201b799a05f4a012eee94139ad54a6e6f"

  bottle do
    cellar :any
    sha256 "d33a7ef7a307313fd6c34b9e37a55a7e4759b033c65509cf5a90c235cbf4c8ec" => :sierra
    sha256 "f2f191e2a8d245642caa0512ef6a0ee2e2ba025ce1523085025c00564201dc5c" => :el_capitan
    sha256 "6ef1e3cd387335d0465f103925d2ae0de561ea3082fc9d29996816c5fc0e55c6" => :yosemite
    sha256 "4a10d2bb952da3287c4492feca37eaf481234bb904656a1fb166754f2a2c5f9f" => :mavericks
  end

  def install
    system "./configure", "--enable-silent-rules", "--prefix=#{prefix}"
    system "make", "install"
  end
end
