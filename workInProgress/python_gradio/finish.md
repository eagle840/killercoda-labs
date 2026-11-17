# Finish

You built a single Gradio application and improved it in six stages:

1. Created a CPU-only environment with pinned packages.
2. Wrapped a sentiment pipeline in `gr.Interface`.
3. Inspected the tokenizer, model, label mapping, and confidence score.
4. Added descriptions, labels, examples, and an explicit model checkpoint.
5. Converted the app to `gr.Blocks` with Sentiment and Zero-shot tabs.
6. Added Summarization and Entities tabs, ending with four tasks in one app.

The final `app.py` contains four independently wired tasks:

- **Sentiment** — label and confidence for a piece of text
- **Zero-shot** — ranked scores for labels you provide at runtime
- **Summarization** — a shorter generated version of a longer passage
- **Entities** — highlighted people, organizations, locations, and other spans

## Useful patterns to take away

- Create a pipeline with a task name and a pinned `model=`.
- Treat the pipeline output as ordinary Python data: dictionaries, lists, labels, and scores.
- Start with `gr.Interface` for one function, then move to `gr.Blocks` when you need multiple views.
- Use full-file replacement when following this lab so that each step starts from a known state.
- Prefer explicit generation options such as `max_length`, `min_length`, and `do_sample=False` for repeatable CPU demos.

## Continue exploring

Try replacing one model with another from the [Hugging Face Hub](https://huggingface.co/models), or add a fifth tab for translation or question answering. The Gradio layout pattern stays the same: create components, define a Python function, and connect them with `.click()`.

Please remember that this lab is a learning exercise; do not reuse this code directly in production.
