class CliPhoneticAlphabet < Formula
  include Language::Python::Virtualenv

  desc "A CLI version of the NATO Phonetic alphabet"
  homepage "https://github.com/trtmn/cli-phonetic-alphabet"
  url "https://github.com/trtmn/cli-phonetic-alphabet/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "6bd4e21e78dfe5ec9cebe2e690530acc12c22f5b86a62b8f934e8dd1f8bfe6ce"

  depends_on "python@3.11"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/phonetic", "--help"
  end
end 