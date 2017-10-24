
Please run ``brew update`` and check ``brew doctor`` to make sure your system is ready to brew.

If you encounter an error message whose last line is ``pip.exceptions.InstallationError``, this error message produced by the Homebrew/Python installation code, and unfortunately it hides the real error message (but still provides a bit of information). To help with this one, please run 

```
	brew install --keep-tmp --debug ocrmypdf
```

That tells ``brew`` to put all of the intermediate files it generates in ``~/Library/Logs/Homebrew/ocrmypdf``. If you are getting the ``pip.exceptions.InstallationError`` please include a .zip of those intermediate files.
