# Step 6 — Run the model

Time to make the file do something. This is the same `Llama-3.2-1B-Instruct-Q4_K_M.gguf`
you have been dissecting.

```bash
cd ~/models
llama-cli -m Llama-3.2-1B-Instruct-Q4_K_M.gguf \
  -p "List three uses for a hammer, numbered, one line each." \
  -n 64 -t 1 -c 2048
```{{exec}}

The flags matter, and they map directly to what you have learned:

| Flag | Meaning | Why here |
|---|---|---|
| `-m` | the model file to load | the GGUF you inspected |
| `-p` | the prompt | your input text |
| `-n 64` | generate at most 64 tokens, then stop | keeps a small model on a slow CPU quick |
| `-t 1` | use **1** CPU thread | this VM has **one** vCPU |
| `-c 2048` | context window of 2048 tokens | caps the memory the KV cache can use |

`-t 1` is the one to remember. Most advice on the internet says "match your
thread count to your cores" and shows `-t 8` or similar. On this box, the correct
value is **1**. Setting it higher makes generation *slower*, because the threads
fight over the same physical core.

**You should see** the model continue your prompt, and then a timing summary. If
the output is garbled or cuts off, that is fine — this is a *small* 1B model, and
it is good at formatting and short answers, not deep reasoning.

> **If it lands you in an interactive chat prompt** (a `>` or `>>>` waiting for
> input), type `/exit` to leave, then re-run with the `-no-cnv` flag appended to
> force single-shot completion.

## What just happened

`llama-cli` ran the loop below, once per token:

```
   your prompt
        │
        ▼
1. TOKENIZE ─────────── slice text into numbers, using the 128k-entry
   (metadata)          vocabulary you saw in step 3
        │
        ▼
2. LOAD ─────────────── read the tensors from the file into RAM
   (tensor data)       (already done once, on startup)
        │
        ▼
3. MATRIX MULTIPLY ──── push the tokens through the rigid layers you saw in
   (the weights)       step 4, multiplying against the Q4_K / Q6_K weights
        │
        ▼
4. PREDICT ──────────── which token is statistically most likely next?
   (probabilities)
        │
        ▼
5. APPEND & REPEAT ──── add that token to the input, go back to step 3
   (autoregression)     until the stop token, or `-n` tokens
```

Notice what the model file did and did not do:

- It supplied the **vocabulary** for step 1 and the **weights** for step 3 — as
  pure data.
- It ran **no code**. `llama-cli` is the program; the `.gguf` is the dataset it
  operates on. A different engine (Ollama, LM Studio) could load the exact same
  file and produce the same kind of output.

That is the whole picture: a structured binary plus a program that knows how to
do math on it.

## What you learned

- The engine drives a fixed loop: **tokenize → matrix-multiply → predict →
  append → repeat**.
- `-t` should equal your **physical cores** (here, 1), and `-c` caps the KV cache
  memory.
- The `.gguf` is inert data; the engine is the executable.
