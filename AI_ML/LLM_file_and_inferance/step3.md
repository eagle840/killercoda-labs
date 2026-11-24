# Step 3 — Read the file blueprint

A GGUF file has two halves:

1. **The metadata header** — the "blueprint". Text-like key/value pairs telling
   the engine what this model *is*: its architecture, how many layers it has,
   how long a context it supports, and the entire tokenizer vocabulary.
2. **The tensor data** — the other ~99% of the file. A giant block of numbers:
   the trained weights, arranged into arrays (tensors).

In this step we read only the first half.

`gguf-dump` prints the metadata. The `--no-tensors` flag hides the long tensor
list, and we redirect to a file because the tokenizer vocabulary is tens of
thousands of entries and will flood your terminal:

```bash
cd ~/models
gguf-dump --no-tensors Llama-3.2-1B-Instruct-Q4_K_M.gguf > blueprint.txt
wc -l blueprint.txt
```{{exec}}

Now pull out the architectural keys — the ones that describe the model's shape:

```bash
grep -E 'architecture|context_length|block_count|embedding_length|head_count|vocab_size|file_type' blueprint.txt
```{{exec}}

**You should see** entries along these lines:

- `general.architecture` → **`llama`** (which family of model this is)
- `llama.context_length` → the maximum number of tokens the model can attend
  over (Llama 3.2 supports a large context)
- `llama.block_count` → the number of transformer **layers** (**16** for this model)
- `llama.embedding_length` → the width of the model's hidden vectors
- `llama.attention.head_count` / `head_count_kv` → the attention head layout
- `general.file_type` → the quantization type of the file

The point is that **all of this is readable text in a binary file**. The engine
does not guess the architecture — the file declares it.

## Now look at the tokenizer

The vocabulary is also stored here, as a lookup table from token text to a
numeric ID. Peek at a few entries:

```bash
grep -A 12 'tokenizer.ggml.tokens' blueprint.txt | head -15
```{{exec}}

That is the model's whole vocabulary — the reason it can split your prompt into
the numbers it actually computes on. Its size is why this file is the biggest
part of the "header".

## What you learned

- A GGUF file is divided into a **metadata header** (config + tokenizer) and
  **tensor data** (the weights).
- The header is **self-describing**: architecture, layer count, context length,
  and vocabulary are all declared in the file.
- No code executes from the file — it is data that a separate program
  (`llama-cli`) interprets.
