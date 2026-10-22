
# Configure vLLM for CPU-only execution.
# The lab VM has a 4GB memory limit, so run the engine in-process
# (VLLM_ENABLE_V1_MULTIPROCESSING=0): the default multi-process mode
# spawns 2 extra Python processes that each cost over 1GB.
# VLLM_CPU_KVCACHE_SPACE is deliberately unset - it would override the
# kv_cache_memory_bytes argument and only accepts whole GiB values.
os.environ["VLLM_TARGET_DEVICE"] = "cpu"
os.environ["VLLM_ENABLE_V1_MULTIPROCESSING"] = "0"
os.environ.pop("VLLM_CPU_KVCACHE_SPACE", None)
os.environ["TORCHDYNAMO_DISABLE"] = "1"

# 128MB KV cache - holds ~43 full-length sequences for SmolLM-135M at
# max_model_len=128 (~22.5KB KV per token). Kept small because vLLM's
# startup check counts the pod's page cache (model downloads) as used
# memory, leaving only a few hundred MB "available" on the 4GB VM.
KV_CACHE_BYTES = 128 * 1024 * 1024



    # Extract results
    generated_text = outputs[0].outputs[0].text
    generated_tokens = len(outputs[0].outputs[0].token_ids)
    total_time = end_time - start_time
    tokens_per_second = generated_tokens / total_time
 4GB VM.


