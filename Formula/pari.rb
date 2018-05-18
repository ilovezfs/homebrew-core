class Pari < Formula
  desc "Computer algebra system designed for fast computations in number theory"
  homepage "https://pari.math.u-bordeaux.fr/"
  url "https://pari.math.u-bordeaux.fr/pub/pari/unix/pari-2.9.5.tar.gz"
  sha256 "6b451825b41d2f8b29592c08d671999527bf936789c599d77b8dfdc663f1e617"

  bottle do
    sha256 "e395e67785175c625c794e0535c4224bd15cbc15f661cbcf6d8bc96f15e58aba" => :high_sierra
    sha256 "e23557107118210578fcd65b8b48ae2f2ceb817ba4fb40b7afab2f3f4658b4e3" => :sierra
    sha256 "6d5cd278c72dfedac177af118a3762028a87d4748b5044d30d73d9dda55c5a3e" => :el_capitan
  end

  depends_on "gmp"
  depends_on "readline"
  depends_on :x11

  def install
    readline = Formula["readline"].opt_prefix
    gmp = Formula["gmp"].opt_prefix
    system "./Configure", "--prefix=#{prefix}",
                          "--with-gmp=#{gmp}",
                          "--with-readline=#{readline}"
    # make needs to be done in two steps
    system "make", "all"
    system "make", "install"
  end

  test do
    (testpath/"math.tex").write "$k_{n+1} = n^2 + k_n^2 - k_{n-1}$"
    system bin/"tex2mail", testpath/"math.tex"
  end
end
