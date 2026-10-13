# Step 5 — Measure quantization

You have seen `Q4_K` and `Q6_K` inside the file. Now let's put a price on them.

## The idea

When a model is trained, every weight is typically a **16-bit floating-point
number** (2 bytes). For a 1.24-billion-parameter model that is about **2.5 GB**
just to sit in memory.

**Quantization** lowers the precision of those weights — from 16-bit decimals
down to 8-bit, 4-bit, or even 2-bit integers — so the file gets smaller and runs
faster, at the cost of some accuracy.

Rather than take that on faith, **measure it**. The same model is hosted at
several precisions. We can read each file's exact size from the network with a
`HEAD` request, without downloading them:

```bash
cd ~/models
for Q in Q4_K_M Q8_0; do
  printf '%-8s ' "$Q"
  curl -sIL "https://huggingface.co/bartowski/Llama-3.2-1B-Instruct-GGUF/resolve/main/Llama-3.2-1B-Instruct-$Q.gguf" \
    | grep -i '^content-length' | tail -1
done
```{{exec}}

And confirm against the file you actually downloaded:

```bash
ls -l Llama-3.2-1B-Instruct-Q4_K_M.gguf
```{{exec}}

> **Why `tail -1`?** The Hugging Face URL redirects, and `curl -I -L` prints
> headers for **both** responses. The first `content-length` belongs to the
> 302 redirect page (1120 bytes); the last one is the real file. Always take the
> last.

## Put the numbers together

| Precision | Bytes per weight | Approx. size (1.24B params) | Quality |
|---|---|---|---|
| Unquantized (F16/BF16) | 2 | ~2.5 GB | baseline |
| `Q8_0` (8-bit) | ~1 | ~1.3 GB | near-lossless |
| **`Q4_K_M` (4-bit)** | ~0.5 | **~0.81 GB** | very good — the sweet spot |
| `Q2_K` (2-bit) | ~0.25 | ~0.5 GB | noticeably degraded |

The `Q4_K_M` figure should match both your download and the `content-length`
probe above. That is the trade-off, measured on a real model: **roughly a 3×
size reduction versus F16 for a quality loss most users cannot detect in casual
use.**

Two caveats worth knowing:

- **It is not exactly `params × bytes`.** The parts left at `F32` (norms, and
  often the tokenizer embeddings) are not compressed, so real files land a little
  above the estimate — which is why the numbers here are "approx".
- **Smaller is not free.** Accuracy falls off a cliff at very low bit-widths. A
  2-bit model of a small model is often just bad; 4-bit is where practicality
  sits today.

## What you learned

- Quantization trades numerical precision for size and speed.
- The gain is real and measurable: **~2.5 GB → ~0.81 GB** for this model.
- The filename encodes the scheme: `Q4_K_M` = 4-bit, K-quant, medium/mixed.
- You can inspect file sizes on a model hub **without downloading**, using a
  `HEAD` request and following redirects.
