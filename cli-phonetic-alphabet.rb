class CliPhoneticAlphabet < Formula
  include Language::Python::Virtualenv

  desc "A CLI version of the NATO Phonetic alphabet"
  homepage "https://github.com/yourusername/cli-phonetic-alphabet"
  url "https://github.com/yourusername/cli-phonetic-alphabet/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "YOUR_SHA256_HASH"  # You'll need to replace this with the actual SHA256 hash

  depends_on "python@3.8"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/phonetic", "--help"
  end
end 