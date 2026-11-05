#!/bin/bash
# Verify step 2: inspect_response() works against a fresh live call.
set -u

LAB=/root/anthropic-lab

if [ ! -f /var/lib/anthropic-lab-ready ]; then
  echo "Waiting for the background setup to finish ..."
  for _ in $(seq 1 60); do
    [ -f /var/lib/anthropic-lab-ready ] && break
    sleep 2
  done
fi

if [ ! -d "$LAB" ]; then
  echo "FAIL: $LAB does not exist. Complete step 1 first."
  exit 1
fi
cd "$LAB" || exit 1

if [ ! -f helpers/inspect.py ]; then
  echo "FAIL: helpers/inspect.py is missing."
  exit 1
fi
if [ ! -f anatomy.py ]; then
  echo "FAIL: anatomy.py is missing."
  exit 1
fi

echo "Running anatomy.py ..."
timeout 300 uv run --quiet python anatomy.py >/tmp/verify2.out 2>&1
rc=$?
head -n 60 /tmp/verify2.out
if [ "$rc" -ne 0 ]; then
  echo "FAIL: anatomy.py exited with status $rc (full output above)."
  exit 1
fi

echo
echo "Asserting on a fresh response ..."
timeout 240 uv run --quiet python - <<'PY'
from helpers.client import get_client, get_model
from helpers.inspect import inspect_response

message = get_client().messages.create(
    model=get_model(),
    max_tokens=64,
    messages=[{"role": "user", "content": "Say hello in one short sentence."}],
)

info = inspect_response(message)
assert isinstance(info, dict), "inspect_response() must return a dict"
assert info["block_types"] == ["text"], info
assert info["stop_reason"] in {"end_turn", "max_tokens"}, info
assert isinstance(info["input_tokens"], int) and info["input_tokens"] > 0, info
assert isinstance(info["output_tokens"], int) and info["output_tokens"] > 0, info
assert len(info["text_preview"]) > 0, info
print("PASS:", info)
PY
rc=$?
if [ "$rc" -ne 0 ]; then
  echo "FAIL: assertions failed."
  exit 1
fi

echo
echo "PASS: response inspection helper is complete."
