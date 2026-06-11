## Diver milestones & proactive reminders

Last updated: 2026-06-04

**Purpose:** Machine-readable triggers the agent evaluates after logging dives, finishing trip Q&A, updating certifications, marking bucket-list destinations done, or on the **monthly Cursor Automation** (see `.cursor/automations/`).

**Dive count:** Always recompute from `divinglog.md` (numbered table rows), not from hints in `diver-status.md`.

**Certifications:** Read `diver-status.md` structured YAML (`certifications`, `current_highest_certifications`).

---

### Evaluation log (append-only)

| Date | Milestone ID | Dive count | Outcome |
|------|----------------|------------|---------|
| *(none yet)* | | | |

---

### Structured registry

```yaml
tracking:
  bucket_list_tracking_start: 2026-06-04  # first meaningful tracking of Done column
  last_meaningful_bucket_done: null       # YYYY-MM-DD when any destination gets Done = ✅
  last_meaningful_bucket_done_destination: null

reminder_policy:
  default_snooze_months: 6
  max_one_proactive_block_per_session: 2   # session-based checks only; automation may report all due items in one summary

milestones:
  rescue_diver_at_40:
    enabled: true
    description: "At 40 logged dives, nudge Rescue Diver if not yet certified"
    trigger:
      dive_count_gte: 40
    requires_certification_absent: "Rescue Diver"
    message: |
      You've reached **40 logged dives**. Many operators and bucket-list trips list **Rescue Diver** as desirable (some liveaboards strongly prefer it). If you haven't started Rescue yet, worth scheduling before heavy liveaboard / current-heavy trips.
    actions:
      - "Offer to add Rescue to diver-status.md planned_certs if you want a target window"
      - "Do not mark obtained without confirmation or course dives in divinglog.md"

  bucket_list_stale_9m:
    enabled: true
    description: "No bucket-list destination marked Done (✅) for 9+ months"
    trigger:
      months_since_last_meaningful_done_gte: 9
      # If never ✅, measure from bucket_list_tracking_start
    done_definition: "Done column = ✅ in bucket-list-readiness.md (🟠 partial does not count)"
    message: |
      It's been **9+ months** with no bucket-list destination marked **Done (✅)**. Worth a short planning pass: pick 1–2 **Near-term** rows in `bucket-list-readiness.md` that fit `trip-preferences.md` (season, temps, flight time) and sketch a realistic window.
    actions:
      - "Suggest 2–3 Near-term destinations with one-line why-now"
      - "Read trip-preferences.md and trip-pricing-budget.md before recommending"

  nitrox_overdue:
    enabled: true
    description: "Nitrox planned but not confirmed after expected_by date"
    trigger:
      certification_key: "Enriched Air Nitrox"
      obtained: false
      days_after_expected_by: 14
    message: |
      **Nitrox** was expected by your target date but isn't marked obtained in `diver-status.md`. If you completed the course, confirm so we can update Gas in `divinglog.md` / status; if not, worth booking before trips that include Nitrox fills.

  dives_rust_6m:
    enabled: true
    description: "No new dives logged for 6 months"
    trigger:
      months_since_last_dive_log_gte: 6
    message: |
      No new dives in **6+ months**. Before the next trip, a **refresher** or easy warm-up dives (shore, shallow) often pays off — especially if you're stepping up to currents, wrecks, or liveaboard rhythm.

  twentyfive_dive_gate:
    enabled: true
    description: "Crossing 25 dives — many bucket sites use this as a soft minimum"
    trigger:
      dive_count_crossing: 25
    message: |
      **25 dives** logged — several bucket-list and liveaboard itineraries use ~25 as a practical minimum. Good time to skim `bucket-list-readiness.md` for destinations you've marked Near-term and check site minimums vs your log.

  liveaboard_prep_first:
    enabled: true
    description: "First booked Red Sea / liveaboard-style trip — readiness checklist"
    trigger:
      event: "first_booking_matching"
      patterns:
        - "liveaboard"
        - "brothers"
        - "daedalus"
        - "elphinstone"
      source_files:
        - "dives/**/booking-comms.md"
        - "dives/**/planning.md"
    message: |
      First **liveaboard / current-heavy** booking detected. Quick checklist: SMB deployments in log, drift comfort, Nitrox status, Rescue/DM requirements on the itinerary, reef-hook policy for the boat.
    note: "Fire once per trip folder when booking-comms or planning first mentions liveaboard"

  computer_rental_40:
    enabled: true
    description: "40+ dives still renting computer — align with purchase intent"
    trigger:
      dive_count_gte: 40
    requires:
      equipment_yaml_path: equipment-inventory.md
      dive_computer_purchase_status.intent: "considering"
      rented_items_includes: "dive computer"
    message: |
      **40+ dives** and you're still **renting a dive computer** with purchase intent noted. Worth setting a budget band and picking Nitrox-compatible models before the next multi-dive trip.

  divemaster_at_100:
    enabled: false
    description: "Optional: DM path only if user opts in"
    trigger:
      dive_count_gte: 100
    requires_certification_absent: "Divemaster"
    message: "Only enable if pursuing pro path — many recreational divers skip DM."

reminder_state:
  rescue_diver_at_40: {}
  bucket_list_stale_9m: {}
  nitrox_overdue: {}
  dives_rust_6m: {}
  twentyfive_dive_gate: {}
  liveaboard_prep_first: {}
  computer_rental_40: {}
  divemaster_at_100: {}
```

### Human notes

- **Rescue at 40** — your chosen checkpoint (PADI does not require 40 dives for Rescue).
- **9-month bucket list** uses **✅ only**; Komodo **🟠** does not reset the timer. First possible stale nudge if never ✅: **2027-03-04** (9 months after tracking start).
- When you mark a destination **Done (✅)**, set `last_meaningful_bucket_done` and destination name in the YAML the same session.
- **Monthly automation** runs the same evaluation even when you are not logging dives (see `.cursor/automations/README.md`).
