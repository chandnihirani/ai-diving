## Project folder structure

### Overview

- **`divinglog.md`** = High-level summary table only (one row per dive)
- **`dives/`** = Detailed reflection files (one file per dive). Optional **`costs.md`** only for **dive-focused trips** (actual spend); not used for general holidays with incidental diving.

---

### Proposed structure

```
diving_project/
├── divinglog.md                    # Main summary table (high-level only)
├── ideas.md                        # Planning notes
├── FOLDER_STRUCTURE.md             # This file
│
└── dives/                          # Detailed dive reflections
    ├── indonesia-komodo/           # Trip: Indonesia, Komodo (Mar 2024)
    │   ├── dive-1-sebayur.md
    │   ├── dive-2-siaba-besar.md
    │   ├── dive-3-mawan.md
    │   └── dive-4-sudamala.md
    │
    ├── turkey-dalaman/             # Trip: Turkey, Dalaman (Oct 2024)
    │   ├── dive-5-dalaman-1.md
    │   └── dive-6-baba-island.md
    │
    ├── antigua/                    # Trip: Antigua (May 2025)
    │   ├── dive-7-pillars-of-hercules.md
    │   ├── dive-8-blacks-point.md
    │   ├── dive-9-nanton-point.md
    │   └── photos/                 # Photos per dive (from ingest script)
    │       ├── dive-7-pillars-of-hercules/
    │       ├── dive-8-blacks-point/
    │       └── dive-9-nanton-point/
    │
    ├── kenya-diani/                # Trip: Kenya, Diani (Mar 2026), dive-focused
    │   ├── costs.md                # Dive-only trip cost log
    │   ├── dive-10-[site-name].md
    │   ├── dive-11-[site-name].md
    │   └── ...
    │
    ├── sicily-taormina/            # Trip: Sicily, Taormina (May 2025) - upcoming
    │   ├── dive-[#]-[site-name].md
    │   └── ...
    │
    └── malta-mellieha/             # Trip: Malta, Mellieha (dive-focused) - upcoming
        ├── costs.md                # Dive-only trip cost log
        ├── dive-[#]-[site-name].md
        └── ...
```

---

### Naming convention

**Folder names:** `[country]-[location]` (e.g., `kenya-diani`, `sicily-taormina`)

**File names:** `dive-[number]-[site-name].md` (e.g., `dive-10-mombasa-reef.md`)

---

### What goes where

**`divinglog.md` (summary table):**
- One row per dive
- Key quantitative data (depth, time, conditions, gear)
- Brief wildlife/notes summary (1–2 sentences max)
- Links to detailed reflection files

**`dives/[trip]/costs.md` (trip spend, dive-focused trips only):**
- Flights, accommodation, diving, transfers, rental, other; currency and dates; optional £/night or £/dive for comparison. Omit for trips that are mainly a general holiday with only incidental diving. Not duplicated in `divinglog.md`.

**`dives/[trip]/dive-[#]-[site].md` (detailed reflections):**
- Full PADI log data (if not in summary)
- Your complete reflections/voice notes
- Q&A summary (written after a Q&A conversation on that dive—use the dive-qa skill). Can include a **Raja Ampat readiness** block (SMB, drift, buoyancy, reef hook, negative entry) so the raja-ampat-readiness skill can assess progress from this log.
- Self-ratings (buoyancy, trim, navigation, etc.)
- Detailed notes on challenges, breakthroughs, learning moments
- Links to media (photos/videos) if applicable

**`dives/[trip]/photos/dive-[#]-[site]/` (per-dive photo folders):**
- Created by the **dive-photo-ingest** skill/script when you ingest camera photos (e.g. DJI Osmo Action).
- One folder per dive; photos are assigned by date and time windows (see that skill). The dive’s `## Media` section links to these folders.

---

### Workflow

1. You share dive data (screenshots OR read from PADI app OR voice notes)
2. I extract key data → add to `divinglog.md` summary table
3. I create/update `dives/[trip]/dive-[#]-[site].md` with full dive details and your reflections.
4. For deeper discussion on one dive, use the **dive-qa skill**: we Q&A in chat, then I write a Q&A summary into that dive's file.
5. Summary table stays clean; all detail preserved in individual files.

---

### Benefits

- **Summary table** = Quick overview, easy to scan
- **Detailed files** = Rich qualitative data for analysis
- **Organized by trip** = Easy to find and review
- **Scalable** = Can add as many dives as needed without cluttering the summary
