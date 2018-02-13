class GitArchiveAll < Formula
  desc "Archive a project and its submodules"
  homepage "https://github.com/Kentzo/git-archive-all"
  url "https://github.com/Kentzo/git-archive-all/archive/1.17.tar.gz"
  sha256 "b07ab276811f643252ff03dd8cbb6706bd31311b0e0efa1499b864a32c835659"
  head "https://github.com/Kentzo/git-archive-all.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "38181f895887952902f399431bf99aca3b178ef4ae9318e9df4b3180850b1991" => :high_sierra
    sha256 "fcf25d28196f392663004bc5456484faed750e510b02bae78184180442f794c9" => :sierra
    sha256 "fcf25d28196f392663004bc5456484faed750e510b02bae78184180442f794c9" => :el_capitan
    sha256 "fcf25d28196f392663004bc5456484faed750e510b02bae78184180442f794c9" => :yosemite
  end

  def install
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    (testpath/".gitconfig").write <<~EOS
      [user]
        name = Real Person
        email = notacat@hotmail.cat
      EOS
    system "git", "init"
    touch "homebrew"
    system "git", "add", "homebrew"
    system "git", "commit", "--message", "brewing"

    assert_equal "#{testpath.realpath}/homebrew => archive/homebrew",
                 shell_output("#{bin}/git-archive-all --dry-run ./archive", 0).chomp
  end
end
