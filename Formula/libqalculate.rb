class Libqalculate < Formula
  desc "Library for Qalculate! program"
  homepage "http://qalculate.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/qalculate/libqalculate/libqalculate-0.9.7/libqalculate-0.9.7.tar.gz"
  sha256 "9a6d97ce3339d104358294242c3ecd5e312446721e93499ff70acc1604607955"
  revision 1

  bottle do
    revision 1
    sha256 "3648fa3685e511542c27b16de71363a997c440039fd9725f0232ba0bf6fed8bf" => :el_capitan
    sha256 "892594672e9173081e77f59c912921f1cc326bedb3afc46ead16b5f4c5448bc9" => :yosemite
    sha256 "069cb2261cd9a7f098c3784924ddf405c8ee3d6f02d22fc36ed9fff5f2557eb1" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "cln"
  depends_on "glib"
  depends_on "gnuplot"
  depends_on "gettext"
  depends_on "readline"
  depends_on "wget"

  # Patches against version 0.9.7, should not be needed in the future
  patch :DATA

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/qalc", "-nocurrencies", "(2+2)/4 hours to minutes"
  end
end

__END__
diff -ur a/src/defs2doc.cc b/src/defs2doc.cc
--- a/src/defs2doc.cc 2009-12-02 14:24:28.000000000 -0600
+++ b/src/defs2doc.cc 2012-01-10 18:47:50.000000000 -0600
@@ -16,7 +16,9 @@
 #include <time.h>
 #include <pthread.h>
 #include <dirent.h>
+#if !defined(__APPLE__)
 #include <malloc.h>
+#endif
 #include <stdio.h>
 #include <vector>
 #include <glib.h>
diff -ur a/src/qalc.cc b/src/qalc.cc
--- a/src/qalc.cc 2010-01-05 09:17:29.000000000 -0600
+++ b/src/qalc.cc 2012-01-10 18:47:42.000000000 -0600
@@ -16,7 +16,9 @@
 #include <time.h>
 #include <pthread.h>
 #include <dirent.h>
+#if !defined(__APPLE__)
 #include <malloc.h>
+#endif
 #include <stdio.h>
 #include <vector>
 #include <glib.h>
