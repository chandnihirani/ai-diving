# Diving project – agent context

This project is a **personal diving log**. The user adds dive data (from PADI app, screenshots, voice notes, or typed info). All input about dives must be categorized and stored in a fixed structure.

## When the user shares dive information

- **Always use the dive-categorization skill** when the user provides:
  - Dive data (depth, site, date, conditions, wildlife, etc.)
  - PADI log info, screenshots, or voice-note transcriptions
  - New dives to log or updates to existing dives

The skill defines where every piece of information goes: summary table vs detailed files, folder names, and file names.

## Project layout (summary)

- **`divinglog.md`** – One row per dive; quantitative data and brief notes only.
- **`dives/`** – One folder per trip (`[country]-[location]`), one file per dive (`dive-[#]-[site-name].md`). All reflections, Q&A, and detailed notes go here.

For exact naming, workflow, and what goes where, follow the **dive-categorization** skill.
