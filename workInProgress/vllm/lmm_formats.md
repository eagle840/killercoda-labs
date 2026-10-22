# vLLM models in different file formats (CPU-only, 4 GB RAM)

Here's a sampler — one line per format, all small enough for 4 GB RAM (CPU-only):

- **GGUF** (needs `uv pip install vllm-gguf-plugin`):
  ```bash
  vllm serve unsloth/Qwen3-0.6B-GGUF:Q4_K_M --tokenizer Qwen/Qwen3-0.6B
  ```
- **safetensors** (native):
  ```bash
  vllm serve Qwen/Qwen2.5-0.5B-Instruct --dtype bfloat16 --max-model-len 1024
  ```
- **PyTorch `.bin`** (legacy format, still loadable):
  ```bash
  vllm serve facebook/opt-125m --dtype bfloat16 --max-model-len 1024
  ```
- **GPTQ** (4-bit quantized safetensors):
  ```bash
  vllm serve Qwen/Qwen2.5-0.5B-Instruct-GPTQ --dtype bfloat16 --max-model-len 1024
  ```

Quick notes for your box:

- **GGUF**: vLLM's GGUF support moved out-of-tree — install the `vllm-gguf-plugin` first. Tested combos include Qwen3 Q8_0, Qwen2.5 Q6_K, GPT-2 Q4_K_M. Use the `repo_id:quant_type` shorthand or a local `.gguf` file, and always pass the base model as `--tokenizer`.
- **4 GB is the real constraint**: keep `--max-model-len` low and set a small KV cache (CPU build uses `VLLM_CPU_KVCACHE_SPACE`, in GiB) — weights + KV cache + PyTorch overhead all share those 4 GB. Sub-1B models are the safe zone; a 0.5B fp16 model (~1 GB) is already pushing it once the framework is loaded.
- **Caveat**: GGUF-on-CPU has historically been bumpy (older issues report `NotImplementedError` on the CPU platform). If it fails, the safetensors/OPT options above are the most reliable CPU path — and if you just need something that runs on 4 GB, `llama.cpp` with a GGUF is the tool that's guaranteed to be happy there.
