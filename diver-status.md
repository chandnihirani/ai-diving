## Diver Status (current qualifications & progression)

Last updated: 2026-03-23

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

divinglog_latest_known:
  dives_logged_as_of: 2026-03-15
  dives_count_hint: 15
```

### Human notes
- You currently have **AOW**.
- Nitrox detection rule (for automation):
  - If your Nitrox course completion dives in `divinglog.md` have the `Gas` field set to something like `Nitrox`, `EAN`, or `EANx`, the agent can automatically mark Nitrox as obtained in this file.
  - If Nitrox is only mentioned in free-form notes (not in `divinglog.md`'s `Gas` column) then the agent should ask you to confirm before changing the status.

