#!/bin/bash
# Background provisioning for the "Anthropic Python SDK with Ollama" lab.
#
# Killercoda runs this in the background while the learner reads intro.md.
# Progress is written to /var/log/anthropic-lab-setup.log.
# When everything is ready, /var/lib/anthropic-lab-ready is created.

set -u

LOG=/var/log/anthropic-lab-setup.log
READY=/var/lib/anthropic-lab-ready
OLLAMA_LOG=/var/log/ollama.log
MODEL="${ANTHROPIC_MODEL:-qwen2.5-coder:1.5b}"

rm -f "$READY"
: > "$LOG"
exec >>"$LOG" 2>&1

log() { echo "[$(date +%H:%M:%S)] $*"; }

log "starting lab setup"

export DEBIAN_FRONTEND=noninteractive

# --- base packages -----------------------------------------------------------
if ! command -v curl >/dev/null 2>&1 || ! command -v python3 >/dev/null 2>&1; then
  log "installing base packages"
  apt-get -o DPkg::Lock::Timeout=180 update -qq || true
  apt-get -o DPkg::Lock::Timeout=180 install -y -qq \
    curl ca-certificates tar python3 python3-venv || true
fi

# --- uv ----------------------------------------------------------------------
if ! command -v uv >/dev/null 2>&1; then
  log "installing uv into /usr/local/bin"
  curl -fsSL https://astral.sh/uv/install.sh \
    | env UV_INSTALL_DIR=/usr/local/bin sh || log "WARNING: uv install failed"
else
  log "uv already present: $(uv --version 2>/dev/null)"
fi

if ! command -v uv >/dev/null 2>&1; then
  log "FATAL: uv is not available"
  exit 1
fi

# --- ollama ------------------------------------------------------------------
OLLAMA_VERSION="${OLLAMA_VERSION:-0.40.14}"
OLLAMA_PINNED="https://github.com/ollama/ollama/releases/download/v${OLLAMA_VERSION}/ollama-linux-amd64.tgz"
OLLAMA_LATEST="https://ollama.com/download/ollama-linux-amd64.tgz"

if ! command -v ollama >/dev/null 2>&1; then
  log "downloading Ollama v${OLLAMA_VERSION} (about 1.5 GB)"
  # The manual tarball avoids the install script's systemd assumptions.
  if ! curl -fL --retry 3 --retry-delay 2 "$OLLAMA_PINNED" -o /tmp/ollama.tgz; then
    log "WARNING: pinned Ollama download failed; falling back to latest"
    curl -fL --retry 3 --retry-delay 2 "$OLLAMA_LATEST" -o /tmp/ollama.tgz || true
  fi

  if [ -s /tmp/ollama.tgz ]; then
    tar -C /usr -xzf /tmp/ollama.tgz
    rm -f /tmp/ollama.tgz
    log "ollama installed: $(ollama --version 2>&1 | head -n 1)"
  else
    log "ERROR: Ollama download failed"
  fi
else
  log "ollama already present"
fi

if ! command -v ollama >/dev/null 2>&1; then
  log "FATAL: ollama binary is not available"
  exit 1
fi

# --- run the server ----------------------------------------------------------
if ! curl -sf http://127.0.0.1:11434/api/version >/dev/null 2>&1; then
  log "starting ollama serve"
  # setsid detaches the server from this script's process group so it survives
  # the background script exiting.
  if command -v setsid >/dev/null 2>&1; then
    nohup setsid ollama serve >"$OLLAMA_LOG" 2>&1 &
  else
    nohup ollama serve >"$OLLAMA_LOG" 2>&1 &
  fi
fi

for _ in $(seq 1 90); do
  curl -sf http://127.0.0.1:11434/api/version >/dev/null 2>&1 && break
  sleep 2
done

if ! curl -sf http://127.0.0.1:11434/api/version >/dev/null 2>&1; then
  log "FATAL: Ollama did not start; see $OLLAMA_LOG"
  exit 1
fi
log "ollama is listening on 127.0.0.1:11434"

# --- pull the model ----------------------------------------------------------
log "pulling $MODEL (about 1 GB; first boot only)"
for attempt in 1 2 3; do
  if ollama pull "$MODEL"; then
    break
  fi
  log "pull attempt $attempt failed; retrying in 5s"
  sleep 5
done

if ! ollama list 2>/dev/null | grep -q "${MODEL%%:*}"; then
  log "FATAL: model $MODEL is not available"
  exit 1
fi

touch "$READY"
log "READY: $MODEL is installed and Ollama is serving"
