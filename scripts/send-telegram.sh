#!/usr/bin/env bash
# Send a text message via Telegram Bot API.
# Secrets: ~/.config/diving-telegram.env (TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID)
set -euo pipefail

ENV_FILE="${TELEGRAM_ENV_FILE:-$HOME/.config/diving-telegram.env}"
WORKSPACE_ENV=".cursor/telegram.env"
for f in "$WORKSPACE_ENV" "$ENV_FILE"; do
  if [[ -f "$f" ]]; then
    # shellcheck source=/dev/null
    source "$f"
  fi
done

if [[ -z "${TELEGRAM_BOT_TOKEN:-}" || -z "${TELEGRAM_CHAT_ID:-}" ]]; then
  echo "Set TELEGRAM_BOT_TOKEN and TELEGRAM_CHAT_ID in Cloud Environment secrets, $WORKSPACE_ENV, or $ENV_FILE." >&2
  exit 1
fi

if [[ "${1:-}" == "--file" ]]; then
  [[ -n "${2:-}" && -f "$2" ]] || { echo "Usage: $0 --file path/to/message.txt" >&2; exit 1; }
  MESSAGE="$(cat "$2")"
elif [[ -n "${1:-}" && -f "$1" ]]; then
  MESSAGE="$(cat "$1")"
elif [[ -n "${1:-}" ]]; then
  MESSAGE="$1"
else
  MESSAGE="$(cat)"
fi

if [[ -z "$MESSAGE" ]]; then
  echo "No message to send." >&2
  exit 1
fi

# Telegram hard limit is 4096 characters per message.
if [[ ${#MESSAGE} -gt 4096 ]]; then
  MESSAGE="${MESSAGE:0:4093}..."
fi

RESPONSE="$(curl -sS -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
  --data-urlencode "chat_id=${TELEGRAM_CHAT_ID}" \
  --data-urlencode "text=${MESSAGE}" \
  -d "parse_mode=Markdown" 2>&1)" || {
  echo "curl failed (network may block api.telegram.org on this machine): $RESPONSE" >&2
  exit 1
}

if ! echo "$RESPONSE" | grep -q '"ok":true'; then
  # Retry without Markdown if parsing failed
  RESPONSE="$(curl -sS -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
    --data-urlencode "chat_id=${TELEGRAM_CHAT_ID}" \
    --data-urlencode "text=${MESSAGE}" 2>&1)"
  if ! echo "$RESPONSE" | grep -q '"ok":true'; then
    echo "Telegram API error: $RESPONSE" >&2
    exit 1
  fi
fi

echo "Sent to Telegram."
