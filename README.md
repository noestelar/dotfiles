# My Dotfiles

Personal dotfiles repository containing my development environment configurations.

## Contents

- **nvim/kickstart.nvim**: Neovim configuration based on kickstart.nvim

## Installation

```bash
# Clone the repository
git clone <your-repo-url> ~/Workspace/dotfiles

# Run the install script
./install.sh
```

## Manual Setup

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# Create symlink
ln -s ~/Workspace/dotfiles/nvim/kickstart.nvim ~/.config/nvim
```

## Structure

```
dotfiles/
├── nvim/
│   └── kickstart.nvim/    # Neovim configuration
├── install.sh             # Installation script
└── README.md             # This file
```
