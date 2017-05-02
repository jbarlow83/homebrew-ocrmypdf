
class Ocrmypdf < Formula
  include Language::Python::Virtualenv

  desc "Adds an OCR text layer to scanned PDF files"
  homepage "https://github.com/jbarlow83/OCRmyPDF"
  url "https://files.pythonhosted.org/packages/3e/38/aa3de363b5a268ec549365303fae282dbc8d4bf84dd42ac566cd99421c52/ocrmypdf-4.5.6.tar.gz"
  sha256 "713c7fd01a6b8e415d69803f1498705bbbe079f80c3b65569dd6fbcc589fc318"

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

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/a1/32/e3d6c3a8b5461b903651dd6ce958ed03c093d2e00128e3f33ea69f1d7965/cffi-1.9.1.tar.gz"
    sha256 "563e0bd53fda03c151573217b3a49b3abad8813de9dd0632e10090f6190fdaf8"
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
    url "https://files.pythonhosted.org/packages/8d/80/eca7a2d1a3c2dafb960f32f844d570de988e609f5fd17de92e1cf6a01b0a/Pillow-4.0.0.tar.gz"
    sha256 "ee26d2d7e7e300f76ba7b796014c04011394d0c4a5ed9a288264a3e443abca50"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/be/64/1bb257ffb17d01f4a38d7ce686809a736837ad4371bcc5c42ba7a715c3ac/pycparser-2.17.tar.gz"
    sha256 "0aac31e917c24cb3357f5a4d5566f2cc91a19ca41862f6c3c22dc60a629673b6"
  end

  resource "PyPDF2" do
    url "https://files.pythonhosted.org/packages/b4/01/68fcc0d43daf4c6bdbc6b33cc3f77bda531c86b174cac56ef0ffdb96faab/PyPDF2-1.26.0.tar.gz"
    sha256 "e28f902f2f0a1603ea95ebe21dff311ef09be3d0f0ef29a3e44a932729564385"
  end

  resource "reportlab" do
    url "https://files.pythonhosted.org/packages/b8/17/7c5342dfbc9dc856173309270006e34c3bfad59934f0faa1dcc117ac93f1/reportlab-3.3.0.tar.gz"
    sha256 "f48900b9321bcb2871a46543993bd995148d769a11a9e24495f25b4ec0bbe267"
  end

  resource "ruffus" do
    url "https://files.pythonhosted.org/packages/97/fe/12445c6793350ab5dbf76cb87a122b9e9aab9a9040a2801004806d985216/ruffus-2.6.3.tar.gz"
    sha256 "d78728d802013d91d15e5e939554dabce196967734850fa44634dce47e3e5061"
  end


  def install
    ENV.append ["SETUPTOOLS_SCM_PRETEND_VERSION"], "v4.5.6"
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
