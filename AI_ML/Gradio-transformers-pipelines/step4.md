# Add Zero-Shot Classification with Tabs

## Concept: zero-shot classification

Sentiment analysis asks a model to choose from labels it was trained for. **Zero-shot classification** is more flexible: you provide the candidate labels at request time.

For example, given the sentence “The battery lasted two full days”, you might supply:

```text
battery, camera, delivery, price
```

The model compares the text against each label and returns a score for every label. No extra training is needed, which makes this useful for quickly exploring a classification problem.

We will pin:

```text
valhalla/distilbart-mnli-12-1
```

This checkpoint is a natural-language-inference model adapted for zero-shot classification.

## Concept: `gr.Blocks` and `gr.Tab`

`gr.Interface` is excellent for one input-to-output function. `gr.Blocks` gives us a layout so several functions can live in one app.

A tab is created with:

```python
with gr.Tab("Name"):
    ...
```

Inside a tab, we create components and then connect a button with `.click(fn, inputs, outputs)`. The button calls the Python function with the current input component value and writes the return value to the output component.

The rest of the lab will keep extending this same Blocks app.

## Gradio: replace the app with two tabs

If the previous Gradio server is still running, press `Ctrl-C` first. Replace the whole contents of `app.py` with this version:

```python
from transformers import pipeline
import gradio as gr


SENTIMENT_MODEL = "distilbert-base-uncased-finetuned-sst-2-english"
ZERO_SHOT_MODEL = "valhalla/distilbart-mnli-12-1"

sentiment = pipeline("sentiment-analysis", model=SENTIMENT_MODEL)
zeroshot = pipeline("zero-shot-classification", model=ZERO_SHOT_MODEL)


def classify_sentiment(text):
    result = sentiment(text)[0]
    label = result["label"]
    confidence = result["score"]
    return f"{label} ({confidence:.3f})"


def classify_zero_shot(text, labels_text):
    candidate_labels = [
        label.strip() for label in labels_text.split(",") if label.strip()
    ]

    if not text.strip() or not candidate_labels:
        return "Enter some text and at least one candidate label."

    result = zeroshot(text, candidate_labels=candidate_labels)

    lines = [
        f"{label}: {score:.3f}"
        for label, score in zip(result["labels"], result["scores"])
    ]
    return "\n".join(lines)


with gr.Blocks() as demo:
    gr.Markdown("# NLP Playground")
    gr.Markdown("Two text models behind one Gradio app.")

    with gr.Tab("Sentiment"):
        sentiment_input = gr.Textbox(label="Text to analyze", lines=3)
        sentiment_output = gr.Textbox(label="Predicted sentiment")
        sentiment_button = gr.Button("Classify sentiment")

        sentiment_button.click(
            classify_sentiment,
            inputs=sentiment_input,
            outputs=sentiment_output,
        )

    with gr.Tab("Zero-shot"):
        zero_shot_input = gr.Textbox(label="Text to classify", lines=3)
        labels_input = gr.Textbox(
            label="Candidate labels (comma-separated)",
            value="battery, camera, delivery, price",
        )
        zero_shot_output = gr.Textbox(label="Label scores")
        zero_shot_button = gr.Button("Classify zero-shot")

        zero_shot_button.click(
            classify_zero_shot,
            inputs=[zero_shot_input, labels_input],
            outputs=zero_shot_output,
        )


demo.launch(server_name="0.0.0.0", server_port=8080)
```{{copy}}

Run the app:

`python app.py`{{execute}}

Open the app:

{{TRAFFIC_HOST1_8080}}

In the **Zero-shot** tab, try this text:

```text
The battery lasted two full days, but the camera is disappointing.
```

Use the default candidate labels. You should see a ranked list with a score for each label.

Then switch to the **Sentiment** tab and confirm that the original function still works.

## What you learned

You used a zero-shot pipeline with candidate labels supplied at runtime, and you converted the app from a single `Interface` into a two-tab `Blocks` layout with button event handlers.
