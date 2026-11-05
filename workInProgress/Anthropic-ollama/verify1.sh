#!/bin/bash
# Verify step 1: a working first call through the shared helper.
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

if [ ! -f hello.py ]; then
  echo "FAIL: hello.py is missing."
  exit 1
fi
if [ ! -f helpers/client.py ]; then
  echo "FAIL: helpers/client.py is missing."
  exit 1
fi

if ! grep -q "get_client" hello.py; then
  echo "FAIL: hello.py should use helpers.client.get_client() (step 1, section 6)."
  exit 1
fi

echo "Running hello.py ..."
out="$(timeout 240 uv run --quiet python hello.py 2>/tmp/verify1.err)"
rc=$?
if [ "$rc" -ne 0 ]; then
  echo "FAIL: hello.py exited with status $rc"
  sed -n '1,40p' /tmp/verify1.err
  exit 1
fi

echo "$out"
if [ "${#out}" -lt 10 ]; then
  echo "FAIL: hello.py printed less than 10 characters."
  exit 1
fi

echo
echo "Checking helpers.client ..."
timeout 60 uv run --quiet python -c "
from helpers.client import get_client, get_model
c = get_client()
m = get_model()
assert m, 'get_model() returned an empty value'
assert hasattr(c, 'messages'), 'get_client() did not return an Anthropic client'
print('OK client=%s model=%s' % (type(c).__name__, m))
" || {
  echo "FAIL: helper import check failed."
  exit 1
}

echo
echo "PASS: first Anthropic call works against Ollama."
