# Step 4 — Map the tensors

Now the other 99% of the file: the **tensor data**. This is where the weights
live — the numbers the model learned during training.

A transformer model is a **fixed, rigid architecture**: an embedding layer,
then a stack of identical layers (each with an attention block and a
feed-forward block), then a final output layer. The file contains the exact
weight matrix for every one of those pre-determined positions.

Dump the full structure to a file (it is long):

```bash
cd ~/models
gguf-dump Llama-3.2-1B-Instruct-Q4_K_M.gguf > tensors.txt
wc -l tensors.txt
grep -c 'blk\.' tensors.txt
```{{exec}}

The `blk.` count tells you how many tensors belong to the repeating layer stack.

## Look at one layer

Every tensor inside the stack is named after its position and role. Let's look at
**layer 0**:

```bash
grep -E 'blk\.0\.' tensors.txt
```{{exec}}

**You should see** names like these, each with a shape and a type:

```
blk.0.attn_norm.weight
blk.0.attn_q.weight
blk.0.attn_k.weight
blk.0.attn_v.weight
blk.0.attn_output.weight
blk.0.ffn_norm.weight
blk.0.ffn_gate.weight
blk.0.ffn_down.weight
blk.0.ffn_up.weight
```

Read them as a sentence:

- `attn_q/k/v` — the **query, key and value** projections of the attention block.
- `attn_output` — the attention block's output projection.
- `ffn_gate`, `ffn_up`, `ffn_down` — the **feed-forward** block, which is where
  most of the model's parameters live.
- `*_norm` — normalisation layers, applied between blocks.

This same set repeats for `blk.1`, `blk.2`, … all the way up. Because the
architecture is rigid, every layer has the same tensor names — only the numbers
inside differ.

## Which tensors got compressed?

Look closely at the **type** column. Then count the types across the whole file:

```bash
grep -oE '(Q[0-9]+_K|Q[0-9]+_[0-9]+|F32|F16|BF16)' tensors.txt | sort | uniq -c | sort -rn
```{{exec}}

**You should see** a mix, roughly like:

```
 90 Q4_K
 30 Q6_K
 25 F32
```

Notice three things:

1. **Most weights are `Q4_K`** — 4-bit quantized. That is the compression that
   makes this file 808 MB instead of ~2.5 GB.
2. **Some are `Q6_K`** — a higher-precision type. The `_M` in `Q4_K_M` means
   *medium*: a mixed strategy that keeps certain sensitive tensors (here, the
   feed-forward `down` projections) at higher precision.
3. **The `*_norm` tensors stayed `F32`** — full 32-bit precision.

That last point is the important one. **Quantization is not applied uniformly.**
Normalisation tensors are few and cheap, and precision there matters
disproportionately, so they are left alone. The big matrices are the ones worth
compressing.

## What you learned

- The file stores a **fixed architecture** as named weight matrices
  (`blk.0.attn_q.weight`, …).
- Quantization is **selective**, not uniform — most matrices are 4-bit, some are
  higher precision, and norms stay `F32`.
- The name and shape of every tensor is **declared in the file**, so a tool can
  read the whole model layout without loading the weights.
