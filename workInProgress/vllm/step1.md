# Start Here

This is your starting point. Use this step to define your initial setup or
instructions for the user.

For example, check the resources available in the environment:

```bash
free -m
```{{exec}}

```bash
nproc
```{{exec}}

```bash
lspci | grep -i nvidia || echo "No NVIDIA GPU detected"
```{{exec}}

**What you learned:** how to confirm CPU, memory, and GPU availability before
installing an inference engine.

> **Note:** vLLM is optimized for NVIDIA/AMD GPUs. On a CPU-only environment it can
> only serve small models slowly, so plan the lab content accordingly (see
> `resources.md`).


---

WIP `curl -fsSL https://opencode.ai/v2/install | bash`{{exec}}


`curl -LsSf https://astral.sh/uv/install.sh | sh`{{exec}}

`source $HOME/.local/bin/env`{{exec}}

```bash
mkdir vllm-lab2 && cd vllm-lab2
```{{exec}}

`uv venv && source .venv/bin/activate`{{exec}}


WIP:   21  uv pip install triton

WIP: the below seems to work only 25% of the time (a install dependense failure)

`uv pip install vllm   --extra-index-url https://wheels.vllm.ai/0.31.0/cpu   --torch-backend cpu   "triton @ https://github.com/triton-lang/triton-cpu/releases/download/v3.8.0/triton-3.8.0+cpu-cp312-abi3-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl"`{{exec}}

`vllm --help`{{exec}}

   ---

   opencode suugests using -135M-  and or len of 2048 (what other versions are there?)

   What tools are available to monitor memory/cpu/gpu? and general vllm overall?

   ```
   OMP_NUM_THREADS=$(nproc) vllm serve HuggingFaceTB/SmolLM2-360M-Instruct \
  --dtype bfloat16 \
  --max-model-len 4096 \
  --enforce-eager
  ```{{exec}}

  ```
  curl http://localhost:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"HuggingFaceTB/SmolLM2-360M-Instruct","messages":[{"role":"user","content":"Hello!"}]}'
  ```{{exec}}