# Diving project – agent context

This project is a **personal diving log**. The user adds dive data (from PADI app, screenshots, voice notes, or typed info). All input about dives must be categorized and stored in a fixed structure.

## When the user shares dive information

- **Always use the dive-categorization skill** when the user provides:
  - Dive data (depth, site, date, conditions, wildlife, etc.)
  - PADI log info, screenshots, or voice-note transcriptions
  - New dives to log or updates to existing dives

The skill defines where every piece of information goes: summary table vs detailed files, folder names, and file names.

- **Use the dive-qa skill** when the user wants to do Q&A on a specific dive (e.g. "Q&A on dive 3", "let's reflect on Mawan"). Conduct the Q&A in chat, then write a short **Q&A summary** into that dive's file (not the full transcript).

- **Use the dive-photo-ingest skill** when the user wants to ingest dive photos (e.g. from DJI Osmo Action), store them in per-dive folders, and tag them to dives by timestamp. Run the ingestion script, then update the **Media** section in affected dive files.

## Project layout (summary)

- **`divinglog.md`** – One row per dive; quantitative data and brief notes only.
- **`dives/`** – One folder per trip (`[country]-[location]`), one file per dive (`dive-[#]-[site-name].md`). Reflections and Q&A summary (written after a Q&A conversation) go here. For **dive-focused / dive-only trips** only, the trip folder may include **`costs.md`** (flights, stay, diving, etc.); skip this for general holidays where diving is incidental (e.g. one dive day on a beach trip).

For exact naming, workflow, and what goes where, follow the **dive-categorization** skill.

**Trip `costs.md` files:** Store all monetary amounts in **GBP**. If the user (or invoices) give prices in other currencies, **convert to GBP** using a clear, dated mid-market (or stated) rate and keep the original currency in a note or small table where helpful—do not leave trip totals only in foreign currency.

## Git versioning (local only)

- **Commit after completing work.** Whenever you finish a task or a logical set of edits (e.g. adding a dive, updating the log, refactoring a file), commit the changes to Git. We use Git only for local versioning and revert capability—nothing is pushed to GitHub.
- **Commit message:** Short, clear description of what changed (e.g. "Add dive 3 Siaba Besar to Indonesia–Komodo", "Update divinglog summary table", "Fix dive-categorization skill").
- **What to commit:** Stage and commit all modified or new project files that belong to the change. Do not commit unless you have actually changed files.
- **When:** Commit once per completed task or coherent batch of edits, not after every single tiny edit.

## Versioning this file (AGENTS.md)

- **After any edit to this file**, run from the project root: `bash scripts/commit-agents-md.sh`
- This creates a Git snapshot so changes can be reverted. Do it automatically; the user does nothing.
- To revert AGENTS.md to a previous version, use `git checkout` or `git restore` with the desired commit.

## Trip planning constraints (background context)

When suggesting or ranking future dive trips, the agent should consult:
- `trip-preferences.md` for always-on constraints (flight-time proximity from London, bottom-water temperature thresholds, direct-flight preference, trip cadence).
- `trip-pricing-budget.md` for budget/price ballparks (flights + accommodation ranges; diving costs are estimated from real/observed dive-package prices when available).
- **`dives/[trip]/costs.md`** for **historical actual spend** on **dive-focused trips** (hotels, flights, diving, etc.). Do not expect or infer costs from trips that never had a `costs.md` (e.g. mixed holidays). When the user asks about trip costs or spending patterns, read the relevant `costs.md` files and use them together with `trip-pricing-budget.md`. For a **new dive-only trip**, create or remind the user to add `costs.md` once bookings exist.

In particular:
- Treat `bottom water temperature < 20C` as a hard exclude.
- Treat `bottom water temperature < 22C` as generally a skip (e.g., Malta in February), unless there is a clear, strong reason to still recommend that destination.

## Current diver state (always check before planning)

Before recommending specific dive sites or structuring a trip, the agent must:
1. Recompute your **current dive count** from `divinglog.md` (counting the numbered table rows), so minimum-dive requirements are correct.
2. Read your **highest known certification(s)** from `diver-status.md`.
   - Right now: **AOW** is your current highest qualification.
   - **Nitrox** is expected by **July**; once you confirm it’s obtained, update `diver-status.md`.

If a destination’s sites have explicit minimum requirements (e.g., “25 dives” or “AOW required”), the agent should either:
- ensure you meet them based on steps (1) and (2), or
- ask you for confirmation/updates (if data is missing or Nitrox is uncertain).

Nitrox automation detail:
- The agent may infer Nitrox completion and update `diver-status.md` if the relevant Nitrox course dives in `divinglog.md` have the `Gas` column set to values like `Nitrox`, `EAN`, or `EANx`.
- If Nitrox is mentioned only in free-form notes and not reflected in `divinglog.md`'s `Gas` field, the agent should ask you to confirm.

## Current equipment inventory (always check before budgeting)

Before estimating trip costs (especially equipment-rental-heavy budgets) or recommending gear-dependent experiences, the agent should consult `equipment-inventory.md`.

In particular:
- Treat you as owning **mask + snorkel only** unless `equipment-inventory.md` says otherwise.
- Assume you **rent** BCD/regulator/fins/wetsuit/weights/dive computer by default.
- If you’re considering a dive computer purchase, prefer recommendations that match your likely Nitrox needs (Nitrox/EAN compatibility) and ask you for your budget range before “hard” assumptions.
