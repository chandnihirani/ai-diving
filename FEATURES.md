# Diving project – feature list

This document is a living checklist of what this repo can do today, plus a pipeline of “next agentic features” we can build.

Legend:
- **✅ Built** = exists in the repo and is part of the current workflow
- **🧪 Partial** = exists, but not fully end-to-end or not routinely used yet
- **🧭 Planned** = proposed next feature; not implemented yet

---

## ✅ Built: Core product (the diving log)

- **Dive summary table (`divinglog.md`)**
  - One row per dive with key quantitative fields and brief notes
  - Link from each row to a per-dive detail file

- **Per-dive detail pages (`dives/[trip]/dive-[#]-[site].md`)**
  - Long-form reflections and structured sections per dive
  - Dedicated `## Q&A summary` section per dive (written after a Q&A conversation)

- **Trip folder structure (`dives/[country]-[location]/`)**
  - Consistent naming convention and discoverability
  - Captured in `FOLDER_STRUCTURE.md`

- **Diver state + constraints**
  - **Certifications / status**: `diver-status.md`
  - **Equipment owned vs rented**: `equipment-inventory.md`
  - **Trip constraints** (flight time, bottom temp thresholds, direct-flight preference): `trip-preferences.md`
  - **Budget bands + historical actuals**: `trip-pricing-budget.md`

---

## ✅ Built: Agentic workflows (skills + rules)

These are the “agent behaviors” that keep the system consistent and reduce manual work.

- **Dive categorization (skill: `dive-categorization`)**
  - Routes new dive input (PADI data / screenshots / voice notes / typed notes) into:
    - `divinglog.md` (summary row)
    - the correct per-dive file under `dives/`
    - optional trip `costs.md` for dive-focused trips
  - Triggers readiness refresh when new evidence materially changes readiness signals

- **Dive Q&A (skill: `dive-qa`)**
  - Runs a back-and-forth reflection Q&A in chat about a chosen dive
  - Writes a short, action-oriented summary into that dive’s `## Q&A summary` (no transcript stored)
  - Optionally captures bucket-list-relevant evidence when it naturally comes up

- **Bucket-list readiness refresh (skill: `bucket-list-readiness`)**
  - Maintains `bucket-list-readiness.md` using source-of-truth files:
    - dive count from `divinglog.md`
    - cert/Nitrox state from `diver-status.md`
    - evidence from per-dive summaries/reflections

- **Always-on guardrails (Cursor rules in `.cursor/rules/`)**
  - **Readiness stays current** when new dives/Q&A materially change evidence
  - **Trip costs stay in sync** (trip `costs.md` + rollup table in `trip-pricing-budget.md`)
  - **Versioning for `AGENTS.md`** via a safe snapshot script after edits

---

## ✅ Built: Photo ingestion + media organization

- **Photo ingest script (`scripts/ingest-dive-photos.py`)**
  - Reads `divinglog.md` and matches media to dives by date and time-window gaps
  - Copies photos/videos into: `dives/[trip]/photos/dive-[#]-[site]/`
  - Sends unmatched media to `photos/unassigned/` (no deletion)

- **Default photo source configuration (`config/dive-photo-source.txt`)**
  - Saves the default source folder path so ingest can run without pasting paths repeatedly

- **Photo ingestion workflow (skill: `dive-photo-ingest`)**
  - Defines how ingest should be run + how to update per-dive `## Media` sections afterward

---

## 🧭 Planned: Agentic pipeline (next features)

### Trip discovery & planning

- **Proactive trip scout (flights + timing + fit)**
  - Periodically surfaces 2–5 concrete trip options aligned to your constraints and readiness gaps
  - Inputs: `trip-preferences.md`, `trip-pricing-budget.md`, `bucket-list-readiness.md`
  - Notes: full automation via Google Flights/Skyscanner scraping is brittle; a robust version can use user-provided alerts/emails or API-backed providers

- **Trip builder (“idea → itinerary + budget”)**
  - Generates 2–3 candidate itineraries for a given time window
  - Includes transfer logic, dive-days vs rest-days, and a budget estimate consistent with your budget rules and rental assumptions

- **Dive-center/site intelligence pack**
  - 1–2 page briefing for a destination + month:
    - typical conditions, skill-fit, what to book, what to practice
  - Grounded in your logged readiness gaps and current certification

### Readiness, skills, and progression analytics

- **Readiness evidence engine (automatic signal extraction)**
  - Tracks readiness signals over time (SMB reps, current exposure, depth comfort, buoyancy/trim confidence, boat routine)
  - Generates “what’s missing next” suggestions after each trip or cluster of dives

- **Post-trip analysis reports**
  - Summaries like “pre-trip vs post-trip capability change”
  - Highlights patterns (air consumption trend, weighting stability, comfort in current, etc.)

### Ingestion automation (reduce manual entry)

- **Screenshot/voice-note → structured dive log ingestion**
  - Extracts dive fields from screenshots or transcriptions
  - Automatically updates `divinglog.md` + per-dive file with consistent units/vocabulary
  - Flags contradictions for review (e.g., depth/time mismatch)

- **Booking confirmation → costs autopilot**
  - Parses pasted booking emails/receipts
  - Converts to GBP with recorded FX rate/date
  - Updates trip `costs.md` and the rollup table in `trip-pricing-budget.md`

### Photo coaching (feedback loop)

- **Photo coach (composition/clarity/backscatter/color feedback)**
  - Reviews a selection of photos from a dive/trip and gives specific drills for improvement
  - Optionally produces a “best-of” selection per dive folder after ingest

---

## 🧭 Planned: “glue” features (to make it feel productized)

- **One-command / one-message workflows**
  - “New dives to log” → categorization + optional Q&A + readiness refresh
  - “New photos” → ingest + update `## Media` links in affected dive files

- **Lightweight dashboards**
  - Current dive count, recent dives, next readiness milestones
  - Next best trip windows aligned to temperature/budget rules

