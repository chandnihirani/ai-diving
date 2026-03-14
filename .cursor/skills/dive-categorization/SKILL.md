---
name: dive-categorization
description: Routes dive data into the correct files and folders. Use when the user provides dive information, logs a dive, shares PADI data, screenshots, voice notes about dives, or asks to add or update dive entries.
---

# Dive categorization

Route all dive-related input into the project's folder structure. Use this skill whenever the user gives information about a dive (data, reflections, PADI log, voice notes, or updates).

## Where things go

**Summary only → `divinglog.md`**
- One row per dive in the main table.
- Quantitative data: date, country, area, site, depth, bottom time, conditions, gear, cylinder, etc.
- Brief wildlife/notes (1–2 sentences). Link to the detailed file for that dive.

**Everything else → `dives/[trip]/dive-[#]-[site].md`**
- Full dive details, reflections, Q&A summary (written after a Q&A conversation—see dive-qa skill), self-ratings, challenges, media links.
- One file per dive. Create the trip folder if it does not exist.

## Naming

**Trip folder:** `[country]-[location]` in lowercase, hyphenated.
- Examples: `indonesia-komodo`, `turkey-dalaman`, `antigua`, `kenya-diani`, `sicily-taormina`, `malta-bugibba`.

**Dive file:** `dive-[number]-[site-name].md`. Site name lowercase, hyphens for spaces.
- Examples: `dive-10-mombasa-reef.md`, `dive-1-sebayur.md`.

## Workflow

1. **Parse** the user's input (PADI data, voice note, or typed info).
2. **Identify trip** from location/date → pick or create folder under `dives/` (e.g. `dives/kenya-diani/`).
3. **Next dive number** from the last row in `divinglog.md` (or last file in that trip).
4. **Add one row** to the table in `divinglog.md` (key fields + short notes + link to detail file).
5. **Create or update** `dives/[trip]/dive-[#]-[site].md` with full details, reflections, and a "Q&A summary" section (summary is filled when the user runs a Q&A on that dive via the dive-qa skill).
6. **Trigger Q&A:** Once the dive has been added or updated with full details (or the user has finished supplying details for that dive), **immediately start the dive-qa flow** for that dive—i.e. conduct the Q&A conversation in chat and then write the Q&A summary to the dive file. Skip this step only if the user has explicitly said they don't want Q&A (e.g. "just log this, no Q&A").

Summary table stays minimal; all detail lives in the per-dive files.
