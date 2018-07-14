class Clblast < Formula
  desc "Tuned OpenCL BLAS library"
  homepage "https://github.com/CNugteren/CLBlast"
  url "https://github.com/CNugteren/CLBlast/archive/1.4.1.tar.gz"
  sha256 "2c03483d4470066c37d31288e07746c8f1ca5bfb52eecdedb2c7252bb1fb2d8d"

  bottle do
    cellar :any
    sha256 "d8ad0f507da8f46d1c7e1662752a1888f4dd54cb1f98b07b29ebd51cb21b0aed" => :high_sierra
    sha256 "1a8a496863575df9b630066a1d98ea64a455a738a748d84042368f8e15adc727" => :sierra
    sha256 "51acd50cb8580e9c47b398baeb397ea985db764e29690568f199bd89fec4a164" => :el_capitan
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    pkgshare.install "samples" # for a simple library linking test
  end

  test do
    system ENV.cc, pkgshare/"samples/sgemm.c", "-I#{include}", "-L#{lib}",
                   "-lclblast", "-framework", "OpenCL"
  end
end
