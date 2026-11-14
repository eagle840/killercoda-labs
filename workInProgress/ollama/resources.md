# Ollama Lab — Notes and Older Code

## Model selection (Step 6)

Step 6 uses **`bonsai-2:4b`** from https://ollama.com/library/bonsai-2.

Rationale:

- The library page lists the family as supporting **thinking** (badge: `vision tools thinking 2b 4b 9b 27b`),
  so we get a real reasoning loop instead of a prompt-engineering imitation.
- The `4b` tag is **1.6 GB** on disk — small enough for the lab's memory budget.
  `bonsai-2:27b` (8.3 GB) is the same model family but will not load here.
- Bonsai 2 (Prism ML) uses ternary weights (−1, 0, +1), roughly half the size of an equivalent
  4-bit model, and is Apache 2.0 licensed.

Other models considered for this step:

| Model | Size | Native thinking | Verdict |
| --- | --- | --- | --- |
| `gemma3:1b` | 815 MB | ❌ | Needed a `<think>` system prompt; not a real reasoning model |
| `deepseek-r1:1.5b` | 1.1 GB | ✅ | Works, but older and weaker at small sizes than bonsai-2 |
| `qwen3:1.7b` | 1.4 GB | ✅ | Good alternative, toggle with `/set think` |
| **`bonsai-2:4b`** | **1.6 GB** | **✅** | **Chosen: newest thinking model that fits** |
| `bonsai-2:27b` | 8.3 GB | ✅ | Too large for this lab |

## API note

With a native thinking model, the reasoning is returned in a dedicated field rather than inline
tags, so no tag parsing is required:

```python
stream = ollama.chat(model="bonsai-2:4b", messages=[...], think=True, stream=True)
for chunk in stream:
    print(chunk.message.thinking or "", end="")  # reasoning trace
    print(chunk.message.content or "", end="")   # final answer
```

Setting `think=False` disables the trace, which is useful for latency comparisons.

## Older code — `gemma3:1b` with a fake thinking loop

This was the original Step 6 script. `gemma3:1b` does not reason natively, so the script forced it
to emit `<think>` tags via a system prompt and then stripped the tags while streaming. It is kept
here for reference; it produces text that *looks* like a reasoning trace but is not a separate
reasoning phase.

```python
import sys
import ollama


def ask_gemma_with_thinking(user_prompt: str):
    model_name = "gemma3:1b"

    # Since gemma3:1b doesn't natively use a thinking loop,
    # we use a system prompt to force it to use <think> tags.
    messages = [
        {
            "role": "system",
            "content": (
                "You must think step-by-step before answering. "
                "Write your entire reasoning process inside a <think> block, "
                "and then provide your final answer outside of it.\n"
                "Example format:\n"
                "<think>\n[Your step-by-step logic here]\n</think>\n[Your final answer here]"
            ),
        },
        {"role": "user", "content": user_prompt},
    ]

    print(f"--- Querying {model_name} (2GB CPU Mode) ---")

    try:
        stream = ollama.chat(model=model_name, messages=messages, stream=True)

        in_thinking_block = False
        thinking_header_printed = False
        answer_header_printed = False

        for chunk in stream:
            content = chunk["message"]["content"]
            if not content:
                continue

            if "<think>" in content:
                in_thinking_block = True
                content = content.replace("<think>", "")

            if "</think>" in content:
                in_thinking_block = False
                content = content.replace("</think>", "")
                content += "\n"

            if in_thinking_block and not thinking_header_printed:
                print("\n🧠 THOUGHT PROCESS:")
                thinking_header_printed = True

            if not in_thinking_block and thinking_header_printed and not answer_header_printed:
                print("\n✨ FINAL ANSWER:")
                answer_header_printed = True

            sys.stdout.write(content)
            sys.stdout.flush()

        print("\n-------------------------------------------")

    except Exception as e:
        print(f"\nAn error occurred: {e}")
        print("Please ensure Ollama is running and gemma3:1b is downloaded.")


if __name__ == "__main__":
    sample_question = "If John has 3 apples and gives 1 to Mary, then buys a box of 5 more, how many does he have?"
    ask_gemma_with_thinking(sample_question)
```

## Links

- Ollama library: https://ollama.com/library
- Bonsai 2: https://ollama.com/library/bonsai-2
- Ollama Python client: https://github.com/ollama/ollama-python
- uv: https://docs.astral.sh/uv/
- Prism ML on Hugging Face: https://huggingface.co/prism-ml
