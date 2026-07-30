#!/bin/bash
# Verify k3s process is running and systemd is happy
systemctl is-active --quiet k3s || exit 1
