# Step 6: Exploring Thinking Models

Due to the limited memory size, we are limited

`ollama run gemma3:1b`{{exec}}

We'll use python to see the thinking in action, with the question "If John has 3 apples and gives 1 to Mary, then buys a box of 5 more, how many does he have?"

# Install uv

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```{{execute}}

Add uv to your PATH for this session:

```bash
source $HOME/.cargo/env 2>/dev/null || source $HOME/.local/bin/env 2>/dev/null || export PATH="$HOME/.local/bin:$PATH"
```{{execute}}

Verify:

```bash
uv --version
```{{execute}}

## Create Project

```bash
mkdir -p ~/ollama-thinking && cd ~/ollama-thinking
uv init
```{{execute}}


```bash
uv add ollama 
```{{execute}}

`pip install ollama`{{exec}}

`touch thinking.py`{{exec}}

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
        # Stream the response to handle low-memory CPU processing smoothly
        stream = ollama.chat(model=model_name, messages=messages, stream=True)

        in_thinking_block = False
        thinking_header_printed = False
        answer_header_printed = False

        for chunk in stream:
            content = chunk["message"]["content"]
            if not content:
                continue

            # Check if the model is entering or exiting the thinking phase
            if "<think>" in content:
                in_thinking_block = True
                content = content.replace("<think>", "")

            if "</think>" in content:
                in_thinking_block = False
                content = content.replace("</think>", "")
                # Force a newline after thinking ends
                content += "\n"

            # Print headers nicely to separate the two states
            if in_thinking_block and not thinking_header_printed:
                print("\n🧠 THOUGHT PROCESS:")
                thinking_header_printed = True

            if not in_thinking_block and thinking_header_printed and not answer_header_printed:
                print("\n✨ FINAL ANSWER:")
                answer_header_printed = True

            # Stream the text to the terminal immediately
            sys.stdout.write(content)
            sys.stdout.flush()

        print("\n-------------------------------------------")

    except Exception as e:
        print(f"\nAn error occurred: {e}")
        print("Please ensure Ollama is running and gemma3:1b is downloaded.")


if __name__ == "__main__":
    # Test question that requires a bit of logic
    sample_question = "If John has 3 apples and gives 1 to Mary, then buys a box of 5 more, how many does he have?"
    ask_gemma_with_thinking(sample_question)

```{{copy}}

`python thinking.py`{{exec}}