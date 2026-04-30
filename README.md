# Diving Project (personal dive log + planning assistant)

## 30‑second explanation (ELI5)
This repo is my **personal scuba diving log**, written in Markdown.
I record each dive twice:

- **A simple “spreadsheet row”** for quick scanning (`divinglog.md`)
- **A detailed page per dive** for reflections, lessons, and media (`dives/...`)

Over time, those notes are also used to keep a separate document up to date that answers:  
**“Am I ready for X bucket‑list destination yet?”** (`bucket-list-readiness.md`)

It’s not an app you run. It’s a **structured notebook** that stays consistent and searchable.

---

## What this project does (today)
- **Keeps a clean dive history table** in `divinglog.md` (one row per dive, with links to details)
- **Stores rich per-dive detail pages** in `dives/[trip]/dive-[#]-[site].md`
  - reflections + lessons learned
  - a short **Q&A summary** (written after a chat-based dive debrief)
  - optional **Media** links (photos/videos)
- **Tracks “bucket-list readiness”** in `bucket-list-readiness.md`
  - uses evidence from logged dives + per-dive Q&A summaries (e.g. SMB practice, current comfort, depth comfort)
- **Captures diver state** that affects planning and recommendations
  - `diver-status.md` (certs like AOW/Nitrox)
  - `equipment-inventory.md` (what I own vs rent)
- **Optionally tracks dive-trip spend** (dive-focused trips only)
  - `dives/[trip]/costs.md` (amounts kept in **GBP**)
- **Can ingest camera media into per-dive folders** (scripted)
  - organized under `dives/[trip]/photos/dive-[#]-[site]/`

For a fuller “what exists vs what’s planned” checklist, see `FEATURES.md`.

---

## Where things live (mental model)
- **`divinglog.md`**: the index (fast overview + links)
- **`dives/`**: the detail library (one folder per trip, one file per dive)
- **`bucket-list-readiness.md`**: “how close am I to Maldives / Raja Ampat / etc?”
- **`diver-status.md`** + **`equipment-inventory.md`**: current baseline that planning depends on
- **`trip-preferences.md`** + **`trip-pricing-budget.md`**: constraints + budget heuristics for future trip planning
- **`scripts/`** + **`config/`**: helper automation (e.g., photo ingest)

Naming convention:
- Trip folder: `dives/[country]-[location]/` (example: `dives/kenya-diani/`)
- Dive file: `dive-[number]-[site-name].md` (example: `dive-14-alpha-funguo-reef.md`)

---

## How I use it (typical workflow)
1. **After a dive day**, I copy/paste dive info (or send screenshots / voice notes) into chat.
2. The dive gets added/updated in:
   - `divinglog.md` (one summary row)
   - `dives/...` (full detail page)
3. If I want a proper debrief, I do a **Q&A on one dive**, and a short summary is written into that dive’s file.
4. When new dives add meaningful evidence (SMB, currents, deep, boat routine, etc.), `bucket-list-readiness.md` is refreshed.

---

## “What do I tell someone who asks?”
> “It’s my dive log as Markdown: one table row per dive plus a detailed page per dive.  
> Because it’s structured, I can keep an up-to-date readiness tracker for bucket-list trips (like Maldives / Raja Ampat) based on real evidence from my dives.”

---

## Keeping this README up to date
This file is meant to stay **one page** and reflect “what the project actually is and does”.
If the workflow or capabilities change, update:
- `README.md` (this page)
- `FEATURES.md` (built vs planned checklist)

