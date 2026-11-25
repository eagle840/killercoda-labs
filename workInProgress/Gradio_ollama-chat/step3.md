# Step 3: Customize the UI and Use the API

`gr.Interface` is ideal for simple function-in, result-out demos. For more control over layout and events, Gradio provides `gr.Blocks`.

In this step you will build a small **Text Stats** app with a custom layout, then call it from a Python client.

## Build the app with `gr.Blocks`

Stop the previous server and replace `app.py`:

```bash
cd ~/gradio-lab
cat > app.py <<'EOF'
import os

os.environ.setdefault("GRADIO_ANALYTICS_ENABLED", "False")

import gradio as gr


def analyze(text):
    words = len(text.split())
    characters = len(text)
    lines = len(text.splitlines())
    return f"Words: {words}\nCharacters: {characters}\nLines: {lines}"


with gr.Blocks(title="Text Stats") as demo:
    gr.Markdown(
        "# Text Stats\n"
        "Type or paste some text, then click **Analyze**."
    )

    with gr.Row():
        text_input = gr.Textbox(
            label="Your text",
            lines=8,
            scale=3,
            placeholder="Paste text here...",
        )
        stats_output = gr.Textbox(
            label="Statistics",
            lines=8,
            scale=1,
            interactive=False,
        )

    with gr.Row():
        analyze_button = gr.Button("Analyze", variant="primary")
        clear_button = gr.ClearButton([text_input, stats_output])

    analyze_button.click(
        fn=analyze,
        inputs=text_input,
        outputs=stats_output,
        api_name="analyze",
    )

demo.launch(server_name="0.0.0.0", server_port=7860)
EOF
```{{exec interrupt}}

How this differs from `gr.Interface`:

- `with gr.Blocks() as demo:` creates an app container. Components declared inside it become part of the page.
- `gr.Row()` and `gr.Column()` control layout. Here the input takes three quarters of the row (`scale=3`) and the output takes one quarter (`scale=1`).
- `analyze_button.click(...)` wires an event. The first argument is the function; `inputs` and `outputs` connect components.
- `api_name="analyze"` exposes the event at `/analyze` for HTTP and Python clients.
- `gr.ClearButton` is a built-in component that resets the components you give it.

## Run it

Start the new version in the background:

```bash
cd ~/gradio-lab
uv run python app.py 
```{{exec}}



Open the app and test it:

**[Open the Text Stats app]({{TRAFFIC_HOST1_7860}})**

Paste a few paragraphs and click **Analyze**. Then try the **Clear** button.

## Call the app from Python

Every Gradio app is also an API. The `gradio_client` package is installed as a dependency of `gradio`.

Leave the gradio program running, and n a new tab, Create a small client:

```bash
cd ~/gradio-lab
cat > client_demo.py <<'EOF'
from gradio_client import Client

client = Client("http://localhost:7860/")
client.view_api()

result = client.predict(
    "Gradio makes it easy to build machine learning demos.",
    api_name="/analyze",
)
print("Result:")
print(result)
EOF
```{{exec}}

Run it:

```bash
cd ~/gradio-lab
uv run python client_demo.py
```{{exec}}

You should see a description of the available endpoint followed by the word, character, and line counts.

This is the same mechanism you could use from another service, a scheduled job, or a test suite. You can also click **Use via API** at the bottom of the Gradio page to see generated client code.



Next, you will install Ollama and a small language model to power a real chatbot.
