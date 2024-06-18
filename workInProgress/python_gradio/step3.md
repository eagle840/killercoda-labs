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
