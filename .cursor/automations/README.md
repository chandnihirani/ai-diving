# Cursor Automations — diving project

## Diving milestone check

**Schedule:** 1st of every month at **09:00** (cron `0 9 1 * *` — adjust timezone in the Automations editor to match UK local time if needed).

**What it does:** Runs the same logic as `.cursor/rules/diver-milestone-reminders.mdc` — Rescue at **40** dives, bucket-list stale **9 months** without ✅, Nitrox overdue, 6-month rust, 25-dive gate, computer rental at 40+, etc.

**Files updated when something fires:** `diver-milestones.md` (`reminder_state` + evaluation log). No automatic git commit.

### Setup in Cursor

1. Open **Agents** → **Automations** → **New automation** (or ask the agent in the **Agents Window** to open the editor with the draft).
2. Import or paste from **`diving-milestone-check.workflow.json`** in this folder, or copy fields manually:
   - **Name:** Diving milestone check
   - **Trigger:** Schedule → monthly, 1st, 9:00 (set your timezone in the UI)
   - **Tools:** none required (workspace file read/write only)
   - **Instructions:** use `diving-milestone-check.prompt.md` or the `prompts` block in the JSON
3. Point the automation at **this workspace** (`diving_project`). Cloud runs need the folder available to the agent (local workspace automation or a synced copy of the repo).
4. Enable **memory** if you want the automation to remember prior run context (optional).
5. Save and enable.

### Prefill handoff

If your agent session supports opening the Automations editor with a draft, say: *“Open the diving milestone automation from `.cursor/automations/diving-milestone-check.workflow.json`.”*

### Thresholds (source of truth)

| Milestone | Threshold |
|-----------|-----------|
| Rescue Diver nudge | ≥ 40 logged dives, Rescue not obtained |
| Bucket list stale | ≥ 9 months since last ✅ (or since tracking start if never ✅) |

Edit thresholds in **`diver-milestones.md`**, not only in the automation JSON.

### Dismiss / snooze

Tell any agent session: *“Dismiss rescue reminder”* or *“Snooze bucket list stale 6 months”* — it updates `reminder_state` in `diver-milestones.md`.
