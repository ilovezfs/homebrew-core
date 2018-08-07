class Ptex < Formula
  desc "Texture mapping system"
  homepage "http://ptex.us"
  url "https://github.com/wdas/ptex/archive/v2.3.0.tar.gz"
  sha256 "285947961ac7da2a7a15955259e271a50e485793e1d596d9f254c847301eda92"

  bottle do
    cellar :any
    sha256 "4da50057c397b08a7dabbc621947f607b98cfbc887cd43f0bfa41960b36c6466" => :high_sierra
    sha256 "227c2b01f8398714d38c494061a630385dfd630e1b30bf5a651c14667c9f0621" => :sierra
    sha256 "12d030b336d928a80776188daa86fe4de608e5bc4516b8382d52a508a5a4091f" => :el_capitan
  end

  depends_on "cmake" => :build

  def install
    system "make", "prefix=#{prefix}"
    system "make", "test"
    system "make", "install"
  end
end
