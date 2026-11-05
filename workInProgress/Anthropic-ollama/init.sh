#!/bin/bash
# Foreground bootstrap, run by Killercoda when the scenario starts.

# Create a normal user with passwordless sudo. The terminal still starts as root.
useradd -ms /bin/bash coder 2>/dev/null || true
echo "coder ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/coder
chmod 0440 /etc/sudoers.d/coder

cat <<'EOF'

  Anthropic Python SDK with Ollama
  --------------------------------

  This sandbox starts empty: step 1 installs Ollama, starts it and
  pulls the model. Expect a roughly 2.5 GB download on the first run.

  The terminal runs as root. Everything else is in step 1.

EOF
