# Step 2 — Peek at the header, then download

## What is a `.gguf` file?

Almost every "download and run" local model you have used is a **GGUF**
(GPT-Generated Unified Format) file. It is the de-facto standard for CPU and
consumer-GPU inference, and its whole trick is that it packs the model weights,
the configuration, and the tokenizer into **one single file**.

You may also encounter other formats on model hubs:

| Format | Built for | Can it spill to system RAM? |
|---|---|---|
| **GGUF** | CPU + GPU, one file | **Yes** — splits between VRAM and RAM |
| **EXL2 / GPTQ** | NVIDIA GPUs, specialised loaders | No, GPU-only |
| **safetensors** | Developers, raw unquantized weights | Not a runtime format |

The model we want is hosted on **Hugging Face**. The original releases (often
`.safetensors`) are huge and unquantized; community members re-quantize them into
GGUF for the rest of us. We are using the `bartowski` GGUF repo.

Open the model card to see the file list for yourself:

```text
https://huggingface.co/bartowski/Llama-3.2-1B-Instruct-GGUF
```{{copy}}

On that page, under **Files and versions**, you will see many `.gguf` files
(`...Q4_K_M.gguf`, `...Q8_0.gguf`, …). **You download exactly one** — the one
that fits your memory. We want `Q4_K_M`.

## Peek before you download

The file is ~808 MB. Before spending that, we can read its **first 24 bytes**
over the network, using an HTTP range request. This costs nothing.

```bash
mkdir -p ~/models && cd ~/models

URL="https://huggingface.co/bartowski/Llama-3.2-1B-Instruct-GGUF/resolve/main/Llama-3.2-1B-Instruct-Q4_K_M.gguf"

curl -sL -r 0-23 -D - -o head.bin "$URL"
ls -l head.bin
xxd head.bin
```{{exec}}

**You should see** 24 bytes of output starting with:

```
00000000: 4747 5546 0300 0000 ....
```

Decode it yourself — these 24 bytes are the entire header skeleton of a GGUF
file:

- `47 47 55 46` → the ASCII magic bytes **`GGUF`**
- `03 00 00 00` → version **3** (a little-endian 32-bit integer)
- next 8 bytes → the **tensor count** (how many weight matrices the model has),
  as a 64-bit little-endian integer
- next 8 bytes → the **metadata KV count** (how many key/value entries follow)

Every `.gguf` on your disk starts exactly this way. **Write your tensor count
down** — you will use it again in step 4.

> **Trap:** that Hugging Face URL **redirects** to a signed CDN URL. Without the
> `-L` flag, `curl` prints the redirect page's HTML (`Found. Redirecting to …`,
> 1120 bytes) and `xxd` shows ASCII letters — not a GGUF header. If your hex
> dump starts with `466f 756e 642e` ("Found."), you forgot `-L`. Always follow
> redirects.
>
> Also never run `curl … | xxd` without saving to a file first: if the CDN ever
> ignores the range, `xxd` will hex-dump the whole 808 MB.

## Now download it

```bash
cd ~/models
time curl -L -o Llama-3.2-1B-Instruct-Q4_K_M.gguf "$URL"
ls -l Llama-3.2-1B-Instruct-Q4_K_M.gguf
```{{exec}}

**You should see** a file of **807,694,464 bytes** (about 808 MB). On this
connection it takes roughly two to three minutes.

## What you learned

- A GGUF file is a **single self-contained file**: weights + config + tokenizer.
- Its first bytes are a **readable header**, not opaque data — you decoded the
  magic, the version, and two counts by hand.
- You can **inspect a model over the network** with an HTTP range request,
  before committing to the download.
