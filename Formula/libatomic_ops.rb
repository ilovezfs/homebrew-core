class LibatomicOps < Formula
  desc "Implementations for atomic memory update operations"
  homepage "https://github.com/ivmai/libatomic_ops/"
  url "https://github.com/ivmai/libatomic_ops/releases/download/v7.6.4/libatomic_ops-7.6.4.tar.gz"
  sha256 "5b823d5a685dd70caeef8fc50da7d763ba7f6167fe746abca7762e2835b3dd4e"

  bottle do
    cellar :any_skip_relocation
    sha256 "eab4cb5ef3fd4aca17588e7ef5925fce490fbc4bd4f970db1420aa0fd5dc0a46" => :high_sierra
    sha256 "f4490f641b310ff0abd18ef8ecd4bfc542d6c99567ef9fc2aab716c8048bc5ba" => :sierra
    sha256 "f44a1ebafef8923b58d81dd1ef26fd1b136300c900c593c22f2c74eddb0c9f61" => :el_capitan
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make", "check"
    system "make", "install"
  end
end
