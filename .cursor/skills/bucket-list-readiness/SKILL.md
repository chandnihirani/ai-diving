---
name: bucket-list-readiness
description: Assesses readiness across the diving bucket list using divinglog.md, diver-status.md, bucket-list-readiness.md, and per-dive Q&A summaries. Use when the user asks how close they are to bucket-list trips, asks if they are ready for Maldives, Raja Ampat, Philippines, Fiji, or similar destinations, or when dive/Q&A updates materially change readiness evidence.
---

# Bucket List Readiness

Use the shared readiness system in `bucket-list-readiness.md` instead of treating Raja Ampat as a standalone tracker.

## When to use

- The user asks how close they are to their bucket-list destinations.
- The user asks about readiness for a specific destination in the bucket list.
- A new dive log or dive Q&A adds material readiness evidence and the tracker should be refreshed.
- The user logs new dives from a bucket-list destination and the tracker should reflect that trip immediately.

## Source of truth

Read these files:

- `bucket-list-readiness.md`
- `divinglog.md`
- `diver-status.md`
- Relevant dive files under `dives/` when Q&A or reflections may contain readiness evidence

## What to recompute

Always recompute from the underlying files instead of trusting stale summary text:

- Total dive count from the numbered rows in `divinglog.md`
- Highest certification from `diver-status.md`
- Nitrox status from `diver-status.md`, unless clearly upgraded by logged Nitrox course dives
- Evidence for:
  - depth in the `25-30 m` range
  - SMB deployments
  - drift/current comfort
  - buoyancy/trim
  - reef hook use
  - negative entries
  - blue-water comfort
  - boat/liveaboard comfort

Use per-dive Q&A summaries first when present. If the block is missing, infer carefully from reflections or summary-table notes.

## Refresh workflow

When readiness evidence has materially changed:

1. Update `bucket-list-readiness.md`:
   - `Last updated`
   - `## Bucket list summary`
   - `## Current snapshot`
   - the relevant destination section under `## Bucket list destinations`
   - `## Current likely position` if the ranking changed
2. Keep the destination thresholds stable unless the user asks to change the bucket list itself.
3. Do not invent evidence that is not in the log or the current conversation.

## Bucket-list trip workflow

When the user logs new dives from a destination that is already in `bucket-list-readiness.md`:

1. Treat that destination as requiring a tracker update in the same overall workflow.
2. After the dives are logged and any same-session dive Q&A is complete, update:
   - the top summary table row for that destination
   - the destination's detailed section
3. In the summary table:
   - use `✅` when the user has now done a meaningful version of that bucket-list destination
   - use `🟠` when they have only partial / limited / training-style exposure and it should not count as fully ticked off
   - leave blank when not yet dived
4. For a destination like Maldives, if the user has completed real recreational dives there, that normally counts as `✅`, even if the trip is still ongoing.
5. For destinations where the first experience was clearly only a limited version of the place (for example training dives or unusually easy sampler dives), keep it at `🟠` until there is a more meaningful version.
6. In the detailed destination section, add or update a brief progress note based on the new trip:
   - whether the destination is now done / partial / not yet
   - what kind of version they have done so far
   - what remains if they have only partially completed it

## Response format

When the user asks for a readiness check, answer destination by destination using labels like:

- `Ready now`
- `Close / one trip away`
- `Needs more current practice`
- `Needs Nitrox`
- `Longer-term goal`

Be explicit about why, using the evidence from the log.

## Coordination

- For new dive data: `dive-categorization` handles the logging.
- For deeper evidence from one dive: `dive-qa` handles the conversation and writes the per-dive summary.
- After either of those adds material readiness evidence, refresh `bucket-list-readiness.md`.
- For bucket-list destinations, the refresh must include both the summary table row and the relevant destination section.
