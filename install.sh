#!/usr/bin/env bash
# Dotfiles install script
# Usage: bash install.sh
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
log() { echo "[dotfiles] $*"; }

ask() {
  read -rp "[dotfiles] $1 [y/N] " answer
  [[ "$answer" =~ ^[Yy] ]]
}

# Detect OS
IS_MAC=false
IS_LINUX=false
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
    OS="unknown"
    log "Detected: Linux (unknown distro)"
  fi
fi

# --- Neovim (LazyVim) ---
if [[ -d "$DOTFILES_DIR/nvim" ]]; then
  NVIM_DIR="$HOME/.config/nvim"
  if [[ -d "$NVIM_DIR" ]]; then
    log "Neovim config already exists at $NVIM_DIR — skipping"
  else
    ln -s "$DOTFILES_DIR/nvim" "$NVIM_DIR"
    log "Linked nvim config → $NVIM_DIR"
  fi
fi

# --- Ghostty ---
if [[ -f "$DOTFILES_DIR/ghostty/config" ]]; then
  GHOSTTY_DIR="$HOME/.config/ghostty"
  mkdir -p "$GHOSTTY_DIR"
  cp -n "$DOTFILES_DIR/ghostty/config" "$GHOSTTY_DIR/config" 2>/dev/null && log "Installed ghostty config" || log "ghostty config already exists"
fi

# --- Linux-only configs ---
if [[ "$IS_LINUX" == true ]]; then
  log "Installing Linux configs..."

  # Core packages (Arch)
  if [[ "${OS:-}" == "arch" ]]; then
    log "Installing packages via pacman..."
    sudo pacman -S --needed --noconfirm \
      git curl wget unzip socat jq \
      nodejs npm python python-pip \
      base-devel tailscale
  fi

  # keyd (Mac-style keyboard)
  if [[ -f "$DOTFILES_DIR/keyd/default.conf" ]]; then
    log "keyd config: requires sudo to install"
    log "  sudo cp $DOTFILES_DIR/keyd/default.conf /etc/keyd/default.conf"
    log "  sudo systemctl enable --now keyd"
  fi

  # environment.d (gaming + gog)
  mkdir -p "$HOME/.config/environment.d"
  for f in "$DOTFILES_DIR/environment.d/"*.conf; do
    fname=$(basename "$f")
    cp -n "$f" "$HOME/.config/environment.d/$fname" 2>/dev/null && log "Installed environment.d/$fname" || log "environment.d/$fname already exists"
  done

  # KWin decoration (Mac-style buttons)
  if command -v kwriteconfig6 >/dev/null 2>&1; then
    kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key ButtonsOnLeft "XIA"
    kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key ButtonsOnRight ""
    log "Applied Mac-style window buttons"
  fi

  # KRFB (VNC)
  mkdir -p "$HOME/.config"
  cp -n "$DOTFILES_DIR/krfb/krfbrc" "$HOME/.config/krfbrc" 2>/dev/null && log "Installed krfbrc" || log "krfbrc already exists"

  # --- Optional: MangoHud ---
  if ask "Install MangoHud config?"; then
    mkdir -p "$HOME/.config/MangoHud"
    cp -n "$DOTFILES_DIR/mangohud/MangoHud.conf" "$HOME/.config/MangoHud/MangoHud.conf" 2>/dev/null && log "Installed MangoHud config" || log "MangoHud config already exists"
  fi

  # --- Optional: Sofle QMK ---
  if ask "Install Sofle QMK build dependencies?"; then
    if [[ "${OS:-}" == "arch" ]]; then
      sudo pacman -S --needed --noconfirm qmk avr-gcc avrdude python-hid
      log "QMK dependencies installed. Keymap is at: $DOTFILES_DIR/qmk/sofle/"
    else
      log "QMK packages must be installed manually on this distro"
      log "Keymap is at: $DOTFILES_DIR/qmk/sofle/"
    fi
  fi

else
  log "macOS detected — skipping Linux-only configs (keyd, KDE, gaming, etc.)"
fi

log ""
log "Done! Next steps:"
log "  1. sudo cp dotfiles/keyd/default.conf /etc/keyd/ && sudo systemctl enable --now keyd"
log "  2. op signin  (1Password CLI)"
log "  3. tailscale up"
