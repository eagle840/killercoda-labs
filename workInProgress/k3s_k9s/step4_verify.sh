#!/bin/bash
[ -x /usr/local/bin/k9s ] || exit 1
k9s version &>/dev/null || exit 1
