
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

# Run First

`sudo apt update`{{exec}}

# Gradio

https://www.gradio.app/guides/quickstart





`python -V`{{exec}}
`mkdir gradio`{{exec}}

`cd gradio`{{exec}}



### fix some dependency issues:
`pip install jinja2==2.11.2 markupsafe==2.0.1`{{exec}}

`pip install gradio`{{exec}}

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



