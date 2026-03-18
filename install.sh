#!/usr/bin/env bash
# Dotfiles install script — links/copies config files into place
# Usage: bash install.sh
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
log() { echo "[dotfiles] $*"; }

ask() {
  read -rp "[dotfiles] $1 [y/N] " answer
  [[ "$answer" =~ ^[Yy] ]]
}

IS_MAC=false
IS_LINUX=false
if [[ "$(uname)" == "Darwin" ]]; then
  IS_MAC=true
  log "Detected: macOS"
elif [[ "$(uname)" == "Linux" ]]; then
  IS_LINUX=true
  log "Detected: Linux"
fi

# --- Neovim (LazyVim) ---
NVIM_DIR="$HOME/.config/nvim"
if [[ -d "$NVIM_DIR" ]]; then
  log "Neovim config already exists at $NVIM_DIR — skipping"
else
  ln -s "$DOTFILES_DIR/nvim" "$NVIM_DIR"
  log "Linked nvim config → $NVIM_DIR"
fi

# --- Ghostty ---
if [[ -f "$DOTFILES_DIR/ghostty/config" ]]; then
  mkdir -p "$HOME/.config/ghostty"
  cp -n "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config" 2>/dev/null && log "Installed ghostty config" || log "ghostty config already exists"
fi

# --- macOS: SSH + Git + 1Password ---
if [[ "$IS_MAC" == true ]]; then
  log "Setting up SSH + git multi-account config..."

  # SSH config
  mkdir -p "$HOME/.ssh/keys"
  chmod 700 "$HOME/.ssh"
  if [[ -f "$HOME/.ssh/config" ]]; then
    log "~/.ssh/config already exists — skipping (review $DOTFILES_DIR/ssh/config manually)"
  else
    cp "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"
    log "Installed ~/.ssh/config"
  fi

  # Export public keys from 1Password (requires op CLI + auth)
  if command -v op >/dev/null 2>&1; then
    log "Exporting SSH public keys from 1Password..."
    op item get "noe-ali" --fields "public key" > "$HOME/.ssh/keys/github-personal.pub" 2>/dev/null && log "  Exported github-personal.pub" || log "  Failed to export noe-ali (auth needed?)"
    op item get "Starlight-github-ssh" --fields "public key" > "$HOME/.ssh/keys/github-work.pub" 2>/dev/null && log "  Exported github-work.pub" || log "  Failed to export Starlight-github-ssh (auth needed?)"
    op item get "Highvern DB SSH" --fields "public key" > "$HOME/.ssh/keys/highvern-db.pub" 2>/dev/null && log "  Exported highvern-db.pub" || log "  Failed to export Highvern DB SSH (auth needed?)"
    chmod 600 "$HOME/.ssh/keys/"*.pub 2>/dev/null
  else
    log "op CLI not found — install with: brew install --cask 1password-cli"
    log "Then re-run this script to export SSH public keys"
  fi

  # Git config files
  cp -n "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig" 2>/dev/null && log "Installed ~/.gitconfig" || log "~/.gitconfig already exists"
  cp -n "$DOTFILES_DIR/git/gitconfig-personal" "$HOME/.gitconfig-personal" 2>/dev/null && log "Installed ~/.gitconfig-personal" || log "~/.gitconfig-personal already exists"
  cp -n "$DOTFILES_DIR/git/gitconfig-work" "$HOME/.gitconfig-work" 2>/dev/null && log "Installed ~/.gitconfig-work" || log "~/.gitconfig-work already exists"

  # 1Password SSH agent config
  mkdir -p "$HOME/.config/1Password/ssh"
  cp -n "$DOTFILES_DIR/1password/agent.toml" "$HOME/.config/1Password/ssh/agent.toml" 2>/dev/null && log "Installed 1Password agent.toml" || log "agent.toml already exists"

  # Workspace directories
  mkdir -p "$HOME/Workspace/personal" "$HOME/Workspace/starlight"
  log "Created ~/Workspace/{personal,starlight}"

  # GitHub known hosts
  if ! grep -q "github.com" "$HOME/.ssh/known_hosts" 2>/dev/null; then
    ssh-keyscan github.com >> "$HOME/.ssh/known_hosts" 2>/dev/null
    log "Added github.com to known_hosts"
  fi
fi

# --- Linux: keyd, KDE, KRFB ---
if [[ "$IS_LINUX" == true ]]; then
  log "Installing Linux configs..."

  # keyd (Mac-style keyboard)
  if [[ -f "$DOTFILES_DIR/keyd/default.conf" ]]; then
    log "keyd config: requires sudo to install"
    log "  sudo cp $DOTFILES_DIR/keyd/default.conf /etc/keyd/default.conf"
    log "  sudo systemctl enable --now keyd"
  fi

  # KWin decoration (Mac-style buttons)
  if command -v kwriteconfig6 >/dev/null 2>&1; then
    kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key ButtonsOnLeft "XIA"
    kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key ButtonsOnRight ""
    log "Applied Mac-style window buttons"
  fi

  # KRFB (VNC)
  mkdir -p "$HOME/.config"
  cp -n "$DOTFILES_DIR/krfb/krfbrc" "$HOME/.config/krfbrc" 2>/dev/null && log "Installed krfbrc" || log "krfbrc already exists"
fi

log ""
log "Core dotfiles installed!"

# --- Extras (dev runtimes, gaming, QMK) ---
if [[ -f "$DOTFILES_DIR/extras/install.sh" ]]; then
  if ask "Install extras (dev runtimes, gaming configs, QMK)?"; then
    bash "$DOTFILES_DIR/extras/install.sh"
  fi
fi

log ""
log "All done!"
if [[ "$IS_MAC" == true ]]; then
  log "Next: op signin && tailscale up"
elif [[ "$IS_LINUX" == true ]]; then
  log "Next: sudo cp $DOTFILES_DIR/keyd/default.conf /etc/keyd/ && sudo systemctl enable --now keyd"
fi
