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
nohup uv run python app.py > app.log 2>&1 &
echo "Started PID $!"
```{{exec}}

Wait for Gradio to finish starting, then check that it responds:

```bash
for i in $(seq 1 30); do
  if curl -sf http://localhost:7860 >/dev/null; then
    echo "Gradio is up."
    break
  fi
  sleep 1
done
curl -s -o /dev/null -w "HTTP status: %{http_code}\n" http://localhost:7860
```{{exec}}

If the status is `200`, open the app:

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

## Hot reload (optional)

While developing, you can let Gradio watch the file and reload on every save. Stop the background server first:

```bash
pkill -f "[p]ython app.py" 2>/dev/null || true
cd ~/gradio-lab
uv run gradio app.py
```{{exec interrupt}}

Gradio reloads `app.py` whenever you change it. Press `Ctrl+C` in the terminal to stop it.

In the next step you will replace this simple layout with a custom `gr.Blocks` interface and call it programmatically.
