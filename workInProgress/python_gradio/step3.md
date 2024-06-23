# The Interface class



READ and follow from https://www.gradio.app/guides/the-interface-class

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


---


To share your app anywhere, and the following to the launch method

WIP
`demo.launch(share=True)  # Share your demo with just 1 extra parameter`{{exec}}


API details for the launch method. https://www.gradio.app/docs/gradio/interface#interface-launch

More on the python client: https://www.gradio.app/docs/python-client/introduction

