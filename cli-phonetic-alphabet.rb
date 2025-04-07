class CliPhoneticAlphabet < Formula
  include Language::Python::Virtualenv

  desc "A CLI version of the NATO Phonetic alphabet"
  homepage "https://github.com/trtmn/cli-phonetic-alphabet"
  url "https://github.com/trtmn/cli-phonetic-alphabet/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "34374de4fb17a9b8392e98f48907183e725eea1b420d0a87674214cc28f0c077"

  depends_on "python@3.11"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/phonetic", "--help"
  end
end 