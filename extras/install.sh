#!/usr/bin/env bash
# Setup tools — machine bootstrap + optional extras (gaming, QMK, dev runtimes)
# Usage: bash install.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
log() { echo "[setup-tools] $*"; }

ask() {
  read -rp "[setup-tools] $1 [y/N] " answer
  [[ "$answer" =~ ^[Yy] ]]
}

IS_MAC=false
IS_LINUX=false
OS="unknown"
if [[ "$(uname)" == "Darwin" ]]; then
  IS_MAC=true
  log "Detected: macOS"
elif [[ "$(uname)" == "Linux" ]]; then
  IS_LINUX=true
  if command -v pacman >/dev/null 2>&1; then
    OS="arch"
    log "Detected: Arch/CachyOS"
  elif command -v rpm-ostree >/dev/null 2>&1; then
    OS="bazzite"
    log "Detected: Bazzite/Fedora (immutable)"
  else
    log "Detected: Linux (unknown distro)"
  fi
fi

# ─── Dev runtimes ─────────────────────────────────────────────

if ask "Install dev runtimes (uv, node via fnm, pnpm)?"; then

  # uv (Python)
  if command -v uv >/dev/null 2>&1; then
    log "uv already installed"
  else
    log "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    log "uv installed — restart your shell or source ~/.bashrc / ~/.zshrc"
  fi

  # fnm (Node version manager)
  if command -v fnm >/dev/null 2>&1; then
    log "fnm already installed"
  else
    log "Installing fnm..."
    if [[ "$IS_MAC" == true ]]; then
      brew install fnm
    else
      curl -fsSL https://fnm.vercel.app/install | bash
    fi
    log "fnm installed — restart your shell, then: fnm install --lts"
  fi

  # pnpm
  if command -v pnpm >/dev/null 2>&1; then
    log "pnpm already installed"
  else
    log "Installing pnpm..."
    curl -fsSL https://get.pnpm.io/install.sh | sh -
    log "pnpm installed"
  fi
fi

# ─── Linux core packages ─────────────────────────────────────

if [[ "$IS_LINUX" == true && "$OS" == "arch" ]]; then
  if ask "Install core Arch packages (git, curl, wget, jq, tailscale, etc.)?"; then
    sudo pacman -S --needed --noconfirm \
      git curl wget unzip socat jq \
      python python-pip base-devel tailscale
  fi
fi

# ─── Gaming (Linux) ──────────────────────────────────────────

if [[ "$IS_LINUX" == true ]]; then
  if ask "Install gaming configs (MangoHud, environment.d)?"; then
    # environment.d (gaming + gog)
    mkdir -p "$HOME/.config/environment.d"
    for f in "$SCRIPT_DIR/environment.d/"*.conf; do
      fname=$(basename "$f")
      cp -n "$f" "$HOME/.config/environment.d/$fname" 2>/dev/null && log "Installed environment.d/$fname" || log "environment.d/$fname already exists"
    done

    # MangoHud
    mkdir -p "$HOME/.config/MangoHud"
    cp -n "$SCRIPT_DIR/mangohud/MangoHud.conf" "$HOME/.config/MangoHud/MangoHud.conf" 2>/dev/null && log "Installed MangoHud config" || log "MangoHud config already exists"
  fi
fi

# ─── Sofle QMK ────────────────────────────────────────────────

if ask "Install Sofle QMK build dependencies?"; then
  if [[ "$OS" == "arch" ]]; then
    sudo pacman -S --needed --noconfirm qmk avr-gcc avrdude python-hid
    log "QMK dependencies installed"
  else
    log "QMK packages must be installed manually on this OS"
  fi
  log "Keymap source: $SCRIPT_DIR/qmk/sofle/"
  log "Pre-built firmware: $SCRIPT_DIR/qmk/sofle/sofle_rev1_noestelar.hex"
fi

log ""
log "Done!"
