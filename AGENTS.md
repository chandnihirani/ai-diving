# Diving project – agent context

This project is a **personal diving log**. The user adds dive data (from PADI app, screenshots, voice notes, or typed info). All input about dives must be categorized and stored in a fixed structure.

## When the user shares dive information

- **Always use the dive-categorization skill** when the user provides:
  - Dive data (depth, site, date, conditions, wildlife, etc.)
  - PADI log info, screenshots, or voice-note transcriptions
  - New dives to log or updates to existing dives

The skill defines where every piece of information goes: summary table vs detailed files, folder names, and file names.

After logging a dive or finishing dive Q&A, if the new information materially affects readiness evidence (e.g. dive count, Nitrox, SMB deployment, drift/current comfort, buoyancy/trim, reef hook, negative entry, blue-water comfort, boat/liveaboard comfort), refresh `bucket-list-readiness.md`.

After logging dives or updating certifications, evaluate **proactive milestone reminders** per `diver-milestones.md` and `.cursor/rules/diver-milestone-reminders.mdc` (e.g. Rescue at 40 dives, bucket-list stale 9 months without a ✅). A **monthly Cursor Automation** also runs the same checks — see `.cursor/automations/README.md`.

If the newly logged or updated dives are from a destination already on the bucket list (e.g. Maldives, Raja Ampat, Komodo, Fiji), the refresh must update both:
- the top summary table row for that destination, including `Done` status (`✅` for meaningful completion, `🟠` for partial-only exposure)
- the detailed section for that destination under `## Bucket list destinations`

- **Use the dive-qa skill** when the user wants to do Q&A on a specific dive (e.g. "Q&A on dive 3", "let's reflect on Mawan"). Conduct the Q&A in chat, then write a short **Q&A summary** into that dive's file (not the full transcript).

- **Use the bucket-list-readiness skill** when the user asks how close they are to bucket-list destinations, asks if they are ready for a specific bucket-list trip, or when new dive/Q&A content materially changes readiness evidence.

- **Use the dive-photo-ingest skill** when the user wants to ingest dive photos (e.g. from DJI Osmo Action), store them in per-dive folders, and tag them to dives by timestamp. Run the ingestion script, then update the **Media** section in affected dive files.

## Project layout (summary)

- **`divinglog.md`** – One row per dive; quantitative data and brief notes only.
- **`dives/`** – One folder per trip (`[country]-[location]`), one file per dive (`dive-[#]-[site-name].md`). Reflections and Q&A summary (written after a Q&A conversation) go here. For **dive-focused / dive-only trips** only, the trip folder may include:
  - **`costs.md`** — flights, stay, diving, etc. (amounts in **GBP**)
  - **`booking-comms.md`** — **mandatory** for every planned/booked dive-focused trip: full pasted email/WhatsApp thread + **Confirmed booking summary**. User will provide all booking comms; agent must persist them in the same session — never rely on chat memory. Read this before quoting what's included, priced, or booked. Template: `dives/_template/booking-comms.md`.

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

When the user **asks for judgment** on a plan (e.g. “thoughts”, “what do you think”, “other ideas”), follow **`.cursor/rules/dive-trip-advisor-counsel.mdc`** for a full **Advisor take** with trade-offs and alternatives. If they only state a plan without asking, record it efficiently; reserve full counsel for those invitations (brief conflict note only when a statement contradicts a booked trip or hard constraint).

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

## Cursor Cloud specific instructions

This is a **content/data repository**, not a conventional software app. The "product" is the markdown dive log plus a few helper scripts. There is **no build step, no lint config, and no automated test suite** — do not look for `npm run build`, a test runner, or a linter; none exist.

The only executable code:
- **`scripts/ingest-dive-photos.py`** — the one real application. Python 3 (system `python3`, currently 3.12). Run from the repo root; see the `dive-photo-ingest` skill for usage. Its only third-party dependency is **`exifread`** (installed by the update script). Without `exifread` the script still runs but falls back to file mtime and prints a warning instead of reading EXIF capture times.
- **`scripts/commit-agents-md.sh`** — git snapshot of `AGENTS.md`; run after editing `AGENTS.md` (per `.cursor/rules/version-agents-md.mdc`). Local git only; nothing is pushed by this script.
- **`scripts/send-telegram.sh`** — needs `TELEGRAM_BOT_TOKEN` and `TELEGRAM_CHAT_ID` (from `~/.config/diving-telegram.env` or Secrets) **and** outbound network to `api.telegram.org`; it will exit non-zero without them.

Non-obvious gotchas:
- `config/dive-photo-source.txt` holds a **macOS Google Drive path that does not exist in the cloud VM**. When running/testing the ingest script here, pass an explicit source folder argument instead of relying on the default path.
- The ingest script matches photos to dives by **date** (from `divinglog.md`) and a **time-gap rule** for multiple same-day dives. To test, create sample image files whose mtime/EXIF dates match dive dates in `divinglog.md` (e.g. three windows on `27 Mar 2024` map to dives 1–3). Use `--dry-run` to preview assignments; note that a real run already copies files, so a later `--dry-run` will skip them as existing duplicates.
