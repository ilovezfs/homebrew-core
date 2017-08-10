class Libgxps < Formula
  desc "GObject based library for handling and rendering XPS documents"
  homepage "https://live.gnome.org/libgxps"
  url "https://download.gnome.org/sources/libgxps/0.3/libgxps-0.3.0.tar.xz"
  sha256 "412b1343bd31fee41f7204c47514d34c563ae34dafa4cc710897366bd6cd0fae"

  bottle do
    cellar :any
    sha256 "4cfffe7346052e0b1e58d90c121a3f5019a5dbc84ba615f2b61d12489b6f83a6" => :sierra
    sha256 "98487c22daa05bf49ae4975759c71f568b574a55f96cdbdd9834c4d05293155c" => :el_capitan
    sha256 "234ce5d81d10db1eac54601306fb9889a549559c4e2a87e972782971103ae399" => :yosemite
  end

  head do
    url "https://github.com/GNOME/libgxps.git"

    depends_on "libtool" => :build
    depends_on "gnome-common" => :build
    depends_on "gtk-doc" => :build
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "libarchive"
  depends_on "freetype"
  depends_on "gtk+3"
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "little-cms2"

  def install
    if build.head?
      ENV.delete("PYTHONPATH")
      ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"
    end

    mkdir "build" do
      system "meson", "--prefix=#{prefix}", ".."
      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    mkdir_p [
      (testpath/"Documents/1/Pages/_rels/"),
      (testpath/"_rels/"),
    ]

    (testpath/"FixedDocumentSequence.fdseq").write <<-EOS.undent
      <FixedDocumentSequence>
      <DocumentReference Source="/Documents/1/FixedDocument.fdoc"/>
      </FixedDocumentSequence>
      EOS
    (testpath/"Documents/1/FixedDocument.fdoc").write <<-EOS.undent
      <FixedDocument>
      <PageContent Source="/Documents/1/Pages/1.fpage"/>
      </FixedDocument>
      EOS
    (testpath/"Documents/1/Pages/1.fpage").write <<-EOS.undent
      <FixedPage Width="1" Height="1" xml:lang="und" />
      EOS
    (testpath/"_rels/.rels").write <<-EOS.undent
      <Relationships>
      <Relationship Target="/FixedDocumentSequence.fdseq" Type="http://schemas.microsoft.com/xps/2005/06/fixedrepresentation"/>
      </Relationships>
      EOS
    [
      "_rels/FixedDocumentSequence.fdseq.rels",
      "Documents/1/_rels/FixedDocument.fdoc.rels",
      "Documents/1/Pages/_rels/1.fpage.rels",
    ].each do |f|
      (testpath/f).write <<-EOS.undent
        <Relationships />
        EOS
    end

    Dir.chdir(testpath) do
      system "/usr/bin/zip", "-qr", (testpath/"test.xps"), "_rels", "Documents", "FixedDocumentSequence.fdseq"
    end
    system "#{bin}/xpstopdf", (testpath/"test.xps")
  end
end
