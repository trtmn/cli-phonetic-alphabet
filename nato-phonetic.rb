class NatoPhonetic < Formula
  include Language::Python::Virtualenv

  desc "A CLI version of the NATO Phonetic alphabet"
  homepage "https://github.com/trtmn/cli-phonetic-alphabet"
  url "https://github.com/trtmn/cli-phonetic-alphabet/archive/refs/tags/v0.1.5.tar.gz"
  version "0.1.5"
  sha256 "38cc275f7821598082b138d4a8782b5b385a190332945d0660953fac6ad12855"

  depends_on "python@3.11"

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/a7/ec/4a7d80728bd429f7c0d4d51245287158a1516315cadbb146012439403a9d/rich-13.7.0.tar.gz"
    sha256 "5cb5123b5cf9ee70584244246816e9114227e0b98ad9176eede6ad54bf5403fa"
  end

  def install
    venv = virtualenv_create(libexec, "python3.11")
    venv.pip_install resources
    venv.pip_install buildpath
  end

  test do
    system bin/"phonetic", "--help"
  end
end 