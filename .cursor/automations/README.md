# Cursor Automations — diving project

## Diving milestone check

**Schedule:** 1st of every month at **09:00** (cron `0 9 1 * *` — adjust timezone in the Automations editor to match UK local time if needed).

**What it does:** Runs the same logic as `.cursor/rules/diver-milestone-reminders.mdc` — Rescue at **40** dives, bucket-list stale **9 months** without ✅, Nitrox overdue, 6-month rust, 25-dive gate, computer rental at 40+, etc.

**Files updated when something fires:** `diver-milestones.md` (`reminder_state` + evaluation log). No automatic git commit.

**Telegram:** Fun **dive-buddy digest** (not an audit). Validated by `scripts/validate-milestone-nudge.sh` before `send-telegram.sh` — rejects dry “No milestones due / reminder_state” messages. **Turn memory OFF** on this automation. If messages still look like a textbook, re-paste instructions from `diving-milestone-check.prompt.md` in the Automations editor. Format + gold-standard example in that file.

### Telegram setup (one-time)

1. Create a bot with **@BotFather**; revoke the token if you ever pasted it in chat.
2. Get your **chat ID** (e.g. **@getmyid_bot** in the Telegram app).
3. Create `~/.config/diving-telegram.env` (not in this repo):

   ```bash
   TELEGRAM_BOT_TOKEN=your_token_here
   TELEGRAM_CHAT_ID=your_id_here
   ```

4. **Also add secrets for cloud runs** (automations run on Cursor’s cloud VM, not your Mac):
   - Open [cursor.com/dashboard](https://cursor.com/dashboard) → **Cloud Agents** → **Secrets**
   - Add `TELEGRAM_BOT_TOKEN` and `TELEGRAM_CHAT_ID` (Runtime Secret)
5. **Test** with **Run now** on the automation (cloud can reach Telegram even when your home network blocks `api.telegram.org`).

### Setup in Cursor

1. Open the **Agents** sidebar (left) → **Automations** tab  
   Or go to [cursor.com/automations](https://cursor.com/automations)
2. Open **Diving milestone check** (or create from **`diving-milestone-check.workflow.json`**):
   - **Trigger:** Schedule → monthly, 1st, 9:00 (UK timezone)
   - **Repository:** attach this `diving_project` repo (required to read `divinglog.md` and run the send script)
   - **Instructions:** use `diving-milestone-check.prompt.md` or the `prompts` block in the JSON
   - **Tools:** optional extras only (Slack, MCP, etc.) — terminal is included by default on cloud agents; there is no separate “Shell” toggle
3. **Memory: OFF** for this automation (Settings / Agent options → turn **Memory** off). Memory tends to lock in the old dry audit format.
4. **Save** and **Enable** / **Activate**.

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
