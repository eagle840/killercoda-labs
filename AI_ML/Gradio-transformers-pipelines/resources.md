# Resources and Notes

## Background reading used by this lab

- [Hugging Face LLM Course — Chapter 1.3: How do Transformers work?](https://huggingface.co/learn/llm-course/en/chapter1/3) — optional conceptual background linked from the introduction.
- [Hugging Face LLM Course — Chapter 1.2: Transformers models](https://huggingface.co/learn/llm-course/en/chapter1/2) — extra background on model families and checkpoints.
- [Hugging Face Transformers documentation](https://huggingface.co/docs/transformers/index) — pipeline, tokenizer, and model reference.
- [Hugging Face Pipeline documentation](https://huggingface.co/docs/transformers/main/en/pipelines) — task list and pipeline options.
- [Hugging Face Hub](https://huggingface.co/models) — model search and model cards.
- [Gradio documentation](https://www.gradio.app/docs/) — component and event reference.
- [Gradio Blocks guide](https://www.gradio.app/guides/blocks-and-event-listeners) — layout and `.click()` patterns.
- [Gradio `HighlightedText` documentation](https://www.gradio.app/docs/gradio/highlightedtext) — the component used for named entities.

## Model cards used in the steps

- [distilbert-base-uncased-finetuned-sst-2-english](https://huggingface.co/distilbert-base-uncased-finetuned-sst-2-english)
- [valhalla/distilbart-mnli-12-1](https://huggingface.co/valhalla/distilbart-mnli-12-1)
- [t5-small](https://huggingface.co/t5-small)
- [dslim/bert-base-NER](https://huggingface.co/dslim/bert-base-NER)
- [nlptown/bert-base-multilingual-uncased-sentiment](https://huggingface.co/nlptown/bert-base-multilingual-uncased-sentiment)

## Version pins and why they were chosen

This lab pins versions for reproducibility:

```text
torch==2.15.0
transformers==4.57.6
gradio==5.44.1
sentencepiece==0.2.1
```

Notes:

- PyTorch is installed from the CPU wheel index. The lab is text-only, so `torchvision` and `torchaudio` are not needed.
- `transformers` v5 removed some pipelines used here, including the summarization pipeline path. The latest 4.x line, `4.57.6`, keeps these beginner-friendly task APIs available.
- Gradio 6.x requires a newer `huggingface-hub` than `transformers` 4.x allows. Gradio `5.44.1` uses a compatible `huggingface-hub` range.
- `sentencepiece` is included because T5 tokenizers need it.

These pins are for a stable teaching environment, not a recommendation for every application.

## Alternatives considered

- **spaCy** would be a good alternative for production-style NER and tokenization, but it would not demonstrate Hugging Face pipelines or Hub checkpoints.
- **Streamlit** could also build the web UI, but Gradio is designed around model demos and has direct `Interface`, `Blocks`, `HighlightedText`, and examples support.
- A single pinned `uv` install keeps setup short and deterministic for an interactive lab. CPU-only PyTorch keeps the focus on text pipelines and the web UI.

## Operational notes

- The lab listens on port `8080` and uses the Killercoda traffic host link `{{TRAFFIC_HOST1_8080}}`.
- Stop a running Gradio server with `Ctrl-C` before starting the next full version of `app.py`; otherwise the port will already be in use.
- First-run model downloads can take time. Later launches are usually faster because files are cached.
- The standard backend is `ubuntu`. If cold-run testing shows memory pressure, switch the scenario backend to `ubuntu-4GB`; no lab code changes should be required.
- Very short summarization inputs can produce weak or odd output because the model expects a longer passage.
- For Step 6, `aggregation_strategy="simple"` is intentional. It merges subword pieces and aligns character offsets with `gr.HighlightedText`. The older `grouped_entities=True` option is deprecated and is not used.

Please note that the lab is set up as a learning experience and the code should never be used in production.
