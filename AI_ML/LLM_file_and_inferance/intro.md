# Open an LLM, then run it

You have probably downloaded a model and run it — Ollama, LM Studio, or a
chat app. Behind every one of those is a **single weights file** on disk: a
`.gguf` file. This lab takes that file apart.

GGUF is not the only format you will meet, though. You may also see **EXL2 /
GPTQ** (highly optimised for NVIDIA GPUs, but they cannot spill to system RAM)
and **safetensors** (Hugging Face's safe, raw format — usually unquantized, and
typically what a model is *released* in before someone re-quantizes it to GGUF).
This lab focuses on GGUF because it is the one end users actually download and
run.

You will not just read about it. You will:

1. Install **llama.cpp**, the engine that (indirectly) powers most local LLM
   tools, and the tooling that can read a GGUF file.
2. **Peek at the first 24 bytes** of a real model *over the network* and decode
   them by hand — before downloading anything.
3. Download **Llama 3.2 1B Instruct (Q4_K_M)** and read its metadata header: the
   architecture, layer count, context length, and vocabulary.
4. Read its **tensor map**, where the actual quantized weights live, and see which
   parts of the model got compressed and which did not.
5. **Measure** what quantization costs by comparing the same model at different
   precisions.
6. **Run that exact file** and generate text.

By the end, "a model is a big magic file you download" becomes "a model is a
structured binary I can read, and a program that does matrix math on it."

## What you should already know

- Comfort with a Linux terminal (`cd`, `curl`, `tar`).
- A rough idea of what a floating-point number and a matrix are.

You do **not** need any machine-learning training, and you do not need a GPU.

## About this environment

This VM is deliberately modest: **one vCPU** and a few GB of RAM. That is part
of the lesson — we will see exactly how the engine adapts to limited hardware,
and why the thread-count flag matters here.

**Last updated:** 2026-10-14

> **Note:** This lab is a learning experience. The commands and configuration
> here are for exploration, not production use — do not reuse them as-is in a
> deployed service.
