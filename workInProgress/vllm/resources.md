# vLLM Lab — Resources & Planning Notes

This file carries additional notes, links, and older/exploratory code for the
scenario. It is intentionally excluded from the learner-facing flow.

## Alternatives considered

vLLM is not the only LLM serving engine. Before building the lab, weigh the
trade-offs:

| Engine | Strength | Trade-off |
|--------|----------|-----------|
| **vLLM** | PagedAttention, continuous batching, OpenAI-compatible server, huge model support | Requires a GPU for realistic throughput |
| **SGLang** | Very fast runtime, strong structured/constrained generation, RadixAttention | Younger ecosystem, smaller community |
| **Hugging Face TGI** | Mature, well-integrated with HF Hub, solid Docker images | Historically narrower hardware/model coverage than vLLM |
| **LMDeploy** | Strong on NVIDIA + some AMD, good quantization support | Smaller community/less docs |
| **Ollama** | Dead-simple local CPU/GPU running, great for beginners | Not built for high-throughput multi-user serving |

**Choice:** vLLM, because the lab's goal is to teach *serving* concepts
(throughput, batching, KV cache, OpenAI-compatible API) rather than just running a
model locally.

## Version pinning

- Pin the vLLM version explicitly (e.g. `vllm==0.6.3`) for reproducibility — never
  install `latest`.
- Pin the torch/CUDA combination alongside vLLM; mismatches are the most common
  install failure.
- Record the chosen version here once the lab is written.

## Runtime / hardware requirements

- Upstream vLLM targets **NVIDIA (CUDA)** or **AMD (ROCm)** GPUs. There is an
  experimental CPU backend.
- Killercoda's `ubuntu` backend has **2 GB RAM** and no GPU; `ubuntu-4GB` has 4 GB.
  Neither can serve a real model at useful speed.
- **Planning implication:** either
  1. keep the lab GPU-independent (teach the CLI/API surface and inspect config,
     using a tiny model), or
  2. self-host with a GPU host and use the Killercoda traffic selectors
     (`{{TRAFFIC_HOST1_8000}}`) to reach a separately provisioned vLLM server.

Do not promise real inference throughput on the default CPU backend.

## Course coherence

- Related AI/ML scenarios in this repo: `workInProgress/ollama` (running models
  locally), `workInProgress/python_gradio`, `AI_ML/*`.
- Suggested prerequisite: basic Linux terminal + Python virtual environments
  (see `python-uv`, `pythonvenv2`).
- Suggested follow-ups: an OpenAI-compatible clients lab, or quantization
  (AWQ/GPTQ) deep-dive.

## Learner proficiency

Target: **intermediate**. Assumes comfort with Python, `pip`, and reading HTTP
APIs. Mark as beginner only if the lab is limited to `ollama`-style model running.

## References

- vLLM documentation: https://docs.vllm.ai/
- vLLM OpenAI-compatible server: https://docs.vllm.ai/en/latest/serving/openai_compatible_server.html
- PagedAttention paper: https://arxiv.org/abs/2309.06180
