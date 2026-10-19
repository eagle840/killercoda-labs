# LLM / AI Inference Engine Metrics — Reading List

Curated articles on metrics for AI inference engines (vLLM, TGI, TensorRT-LLM,
Triton, and the general LLM-serving literature). ★ = worth a full read.

---

## Foundational / "what to measure"

- ★ **Databricks — [LLM Inference Performance Engineering: Best Practices](https://www.databricks.com/blog/llm-inference-performance-engineering-best-practices)**
  The canonical piece. Defines TTFT and TPOT and the identity
  `latency = TTFT + TPOT × output_tokens`, then connects them to batching,
  memory and quantization. Almost every other article builds on this vocabulary.
- ★ **Modular — [Key metrics for LLM inference](https://handbook.modular.com/llm-inference-basics/llm-inference-metrics/)**
  Best treatment of **goodput** and utilization metrics (MFU/MBU) tied to SLOs.
  Clear about why raw throughput without a latency constraint is meaningless.
- ★ **Baseten — [Inference Engineering (online book)](https://www.baseten.co/inference-engineering/)**
  Start with "Measuring Latency and Throughput" and "GPU Utilization Is a Lie."
  Practitioner-grade; strong on why utilization % misleads and how percentiles behave.
- **Anyscale — [Understand LLM latency and throughput metrics](https://docs.anyscale.com/llm/serving/benchmarking/metrics)**
  Concise, correct definitions of TTFT, ITL/TPOT, E2E, TPS, RPS, and goodput.

## Metric definitions, deep dives

- **ClickHouse — [LLM inference latency: TTFT, tokens per second, and what actually matters](https://clickhouse.com/resources/engineering/llm-inference-latency)**
  Strong argument that latency only means anything as percentiles (p50/p95/p99)
  over raw request events, never averages.
- **GPUSmith — [TTFT, ITL, TPS and Goodput](https://gpusmith.com/articles/en/llm-inference-metrics-ttft-itl-tps-goodput)**
  Careful about the **TPOT vs ITL** distinction (average vs token-wise), a detail
  many articles get wrong.
- **IntoAI — [10 LLM Inference Metrics Every AI Engineer Must Know](https://www.intoai.pub/p/llm-inference-metrics)**
  Good breadth: TTFT, TPOT, ITL, goodput, MBU, MFU.
- **HiveNet — [LLM inference benchmark metrics explained](https://www.hivenet.com/post/llm-inference-metrics-ttft-tps)**
  Readable intro if you need to onboard someone quickly.

## Engine-specific (the ones you're actually running)

- ★ **vLLM — [Production Metrics](https://docs.vllm.ai/en/stable/usage/metrics/)** and
  **[v1 Metrics design](https://docs.vllm.ai/en/v0.29.0/design/v1/metrics.html)**
  The authoritative catalog of `vllm:*` counters/histograms plus a reference
  Prometheus + Grafana example. This is the source of truth for the `vllm:*`
  series exposed on `/metrics`.
- **Hugging Face TGI — [Metrics reference](https://huggingface.co/docs/text-generation-inference/en/reference/metrics)** and the
  **[Prometheus + Grafana monitoring tutorial](https://huggingface.co/docs/text-generation-inference/en/basic_tutorials/monitoring)**
  The other major engine; directly comparable counter names.
- **NVIDIA Triton — [Metrics](https://docs.nvidia.com/deeplearning/triton-inference-server/user-guide/docs/user_guide/metrics.html)**
  For classic ML/DL serving alongside LLMs; good if your stack isn't LLM-only.
- **vLLM production-stack — [Observability dashboard](https://github.com/vllm-project/production-stack/blob/main/observability/README.md)**
  How the maintainers wire router + Prometheus together.

## Production observability stacks

- **Elastic — [vLLM Prometheus metrics for self-hosted LLM tuning](https://www.elastic.co/observability-labs/blog/tune-vllm-prometheus-metrics-elastic)**
  Notably careful about counters being cumulative (the same trap as naive `rate()` math).
- **Andrew Krisanov — [Monitoring vLLM in Production: Metrics, PromQL, Alerts, Runbooks](https://akrisanov.com/vllm-metrics/)**
  Copy-paste PromQL and alerting rules.
- **Rost Glukhov — [Prometheus & Grafana for vLLM, TGI, llama.cpp](https://www.glukhov.org/observability/monitoring-llm-inference-prometheus-grafana/)**
  Cross-engine, practical.
- **Google Cloud — [vLLM Managed Prometheus exporter](https://docs.cloud.google.com/stackdriver/docs/managed-prometheus/exporters/vllm)**
  and the **[Grafana vLLM dashboards](https://grafana.com/grafana/dashboards/25620-vllm-serving-overview-tested-gpu-free/)**
  Ready-made starting points.

## Papers (where the metrics lexicon came from)

- **DistServe** (goodput-optimal, prefill/decode disaggregation) and
  **Sarathi-Serve** (chunked prefill, stall-free batching) — these are why
  "goodput" and the "TTFT vs ITL tradeoff" exist as concepts.
- **PagedAttention / vLLM** paper — origin of the KV-cache metrics.
- **[A Performance Study of vLLM and HuggingFace TGI](https://arxiv.org/html/2511.17593v1)** (2025).

---

**Shortlist if you only read three:** Databricks (foundations), Modular handbook
(goodput/SLOs), and the vLLM metrics docs (the actual series on your server).
