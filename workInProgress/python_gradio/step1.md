## Run First

`sudo apt update`{{exec}}

`pip3 install --upgrade pip`{{exec}}

`apt install python3.8-venv`{{exec}}

https://www.gradio.app/guides/quickstart

`mkdir gradio`{{exec}}

`cd gradio`{{exec}}

`python3 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

We'll be using pip-tools to get a trouble free install of multiple packages

`pip install pip-tools`{{exec}}

`touch requirements.in`{{exec}}

copy the following into that file

```
gradio
tensorflow
transformers
```{{copy}}

`pip-compile`{{exec}} # takes a while

`pip install -r requirements.txt`{{exec}}


# Run the App

`touch app.py`{{exec}}

```python
import gradio as gr

def greet(name, intensity):
    return "Hello, " + name + "!" * int(intensity)

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

