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

## Git versioning (local only)

- **Commit after completing work.** Whenever you finish a task or a logical set of edits (e.g. adding a dive, updating the log, refactoring a file), commit the changes to Git. We use Git only for local versioning and revert capability—nothing is pushed to GitHub.
- **Commit message:** Short, clear description of what changed (e.g. "Add dive 3 Siaba Besar to Indonesia–Komodo", "Update divinglog summary table", "Fix dive-categorization skill").
- **What to commit:** Stage and commit all modified or new project files that belong to the change. Do not commit unless you have actually changed files.
- **When:** Commit once per completed task or coherent batch of edits, not after every single tiny edit.

## Versioning this file (AGENTS.md)

- **After any edit to this file**, run from the project root: `bash scripts/commit-agents-md.sh`
- This creates a Git snapshot so changes can be reverted. Do it automatically; the user does nothing.
- To revert AGENTS.md to a previous version, use `git checkout` or `git restore` with the desired commit.
