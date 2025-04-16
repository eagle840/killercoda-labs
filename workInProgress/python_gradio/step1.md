## Run First

`sudo apt update`{{exec}}

`python -V`{{exec}}

`pip install --upgrade pip`{{exec}}

`apt install python3.12-venv`{{exec}}

https://www.gradio.app/guides/quickstart

`mkdir gradio`{{exec}}

`cd gradio`{{exec}}

`python -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

We'll be using pip-tools to get a trouble free install of multiple packages

`pip install pip-tools`{{exec}}

`touch requirements.txt`{{exec}}

copy the following into that file

```
gradio
tensorflow
transformers
```{{copy}}

and run

`pip-compile`{{exec}} # Runs against requirements.in, and takes a while. The output being requirements.txt


`pip install -r requirements.txt`{{exec}}


# Run the App

`touch app.py`{{exec}}

```python
import gradio as gr

def greet(name, intensity):
    return "Hello, " + name + "!" * int(intensity)

# Note how the def function is used to couple fn the 'inputs' and 'output'

demo = gr.Interface(
    fn=greet,
    inputs=["text", "slider"],
    outputs=["text"],
)

demo.launch(server_name="0.0.0.0", server_port=8080)

```{{copy}}


`python app.py`{{exec}}

And open the following link to inspect.

{{TRAFFIC_HOST1_8080}}
