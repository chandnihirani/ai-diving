#!/usr/bin/env bash
# One-time local setup: create ~/.config/diving-telegram.env and open in TextEdit.
set -euo pipefail

ENV_FILE="${HOME}/.config/diving-telegram.env"

mkdir -p "${HOME}/.config"

if [[ -f "$ENV_FILE" ]] && [[ -s "$ENV_FILE" ]]; then
  echo "Already exists: $ENV_FILE"
  echo "Opening in TextEdit — edit token/chat ID if needed."
else
  cat > "$ENV_FILE" <<'EOF'
TELEGRAM_BOT_TOKEN=paste_your_bot_token_here
TELEGRAM_CHAT_ID=paste_your_chat_id_here
EOF
  echo "Created $ENV_FILE with placeholders."
  echo "Replace both values in TextEdit, save (Cmd+S), then test:"
  echo "  bash scripts/send-telegram.sh --file .cursor/automations/last-milestone-nudge.txt"
fi

chmod 600 "$ENV_FILE"
open -e "$ENV_FILE"
