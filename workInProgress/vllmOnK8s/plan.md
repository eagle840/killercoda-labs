# Lab Plan — "Operating vLLM on Kubernetes"

**Status:** planning only. No scenario files written yet.
**Planned date:** 2026-10-22
**Proposed folder:** `workInProgress/vllm-k8s/` → later `vllm-k8s/` (lowercase kebab-case `friendURL`: `vllm-k8s`)
**Split from:** `workInProgress/vllm/` (which becomes "vLLM: install, offline inference, serving basics")
**Backend:** `kubernetes-kubeadm-2nodes` (4 GB total, 1 controlplane + 1 worker, taint removed)
**Difficulty:** Intermediate → Advanced
**Time:** 75 minutes (core path ≈ 45–50 min; designed so steps 1–5 fit inside the free-tier 1-hour session, with steps 6–7 as stretch)

---

## 1. Premise

This lab is **not** "run vLLM on Kubernetes". It is **"operate an LLM serving engine on Kubernetes"** — the cluster is the observability and lifecycle harness, and the model is a deliberately tiny CPU one, because the lesson is *shape and signal*, never absolute throughput.

Explicit framing for `intro.md`:

> Absolute tokens/sec here is meaningless (4 vCPU, no GPU). What you will learn to read — queue depth, KV-cache saturation, preemptions, TTFT distribution, probe behaviour — is exactly what you read on an 8×H100 production cluster. Only the numbers change.

**In scope**

- Packaging an inference server as a Deployment: resources, probes, model cache, config surface.
- Exposing it in-cluster and out (`Service`, `port-forward`, `NodePort`/`Ingress` + `{{TRAFFIC_HOST1_...}}`).
- Scraping `/metrics` with a *minimal* Prometheus and querying the vLLM series.
- Driving load and reading the resulting queueing / KV-cache / latency signals.
- Tuning one knob, redeploying, and proving the effect on the metrics.
- Lifecycle failure modes: slow model load vs probe timeouts, OOMKilled, CrashLoopBackOff.

**Out of scope** (name them in `finish.md`, link out)

