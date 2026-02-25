# My Dotfiles

Personal dotfiles repository containing my development environment configurations.

## Contents

- **nvim/kickstart.nvim**: Neovim configuration based on kickstart.nvim
- **openclaw/**: OpenClaw configuration (see below)
- **systemd/**: User systemd service files

## OpenClaw Setup

This section contains OpenClaw configuration files that need to be backed up separately from the workspace.

### What's Included

- `openclaw/openclaw.json` - Main OpenClaw gateway configuration
- `openclaw/cron/jobs.json` - Scheduled jobs
- `openclaw/settings/voicewake.json` - Voice wake settings
- `openclaw/env/clawdbot.env.tmpl` - Environment variables template (1Password references)
- `systemd/openclaw-gateway.service` - Systemd service file

### What's NOT Included (use 1Password)

- `~/.openclaw/credentials/` - OAuth tokens and API keys (in vault)
- `~/.openclaw/agents/*/agent/models.json` - Model configs with API keys

### Installation

```bash
# Clone the repository
git clone https://github.com/noestelar/dotfiles.git ~/dotfiles

# Create directories
mkdir -p ~/.openclaw/cron ~/.openclaw/settings ~/.openclaw/env

# Create symlinks for OpenClaw configs
ln -sf ~/dotfiles/openclaw/openclaw.json ~/.openclaw/openclaw.json
ln -sf ~/dotfiles/openclaw/cron/jobs.json ~/.openclaw/cron/jobs.json
ln -sf ~/dotfiles/openclaw/settings/voicewake.json ~/.openclaw/settings/voicewake.json

# Inject env variables from 1Password
op inject -i ~/dotfiles/openclaw/env/clawdbot.env.tmpl -o ~/.openclaw/env/clawdbot.env

# Link systemd service
ln -sf ~/dotfiles/systemd/openclaw-gateway.service ~/.config/systemd/user/

# Reload systemd
systemctl --user daemon-reload
systemctl --user enable openclaw-gateway.service
```

## Neovim Setup

```bash
# Clone the repository
git clone https://github.com/noestelar/dotfiles.git ~/Workspace/dotfiles

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
├── openclaw/              # OpenClaw config
│   ├── openclaw.json
│   ├── cron/
│   │   └── jobs.json
│   └── settings/
│       └── voicewake.json
├── systemd/               # Systemd services
│   └── openclaw-gateway.service
└── install.sh            # Installation script
```
