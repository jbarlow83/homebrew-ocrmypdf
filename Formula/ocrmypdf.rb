
class Ocrmypdf < Formula
  include Language::Python::Virtualenv

  desc "Adds an OCR text layer to scanned PDF files"
  homepage "https://github.com/jbarlow83/OCRmyPDF"
  url "https://files.pythonhosted.org/packages/6d/c4/764d141f612a9cf323cba31164236fb9a499c1cd932309117e1218e72c8c/ocrmypdf-5.4.2.tar.gz"
  sha256 "464654a7eb08c3d40c2ebac676326b4c48343bdd72f0a4abb6ba38fd2582d921"

  depends_on :python3
  depends_on :x11  # Pillow needs XQuartz
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
  depends_on "zlib"

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

  resource "Pillow" do
    url "https://files.pythonhosted.org/packages/93/73/66854f63b1941aad9af18a1de59f9cf95ad1a87c801540222e332f6688d7/Pillow-4.1.1.tar.gz"
    sha256 "00b6a5f28d00f720235a937ebc2f50f4292a5c7e2d6ab9a8b26153b625c4f431"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/8c/2d/aad7f16146f4197a11f8e91fb81df177adcc2073d36a17b1491fd09df6ed/pycparser-2.18.tar.gz"
    sha256 "99a8ca03e29851d96616ad0404b4aad7d9ee16f25c9f9708a11faf2810f7b226"
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

  def install
    ENV.append ["SETUPTOOLS_SCM_PRETEND_VERSION"], "v5.4.2"
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