- GPU scheduling, device plugin, NVIDIA GPU Operator.
- Tensor parallel, Ray multi-node, disaggregated prefill/decode, KV transfer connectors.
- Real autoscaling on custom metrics (`prometheus-adapter` is too heavy here — discuss, don't install).
- Production-stack Helm chart (mentioned as "the grown-up version", not installed).

---

## 2. Why Kubernetes is the right vehicle for the observability half

The single-VM lab can only `curl /metrics` in a terminal. On k8s the same engine gives us, with no extra theory:

| Capability | Pedagogical value |
|---|---|
| Pod → Service → endpoint discovery | Metrics arrive by *scrape*, not by manual curl; mirrors production |
| `resources.requests/limits` | Turns "KV cache must fit" from a slogan into an OOMKilled event |
| `startupProbe` vs `readinessProbe` vs `livenessProbe` | Model load takes minutes → a genuinely instructive probe design problem |
| `kubectl top`, `describe`, events, restart counts | Resource pressure is visible and diagnostic |
| Multiple replicas behind one Service | Queueing and spreading story without needing a load balancer |
| Declarative redeploy | Tuning becomes "change one arg, `kubectl apply`, re-measure" — the actual workflow |
| `Job` for load generation | Load is reproducible and disposable |

---

## 3. Hard constraints and the memory budget

Killercoda `kubernetes-kubeadm-2nodes` = **4 GB total across two nodes** (controlplane + worker). Everything below is sized against that.

| Item | Budget | Notes |
|---|---|---|
| System + kubelet + CNI + kube-proxy | ~1.2–1.5 GB | leaves ~2.5 GB usable, concentrated on the worker |
| vLLM CPU image | 1.2 GB compressed (`vllm/vllm-openai-cpu:v0.32.0`), verify disk headroom | pulled once; pin the tag |
| vLLM pod RSS (in-process, 135M model, 512 ctx) | ~1.0–1.4 GB | `VLLM_ENABLE_V1_MULTIPROCESSING=0` is mandatory |
| Model weights on disk | 270 MB (SmolLM2-135M bf16) / ~1 GB (Qwen2.5-0.5B fp32) | cache on `hostPath`, not `emptyDir` |
| KV cache | 128–256 MB | `--kv-cache-memory-bytes` (preferred) or `VLLM_CPU_KVCACHE_SPACE` (whole GiB only) |
| Prometheus (minimal Deployment) | 150–250 MiB limit, 2 h retention | no kube-prometheus-stack, no Grafana by default |
| Load generator Job | ~80 MiB | Python + `httpx`/`requests`, or a bash loop with `xargs -P` |

**Consequence:** exactly **one** vLLM replica is realistic. Replica scaling must be *demonstrated and honestly bounded* (step 7), not actually sustained. Say so in the step text instead of letting learners discover a Pending pod and assume they broke something.

---

## 4. Decisions

### 4.1 Deployment style: raw manifests (chosen)

| Option | Verdict |
|---|---|
| **Raw `Deployment`/`Service`/`ConfigMap`** | **Chosen.** Every knob visible; ~120 lines total; teaches the primitives; no Helm/Tiller/debug indirection |
| `vllm-project/production-stack` Helm chart | Production-grade (router, autoscaling, dashboards) but hides exactly what we're teaching, and pulls multiple images/RBAC |
| KServe / Kaito `Workspace` | Great "day 2" abstraction; already covered by the repo's `Kaito` lab — link as follow-up |
| vLLM Operator | Immature / vendor-specific; mention only |

Note the trade-off in `resources.md`, and link `Kaito` + a production-stack reference.

### 4.2 vLLM version and image

- Pin **`v0.32.0`** (current upstream stable; verified on PyPI and Docker Hub, 2026-10-18). Never `latest`.
- Image: **`vllm/vllm-openai-cpu:v0.32.0`** — deterministic deps, sidesteps the pip/triton resolver fragility documented in the sibling lab, and makes the "container image" framing real.
- Do **not** attempt a pip install inside the cluster. If the image pull is too slow on the day, fall back to a pre-pulled node-image strategy or a slimmer variant — decide during build (see open questions).

### 4.3 Model

- Default: **`HuggingFaceTB/SmolLM2-135M-Instruct`** — smallest credible footprint, ~270 MB, loads in seconds (critical: model load is on the lab's critical path).
- Optional swap in one step: `Qwen/Qwen2.5-0.5B-Instruct` to show the memory equation biting (this one is much more coherent, so it's a genuine trade: quality vs panel/limit).
- Serve with `--max-model-len 512 --enforce-eager --disable-log-requests` (or minimal logging) to keep KV and log volume down.

### 4.4 Metrics stack

- **Minimal Prometheus**: one `Deployment` + `ConfigMap` scrape config + `ServiceAccount`/`Role`/`RoleBinding` for endpoint discovery. Static/dns SD on the vLLM `Service` is enough — *don't* teach full Kubernetes SD.
- **No Grafana by default** (another 200–400 MB). Prometheus UI via `port-forward` gives tables and a graph; that is sufficient. If a Grafana step is wanted later, make it optional and reference the repo's `Prometheus_Grafana_K8s` lab rather than duplicating it.
- Retention `2h`, `--storage.tsdb.retention.size=200MB`, memory limit 256Mi.

### 4.5 Metrics to actually teach

Vocabulary first (30 lines of prose, no math): **TTFT**, **TPOT/ITL**, **end-to-end**, **goodput**, and why an average latency is a lie.

Then the series (names verified against vLLM docs for 0.32):

| Signal | Series | What the learner should conclude |
|---|---|---|
| Work arriving | `vllm:num_requests_waiting`, `vllm:num_requests_running` | queue depth is the real load signal |
| Cache pressure | `vllm:kv_cache_usage_perc`, `vllm:num_preemptions` | memory saturation precedes latency collapse |
| Latency | `vllm:time_to_first_token_seconds` (histogram), `vllm:inter_token_latency_seconds` | use `histogram_quantile`, not the mean |
| Throughput | `vllm:prompt_tokens`, `vllm:generation_tokens` | counters → `rate()`; tokens/s is a *derivative* |
| Efficiency | `vllm:prefix_cache_hits` / `prefix_cache_queries` | cache hit rate is free throughput |
| Health | `vllm:request_success`, `vllm:corrupted_requests` | error signal, not just latency |

Also teach the trap explicitly: counters reset on pod restart → `rate()` spikes/negatives; check `restart_count`/start time before believing a graph.

---

## 5. Step outline

Each step: what/why → runnable commands → expected output → "what you learned" recap. `verify` scripts optional per step (see §7).

### Step 1 — Read the cluster before you deploy (8 min)

`kubectl get nodes -o wide`, `kubectl describe node` → allocatable vs capacity, `kubectl get pods -A`, `kubectl top nodes` (metrics-server presence — verify), storage classes, and the absence of `nvidia.com/gpu`.

Learner computes the budget: node allocatable − system − image overhead − weights − KV = what's left for the pod limit. Write the number down; step 4 depends on it.

**Outcome:** "the cluster is a memory budget, and the scheduler enforces it."

### Step 2 — Stage the model where pods can find it (7 min)

Cache the model once on the worker (`hostPath`, e.g. `/opt/models`), or a `PVC` if a storage class exists. Show `HF_HOME` / `--download-dir` pointing at it.

Why this step exists: without it, every pod restart re-downloads ~270 MB inside the startup window, which (a) makes probes flaky and (b) multiplies the time cost across the lab. Tie it back to the sibling lab's "model download is part of startup" lesson.

**Outcome:** model artifacts are an infrastructure concern, not a container concern.

### Step 3 — Deploy vLLM as a Deployment (12 min)

Apply a manifest with:

```yaml
env:
  - { name: VLLM_ENABLE_V1_MULTIPROCESSING, value: "0" }   # 4GB VM: keep it in-process
  - { name: VLLM_CPU_OMP_THREADS_BIND, value: "0-3" }      # match the pod's cpu limit
  - { name: HF_HOME, value: /models }
args: ["HuggingFaceTB/SmolLM2-135M-Instruct",
       "--max-model-len", "512",
       "--kv-cache-memory-bytes", "134217728",
       "--enforce-eager",
       "--served-model-name", "tiny",
       "--port", "8000"]
resources:
  requests: { cpu: "2", memory: "1Gi" }
  limits:   { cpu: "4", memory: "2Gi" }
startupProbe:  { httpGet: { path: /health, port: 8000 }, periodSeconds: 5, failureThreshold: 60 }  # ~5 min grace
readinessProbe:{ httpGet: { path: /health, port: 8000 }, periodSeconds: 5 }
livenessProbe: { httpGet: { path: /health, port: 8000 }, periodSeconds: 15, failureThreshold: 6 }
```

Watch `kubectl get pod -w`, `kubectl logs -f`. Read the startup log aloud: KV blocks, max concurrency, dtype, thread binding.

Then the deliberate failure: bump `--max-model-len` or the KV bytes beyond budget and watch `OOMKilled` / startup failure; explain the exit code and the `describe` event. Revert.

**Outcome:** flags ↔ memory ↔ scheduler are one system; probes must respect model load time.

### Step 4 — Expose and call it (8 min)

`ClusterIP` Service → in-cluster call from a throwaway `curl` pod (shows DNS: `http://vllm:8000/v1/models`) → `kubectl port-forward` for host access → optional `NodePort` + `{{TRAFFIC_HOST1_<port>}}` to prove external reachability.

Then the OpenAI-compatible call: `/v1/models`, non-streaming `/v1/chat/completions`, and a streaming call with `curl -N` showing SSE chunks. Point out that any OpenAI SDK works by changing `base_url`; optionally show `--api-key` + `Authorization` header as a Deploy-time Secret (and note it is not real authz/multi-tenancy).

**Outcome:** in-cluster vs host access paths; OpenAI API parity is a packaging property, not a k8s one.

### Step 5 — Scrape it with Prometheus (10 min)

Deploy minimal Prometheus (ConfigMap scrape config + RBAC + Deployment). Check `Targets` page shows the vLLM service UP; query `vllm:num_requests_running`, `vllm:kv_cache_usage_perc` (flat at zero — nothing has happened yet, which is itself the lesson: gauges are idle until load).

Establish the baseline: tokens/s from `rate(vllm:generation_tokens[1m])` with no traffic; then one single request and see the counter step function.

**Outcome:** metrics are scrape-driven; counters vs gauges; idle ≠ healthy.

### Step 6 — Drive load, read the signals (12 min)

Load `Job` (Python `concurrent.futures` / `xargs -P 8`) sending ~24 requests with short `max_tokens`. Watch simultaneously:

- `num_requests_waiting` rise then drain (queue),
- `kv_cache_usage_perc` climb (pressure),
- `histogram_quantile(0.95, sum(rate(vllm:time_to_first_token_seconds_bucket[1m])) by (le))` (latency),
- `rate(vllm:generation_tokens[1m])` (throughput).

Then the tuning loop: change **one** knob — `--max-num-seqs` (e.g. 1 → 8) or KV bytes — `kubectl apply`, wait for rollout, repeat the same Job, diff the two runs. Table the before/after.

Then the "why util is a lie" beat: CPU util at 100% with terrible goodput is the normal state of a saturated CPU engine.

**Outcome:** the throughput/latency tradeoff is an observable, tunable curve — the core deliverable of the lab.

### Step 7 — Lifecycle and scale, honestly (8 min)

- `kubectl delete pod` mid-request → in-flight failures, counter reset, `rate()` artifact; discuss graceful drain / `terminationGracePeriodSeconds`.
- `kubectl scale --replicas=2` → Pending pod, `describe` shows `Insufficient memory`. Read it, then scale back. This is the honest ceiling of a 4 GB cluster and a perfect segue to "on a GPU node pool this is the line that matters".
- Discuss (no install): HPA on `vllm:num_requests_waiting` via `prometheus-adapter`, why CPU-based HPA is wrong for LLM servers, and PDB/`maxSurge: 0` for rollout without double memory.

**Outcome:** Kubernetes gives you knobs; the engine's memory footprint decides which are usable.

### Step 8 — Cleanup + decision exercise (3 min)

Delete namespace/resources, `kubectl get all -A` to confirm. Then: given "one user, laptop, no GPU" vs "50 concurrent users, 2×A100" vs "batch scoring overnight", which tool — llama.cpp/Ollama, vLLM on k8s, or a managed endpoint? Link the sibling labs.

---

## 6. Assets (planned)

| File | Purpose |
|---|---|
| `assets/vllm-deploy.yaml` | Deployment + Service + ConfigMap (single apply) |
| `assets/prometheus.yaml` | Namespace, RBAC, ConfigMap scrape config, Deployment, Service |
| `assets/load.py` | Concurrent OpenAI-compatible client; CLI flags for concurrency, count, tokens |
| `assets/tune-values.md` | Table of knob → effect → expected direction (for step 6's before/after) |
| `assets/verify-*.sh` | Optional step verifiers (see §7) |

Wire via `details.assets.host01` with `target` under `/root/` and `chmod +x` on `load.py`/verify scripts.

---

## 7. Verification hooks (optional, cheap)

| Step | Verify condition |
|---|---|
| 3 | pod `Ready`, `restartCount == 0`, `/health` reachable via port-forward |
| 4 | `/v1/models` returns `tiny` |
| 5 | Prometheus target for vllm reports `up == 1` |
| 6 | `vllm:generation_tokens` increased during the Job |
| 7 | namespace resources deleted |

Keep verifiers permissive — the point is progress feedback, not grading.

---

## 8. `index.json` sketch

```json
{
  "title": "Operating vLLM on Kubernetes",
  "description": "Deploy, expose, scrape and tune a vLLM inference server on a CPU-only Kubernetes cluster. (v0.1)",
  "difficulty": "Intermediate",
  "time": "75 minutes",
  "details": {
    "intro": { "text": "intro.md" },
    "steps": [
      { "title": "Read the cluster budget",        "text": "step1.md" },
      { "title": "Stage the model on the node",    "text": "step2.md" },
      { "title": "Deploy vLLM",                    "text": "step3.md" },
      { "title": "Expose the OpenAI API",          "text": "step4.md" },
      { "title": "Scrape with Prometheus",         "text": "step5.md" },
      { "title": "Load, read, tune",               "text": "step6.md" },
      { "title": "Lifecycle and scale",            "text": "step7.md" },
      { "title": "Cleanup and choose an engine",   "text": "step8.md" }
    ],
    "finish": { "text": "finish.md" },
    "assets": { "host01": [ /* §6 */ ] }
  },
  "environment": {
    "uilayout": "terminal",
    "terminals": [
      { "name": "Cluster", "command": "kubectl get pods -A -w" },
      { "name": "Logs",    "command": "kubectl logs -f deploy/vllm --tail=50" }
    ]
  },
  "backend": { "imageid": "kubernetes-kubeadm-2nodes" }
}
```

(Exact `terminals` syntax to be confirmed against a working repo scenario before authoring.)

---

## 9. Timing budget

| Phase | Wall clock | Notes |
|---|---|---|
| Cluster boot | 60–90 s | platform, not learner |
| Image pull (1.2 GB) | 90–240 s | **biggest unknown**; pre-pull or accept |
| Model fetch (270 MB) | 10–40 s | once, into `hostPath` |
| First pod start (model load) | 20–60 s | 135M is fast; 0.5B is ~2–3× |
| Prometheus rollout | 30–60 s | image ~100 MB |
| Load job | 60–120 s | 24 short requests on 4 vCPU |
| **Learner-active total** | **≈ 45–55 min** | steps 1–5 ≈ 35 min |

Free tier is 60 minutes → design step 6–7 as "finish if you have time", and state the fast path in `intro.md`. A single 90-minute lab would strand free-tier learners mid-experiment.

---

## 10. Prerequisites and proficiency

- `kubectl` basics: apply/get/describe/logs/exec/port-forward, Deployments vs Services vs ConfigMaps.
- What a container limit is and what OOMKilled means.
- PromQL at "select a metric, `rate()` it" level (a 6-line refresher goes in step 5).
- No LLM-serving knowledge assumed — the sibling lab (`vllm/`) is the intended prerequisite, but each step restates the minimum.

Target: intermediate for steps 1–5, advanced for 6–7.

---

## 11. Risks and mitigations

| Risk | Likelihood | Mitigation |
|---|---|---|
| Image pull too slow / disk full | Medium | Verify free disk in step 1; consider slimmer image or pre-pull during `init` background script; document fallback |
| Pod OOMKilled on the worker (system load) | Medium | 1 replica, 2Gi limit, 135M model, `--max-model-len 512`, `VLLM_ENABLE_V1_MULTIPROCESSING=0` |
| Prometheus + vLLM together don't fit | Medium | Prometheus 256Mi limit, 200MB retention; if still tight, keep vLLM on worker and Prometheus on controlplane via nodeSelector |
| `kubectl top` unavailable (no metrics-server) | Medium | Don't depend on it; use `describe node` allocatable and pod RSS from `kubectl exec`/`/proc` as fallback |
| Probe misconfiguration → CrashLoopBackOff | Certain (deliberate in step 7) | Make the deliberate failure explicitly labelled, and give the revert command |
| Counter/`rate()` artifacts confuse learners | High | Step 5 and 7 teach the reset trap explicitly |
| Retry / platform reboot mid-lab | Low | Manifests are idempotent (`kubectl apply`), all in `assets/` |

---

## 12. Production safety disclaimer (required in `intro.md` and step 3)

- No TLS, no real authn/authz: `--api-key` is a shared secret, not a security boundary.
- No resource quotas, PDB, NetworkPolicy, or node isolation.
- Single replica, `hostPath` model cache, no backup: **not** a production pattern.
- A GPU production deployment needs: GPU Operator + device plugin + node pools, taints/tolerations, multi-replica behind a router, HPA on queue depth, Prometheus + alerting, and the `production-stack` Helm chart — reference it, don't imitate it here.

---

## 13. Course coherence

| Relation | Lab |
|---|---|
| **Prerequisite** | `workInProgress/vllm/` (this sibling: install, offline `LLM`, serving basics) |
| Prerequisite | Kubernetes basics (`k3s_k9s`, `k8s-storage`), `Prometheus_Grafana_K8s` |
| Sibling / contrast | `workInProgress/ollama` (single-user local), `workInProgress/LLM_file_and_inferance` (GGUF, quantization) |
| Follow-up (abstraction) | `workInProgress/Kaito` (operator-driven inference), KServe / production-stack |
| Follow-up (concepts) | GPU serving: tensor parallel, PagedAttention internals, quantization-aware serving |

Positioning sentence for the catalog: *"Ollama runs a model; vLLM serves a model; this lab operates a vLLM server the way you would in production — on the smallest cluster that can hold one."*

Note: the repo's conventions reference `scenario_ideas.md`, which does not exist yet. Create it (or add this topic to it) when the lab moves out of `workInProgress/`.

---

## 14. Open questions to resolve during build

1. **Image strategy** — can the 1.2 GB CPU image be pulled inside the session reliably, or should `init.sh` pre-pull it in the background during the intro? Measure, then decide.
2. **Node topology** — confirm per-node RAM split of `kubernetes-kubeadm-2nodes`; pin the vLLM pod to the worker with `nodeSelector` and Prometheus to the controlplane.
3. **Model cache** — `hostPath` `/opt/models` (simple) vs `PVC` (correct, but only if a default storage class exists in the backend).
4. **Grafana** — confirm minimal Prometheus + UI is enough for the "observability" payoff, or whether a 2-panel Grafana is worth the RAM.
5. **`terminals` syntax** — validate the exact `environment.terminals` shape against a working scenario in this repo.
6. **Version drift** — re-check vLLM stable tag and CPU image tag at authoring time; pin whatever is current (0.32.0 at time of planning).
7. **Free-tier fit** — if steps 1–5 routinely exceed 50 minutes, merge step 2 into step 1 (stage model inside the deploy step) rather than cutting observability.

---

## 15. Definition of done

- [ ] `index.json` valid JSON, title ≈6 words, description <30 words ending `(v0.1)`, `time` realistic.
- [ ] All eight steps have: what/why, executable commands, expected output, recap.
- [ ] `intro.md` carries: last-updated date, proficiency, prerequisites, CPU-only framing, production disclaimer.
- [ ] Assets wired in `details.assets`, scripts executable, manifests idempotent.
- [ ] Step 3's deliberate OOM and step 7's Pending pod both have explicit revert commands.
- [ ] Absolute timings verified by a full end-to-end run (not estimated).
- [ ] Leftover notes, reading lists and abandoned commands parked in `resources.md`, not in steps.
- [ ] `resources.md` records: alternatives, chosen version pin, memory budget, image pull timings, and the "when *not* to run vLLM on k8s" section.
