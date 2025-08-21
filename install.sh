#!/bin/bash

# Dotfiles installation script

DOTFILES_DIR="$HOME/Workspace/dotfiles"

echo "Setting up dotfiles from $DOTFILES_DIR"

# Backup existing nvim config if it exists
if [ -e "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
    echo "Backing up existing nvim config to ~/.config/nvim.backup"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup"
fi

# Remove existing symlink if it exists
if [ -L "$HOME/.config/nvim" ]; then
    rm "$HOME/.config/nvim"
fi

# Create symlink to nvim config
echo "Creating symlink for nvim config"
ln -s "$DOTFILES_DIR/nvim/kickstart.nvim" "$HOME/.config/nvim"

echo "Dotfiles setup complete!"
echo "Your nvim config is now symlinked from: $DOTFILES_DIR/nvim/kickstart.nvim"
