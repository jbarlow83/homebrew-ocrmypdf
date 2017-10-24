=================
Homebrew OCRmyPDF
=================

.. image:: https://travis-ci.org/jbarlow83/homebrew-ocrmypdf.svg?branch=master
    :target: https://travis-ci.org/jbarlow83/homebrew-ocrmypdf

This tap contains a formula to install `OCRmyPDF <https://github.com/jbarlow83/OCRmyPDF>`_ on macOS using Homebrew.

.. code::

	brew tap jbarlow83/ocrmypdf
	brew install ocrmypdf


Troubleshooting
===============

Please run ``brew update`` and check ``brew doctor`` to make sure your system is ready to brew.

If you encounter an error message whose last line is ``pip.exceptions.InstallationError``, this error message produced by the Homebrew/Python installation code, and unfortunately it hides the real error message (but still provides a bit of information). To help with this one, please run 

.. code::

	brew install --keep-tmp --debug ocrmypdf

That tells ``brew`` to put all of the intermediate files it generates in ``~/Library/Logs/Homebrew/ocrmypdf``. If you are getting the ``pip.exceptions.InstallationError`` please include a .zip of those intermediate files.


Alternative
-----------

If the homebrew version is not working for you, or if you prefer to not use homebrew, try the `manual installation procedure for macOS <https://ocrmypdf.readthedocs.io/en/latest/installation.html#manual-installation-on-macos>`_ .
