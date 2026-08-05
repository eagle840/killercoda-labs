# Step 6: Build and Publish

Now that your project is linted and tested, it's time to package it for distribution.

### Building
Use `uv build` to package your project into standard formats (wheels and source distributions).
```bash
uv build
```{{exec}}

### Publishing to PyPI
To share your project, you would publish it to **PyPI (Python Package Index)**, the official repository for Python packages.

For testing purposes, always use **TestPyPI** first. TestPyPI is a separate instance of the PyPI repository that allows you to test your distribution without affecting the real package index.

To publish, you would use:
```bash
# Example: Publishing to TestPyPI
uv publish --index https://test.pypi.org/legacy/
```

*Note: You would need an account on PyPI/TestPyPI and an API token to successfully publish.*
