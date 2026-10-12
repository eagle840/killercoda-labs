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

   17  mkdir test
   18  cd test
   19  uv venv && source .venv/bin/activate
   20  uv pip install vllm --extra-index-url https://wheels.vllm.ai/0.31.0/cpu --torch-backend cpu
   21  uv pip install triton
   22  uv pip install vllm --extra-index-url https://wheels.vllm.ai/0.31.0/cpu --torch-backend cpu
   23  uv pip install -U vllm --pre --extra-index-url https://wheels.vllm.ai/nightly/cpu --torch-backend cpu --index-strategy unsafe-best-match
   24  ls
   25  cd ..
   26  ls
   27  cp install_vllm_cpu.sh ./test/
   28  cd test
   29  ls
   30  cat install_vllm_cpu.sh 
   31  uv pip install vllm   --extra-index-url https://wheels.vllm.ai/0.31.0/cpu   --torch-backend cpu   "triton @ https://github.com/triton-lang/triton-cpu/releases/download/v3.8.0/triton-3.8.0+cpu-cp312-abi3-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl"
   32  vllm --help

   ---

   ```
   OMP_NUM_THREADS=$(nproc) vllm serve HuggingFaceTB/SmolLM2-360M-Instruct \
  --dtype bfloat16 \
  --max-model-len 4096 \
  --enforce-eager
  ```

  ```
  curl http://localhost:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"HuggingFaceTB/SmolLM2-360M-Instruct","messages":[{"role":"user","content":"Hello!"}]}'
  ```