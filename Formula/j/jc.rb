class Jc < Formula
  include Language::Python::Virtualenv

  desc "Serializes the output of command-line tools to structured JSON output"
  homepage "https://github.com/kellyjonbrazil/jc"
  url "https://files.pythonhosted.org/packages/53/a6/065f0796a0a21bc040bc88c8a33410c12729a2a6f4c269d0349f685796da/jc-1.25.1.tar.gz"
  sha256 "683352e903ece9a86eae0c3232188e40178139e710c740a466ef91ed87c4cc7e"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ae5b0c88b6844b19efee99a005b7ce5c1a315bc9de35d6135e97c060ac95f3d1"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "bda8255a118801f1f9374ece1678e4228882152ea8433dd1eb9d13e8b26ac64d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "78d2f85708f9d5f691a42b8b5aa808c55c701cf8e7b1c711128f12f6685bec2e"
    sha256 cellar: :any_skip_relocation, sonoma:         "a5d92598f5efea5f228f68c254e7652187bff0d357a24ce50cbe32e0a9eeebf7"
    sha256 cellar: :any_skip_relocation, ventura:        "0da68119de99fd3ea23f611316784af75e5e8336223ae54e75fa242a305de8ac"
    sha256 cellar: :any_skip_relocation, monterey:       "3045d0c6308932fc6be6c0fa373e7d82efdb00c596578b9d9e11612ffa9acfe2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a0e24338b3a5c29181314fa71b2664bb6ef3e90dd973e842c94c66d382642c94"
  end

  depends_on "pygments"
  depends_on "python@3.12"

  resource "ruamel-yaml" do
    url "https://files.pythonhosted.org/packages/29/81/4dfc17eb6ebb1aac314a3eb863c1325b907863a1b8b1382cdffcb6ac0ed9/ruamel.yaml-0.18.6.tar.gz"
    sha256 "8b27e6a217e786c6fbe5634d8f3f11bc63e0f80f6a5890f28863d9c45aac311b"
  end

  resource "ruamel-yaml-clib" do
    url "https://files.pythonhosted.org/packages/46/ab/bab9eb1566cd16f060b54055dd39cf6a34bfa0240c53a7218c43e974295b/ruamel.yaml.clib-0.2.8.tar.gz"
    sha256 "beb2e0404003de9a4cab9753a8805a8fe9320ee6673136ed7f04255fe60bb512"
  end

  resource "xmltodict" do
    url "https://files.pythonhosted.org/packages/39/0d/40df5be1e684bbaecdb9d1e0e40d5d482465de6b00cbb92b84ee5d243c7f/xmltodict-0.13.0.tar.gz"
    sha256 "341595a488e3e01a85a9d8911d8912fd922ede5fecc4dce437eb4b6c8d037e56"
  end

  def install
    virtualenv_install_with_resources
    man1.install "man/jc.1"
    generate_completions_from_executable(bin/"jc", "--bash-comp", shells: [:bash], shell_parameter_format: :none)
    generate_completions_from_executable(bin/"jc", "--zsh-comp", shells: [:zsh], shell_parameter_format: :none)
  end

  test do
    assert_equal "[{\"header1\":\"data1\",\"header2\":\"data2\"}]\n",
                  pipe_output("#{bin}/jc --csv", "header1, header2\n data1, data2")
  end
end
