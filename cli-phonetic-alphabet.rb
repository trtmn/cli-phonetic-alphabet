class CliPhoneticAlphabet < Formula
  include Language::Python::Virtualenv

  desc "A CLI version of the NATO Phonetic alphabet"
  homepage "https://github.com/trtmn/cli-phonetic-alphabet"
  url "https://github.com/trtmn/cli-phonetic-alphabet/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "9e5764d427e9e91847597458e4a3a85b177c8b45bba5d5b3946bd3feac31a2d1"

  depends_on "python@3.11"

  def install
    # Create a virtual environment
    venv = virtualenv_create(libexec, "python3.11")
    
    # Install the package into the virtual environment
    system Formula["python@3.11"].opt_bin/"pip3", "install", "--no-deps", "."
    
    # Install dependencies into the virtual environment
    system Formula["python@3.11"].opt_bin/"pip3", "install", "--no-deps", "click>=8.0.0", "rich>=10.0.0"
    
    # Create the bin directory and symlink the executable
    bin.install_symlink libexec/"bin/phonetic"
  end

  test do
    system "#{bin}/phonetic", "--help"
  end
end 