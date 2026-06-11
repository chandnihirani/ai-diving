# Diving milestone check (automation prompt)

You are maintaining the **personal diving project** in this workspace.

## Steps

1. Read `diver-milestones.md` (registry, `tracking`, `reminder_state`, evaluation log).
2. Read `.cursor/rules/diver-milestone-reminders.mdc` for evaluation rules.
3. Recompute **dive count** from numbered rows in `divinglog.md`; **last dive date** from the newest row.
4. Read `diver-status.md`, `bucket-list-readiness.md`, and `equipment-inventory.md` when triggers need them.
5. For each **enabled** milestone, test triggers. Respect `reminder_state` (`dismissed`, `snoozed_until`).
6. For each milestone that **fires** and is not dismissed/snoozed:
   - Update `reminder_state` with `last_fired` (today) and `last_dive_count_at_fire` if relevant.
   - Append one row to the **Evaluation log** table in `diver-milestones.md`.
7. **Do not git-commit** unless the automation run explicitly includes a user instruction to commit.

## Reply format

Start with: **Diving milestones**

- If nothing is due: one line — `No milestones due this run.`
- Otherwise: one short section per fired milestone (3–6 sentences each), using the `message` text from `diver-milestones.md` and any `actions` listed there.
- For `bucket_list_stale_9m`, include 2–3 **Near-term** bucket-list options with one-line rationale after reading `trip-preferences.md` and `trip-pricing-budget.md`.
- End with what you updated in `diver-milestones.md` (if anything).

## Do not

- Invent certifications or bucket-list ✅ status.
- Mark Rescue or Nitrox obtained without evidence in `divinglog.md` / user confirmation.
- Nag about milestones that are dismissed or still inside `snoozed_until`.
