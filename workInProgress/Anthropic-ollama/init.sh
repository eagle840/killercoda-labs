#!/bin/bash
# Foreground bootstrap, run by Killercoda when the scenario starts.
# Heavy provisioning (Ollama, model pull) happens in setup.sh in the background.

# Create a normal user with passwordless sudo. The terminal still starts as root.
useradd -ms /bin/bash coder 2>/dev/null || true
echo "coder ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/coder
chmod 0440 /etc/sudoers.d/coder

cat <<'EOF'

  Anthropic Python SDK with Ollama
  --------------------------------

  Ollama and the model are being installed in the background.
  This usually takes 2-5 minutes on first boot.

  Watch progress with:
      tail -f /var/log/anthropic-lab-setup.log

  When the log ends with "READY", step 1 is good to go.

EOF
