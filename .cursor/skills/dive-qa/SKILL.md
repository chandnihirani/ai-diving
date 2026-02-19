---
name: dive-qa
description: Conducts a Q&A conversation about a specific dive using dive data and reflections, then writes a summary to the dive file. Use when the user wants to do Q&A on a dive, discuss a dive in depth, or asks to "Q&A on dive X" or "reflect on dive [site/number]".
---

# Dive Q&A

Run a back-and-forth Q&A in chat about one dive. When the user is done, write a **Q&A summary** into that dive's file (under "Q&A summary"). The dive file stores the summary only—not the full chat transcript.

## When to use

- User says they want to do Q&A on a dive, or to "Q&A dive 3", "reflect on Sebayur", etc.
- User indicates a specific dive (by number, site name, or file) and wants to discuss it.
- User wants to go deeper on reflections or dive data for one dive.

## Workflow

### 1. Identify the dive

- From the user's message: dive number, site name, trip, or path to the dive file.
- If ambiguous, ask which dive (or offer the match from `divinglog.md` / `dives/`).
- Read the dive file: `dives/[trip]/dive-[#]-[site].md` (dive data + reflections sections).

### 2. Conduct Q&A in chat

- Use the dive data table and the **Reflections** section as context.
- Ask questions that build on what they wrote (challenges, highlights, wildlife, skills, conditions).
- Keep the conversation in the chat; do not paste the transcript into the dive file.
- Continue until the user indicates they're done (e.g. "that's it", "no more questions", "summarise this").

### 3. Write the summary to the dive file

- When the user is finished, write a **short summary** of the Q&A (main themes, insights, answers) into that dive file.
- Update **only** the "## Q&A summary" section. Replace the placeholder (or existing summary) with the new summary.
- Format: a few paragraphs or bullet points capturing what was discussed and any takeaways. No need to list every question and answer.
- Do not put the full Q&A transcript in the file.

## Dive file section

Per-dive files have this section:

```markdown
## Q&A summary

*(Summary of Q&A conversation about this dive goes here. Use the dive-qa skill to have a conversation, then this section is updated with the summary.)*
```

After a Q&A session, replace the placeholder (or previous summary) with your written summary. Leave the "## Q&A summary" heading as-is.

## Summary style

- **Concise**: 2–5 short paragraphs or a short bullet list.
- **Themes**: What we talked about (e.g. buoyancy, wildlife, one challenge, one win).
- **Takeaways**: Any clear conclusions or things the diver wants to remember.
- **No transcript**: Do not copy-paste chat turns; summarise in your own words.

## Coordination with dive-categorization

- **Adding/logging dives** (new data, PADI, voice notes) → use **dive-categorization**.
- **Q&A on an existing dive** (conversation + summary in file) → use **dive-qa**.

Both can touch the same dive file: categorization for structure and data; dive-qa for the Q&A summary section only.
