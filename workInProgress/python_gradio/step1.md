## Run First

`sudo apt update`{{exec}}

`pip3 install --upgrade pip`{{exec}}

`apt install python3.8-venv`{{exec}}


## Gradio

https://www.gradio.app/guides/quickstart

`mkdir gradio`{{exec}}

`cd gradio`{{exec}}

## clean python install

`python3 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

`pip install pip-tools`{{exec}}

**REVIEW** https://pypi.org/project/pip-tools/

`touch requirements.in`{{exec}}

`echo gradio/ntensorflow/ntransformers > requirements.in`{{copy}}

`pip-compile`{{exec}} # takes a while


`pip install -r requirements.txt`{{exec}}

# pipdeptree

`pip install pipdeptree`{{execute}}

`pipdeptree -h`{{execute}}

# app

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

{{TRAFFIC_HOST1_8080}}

To share your app anywhere, and the following to the launch method

WIP
`demo.launch(share=True)  # Share your demo with just 1 extra parameter`{{exec}}


API details for the launch method. https://www.gradio.app/docs/gradio/interface#interface-launch

More on the python client: https://www.gradio.app/docs/python-client/introduction
