# Step 2

Replace this placeholder with the next task for the vLLM lab.

A common candidate: set up a Python virtual environment, then install vLLM and inspect the installed version.

## Create a Python virtual environment

Always install vLLM inside an isolated virtual environment, never into the system
Python:

```bash
sudo apt update && sudo apt install -y python3-venv
```{{exec}}

```bash
mkdir vllm-lab && cd vllm-lab
```{{exec}}

```bash
python3 -m venv .venv
```{{exec}}

```bash
source .venv/bin/activate
```{{exec}}

Confirm you are now using the venv's interpreter:

```bash
which python && python -V
```{{exec}}

## Install vLLM

With the environment active, install vLLM and check the version:

```bash
pip install --upgrade pip
```{{exec}}

```bash
pip install  vllm
```{{exec}}

```bash
# pip install --quiet vllm
```{{exec}}

```bash
python -c "import vllm; print(vllm.__version__)"
```{{exec}}

**What you learned:** how to isolate a Python environment with `venv` and pin the
expected vLLM version for this lab.

###

Metrics

# vLLM Token Throughput — curl cheatsheet

Metrics for **Processed Prompt Tokens** and **Generated Completion Tokens**.
Collect them from vLLM's built-in `/metrics` endpoint with plain `curl` — the
counters are kept in-process, so this costs effectively zero CPU (only the
scrape itself).

| Meaning | vLLM v1 counter | Older name |
| --- | --- | --- |
| Processed prompt (prefill) tokens | `vllm:prompt_tokens` | `vllm:prompt_tokens_total` |
| Generated completion tokens | `vllm:generation_tokens` | `vllm:generation_tokens_total` |

Both are **cumulative counters** → throughput is always a difference over time.

---

## 1. The only curl you actually need

```bash
curl -s http://localhost:8000/metrics
```

Everything below is just filtering that output. Use `-sf` to fail non-zero on HTTP errors.
If the server has an API key (`--api-key`), add the header:

```bash
curl -sf -H "Authorization: Bearer $VLLM_API_KEY" http://localhost:8000/metrics
```

## 2. Pull just the two counters

```bash
curl -sf http://localhost:8000/metrics | grep -E '^vllm:(prompt_tokens|generation_tokens)(_total)?\{'
```

Sample output:

```
vllm:prompt_tokens{model_name="meta-llama/Llama-3.1-8B"} 184213.0
vllm:generation_tokens{model_name="meta-llama/Llama-3.1-8B"} 902144.0
```

`(_total)?` also matches the older naming, so this works across vLLM versions.

## 3. Just the numbers (no labels)

```bash
curl -sf http://localhost:8000/metrics \
  | awk '/^vllm:prompt_tokens(\{| )/      {p=$NF}
         /^vllm:generation_tokens(\{| )/ {g=$NF}
         END {printf "prompt=%d generation=%d\n", p, g}'
```

Output: `prompt=184213 generation=902144`

## 4. Capture into shell variables

```bash
reads=$(curl -sf http://localhost:8000/metrics \
  | awk '/^vllm:prompt_tokens(\{| )/      {p=$NF}
         /^vllm:generation_tokens(\{| )/ {g=$NF}
         END {print p+0, g+0}')
read -r prompt_tokens generation_tokens <<<"$reads"
echo "prompt=${prompt_tokens} generation=${generation_tokens}"
```

## 5. Throughput loop (tokens/sec)

Samples every `INTERVAL` seconds (default 30), diffs the counters, prints tokens/sec.

```bash
INTERVAL="${1:-30}"
while true; do
  read -r p g < <(
    curl -sf http://localhost:8000/metrics \
      | awk '/^vllm:prompt_tokens(\{| )/      {p=$NF}
             /^vllm:generation_tokens(\{| )/ {g=$NF}
             END {print p+0, g+0}'
  )
  now=$(date +%s)
  if [ -n "${prev_p:-}" ]; then
    dt=$((now - prev_t))
    echo "$(date -Is)  prompt_tps=$(awk "BEGIN{printf \"%.1f\", ($p-$prev_p)/$dt}")  gen_tps=$(awk "BEGIN{printf \"%.1f\", ($g-$prev_g)/$dt}")"
  fi
  prev_p=$p; prev_g=$g; prev_t=$now
  sleep "$INTERVAL"
done
```

Sample output:

```
2026-10-19T12:00:30+00:00  prompt_tps=812.4  gen_tps=2431.7
2026-10-19T12:01:00+00:00  prompt_tps=790.1  gen_tps=2388.2
```

Guard rails: if the server restarts, counters reset and a diff goes **negative** — skip negative deltas. If a scrape fails, `p`/`g` are empty — check before dividing.

## 6. Sanity checks

```bash
# Endpoint up?
curl -sf -o /dev/null -w '%{http_code}\n' http://localhost:8000/metrics

# Confirm the metric names this version uses
curl -sf http://localhost:8000/metrics | grep -E '^vllm:(prompt|generation)_tokens'

# Scrape payload size
curl -sf http://localhost:8000/metrics | wc -c
```

## 7. Multi-model / multi-rank

```bash
# One specific model:
curl -sf http://localhost:8000/metrics \
  | grep '^vllm:generation_tokens{' \
  | grep 'model_name="meta-llama/Llama-3.1-8B"'

# Sum every series into one total:
curl -sf http://localhost:8000/metrics \
  | awk '/^vllm:generation_tokens\{/ {s+=$NF} END {printf "%.0f\n", s}'
```

## 8. If the counters come back empty

- **No request processed yet** — counters often don't appear until the first request finishes. Send one completion, then re-check.
- **Different naming** — some builds use `..._total`. Verify with the grep in §6.
- **Wrong port/host** — adjust `:8000`, or use `$VLLM_PORT`.

## 9. If you later add Prometheus

```promql
rate(vllm:prompt_tokens[5m])       # prompt tokens/sec
rate(vllm:generation_tokens[5m])   # generation tokens/sec
```
