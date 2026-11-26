# Add Named-Entity Recognition Highlights

## Concept: named-entity recognition

Named-entity recognition, or NER, finds spans of text that belong to categories such as people, organizations, locations, and dates.

The output is a list of entities. Each entity includes the matched text, a category label, a confidence score, and character offsets into the original string.

We will pin:

```text
dslim/bert-base-NER
```

This lab uses:

```python
aggregation_strategy="simple"
```

That setting merges model subword pieces into whole words and returns character offsets that align with the original text. It also gives Gradio’s `HighlightedText` component convenient category names such as `PER`, `ORG`, and `LOC`.

Do not use the deprecated `grouped_entities=True` option here.

## Gradio: add the Entities tab

If the previous Gradio server is still running, press `Ctrl-C` first. Replace the whole contents of `app.py` with the final four-tab version:

```python
from transformers import pipeline
import gradio as gr


SENTIMENT_MODEL = "distilbert-base-uncased-finetuned-sst-2-english"
ZERO_SHOT_MODEL = "valhalla/distilbart-mnli-12-1"
SUMMARIZATION_MODEL = "t5-small"
NER_MODEL = "dslim/bert-base-NER"

sentiment = pipeline("sentiment-analysis", model=SENTIMENT_MODEL)
zeroshot = pipeline("zero-shot-classification", model=ZERO_SHOT_MODEL)
summarizer = pipeline("summarization", model=SUMMARIZATION_MODEL)
ner = pipeline(
    "ner",
    model=NER_MODEL,
    aggregation_strategy="simple",
)


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


def summarize_text(text):
    if not text.strip():
        return "Enter some text to summarize."

    result = summarizer(
        "summarize: " + text,
        max_length=60,
        min_length=15,
        do_sample=False,
    )
    return result[0]["summary_text"]


def find_entities(text):
    if not text.strip():
        return {"text": "", "entities": []}

    return {"text": text, "entities": ner(text)}


with gr.Blocks() as demo:
    gr.Markdown("# NLP Playground")
    gr.Markdown("Four text models behind one Gradio app.")

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

    with gr.Tab("Summarization"):
        summary_input = gr.Textbox(label="Article text", lines=8)
        summary_output = gr.Textbox(label="Summary", lines=4)
        summary_button = gr.Button("Summarize")

        summary_button.click(
            summarize_text,
            inputs=summary_input,
            outputs=summary_output,
        )

    with gr.Tab("Entities"):
        ner_input = gr.Textbox(label="Text with people or places", lines=4)
        ner_output = gr.HighlightedText(label="Detected entities")
        ner_button = gr.Button("Find entities")

        ner_button.click(
            find_entities,
            inputs=ner_input,
            outputs=ner_output,
        )


demo.launch(server_name="0.0.0.0", server_port=8080)
```{{copy}}

Run the final app:

`python app.py`{{execute}}

Open the app:

{{TRAFFIC_HOST1_8080}}

In the **Entities** tab, try:

```text
Ada Lovelace worked with Charles Babbage in London.
```

Names and places should be highlighted with their entity labels. Then click through the other three tabs to confirm that the accumulated app still works as a single Gradio program.

## What you learned

You used an NER pipeline with simple aggregation, passed its character-offset output into `gr.HighlightedText`, and completed the final four-tab Gradio app.
