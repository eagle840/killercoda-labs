# Build NLP Web Apps with Transformers and Gradio

**Last updated: 17 November 2026**

Hugging Face `transformers` makes it possible to run capable natural-language models with a few lines of Python. Gradio turns a Python function into a browser-based interface just as quickly. In this lab you will build one small app, `app.py`, and keep improving it across six steps.

You will start with a single sentiment classifier, inspect what a pipeline does, improve the interface, then grow the app into four tabs:

- Sentiment analysis
- Zero-shot classification
- Summarization
- Named-entity recognition

Everything runs on CPU with pinned Python packages. No GPU, Docker, or prior `transformers` experience is required.

## Assumed knowledge

You should be comfortable with:

- Python functions, variables, and f-strings
- Using a terminal and a Python virtual environment
- Installing packages with `pip` or `uv`

We will explain every `transformers` and Gradio concept as it appears.

## Optional background reading

If you want a short conceptual introduction before starting, read [Hugging Face LLM Course, Chapter 1.3](https://huggingface.co/learn/llm-course/en/chapter1/3). It is optional; the lab is self-contained.

Please note that the lab is set up as a learning experience and the code should never be used in production.
