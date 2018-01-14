class Ditaa < Formula
  desc "Convert ASCII diagrams into proper bitmap graphics"
  homepage "https://ditaa.sourceforge.io/"
  url "https://github.com/stathissideris/ditaa/archive/v0.11.0.tar.gz"
  sha256 "0cd69b13febd285d90fcdc220e81158aae0cba54c6d6bdfd38d97e708c611ebd"

  bottle do
    cellar :any_skip_relocation
    sha256 "91b0b1387aae4c5883913bf4d94f3c050bc5cfea3b8ea5b19d998502e2b2977d" => :high_sierra
    sha256 "d0219cfa8bd6cc6d92b35b8fa0cab880f0b93bf08fb1bc73c7f0181893f0fc21" => :sierra
    sha256 "71a0106395863005e9a00897db143d494017e691a2db7b47ed43c8a46bf3bbd5" => :el_capitan
    sha256 "664937870a0cbd75a0cbbfd7b1d24d9d8f3284fa9ace3968105d5f62910ab359" => :yosemite
    sha256 "966d0dfe96517d50de02c8c8c2d603084c105dc3ae837fe43e61c8481d42b3f8" => :mavericks
  end

  depends_on "ant" => :build
  depends_on :java

  def install
    mkdir "bin"
    system "ant", "-buildfile", "build/release.xml", "release-jar"
    libexec.install "releases/ditaa0_10.jar"
    bin.write_jar_script libexec/"ditaa0_10.jar", "ditaa"
  end

  test do
    system "#{bin}/ditaa", "-help"
  end
end
