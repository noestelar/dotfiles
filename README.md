# My Dotfiles

Personal dotfiles repository for backup and quick setup of my development environment.

## Quick Start - Fresh Linux Install

This is the complete guide to setting up my environment from scratch on a new Linux machine.

### Prerequisites

1. **1Password account** - Must have access to the "OpenClaw" vault
2. **GitHub account** - Access to private repos (alia-config, dotfiles)
3. **Internet connection**

### Step 1: Install Base Tools

```bash
# Clone setup-tools
git clone https://github.com/noestelar/setup-tools.git ~/setup-tools
cd ~/setup-tools

# Install all tools (auto-detects Linux)
./install.sh

# Verify installation
node --version    # Should show LTS version
pnpm --version
opencode --version
docker --version
```

### Step 2: Sign in to 1Password

```bash
# Sign in with service account (or regular account)
eval $(op signin)

# Verify you're signed in
op whoami
```

### Step 3: Clone Repos

```bash
# Clone dotfiles (configs)
git clone https://github.com/noestelar/dotfiles.git ~/dotfiles

# Clone workspace (memory, skills, agents)
git clone https://github.com/noestelar/alia-config ~/.openclaw/workspace
```

### Step 4: Install OpenClaw

```bash
# Install OpenClaw globally
pnpm install -g openclaw

# Initialize (accepts defaults since configs are linked below)
openclaw setup
```

### Step 5: Link Configurations

```bash
# Create directories
mkdir -p ~/.openclaw/{cron,settings,env}

# Link dotfiles configs (these contain 1Password references)
ln -sf ~/dotfiles/openclaw/openclaw.json ~/.openclaw/openclaw.json
ln -sf ~/dotfiles/openclaw/cron/jobs.json ~/.openclaw/cron/jobs.json
ln -sf ~/dotfiles/openclaw/settings/voicewake.json ~/.openclaw/settings/voicewake.json

# Inject environment variables from 1Password
op inject -i ~/dotfiles/openclaw/env/clawdbot.env.tmpl -o ~/.openclaw/env/clawdbot.env
```

### Step 6: Setup Systemd Service

```bash
# Link systemd service file
mkdir -p ~/.config/systemd/user
ln -sf ~/dotfiles/systemd/openclaw-gateway.service ~/.config/systemd/user/

# Reload and enable
systemctl --user daemon-reload
systemctl --user enable openclaw-gateway.service
systemctl --user start openclaw-gateway.service
```

### Step 7: Verify Everything Works

```bash
# Check OpenClaw status
openclaw status
openclaw doctor

# Check services
systemctl --user status openclaw-gateway.service
```

---

## What's Included

### OpenClaw Config (`openclaw/`)
| File | Description |
|------|-------------|
| `openclaw.json` | Main gateway config (API keys stored as 1Password references) |
| `cron/jobs.json` | Scheduled tasks |
| `settings/voicewake.json` | Voice wake settings |
| `env/clawdbot.env.tmpl` | Environment variables template |

### Systemd (`systemd/`)
| File | Description |
|------|-------------|
| `openclaw-gateway.service` | User service for auto-start |

### Neovim (`nvim/`)
| File | Description |
|------|-------------|
| `kickstart.nvim/` | Neovim configuration |

---

## 1Password Vault Reference

All secrets are stored in the **"OpenClaw"** vault with these item names:

| Item | Used For |
|------|----------|
| openrouter | OpenRouter API |
| perplexity | Perplexity API |
| perplexity-cli | Perplexity CLI |
| google-ai | Google AI (Gemini) |
| minimax | MiniMax API |
| venice | Venice AI API |
| groq | Groq API |
| zai | ZAI API |
| elevenlabs | ElevenLabs TTS |
| discord | Discord bot |
| telegram | Telegram bot |
| whatsapp | WhatsApp bot |
| notion | Notion API |
| sag | SAG API |
| github-copilot | GitHub Copilot |
| gemini-oauth | Gemini CLI OAuth |
| 1password-service | 1Password service account |

---

## 1Password Service Account Setup

OpenClaw uses a 1Password service account to read secrets without interfering with your personal 1Password CLI session.

### Setup
1. Create a service account in 1Password with access only to the "OpenClaw" vault
2. Save the token in `~/.openclaw/credentials/1password.env`:
   ```
   OP_SERVICE_ACCOUNT_TOKEN=your_token_here
   ```
3. The systemd service sources this file automatically

### IMPORTANT: Token Resolution

The `op://` reference in config may not resolve correctly when using service accounts. If tokens show as invalid:
- **Option 1**: Hardcode tokens directly in `openclaw.json` (current approach)
- **Option 2**: Debug why `op://` references fail with service account

### Current Configuration
- Telegram bot token: In `openclaw.json` (replace with your own)
- Discord bot token: In `openclaw.json` (replace with your own)
- Gateway token: In systemd service
- Tailscale URL: `https://bazzite.tailce9ba7.ts.net`

### IMPORTANT: Token Setup
Tokens are stored directly in `openclaw.json` for simplicity. **Do not commit your actual tokens to version control.**

For local setup:
1. Copy the template config: `cp ~/dotfiles/openclaw/openclaw.json ~/.openclaw/openclaw.json`
2. Replace tokens with your own (get from @BotFather for Telegram, Discord Developer Portal for Discord)
3. Restart: `systemctl --user restart openclaw-gateway`

---

## Troubleshooting

### OpenClaw won't start
```bash
# Check logs
journalctl --user -u openclaw-gateway.service -f

# Check config errors
openclaw doctor
```

### 1Password injection fails
```bash
# Verify signed in
op whoami

# Check vault access
op vault list
```

### Docker not working
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Log out and back in, or run:
newgrp docker

# Start docker
sudo systemctl start docker
sudo systemctl enable docker
```

---

## Manual Backup (Before Reinstalling)

If you need to backup before formatting:

```bash
# Push workspace changes
cd ~/.openclaw/workspace
git add .
git commit -m "Backup $(date)"
git push

# Export dotfiles changes
cd ~/dotfiles
git add .
git commit -m "Update config"
git push
```

---

## Structure

```
dotfiles/
├── nvim/
│   └── kickstart.nvim/
├── openclaw/
│   ├── openclaw.json
│   ├── cron/
│   │   └── jobs.json
│   ├── settings/
│   │   └── voicewake.json
│   └── env/
│       └── clawdbot.env.tmpl
├── systemd/
│   └── openclaw-gateway.service
└── README.md
```
