
class Ocrmypdf < Formula
  include Language::Python::Virtualenv

  desc "Adds an OCR text layer to scanned PDF files"
  homepage "https://github.com/jbarlow83/OCRmyPDF"
  url "https://files.pythonhosted.org/packages/c9/1a/99115c743245066e6ea8004c68a0c0356ba443fe4ea8e9cfcf9b28192efb/ocrmypdf-6.2.0.tar.gz"
  sha256 "d0f0134b515fb6c7a8881c9ca930dfe59ac81ee5577c441e9e7ff787958b5d01"

  depends_on "pkg-config" => :build
  depends_on "mupdf-tools" => :build  # statically links libmupdf.a
  depends_on "freetype"
  depends_on "ghostscript"
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "python"
  depends_on "qpdf"
  depends_on "tesseract"
  depends_on "unpaper"

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/e7/a7/4cd50e57cc6f436f1cc3a7e8fa700ff9b8b4d471620629074913e3735fb2/cffi-1.11.5.tar.gz"
    sha256 "e90f17980e6ab0f3c2f3730e56d1fe9bcba1891eeea58966e89d352492cc74f4"
  end

  resource "img2pdf" do
    url "https://files.pythonhosted.org/packages/7e/a2/4f06081f674920be757d894b4bab874e6a3b5227e730cb7618430b366e69/img2pdf-0.2.4.tar.gz"
    sha256 "140b70fa3a3bfb54e92947818cee01483a4f1492b5d1d02b0f649257f5ffc9ae"
  end

  resource "pikepdf" do
    url "https://files.pythonhosted.org/packages/73/cd/a4c8249890f30954dcc79173565ab118972eac66df8975cc0f07b768514a/pikepdf-0.1.10.tar.gz"
    sha256 "03340e3c38b38fca2cbb2a95e135897441ae217e8d51f682bc2e01de099ad1de"
  end

  resource "Pillow" do
    url "https://files.pythonhosted.org/packages/0f/57/25be1a4c2d487942c3ed360f6eee7f41c5b9196a09ca71c54d1a33c968d9/Pillow-5.0.0.tar.gz"
    sha256 "12f29d6c23424f704c66b5b68c02fe0b571504459605cfe36ab8158359b0e1bb"
  end

  resource "pybind11" do
    url "https://files.pythonhosted.org/packages/95/30/788a5c943f1399e05b52148504dffa7a801ea52eb5bb5cac0cc828306278/pybind11-2.2.3.tar.gz"
    sha256 "87ff3ae777d9326349af5272974581270b2a0909b2392dc0cc57eb28ce23bcc3"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/8c/2d/aad7f16146f4197a11f8e91fb81df177adcc2073d36a17b1491fd09df6ed/pycparser-2.18.tar.gz"
    sha256 "99a8ca03e29851d96616ad0404b4aad7d9ee16f25c9f9708a11faf2810f7b226"
  end

  resource "python-xmp-toolkit" do
    url "https://files.pythonhosted.org/packages/5b/0b/4f95bc448e4e30eb0e831df0972c9a4b3efa8f9f76879558e9123215a7b7/python-xmp-toolkit-2.0.1.tar.gz"
    sha256 "f8d912946ff9fd46ed5c7c355aa5d4ea193328b3f200909ef32d9a28a1419a38"
  end

  resource "pytz" do
    url "https://files.pythonhosted.org/packages/10/76/52efda4ef98e7544321fd8d5d512e11739c1df18b0649551aeccfb1c8376/pytz-2018.4.tar.gz"
    sha256 "c06425302f2cf668f1bba7a0a03f3c1d34d4ebeef2c72003da308b3947c7f749"
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
    venv = virtualenv_create(libexec, "python3")

    resource("Pillow").stage do
      inreplace "setup.py" do |s|
        sdkprefix = MacOS::CLT.installed? ? "" : MacOS.sdk_path
        s.gsub! "openjpeg.h", "probably_not_a_header_called_this_eh.h"
        s.gsub! "ZLIB_ROOT = None", "ZLIB_ROOT = ('#{sdkprefix}/usr/lib', '#{sdkprefix}/usr/include')"
        s.gsub! "JPEG_ROOT = None", "JPEG_ROOT = ('#{Formula["jpeg"].opt_prefix}/lib', '#{Formula["jpeg"].opt_prefix}/include')"
        s.gsub! "FREETYPE_ROOT = None", "FREETYPE_ROOT = ('#{Formula["freetype"].opt_prefix}/lib', '#{Formula["freetype"].opt_prefix}/include')"
      end

      # avoid triggering "helpful" distutils code that doesn't recognize Xcode 7 .tbd stubs
      ENV.append "CFLAGS", "-I#{MacOS.sdk_path}/System/Library/Frameworks/Tk.framework/Versions/8.5/Headers" unless MacOS::CLT.installed?
      venv.pip_install Pathname.pwd
    end

    res = resources.map(&:name).to_set - ["Pillow"]

    res.each do |r|
      venv.pip_install resource(r)
    end

    venv.pip_install_and_link buildpath
  end

  test do
    # Since we use Python 3, we require a UTF-8 locale
    ENV["LC_ALL"] = "en_US.UTF-8"

    system "#{bin}/ocrmypdf", "-f", "-q", "--deskew",
                              test_fixtures("test.pdf"), "ocr.pdf"
    assert_predicate testpath/"ocr.pdf", :exist?
  end
end
