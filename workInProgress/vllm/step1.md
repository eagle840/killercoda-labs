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

`vllm --version` just prints the package version; the real hardware introspection is `collect-env` plus whatever gets logged when `serve` starts up.

## Caveats worth knowing

- **Detection ≠ full usability.** `torch.cuda.is_available()` can be `False` due to driver problems even though a GPU is physically present — vLLM will then fail at startup rather than "feel" its way around it.
- **Build-dependent.** A CUDA wheel can't use an AMD GPU even if one is installed; the prebuilt Docker images are per-platform (CUDA vs ROCm vs CPU).
- **Visibility is respected.** It only sees GPUs exposed to the process — `CUDA_VISIBLE_DEVICES`, `--device-ids`, containers without GPU passthrough, etc. all change what it "feels."
- There's no single `vllm detect-hardware` subcommand; if you want a quick standalone check, the usual recipe is `vllm collect-env` or `nvidia-smi` / `python -c "import torch; print(torch.cuda.is_available())"`.


`vllm collect-env`{{exec}}

   ---

   opencode suugests using -135M-  and or len of 2048 (what other versions are there?)

   What tools are available to monitor memory/cpu/gpu? and general vllm overall?

   `MODEL="HuggingFaceTB/SmolLM2-135M-Instruct"`{{exec}}

   WIP   `MODEL="HuggingFaceTB/SmolLM2-350M-Instruct"`{{exec}}


   ```bash
   MODEL_LEN="2048"
   ```{{exec}}

   ```bash
   OMP_NUM_THREADS=$(nproc) vllm serve $MODEL --dtype bfloat16 --max-model-len $MODEL_LEN --enforce-eager --gpu-memory-utilization 0.5
   ```{{exec}}

   ```bash
   OMP_NUM_THREADS=$(nproc) vllm serve HuggingFaceTB/SmolLM2-135M-Instruct --dtype bfloat16 --max-model-len 2048 --enforce-eager --gpu-memory-utilization 0.5
   ```{{exec}}

WIP: following fails:
   ```bash
   OMP_NUM_THREADS=$(nproc) vllm serve HuggingFaceTB/SmolLM2-360M-Instruct \
  --dtype bfloat16 \
  --max-model-len 4096 \
  --enforce-eager
  ```{{exec}}


  When you see the following, it's ready to use

   ```
INFO:     Started server process [4870]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
```

  The following command takes a few minutes to return a result:

  ```
  curl http://localhost:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"HuggingFaceTB/SmolLM2-135M-Instruct","messages":[{"role":"user","content":"Hello!"}]}' | jq
  ```{{exec}}