#!/usr/bin/env bash
set -euo pipefail

log() { echo "[amazon-cart-refresh] $*"; }

CART_SCRIPT="/home/noestelar/.openclaw/workspace/skills/promo-track/scripts/amazon-cart.js"
COOKIES_PATH="$HOME/.openclaw/browser/amazon-mx-cookies.json"
CART_PATH="$HOME/.openclaw/browser/amazon-cart.json"

if [[ ! -f "$CART_SCRIPT" ]]; then
  log "ERROR: cart script not found at $CART_SCRIPT"
  exit 1
fi

if [[ ! -f "$COOKIES_PATH" ]]; then
  log "SKIP: no hay cookies de Amazon en $COOKIES_PATH"
  log "Ejecuta: google-chrome --remote-debugging-port=9222 & luego amazon-save-cookies.js"
  exit 0
fi

log "Refrescando carrito de Amazon MX..."
cd /home/noestelar/.openclaw/workspace

if node "$CART_SCRIPT" 2>/tmp/amazon-cart-refresh.err; then
  item_count=$(python3 -c "
import json, sys
try:
    with open('$CART_PATH') as f:
        d = json.load(f)
    items = d.get('activeItems', d.get('items', []))
    print(len(items))
except:
    print('?')
" 2>/dev/null || echo "?")
  log "OK: $item_count ítems en carrito activo. Guardado en $CART_PATH"
else
  err_msg="$(tr '\n' ' ' </tmp/amazon-cart-refresh.err | sed 's/  */ /g' | head -c 200)"
  log "ERROR: $err_msg"
  exit 1
fi
