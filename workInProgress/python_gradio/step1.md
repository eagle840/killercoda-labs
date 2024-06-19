
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

WIP remove 3.8 `sudo apt remove python3.8`{{exec}}

`sudo add-apt-repository -y ppa:deadsnakes/ppa`{{exec}}

`sudo apt-get update`{{exec}}

`apt-get install -y python3.10`{{exec}}

`apt-get install -y python3.11`{{exec}}



sudo apt update
    4  pip3 install --upgrade pip      
    5  apt install python3.8-venv   
    6  mkdir gradio   
    7  cd gradio   
    8  python3 -m venv .venv   
    9  source .venv/bin/activate   
   10  pip3 install wheel   
   11  pip install transformers==4.28.1   
   12  pip install gradio   




## Run First

`sudo apt update`{{exec}}

wip TRY MiniConda?

`pip3 install --upgrade pip`{{exec}}

WIP   `pip3 install --upgrade setuptools`{{exec}}

`apt install python3.8-venv`{{exec}}


WIP JUMP TO STEP 2

## Gradio

https://www.gradio.app/guides/quickstart



`python -V`{{exec}}

`mkdir gradio`{{exec}}

`cd gradio`{{exec}}

## clean python install

`python3 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

WIP `pip3 install wheel`{{exec}}

The above (particles wheel) seems to have resolved issues, copy over to the install python lab

### fix some dependency issues:
WIP remove `pip install jinja2==2.11.2 markupsafe==2.0.1`{{copy}}

`pip3 install gradio=4.5.0`{{exec}}

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
