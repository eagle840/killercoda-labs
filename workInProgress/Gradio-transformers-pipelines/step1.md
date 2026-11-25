# Install the Tools and Build a Sentiment Interface

## Concept: what a pipeline gives you

A `transformers` **pipeline** is the shortest path from text to a model prediction. You give it a task name, such as `"sentiment-analysis"`, and it returns a Python callable. Calling that function with a string gives you structured results such as a label and a confidence score.

Behind the scenes the pipeline downloads a model from the Hugging Face Hub, prepares the text, runs the model, and formats the output. For now, treat that as a black box. In the next step we will open the box just enough to see the tokenizer, the model, and the scores.

We will pin the model explicitly:

```text
distilbert-base-uncased-finetuned-sst-2-english
```

Pinning the model makes the lab reproducible. The model download happens the first time the pipeline is created, so the first launch may take a minute or two.

## Install `uv` and create a virtual environment

Install `uv`, which will create a clean Python environment and install packages quickly:

`curl -LsSf https://astral.sh/uv/install.sh | sh`{{execute}}

Load the `uv` shell helper, create a project directory, and enter it:

`source $HOME/.local/bin/env`{{execute}}

`mkdir -p ~/gradio-nlp`{{execute}}

`cd ~/gradio-nlp`{{execute}}

Create and activate a virtual environment:

`uv venv`{{execute}}

`source .venv/bin/activate`{{execute}}

Install the CPU-only PyTorch wheel first. We do not need `torchvision` or `torchaudio` because this lab only handles text:

`uv pip install torch==2.15.0 --index-url https://download.pytorch.org/whl/cpu`{{execute}}

Install the remaining pinned packages:

`uv pip install transformers==4.57.6 gradio==5.44.1 sentencepiece==0.2.1`{{execute}}

Check that the imports work:

`python -c "import torch, transformers, gradio; print(torch.__version__, transformers.__version__, gradio.__version__)"`{{execute}}

You should see version numbers similar to:

```text
2.15.0+cpu 4.57.6 5.44.1
```

## Gradio: wrap the pipeline in `gr.Interface`

`gr.Interface` is the simplest Gradio abstraction. It connects:

- `fn`: the Python function to call
- `inputs`: the browser component that supplies the argument
- `outputs`: the browser component that displays the return value

Create a new file:

`touch app.py`{{execute}}

Copy the complete first version of `app.py` into the file, replacing anything currently in it:

```python
from transformers import pipeline
import gradio as gr


classifier = pipeline(
    "sentiment-analysis",
    model="distilbert-base-uncased-finetuned-sst-2-english",
)


def classify_sentiment(text):
    result = classifier(text)[0]
    return result["label"]


demo = gr.Interface(
    fn=classify_sentiment,
    inputs=gr.Textbox(label="Movie review"),
    outputs=gr.Textbox(label="Sentiment"),
    title="Sentiment Lab",
    description="Enter a sentence and see the model's sentiment label.",
)

demo.launch(server_name="0.0.0.0", server_port=8080)
```{{copy}}

Run it:

`python app.py`{{execute}}

Open the app:

{{TRAFFIC_HOST1_8080}}

Try these inputs:

```text
I really enjoyed this movie.
```

```text
The plot was boring and too long.
```

The output should be `POSITIVE` or `NEGATIVE`.

## What you learned

You created a reproducible CPU-only environment, built a sentiment pipeline with a pinned model, and exposed it through a Gradio `Interface`. The next step will reveal what happens inside that pipeline and add the confidence score to the interface.
