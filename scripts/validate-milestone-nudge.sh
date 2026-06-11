#!/usr/bin/env bash
# Validate that the monthly dive nudge is a friendly digest, not an audit log.
set -euo pipefail

if [[ $# -ne 1 || ! -f "$1" ]]; then
  echo "Usage: $0 path/to/message.txt" >&2
  exit 2
fi

python3 - "$1" <<'PY'
import re
import sys
from pathlib import Path

path = Path(sys.argv[1])
text = path.read_text(encoding="utf-8")
stripped = text.strip()
errors = []

if not stripped:
    errors.append("message is empty")

if stripped.startswith("Diving milestones"):
    errors.append('message must not start with "Diving milestones"')

banned_patterns = [
    r"\bDiving milestones\b",
    r"\bNo milestones due this run\.",
    r"\bChecked\s+\d+\s+logged dives\b",
    r"\bCurrent status is\b.*\bnot yet due\b",
    r"\bBucket-list tracking started on\b",
    r"\bChanged in diver-milestones\.md\b",
    r"\breminder_state\b",
    r"\bevaluation log\b",
    r"\btrigger\b",
    r"\bnot due\b",
    r"\bdiver-milestones\.md\b",
]

for pattern in banned_patterns:
    if re.search(pattern, text, flags=re.IGNORECASE | re.DOTALL):
        errors.append(f"banned audit wording matched: {pattern}")

if re.search(r"\b(?:divinglog|diver-status|bucket-list-readiness|equipment-inventory|trip-preferences)\.md\b", text, flags=re.IGNORECASE):
    errors.append("message must not mention project filenames")

if len(stripped) < 350:
    errors.append("message is shorter than the 350 character minimum")

if len(stripped) > 1800:
    errors.append("message is longer than the 1800 character maximum")

if "\n\n" not in stripped:
    errors.append("message should use blank lines between sections")

if errors:
    print("Milestone nudge validation failed:", file=sys.stderr)
    for error in errors:
        print(f"- {error}", file=sys.stderr)
    sys.exit(1)

print("Milestone nudge validation passed.")
PY
