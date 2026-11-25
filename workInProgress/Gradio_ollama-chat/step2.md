# Step 2: Your First Gradio App

It takes only a few lines of Python to turn a function into a web app. In this step you will recreate the official [Gradio Quickstart](https://www.gradio.app/guides/quickstart) demo, run it on port 7860, and open it in the browser.

## Write the app

Make sure you are in the project directory, then create `app.py`:

```bash
cd ~/gradio-lab
cat > app.py <<'EOF'
import os

# Disable Gradio analytics so startup does not depend on external network calls.
os.environ.setdefault("GRADIO_ANALYTICS_ENABLED", "False")

import gradio as gr


def greet(name, intensity):
    return "Hello, " + name + "!" * int(intensity)


demo = gr.Interface(
    fn=greet,
    inputs=[
        gr.Textbox(label="Your name", placeholder="Ada"),
        gr.Slider(minimum=1, maximum=10, value=3, step=1, label="Intensity"),
    ],
    outputs=gr.Textbox(label="Greeting"),
    title="Hello, Gradio!",
    description="Type a name, choose an intensity, and press Submit.",
    api_name="predict",
)

demo.launch(server_name="0.0.0.0", server_port=7860)
EOF
```{{exec}}

The important parts of `gr.Interface` are:

- `fn` — any Python function you want to wrap.
- `inputs` — one component per function argument, in order.
- `outputs` — one component per return value, in order.
- `api_name` — also exposes the function as an HTTP API that you can call programmatically.

Because this is a server, start it in the background and keep its output in `app.log`:

```bash
cd ~/gradio-lab
uv run python app.py
```{{exec}}

Wait for Gradio to finish starting, then check that it responds:



**[Open the Gradio app]({{TRAFFIC_HOST1_7860}})**

You can also use the **Traffic** panel and select port `7860`.

## Try it out

1. Enter your name.
2. Move the intensity slider.
3. Press **Submit** and watch the greeting change.

## Check the server log

Gradio prints the local URL and any errors to the log. If the app does not load, inspect it:

```bash
tail -n 30 ~/gradio-lab/app.log
```{{exec}}


In the next step you will replace this simple layout with a custom `gr.Blocks` interface and call it programmatically.
