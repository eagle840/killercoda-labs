# Step 3


---

# WIP

## wheel failure

`python -V`{{exec}}

`pip -V`{{exec}}

Wheel failures during Python package installations can be frustrating, but there are several steps you can take to prevent them:

1. **Upgrade pip and setuptools**: Make sure you have the latest versions of pip and setuptools installed. You can upgrade them using the following commands:

 1.   pip install --upgrade pip
 2.   pip install --upgrade setuptools


2. **Use a virtual environment**: Create a virtual environment for your Python projects to isolate dependencies. This can help prevent conflicts and ensure a clean environment for package installations. You can create a virtual environment using `virtualenv` or `venv`.

3. **Check for system dependencies**: Some Python packages require system-level dependencies to be installed. Make sure you have the necessary libraries and tools installed on your system before installing the Python packages.

4. **Check for compatibility**: Ensure that the Python packages you are trying to install are compatible with the version of Python you are using. Some packages may not support the version of Python you have installed, leading to installation failures.

5. **Use pre-built wheels**: If you are facing issues with building wheels during installation, you can try using pre-built wheels instead. You can download pre-built wheels from websites like `https://www.lfd.uci.edu/~gohlke/pythonlibs/` for Windows or use a package manager like `apt` for Linux.

6. **Check for network issues**: Sometimes network issues can cause failures during package installations. Make sure you have a stable internet connection and try switching to a different network if you continue to face issues.

7. **Check for disk space**: Ensure that you have enough disk space available on your system. Lack of disk space can cause installation failures.

By following these steps, you can reduce the chances of encountering wheel failures during Python package installations.


---


https://www.gradio.app/guides/gradio-lite#additional-requirements


WIP this appears to be fot micropip?
https://huggingface.co/docs/transformers.js/index


use https://huggingface.co/docs/transformers.js/en/index#quick-tour



`pip install tensorflow`{{exec}}

`pip install transformers`{{exec}}



```python
from transformers import pipeline
import gradio as gr

pipe = pipeline('sentiment-analysis')

def classify(text):
	return pipe(text)

demo = gr.Interface(classify, "textbox", "json")
demo.launch(server_name="0.0.0.0", server_port=8080)
```{{copy}}

WIP getting

```
ImportError: cannot import name 'TypeAliasType' from 'typing_extensions' (/usr/local/lib/python3.8/dist-packages/typing_extensions.py)
```

`python app.py`{{exec}}

{{TRAFFIC_HOST1_8080}}
