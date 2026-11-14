# Step 6: Explore a Thinking Model

So far we have used `tinyllama`, a tiny general-purpose model. Now let's look at a model that
actually reasons before it answers.

We are going to use **`bonsai-2:4b`**, pulled from the Ollama library:
https://ollama.com/library/bonsai-2

We chose it because the library page lists it as a **thinking** model (the `thinking` badge on that
page), and the 4B tag is only **1.6 GB** on disk. That is small enough to load inside this lab's
limited memory while still giving us a real reasoning loop, unlike the much smaller `gemma3:1b`.

| Model | Size | Thinking | Fits this lab? |
| --- | --- | --- | --- |
| `tinyllama` | 637 MB | ❌ | ✅ |
| `gemma3:1b` | 815 MB | ❌ (needs prompt tricks) | ✅ |
| **`bonsai-2:4b`** | **1.6 GB** | **✅ native** | **✅** |
| `bonsai-2:27b` | 8.3 GB | ✅ | ❌ too large |

## 1. Pull the model

Downloading 1.6 GB takes a minute or two, so pull it explicitly rather than letting it happen
silently mid-query:

```bash
ollama pull bonsai-2:4b
```{{execute}}

Confirm it is on disk:

```bash
ollama list
```{{execute}}

## 2. Quick check from the CLI

```bash
ollama run bonsai-2:4b "In one sentence, what is a ternary-weight model?"
```{{execute}}

Then check how much memory it needed once loaded:

```bash
ollama ps
```{{execute}}

The `SIZE` column shows the model plus its context in memory. Unload it again with
`ollama stop bonsai-2:4b` if you are short on RAM.

## 3. Set up a Python project with uv

Ollama's Python client exposes the reasoning text separately from the final answer, which is much
easier to work with than scraping tags out of a response.

Install `uv`:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```{{execute}}

Add it to your PATH for this session:

```bash
source $HOME/.cargo/env 2>/dev/null || source $HOME/.local/bin/env 2>/dev/null || export PATH="$HOME/.local/bin:$PATH"
```{{execute}}

Verify:

```bash
uv --version
```{{execute}}

## 4. Create the project

```bash
mkdir -p ~/ollama-thinking && cd ~/ollama-thinking
uv init --bare
uv add ollama
```{{execute}}

`uv init --bare` creates just a `pyproject.toml`, and `uv add ollama` records the dependency and
creates the virtual environment. Note we run the script with `uv run`, so there is no need to
activate anything or to `pip install` into the system Python.

## 5. Write the thinking script

This writes `thinking.py` into the current directory:

```bash
cat > thinking.py << 'EOF'
import sys
import ollama

MODEL = "bonsai-2:4b"


def ask_with_thinking(prompt: str) -> None:
    print(f"--- Querying {MODEL} (native thinking enabled) ---")

    # think=True makes Ollama return the reasoning trace in
    # message.thinking, and the answer in message.content.
    stream = ollama.chat(
        model=MODEL,
        messages=[{"role": "user", "content": prompt}],
        think=True,
        stream=True,
    )

    thinking_started = False
    answer_started = False

    for chunk in stream:
        message = chunk.message
        thinking = getattr(message, "thinking", None) or ""
        content = message.content or ""

        if thinking:
            if not thinking_started:
                print("\n🧠 THINKING:")
                thinking_started = True
            sys.stdout.write(thinking)
            sys.stdout.flush()

        if content:
            if not answer_started:
                print("\n\n✨ FINAL ANSWER:")
                answer_started = True
            sys.stdout.write(content)
            sys.stdout.flush()

    print("\n-------------------------------------------")


if __name__ == "__main__":
    ask_with_thinking(
        "If John has 3 apples and gives 1 to Mary, then buys a box of 5 more, how many does he have?"
    )
EOF
```{{execute}}

## 6. Run it

```bash
cd ~/ollama-thinking && uv run thinking.py
```{{execute}}

You should see the streamed reasoning under 🧠 THINKING, followed by the answer under
✨ FINAL ANSWER.

Because the trace is a separate field, you can now do things a chat UI cannot: count the reasoning
tokens, log the trace for auditing, or feed only the final answer to the next program in a
pipeline.

## What you learned

- How to pick a model by checking its size, capabilities (thinking, vision, tools) and context
  window on its library page before downloading it.
- `bonsai-2:4b` gives native reasoning at 1.6 GB, which fits this lab's memory budget.
- `ollama pull`, `ollama list`, `ollama ps` and `ollama stop` to manage disk and memory.
- `think=True` in the Python client returns reasoning in `message.thinking`, separate from
  `message.content`.

**Tip:** Swap the `MODEL` constant for `bonsai-2:9b` if you have ~3 GB of free RAM, or use
`think=False` to see how the answer changes when the model is not allowed to reason.
