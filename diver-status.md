## Diver Status (current qualifications & progression)

Last updated: 2026-05-30

This file is the source of truth for your *highest known certifications* and near-term plans (e.g., Nitrox by July).

For *dive count*, the agent should always recompute from `divinglog.md` (counting the numbered table rows), rather than trusting this file blindly.

### Structured status

```yaml
current_highest_certifications:
  - Advanced Open Water (AOW)

certifications:
  Enriched Air Nitrox:
    obtained: false
    expected_by: 2026-07
    confidence: "likely (based on your plan)"
  Rescue Diver:
    obtained: false
    notes: "Proactive reminder at 40 logged dives (see diver-milestones.md)"

divinglog_latest_known:
  dives_logged_as_of: 2026-05-30
  dives_count_hint: 15  # recompute from divinglog.md; Malta Jul 2026 is next logged batch

non_diving_trips:
  sicily_2026:
    dived: false
    notes: "Holiday to Sicily — no dives logged; Plemmirio/Syracuse dive plan not taken."

upcoming_dive_trips:
  malta_mellieha:
    when: 2026-07
    expected_additional_dives: "~10 (+ Nitrox course dives)"
```

### Human notes
- You currently have **AOW**.
- **15 dives logged** (through Kenya Mar 2026). **Malta Jul 2026** is the next dive trip.
- Sicily 2026 was a **holiday only** — no dives added to the log.
- Nitrox detection rule (for automation):
  - If your Nitrox course completion dives in `divinglog.md` have the `Gas` field set to something like `Nitrox`, `EAN`, or `EANx`, the agent can automatically mark Nitrox as obtained in this file.
  - If Nitrox is only mentioned in free-form notes (not in `divinglog.md`'s `Gas` column) then the agent should ask you to confirm before changing the status.

