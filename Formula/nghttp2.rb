class Nghttp2 < Formula
  desc "HTTP/2 C Library"
  homepage "https://nghttp2.org/"
  url "https://github.com/nghttp2/nghttp2/releases/download/v1.23.1/nghttp2-1.23.1.tar.xz"
  sha256 "fb75e8c0d6cf9c4381fff242d2dc04cdcc2691af8dc125c6ca349efecf5ccc21"

  bottle do
    sha256 "c3999bdf32ac964dc9db85c9988ee992866b2baa2b2b4034502e7b4aba55f725" => :sierra
    sha256 "3f34a4848ff79507529e00146f5ff1b0e552e120787b63814ce07ca5c9c6e6a0" => :el_capitan
    sha256 "3fed44014fbe49d8e3162ed1668281dc7757afb13eb07115ba73813f32a0732a" => :yosemite
  end

  head do
    url "https://github.com/nghttp2/nghttp2.git"

    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "libtool" => :build
  end

  option "with-examples", "Compile and install example programs"
  option "with-python3", "Build python3 bindings"

  depends_on :python3 => :optional
  depends_on "sphinx-doc" => :build
  depends_on "libxml2" if MacOS.version <= :lion
  depends_on "pkg-config" => :build
  depends_on "cunit" => :build
  depends_on "c-ares"
  depends_on "libev"
  depends_on "openssl"
  depends_on "libevent"
  depends_on "jansson"
  depends_on "boost"
  depends_on "spdylay"
  depends_on "jemalloc" => :recommended

  resource "Cython" do
    url "https://files.pythonhosted.org/packages/b7/67/7e2a817f9e9c773ee3995c1e15204f5d01c8da71882016cac10342ef031b/Cython-0.25.2.tar.gz"
    sha256 "f141d1f9c27a07b5a93f7dc5339472067e2d7140d1c5a9e20112a5665ca60306"
  end

  # https://github.com/tatsuhiro-t/nghttp2/issues/125
  # Upstream requested the issue closed and for users to use gcc instead.
  # Given this will actually build with Clang with cxx11, just use that.
  needs :cxx11

  def install
    ENV.cxx11

    args = %W[
      --prefix=#{prefix}
      --disable-silent-rules
      --enable-app
      --with-boost=#{Formula["boost"].opt_prefix}
      --enable-asio-lib
      --with-spdylay
      --disable-python-bindings
    ]

    args << "--enable-examples" if build.with? "examples"
    args << "--with-xml-prefix=/usr" if MacOS.version > :lion
    args << "--without-jemalloc" if build.without? "jemalloc"

    system "autoreconf", "-ivf" if build.head?
    system "./configure", *args
    system "make"
    system "make", "check"

    # Currently this is not installed by the make install stage.
    if build.with? "docs"
      system "make", "html"
      doc.install Dir["doc/manual/html/*"]
    end

    system "make", "install"
    libexec.install "examples" if build.with? "examples"

    if build.with? "python3"
      pyver = Language::Python.major_minor_version "python3"
      ENV["PYTHONPATH"] = cythonpath = buildpath/"cython/lib/python#{pyver}/site-packages"
      cythonpath.mkpath
      ENV.prepend_create_path "PYTHONPATH", lib/"python#{pyver}/site-packages"

      resource("Cython").stage do
        system "python3", *Language::Python.setup_install_args(buildpath/"cython")
      end

      cd "python" do
        system buildpath/"cython/bin/cython", "nghttp2.pyx"
        system "python3", *Language::Python.setup_install_args(prefix)
      end
    end
  end

  test do
    system bin/"nghttp", "-nv", "https://nghttp2.org"
  end
end
