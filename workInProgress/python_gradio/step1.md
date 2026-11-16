## Run First


`curl -LsSf https://astral.sh/uv/install.sh | sh`{{exec}}

`mkdir gradioT`{{exec}}

`cd gradioT`{{exec}}

`source $HOME/.local/bin/env`{{exec}}

`uv venv`{{exec}}

`source .venv/bin/activate`{{exec}}

`uv pip  install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu`{{exec}}

`uv pip  install transformers tensorflow tf-keras gradio`{{exec}}


https://www.gradio.app/guides/quickstart

WIP:

`pip install pip-tools`{{exec}}



pytorch: https://pytorch.org/get-started/locally/

WIP:


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

# demo.launch(server_name="0.0.0.0", server_port=8080, debug=True)

```{{copy}}


`python app.py`{{exec}}

And open the following link to inspect.

{{TRAFFIC_HOST1_8080}}
