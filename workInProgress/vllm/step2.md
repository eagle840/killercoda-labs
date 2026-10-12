# Step 2

Replace this placeholder with the next task for the vLLM lab.

A common candidate: install vLLM and inspect the installed version.

```bash
python3 -m pip install --quiet vllm
```{{exec}}

```bash
python3 -c "import vllm; print(vllm.__version__)"
```{{exec}}

**What you learned:** the expected vLLM version pinned for this lab.
