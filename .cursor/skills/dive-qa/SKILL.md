---
name: dive-qa
description: Conducts a Q&A conversation about a specific dive using dive data and reflections, then writes a summary to the dive file. Use when the user wants to do Q&A on a dive, discuss a dive in depth, or asks to "Q&A on dive X" or "reflect on dive [site/number]".
---

# Dive Q&A

Run a back-and-forth Q&A in chat about one dive, using dive data and reflections to **draw out more information** from the user. The goal is to produce actionable insight: recommendations, things to look out for, and areas where the user might need help—including gaps you notice from the conversation that they may not have mentioned in their reflections. When the user is done, write a **Q&A summary** into that dive's file (under "Q&A summary"). The dive file stores the summary only—not the full chat transcript.

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
- **Aim to uncover**: what to recommend next, what to look out for on future dives, and any areas where they might need help that they haven’t yet articulated—notice gaps or blind spots and gently probe.
- Keep the conversation in the chat; do not paste the transcript into the dive file.
- Continue until the user indicates they're done (e.g. "that's it", "no more questions", "summarise this").

#### Raja Ampat–related questions (organic, not a checklist)

- **Do not** run through the same fixed Raja Ampat questions (SMB, drift, buoyancy, reef hook, negative entry) on every Q&A. Weave them in only when they fit the conversation and the dive.
- **Use what's already there**: If their reflections or the conversation already cover a criterion (e.g. they mentioned deploying an SMB, or "current was strong and I felt fine"), treat it as covered—follow up naturally if you need a 1–5 or Y/N for the block, or skip if the answer is clear.
- **Match questions to the dive**: Only ask about criteria that are relevant to *this* dive (e.g. drift/current comfort when the log shows current; SMB when it was an open-water dive where they might have deployed; reef hook when the site or conditions suggest it). Don't ask about reef hook on a calm, no-current dive unless it came up.
- **One natural question at a time**: Integrate one topic into the flow (e.g. "You mentioned the current—how comfortable did you feel, on a scale of 1–5?") rather than firing a list. If they're done before every Raja Ampat criterion is covered, that's fine—capture what was discussed in the summary and block.
- When writing the Q&A summary, add the **Raja Ampat readiness (this dive)** block only for criteria that were actually discussed; use "—" or omit lines for criteria not covered in this Q&A.

### 3. Write the summary to the dive file

- When the user is finished, write a **short summary** that is **action-oriented and diagnostic**, not just a recap of what was said.
- Update **only** the "## Q&A summary" section. Replace the placeholder (or existing summary) with the new summary.
- **Always include** (in whatever order fits):
  - **Recommendations**: What to do next (e.g. skills to practice, sites to try, gear or prep to consider).
  - **What to look out for**: Things to watch for or pay attention to on future dives.
  - **Areas to work on or get help with**: Where the user might need support—including anything you noticed from the Q&A that they didn’t mention in their reflections.
- Optionally add a brief note on main themes discussed. Do not put the full Q&A transcript in the file.

## Dive file section

Per-dive files have this section:

```markdown
## Q&A summary

*(Summary of Q&A conversation about this dive goes here. Use the dive-qa skill to have a conversation, then this section is updated with the summary.)*
```

After a Q&A session, replace the placeholder (or previous summary) with your written summary. Leave the "## Q&A summary" heading as-is.

## Summary style

- **Concise**: 2–5 short paragraphs or a short bullet list. Keep it tight—cover each theme once and avoid repeating the same point under "recommendations", "what to look out for", and "areas to work on"; merge into a single bullet per topic where it fits.
- **Action-oriented**: Lead with recommendations, what to look out for, and areas to work on or get help with.
- **Diagnostic**: Include anything you noticed (e.g. gaps, blind spots, unmentioned challenges) that came out in the Q&A.
- **No transcript**: Do not copy-paste chat turns; summarise in your own words.

## Coordination with dive-categorization

- **Adding/logging dives** (new data, PADI, voice notes) → use **dive-categorization**.
- **Immediately after finishing a new or updated dive via dive-categorization**, automatically start **dive-qa** for that specific dive *unless the user has explicitly said they don’t want Q&A right now* (e.g. “just log this, no Q&A”).
- **Q&A on an existing dive** (conversation + summary in file) → use **dive-qa**.

Both can touch the same dive file: categorization for structure and data; dive-qa for the Q&A summary section only.

## When to do Q&A (and when Raja Ampat comes in)

- Q&A is **normally not required after every dive** when considered in isolation, but when a dive has just been logged or updated and the user hasn’t opted out, treat that as a signal to *go ahead and run Q&A now*.
- The user can always say they want to skip or stop Q&A (e.g. “no Q&A for this one”, “let’s pause here”)—in that case, don’t start or continue Q&A.
- Raja Ampat criteria don’t need to be asked every time. Be selective: ask when the dive is relevant (current, open water, drift, etc.) or when the conversation naturally goes there. If the user does Q&A on a calm, shallow dive with no SMB or current, you may cover little or no Raja Ampat—that’s fine. Readiness can still be assessed from other dives’ Q&A summaries and reflections.
