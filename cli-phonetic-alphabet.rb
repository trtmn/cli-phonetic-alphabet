class CliPhoneticAlphabet < Formula
  include Language::Python::Virtualenv

  desc "A CLI version of the NATO Phonetic alphabet"
  homepage "https://github.com/trtmn/cli-phonetic-alphabet"
  url "https://github.com/trtmn/cli-phonetic-alphabet/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"

  depends_on "python@3.11"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/phonetic", "--help"
  end
end 