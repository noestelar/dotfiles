#!/usr/bin/env bash
# Dotfiles install script
# Usage: bash install.sh
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
log() { echo "[dotfiles] $*"; }

# Detect OS
if command -v pacman >/dev/null 2>&1; then
  OS="arch"
  log "Detected: Arch/CachyOS"
elif command -v rpm-ostree >/dev/null 2>&1; then
  OS="bazzite"
  log "Detected: Bazzite/Fedora (immutable)"
else
  OS="unknown"
  log "WARNING: Unknown OS — some steps may need manual intervention"
fi

# Install core packages
if [[ "$OS" == "arch" ]]; then
  log "Installing packages via pacman..."
  sudo pacman -S --needed --noconfirm \
    git curl wget unzip socat jq \
    nodejs npm python python-pip \
    base-devel qmk avr-gcc avrdude python-hid \
    tailscale

  if command -v yay >/dev/null 2>&1; then
    log "Installing AUR packages..."
    yay -S --needed --noconfirm google-chrome 1password-cli ydotool sunshine
  else
    log "WARNING: yay not found — install manually: google-chrome, 1password-cli, ydotool, sunshine"
  fi

elif [[ "$OS" == "bazzite" ]]; then
  log "Bazzite: use rpm-ostree for system packages (requires reboot)"
fi

# OpenClaw
if ! command -v openclaw >/dev/null 2>&1; then
  log "Installing OpenClaw..."
  npm install -g openclaw
else
  log "OpenClaw already installed"
fi

# Shell aliases
BASHRC="$HOME/.bashrc"
if ! grep -q "dotfiles/shell/aliases.sh" "$BASHRC" 2>/dev/null; then
  printf '\n# Dotfiles aliases\nsource %s/shell/aliases.sh\n' "$DOTFILES_DIR" >> "$BASHRC"
  log "Added aliases to ~/.bashrc"
fi

# Systemd user services
SYSTEMD_USER="$HOME/.config/systemd/user"
mkdir -p "$SYSTEMD_USER"
if [[ ! -f "$SYSTEMD_USER/openclaw-gateway.service" ]]; then
  cp "$DOTFILES_DIR/systemd/openclaw-gateway.service" "$SYSTEMD_USER/"
  log "Installed openclaw-gateway.service"
fi

log ""
log "Done! Next steps:"
log "  1. openclaw backup restore <backup.tar.gz>  — restore Alia"
log "  2. systemctl --user enable --now openclaw-gateway"
log "  3. op signin  (1Password CLI)"
log "  4. tailscale up"
log "  5. See: ~/.openclaw/workspace/docs/migration-bazzite-to-cachyos.md"
