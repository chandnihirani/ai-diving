## Trip Pricing & Budget (ballparks + targets)

Last updated: 2026-03-24

This file stores your budget priorities so the agent can filter/rank trip suggestions by expected cost.

For **what you actually paid** on **dive-focused trips**, see **`dives/[trip]/costs.md`** where it exists (not every trip has one—e.g. skip mixed beach holidays with only a day of diving).

### Structured budget rules (machine-readable)

```yaml
currency: GBP
assumptions:
  prices_are_per_person: true
  flights_are_round_trip_total_gbp: true

flights_europe_direct_low_cost:
  preferred_round_trip_range_gbp: [150, 300]
  hard_exclude_if_over_gbp: 500

accommodation:
  # Ideal is still lower, but real bookings (e.g. Malta) land around ~£120/night.
  preferred_per_night_range_gbp: [80, 100]
  typical_maximum_per_night_gbp: 120
  hard_exclude_if_over_gbp: 150

diving_costs:
  # You said diving center pricing is roughly similar, so we don't lock strict diving-only numbers yet.
  strict_thresholds: "none (yet)"
  approach: "use observed/quoted dive package prices when available; otherwise estimate ranges using comparable nearby centers"

total_trip_budget:
  # We'll refine this as you book more trips.
  total_target_gbp: "TBD"
```

### Human-readable guidance
- Europe trips: favor destinations where typical **return flights** from London via low-cost carriers are roughly within `£150–£300` **round-trip per person**, and avoid anything that looks like it would be around `£500+`.
- Accommodation: aim for roughly `£80–£100` per night where possible; a realistic ceiling for planned trips is **around `£120` per night** (confirmed by your Malta booking). Treat much above that (e.g. **`£150+`**) as generally not acceptable unless there is an unusual reason.
- Diving: keep this lightweight for now; when we have real package quotes (or when we create “reference” entries), the agent should use those to estimate totals more accurately.

