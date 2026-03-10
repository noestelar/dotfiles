#!/usr/bin/env bash
set -euo pipefail

log() { echo "[gog-token-refresh] $*"; }

if ! command -v gog >/dev/null 2>&1; then
  log "gog CLI no está instalado."
  exit 1
fi

GOG_CONFIG_DIR="${GOG_CONFIG_DIR:-$HOME/.config/gogcli}"
CREDENTIALS_FILE="$GOG_CONFIG_DIR/credentials.json"

# Si no hay credenciales, no rompas el cron: solo reporta skip.
if [[ ! -f "$CREDENTIALS_FILE" ]]; then
  log "SKIP: no hay credenciales de gog en $CREDENTIALS_FILE"
  log "Configura con: gog auth credentials <credentials.json>"
  exit 0
fi

# Intenta cargar password del keyring desde entorno/1Password (opcional).
if [[ -z "${GOG_KEYRING_PASSWORD:-}" ]] && command -v op >/dev/null 2>&1; then
  if secret="$(op read 'op://OpenClaw/Gog/GOG_KEYRING_PASSWORD' 2>/dev/null)" && [[ -n "$secret" ]]; then
    export GOG_KEYRING_PASSWORD="$secret"
    log "Keyring password cargado desde 1Password."
  else
    log "No se pudo leer GOG_KEYRING_PASSWORD desde 1Password (continuando)."
  fi
fi

# Descubrir cuentas candidatas: env -> auth list -> aliases
accounts=()
[[ -n "${GOG_ACCOUNT:-}" ]] && accounts+=("$GOG_ACCOUNT")

if list_json="$(gog auth list --json --no-input 2>/dev/null)"; then
  while IFS= read -r a; do [[ -n "$a" ]] && accounts+=("$a"); done < <(
    printf '%s' "$list_json" | jq -r '.accounts[]? | if type=="string" then . else (.email // .account // empty) end'
  )
fi

if alias_json="$(gog auth alias list --json --no-input 2>/dev/null)"; then
  while IFS= read -r a; do [[ -n "$a" ]] && accounts+=("$a"); done < <(
    printf '%s' "$alias_json" | jq -r '.aliases? | to_entries[]?.value'
  )
fi

# unique
mapfile -t uniq_accounts < <(printf '%s\n' "${accounts[@]}" | sed '/^$/d' | awk '!seen[$0]++')

if [[ ${#uniq_accounts[@]} -eq 0 ]]; then
  log "SKIP: no hay cuentas autorizadas en gog para refrescar."
  log "Configura con: gog auth add <email> --services gmail"
  exit 0
fi

ok=0
fail=0
for acc in "${uniq_accounts[@]}"; do
  log "Refrescando token para $acc ..."
  if gog gmail search 'newer_than:1d' --max 1 --account "$acc" --json --no-input >/tmp/gog-refresh-"${acc//[^a-zA-Z0-9_.-]/_}".json 2>/tmp/gog-refresh.err; then
    log "OK: $acc"
    ok=$((ok+1))
  else
    err_msg="$(tr '\n' ' ' </tmp/gog-refresh.err | sed 's/  */ /g')"
    log "ERROR: $acc -> $err_msg"
    fail=$((fail+1))
  fi

done

log "Resumen: ok=$ok fail=$fail"
# Sólo falla si había cuentas y todas fallaron.
if [[ $ok -eq 0 && ${#uniq_accounts[@]} -gt 0 ]]; then
  exit 1
fi
