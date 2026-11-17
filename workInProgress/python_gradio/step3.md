# Choose a Model and Improve the Interface

## Concept: the `model=` argument

The task name tells `transformers` what kind of pipeline to create. The `model=` argument tells it **which checkpoint** to download and run.

That distinction matters:

- `"sentiment-analysis"` describes the job.
- `distilbert-base-uncased-finetuned-sst-2-english` is one particular model for that job.
- Other sentiment models may use different training data, languages, or label sets.

A checkpoint name usually contains a model family and the task it was fine-tuned for. In the next step we will use a model whose checkpoint name does not obviously say “zero-shot”, so the explicit `model=` argument will keep the lab predictable.

For this step, keep the current default model but store it in a `MODEL` variable. That makes swapping models a one-line change.

## Gradio: descriptions, labels, and examples

`gr.Interface` also supports small UX improvements:

- `title` gives the page a heading.
- `description` explains what the app does.
- Component `label=` text tells the learner what to enter.
- `examples` provides clickable sample inputs.

If the previous Gradio server is still running, press `Ctrl-C` first. Replace the whole contents of `app.py` with this version:

```python
from transformers import pipeline
import gradio as gr


MODEL = "distilbert-base-uncased-finetuned-sst-2-english"

classifier = pipeline("sentiment-analysis", model=MODEL)


def classify_sentiment(text):
    result = classifier(text)[0]
    label = result["label"]
    confidence = result["score"]
    return f"{label} ({confidence:.3f})"


demo = gr.Interface(
    fn=classify_sentiment,
    inputs=gr.Textbox(
        label="Text to analyze",
        lines=3,
        placeholder="Type a short review or opinion...",
    ),
    outputs=gr.Textbox(label="Predicted sentiment"),
    title="Sentiment Explorer",
    description=(
        "Enter English text and compare the label and confidence returned by "
        "a pinned sentiment model."
    ),
    examples=[
        ["I love how easy this model is to use."],
        ["This update made the app much worse."],
        ["The delivery arrived on time and the packaging was fine."],
    ],
)

demo.launch(server_name="0.0.0.0", server_port=8080)
```{{copy}}

Run it:

`python app.py`{{execute}}

Open the app:

{{TRAFFIC_HOST1_8080}}

Click an example, or type your own sentence. Notice that the app now tells the learner what to do and offers useful starting inputs.

## Swap the model and compare

Now change only this line in `app.py`:

```python
MODEL = "distilbert-base-uncased-finetuned-sst-2-english"
```

to:

```python
MODEL = "nlptown/bert-base-multilingual-uncased-sentiment"
```

Stop the server with `Ctrl-C`, run `python app.py` again, and open {{TRAFFIC_HOST1_8080}}. Try the same examples.

The alternative model uses a star-rating label set such as `1 star` through `5 stars`, so the output format will look different. This is a useful reminder that changing the checkpoint can change both the behavior and the labels, not just the accuracy.

You do not need to keep the alternative model. The following steps will replace `app.py` with newer full versions.

## What you learned

You made the model choice explicit, added user-facing descriptions and examples, and observed how changing a checkpoint can change the output labels and style.
