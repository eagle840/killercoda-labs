## Run First

`sudo apt update`{{exec}}

`python -V`{{exec}}



`apt install python3.12-venv`{{exec}}

https://www.gradio.app/guides/quickstart

`mkdir gradio`{{exec}}

`cd gradio`{{exec}}

`python -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

`pip install --upgrade pip`{{exec}}

We'll be using pip-tools to get a trouble free install of multiple packages

`pip install pip-tools`{{exec}}

manual load each for now

pytorch: https://pytorch.org/get-started/locally/

`pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu`{{exec}}

`python -m pip install tranformers`{{exec}}

`python -m pip install tensorflow`{{exec}}# appears to work

`python -m pip install tf-keras`{{exec}}

`python -m pip install gradio`{{exec}}


`touch requirements.in`{{exec}}

copy the following into that file

```
gradio
tensorflow
transformers
```{{copy}}

```
gradio
tensorflow
transformers
tf-keras
torch
```{{copy}}

and run

`pip-compile`{{exec}} # Runs against requirements.in, and takes a while. The output being requirements.txt


WIP: the following appears to cause the killacoda session to terminate

`pip install -r requirements.txt`{{exec}}

WIP CONSIDER

see https://github.com/huggingface/transformers/blob/main/docker/transformers-pytorch-gpu/Dockerfile

This is for a GPU, try and find one without a gpu


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
