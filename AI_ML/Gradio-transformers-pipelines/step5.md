# Add a Summarization Tab

## Concept: text-to-text summarization

Some models are trained to produce new text rather than choose a label. Summarization is a text-to-text task: the input is a longer passage and the output is a shorter passage.

We will pin the small, CPU-friendly model:

```text
t5-small
```

T5 uses a task prefix, so we pass:

```python
"summarize: " + text
```

The `max_length` and `min_length` arguments control the approximate length of the generated output in tokens. They are not word counts. Keeping them small makes the app responsive on CPU.

Setting `do_sample=False` makes generation deterministic, so repeated runs are easier to compare.

## Gradio: add the Summarization tab

If the previous Gradio server is still running, press `Ctrl-C` first. Replace the whole contents of `app.py` with this version. The sentiment and zero-shot tabs are unchanged; this file adds the summarizer pipeline and one new tab.

```python
from transformers import pipeline
import gradio as gr


SENTIMENT_MODEL = "distilbert-base-uncased-finetuned-sst-2-english"
ZERO_SHOT_MODEL = "valhalla/distilbart-mnli-12-1"
SUMMARIZATION_MODEL = "t5-small"

sentiment = pipeline("sentiment-analysis", model=SENTIMENT_MODEL)
zeroshot = pipeline("zero-shot-classification", model=ZERO_SHOT_MODEL)
summarizer = pipeline("summarization", model=SUMMARIZATION_MODEL)


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


with gr.Blocks() as demo:
    gr.Markdown("# NLP Playground")
    gr.Markdown("Three text models behind one Gradio app.")

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


demo.launch(server_name="0.0.0.0", server_port=8080)
```{{copy}}

Run the app:

`python app.py`{{execute}}

Open the app:

{{TRAFFIC_HOST1_8080}}

In the **Summarization** tab, paste a paragraph of at least a few sentences. For example:

```text
The city council approved a new cycling route on Tuesday. The route connects
the train station to the riverside park and adds protected lanes on two busy
streets. Supporters say it will make short trips safer and reduce traffic near
schools. Construction is scheduled to begin in spring, with the first section
opening before the summer.
```

Click **Summarize**. A short summary should appear in the output box. Very short inputs may produce odd summaries because the model expects more context.

## What you learned

You added a generative text task to the same app, used a T5 task prefix, controlled output length with `max_length` and `min_length`, and kept generation deterministic with `do_sample=False`.
