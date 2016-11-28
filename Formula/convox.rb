class Convox < Formula
  desc "The convox AWS PaaS CLI tool"
  homepage "https://convox.com/"
  url "https://github.com/convox/rack/archive/20161123220503.tar.gz"
  sha256 "8d7ccdbf8f43b9b27b770e11b2d3a520bd67aae6a89f9b6e3db98042b31ac105"

  bottle do
    cellar :any_skip_relocation
    sha256 "cd53ae7b757a641d099af7629665add4b5a5be9243db5b7a0eda4295d49508ff" => :sierra
    sha256 "f08291f969106df7b2b42e9f060f81f5b698385cf814495624c8225d5098c45f" => :el_capitan
    sha256 "6fb25548c9edde6acaff3ab39db38752384ac7a38c9fc51abcd6f113853b2f6b" => :yosemite
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/convox/rack").install Dir["*"]
    system "go", "build", "-ldflags=-X main.Version=#{version}",
           "-o", bin/"convox", "-v", "github.com/convox/rack/cmd/convox"
  end

  test do
    system bin/"convox"
  end
end
