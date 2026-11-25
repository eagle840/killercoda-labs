# Look Inside a Pipeline and Show Confidence

## Concept: tokenizer, model, scores

A text pipeline has three useful moving parts:

1. **Tokenizer** — converts text into integer token IDs and attention masks.
2. **Model** — turns those IDs into raw scores called logits.
3. **Post-processing** — converts the scores into labels and probabilities.

For sentiment analysis, the raw logits are mapped to labels such as `POSITIVE` and `NEGATIVE`. The pipeline returns the highest-scoring label and its probability as `score`.

You do not need to understand the neural network architecture. The important practical idea is that a pipeline object exposes its tokenizer and its model, so you can inspect them when needed.

Make sure the virtual environment is active:

`source ~/gradio-nlp/.venv/bin/activate`{{execute}}

`cd ~/gradio-nlp`{{execute}}

Open a Python REPL:

`python`{{execute}}

Load the same pinned pipeline:

`from transformers import pipeline`{{execute}}

`pipe = pipeline("sentiment-analysis", model="distilbert-base-uncased-finetuned-sst-2-english")`{{execute}}

Inspect the token IDs for a short sentence:

`print(pipe.tokenizer("I love this lab.")["input_ids"])`{{execute}}

Inspect how numeric positions map back to labels:

`print(pipe.model.config.id2label)`{{execute}}

Now see the final formatted result:

`print(pipe("I love this lab."))`{{execute}}

You should see a list with one dictionary, similar to:

```python
[{'label': 'POSITIVE', 'score': 0.9998}]
```

The exact score may vary slightly. Leave the REPL:

`quit()`{{execute}}

## Gradio: return label and confidence

The pipeline already gives us a `score`. We only need to format it as readable text in the interface.

If the previous Gradio server is still running, press `Ctrl-C` in that terminal first. Then replace the whole contents of `app.py` with this version:

```python
from transformers import pipeline
import gradio as gr


SENTIMENT_MODEL = "distilbert-base-uncased-finetuned-sst-2-english"

classifier = pipeline("sentiment-analysis", model=SENTIMENT_MODEL)


def classify_sentiment(text):
    result = classifier(text)[0]
    label = result["label"]
    confidence = result["score"]
    return f"{label} ({confidence:.3f})"


demo = gr.Interface(
    fn=classify_sentiment,
    inputs=gr.Textbox(label="Movie review"),
    outputs=gr.Textbox(label="Sentiment and confidence"),
    title="Sentiment Lab",
    description="Enter text to see the predicted label and confidence score.",
)

demo.launch(server_name="0.0.0.0", server_port=8080)
```{{copy}}

Run the updated app:

`python app.py`{{execute}}

Open the app:

{{TRAFFIC_HOST1_8080}}

Try:

```text
The service was slow, but the food was excellent.
```

The result now includes a probability in parentheses, for example `POSITIVE (0.999)`.

Knowledge check: which object turned the input string into token IDs, and which part of the result is the probability?

## What you learned

You inspected the tokenizer, label mapping, and final pipeline result. You also changed the Gradio function’s return value so the UI shows both the predicted label and the model’s confidence.
