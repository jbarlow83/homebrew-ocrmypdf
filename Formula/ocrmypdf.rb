
class Ocrmypdf < Formula
  include Language::Python::Virtualenv

  desc "Adds an OCR text layer to scanned PDF files"
  homepage "https://github.com/jbarlow83/OCRmyPDF"
  url "https://files.pythonhosted.org/packages/3f/77/0b82816760812a9c65d0a36b6d4c1f5040765af0f821e2661f88549f51b2/ocrmypdf-5.0.1.tar.gz"
  sha256 "f626c8132f62dd5e12bd2baab1dcbaa936bde0281194e0ef10520e2a0b41cdba"

  depends_on :python3
  depends_on "pkg-config" => :build
  depends_on "libffi"
  depends_on "tesseract"
  depends_on "ghostscript"
  depends_on "unpaper"
  depends_on "qpdf"

  # For Pillow source install
  depends_on "openjpeg"
  depends_on "freetype"
  depends_on "libpng"
  depends_on "libjpeg"
  depends_on "webp"
  depends_on "little-cms2"

  resource "appdirs" do
    url "https://files.pythonhosted.org/packages/48/69/d87c60746b393309ca30761f8e2b49473d43450b150cb08f3c6df5c11be5/appdirs-1.4.3.tar.gz"
    sha256 "9e5896d1372858f8dd3344faf4e5014d21849c756c8d5701f78f8a103b372d92"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/5b/b9/790f8eafcdab455bcd3bd908161f802c9ce5adbf702a83aa7712fcc345b7/cffi-1.10.0.tar.gz"
    sha256 "b3b02911eb1f6ada203b0763ba924234629b51586f72a21faacc638269f4ced5"
  end

  resource "img2pdf" do
    url "https://files.pythonhosted.org/packages/b6/bc/e72a813265a5e7b7319c74130888c60bed441b4a13c2b8f76a33c19541bb/img2pdf-0.2.3.tar.gz"
    sha256 "156d9abae0429e30d68c8c8978fbcc23d5a841c6aa8bb914755c5b366f95dc46"
  end

  resource "olefile" do
    url "https://files.pythonhosted.org/packages/35/17/c15d41d5a8f8b98cc3df25eb00c5cee76193114c78e5674df6ef4ac92647/olefile-0.44.zip"
    sha256 "61f2ca0cd0aa77279eb943c07f607438edf374096b66332fae1ee64a6f0f73ad"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/c6/70/bb32913de251017e266c5114d0a645f262fb10ebc9bf6de894966d124e35/packaging-16.8.tar.gz"
    sha256 "5d50835fdf0a7edf0b55e311b7c887786504efea1177abd7e69329a8e5ea619e"
  end

  resource "Pillow" do
    url "https://files.pythonhosted.org/packages/93/73/66854f63b1941aad9af18a1de59f9cf95ad1a87c801540222e332f6688d7/Pillow-4.1.1.tar.gz"
    sha256 "00b6a5f28d00f720235a937ebc2f50f4292a5c7e2d6ab9a8b26153b625c4f431"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/be/64/1bb257ffb17d01f4a38d7ce686809a736837ad4371bcc5c42ba7a715c3ac/pycparser-2.17.tar.gz"
    sha256 "0aac31e917c24cb3357f5a4d5566f2cc91a19ca41862f6c3c22dc60a629673b6"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/3c/ec/a94f8cf7274ea60b5413df054f82a8980523efd712ec55a59e7c3357cf7c/pyparsing-2.2.0.tar.gz"
    sha256 "0832bcf47acd283788593e7a0f542407bd9550a55a8a8435214a1960e04bcb04"
  end

  resource "PyPDF2" do
    url "https://files.pythonhosted.org/packages/b4/01/68fcc0d43daf4c6bdbc6b33cc3f77bda531c86b174cac56ef0ffdb96faab/PyPDF2-1.26.0.tar.gz"
    sha256 "e28f902f2f0a1603ea95ebe21dff311ef09be3d0f0ef29a3e44a932729564385"
  end

  resource "reportlab" do
    url "https://files.pythonhosted.org/packages/87/f9/53b34c58d3735a6df7d5c542bf4de60d699cfa6035e113ca08b3ecdcca3f/reportlab-3.4.0.tar.gz"
    sha256 "5beaf35e59dfd5ebd814fdefd76908292e818c982bd7332b5d347dfd2f01c343"
  end

  resource "ruffus" do
    url "https://files.pythonhosted.org/packages/97/fe/12445c6793350ab5dbf76cb87a122b9e9aab9a9040a2801004806d985216/ruffus-2.6.3.tar.gz"
    sha256 "d78728d802013d91d15e5e939554dabce196967734850fa44634dce47e3e5061"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz"
    sha256 "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a"
  end

  def install
    ENV.append ["SETUPTOOLS_SCM_PRETEND_VERSION"], "v5.0.1"
    ENV.each do |key, value|
      puts "#{key}:#{value}"
    end
    virtualenv_install_with_resources
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/ocrmypdf", "--version"
  end
end
