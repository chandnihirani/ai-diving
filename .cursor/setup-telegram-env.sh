#!/usr/bin/env bash
# Cloud environment install hook: write Telegram creds to a workspace file
# because Runtime Secrets may not be visible in the agent's shell subprocess.
set -euo pipefail

OUT=".cursor/telegram.env"

if [[ -z "${TELEGRAM_BOT_TOKEN:-}" || -z "${TELEGRAM_CHAT_ID:-}" ]]; then
  echo "TELEGRAM_BOT_TOKEN / TELEGRAM_CHAT_ID not set — add them to this Cloud Environment's secrets." >&2
  exit 0
fi

mkdir -p .cursor
umask 077
printf 'TELEGRAM_BOT_TOKEN=%s\nTELEGRAM_CHAT_ID=%s\n' \
  "$TELEGRAM_BOT_TOKEN" "$TELEGRAM_CHAT_ID" > "$OUT"
echo "Wrote $OUT for send-telegram.sh"
