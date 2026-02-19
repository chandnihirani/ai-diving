#!/usr/bin/env bash
# Snapshots AGENTS.md to Git so the agent can revert if needed.
# Run from repo root. Safe to run often; only commits when file changed.

set -e
cd "$(git rev-parse --show-toplevel)"

git add AGENTS.md
if git diff --cached --quiet; then
  exit 0
fi
git commit -m "chore: snapshot AGENTS.md for versioning"
