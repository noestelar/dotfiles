#!/usr/bin/env bash
# Shell aliases — source from ~/.bashrc:
#   source ~/Workspace/dotfiles/shell/aliases.sh

# Browser / Chrome debugging
alias chrome-debug='google-chrome --remote-debugging-port=9222 &'

# Amazon cookie refresh (requires chrome-debug running + logged in to Amazon)
alias amazon-save-cookies='cd ~/.openclaw/workspace && npx tsx scripts/amazon-save-cookies.ts'

# GOG keyring password from 1Password (for non-TTY contexts)
if [[ -z "${GOG_KEYRING_PASSWORD:-}" ]] && command -v op >/dev/null 2>&1; then
  export GOG_KEYRING_PASSWORD="$(op read 'op://OpenClaw/Gog/GOG_KEYRING_PASSWORD' 2>/dev/null)" || true
fi
