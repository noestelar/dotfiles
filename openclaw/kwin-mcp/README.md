# kwin-mcp (Bazzite/KDE) notes

`kwin-mcp` is kept as an **experimental desktop-control stack** for KDE Wayland.

## Install

```bash
# 1) Install runtime
uv tool install kwin-mcp --python /usr/bin/python3

# 2) Link helper wrappers
ln -sf ~/Workspace/dotfiles/openclaw/bin/kwin-mcp-run ~/.local/bin/kwin-mcp-run
ln -sf ~/Workspace/dotfiles/openclaw/bin/kwin-mcp-cleanup ~/.local/bin/kwin-mcp-cleanup
```

## Usage

```bash
echo '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}' | kwin-mcp-run

# If sessions get stuck
kwin-mcp-cleanup
```

## Known caveats on Bazzite

- `session_start` may fail with SIGSEGV depending on KWin/Python/libei versions.
- Accessibility bus can fail inside isolated sessions (`AT-SPI` errors).
- `uv tool upgrade kwin-mcp` may overwrite local runtime patches.

## Fallback (stable)

When kwin-mcp is unstable, use:

- screenshots (`spectacle`)
- input simulation (`ydotool`/`xdotool`)
- vision analysis through the agent
