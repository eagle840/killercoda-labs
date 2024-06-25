# Gradio Components

## The Interface class



READ and follow the **Guide** from https://www.gradio.app/guides/the-interface-class

For more details items, see the **Docs** at https://www.gradio.app/docs



update the function

```
def greet(name, intensity):
    return "Hello, " + name + "!" * int(intensity)
```

And update the interface class

```
demo = gr.Interface(
    fn=greet,
    inputs=["text", "slider"],
    outputs=["text"],
)
```


you can customise the fields eg, `gr.Textbox(lines=2, placeholder="name here")` for the inputs parameter. [API Docs](https://www.gradio.app/docs/gradio/textbox)

---


To share your app anywhere, and the following to the launch method

WIP
`demo.launch(share=True)  # Share your demo with just 1 extra parameter`{{exec}}


API details for the launch method. https://www.gradio.app/docs/gradio/interface#interface-launch

More on the python client: https://www.gradio.app/docs/python-client/introduction

## Blocks

Used in the layout.

https://www.gradio.app/guides/blocks-and-event-listeners

```
import gradio as gr


def greet(name):
    return "Hello " + name + "!"


with gr.Blocks() as demo:
    name = gr.Textbox(label="Name")
    output = gr.Textbox(label="Output Box")
    greet_btn = gr.Button("Greet")
    greet_btn.click(fn=greet, inputs=name, outputs=output, api_name="greet")

demo.launch()
```{{copy}}