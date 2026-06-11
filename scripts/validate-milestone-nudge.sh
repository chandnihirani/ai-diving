#!/usr/bin/env bash
# Reject dry/audit-style milestone Telegram drafts before send.
set -euo pipefail

FILE="${1:-.cursor/automations/last-milestone-nudge.txt}"

if [[ ! -f "$FILE" ]]; then
  echo "Missing $FILE" >&2
  exit 1
fi

MSG="$(cat "$FILE")"
FAIL=0

banned() {
  if echo "$MSG" | grep -qiE "$1"; then
    echo "BANNED pattern matched: $1" >&2
    FAIL=1
  fi
}

# Old audit-bot phrasing
banned '^Diving milestones'
banned 'No milestones due this run'
banned 'nothing changed'
banned 'reminder_state'
banned 'evaluation log'
banned 'not (yet )?due'
banned 'Checked [0-9]+ logged dives'
banned 'trigger'
banned 'diver-milestones\.md'

# Required digest sections (emoji headers)
require_section() {
  if ! echo "$MSG" | grep -qF "$1"; then
    echo "Missing required section: $1" >&2
    FAIL=1
  fi
}

require_section '📊'
require_section '🎯'
require_section '📅'
require_section '✨'

# Visual breathing room
BLANK_LINES="$(echo "$MSG" | grep -c '^[[:space:]]*$' || true)"
if [[ "$BLANK_LINES" -lt 4 ]]; then
  echo "Too dense: need at least 4 blank lines between sections (found $BLANK_LINES)." >&2
  FAIL=1
fi

# Minimum substance
if [[ ${#MSG} -lt 280 ]]; then
  echo "Message too short (${#MSG} chars) — likely a stub." >&2
  FAIL=1
fi

if [[ "$FAIL" -ne 0 ]]; then
  echo "Draft failed validation. Rewrite per .cursor/automations/diving-milestone-check.prompt.md" >&2
  exit 1
fi

echo "Milestone nudge draft OK."
