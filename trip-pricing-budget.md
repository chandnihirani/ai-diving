## Trip Pricing & Budget (ballparks + targets)

Last updated: 2026-04-06

This file stores your budget priorities so the agent can filter/rank trip suggestions by expected cost.

For **what you actually paid** on **dive-focused trips**, see **`dives/[trip]/costs.md`** where it exists (not every trip has one—e.g. skip mixed beach holidays with only a day of diving). Amounts there are kept in **GBP**, with foreign-currency inputs converted and the rate noted.

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
  # "Two-tank dive" = one typical outing of two single-tank dives (two dives / two tanks same session or day).
  two_tank_dive_session_max_gbp: 150
  interpretation: "When comparing quotes or costs.md figures, derive cost per two-dive outing and treat ~£150 as the usual ceiling (like hotel £/night and flight bands)."
  approach: "Use observed/quoted dive-package prices from costs.md or centres when available; convert to GBP. Flag if a two-dive block would exceed two_tank_dive_session_max_gbp unless there is a clear reason (e.g. remote boat, specialty)."

total_trip_budget:
  # We'll refine this as you book more trips.
  total_target_gbp: "TBD"
```

### Human-readable guidance
- Europe trips: favor destinations where typical **return flights** from London via low-cost carriers are roughly within `£150–£300` **round-trip per person**, and avoid anything that looks like it would be around `£500+`.
- Accommodation: aim for roughly `£80–£100` per night where possible; a realistic ceiling for planned trips is **around `£120` per night** (confirmed by your Malta booking). Treat much above that (e.g. **`£150+`**) as generally not acceptable unless there is an unusual reason.
- **Diving (two-tank / two-dive block):** treat **~£150** as the usual **maximum** for a **two-dive outing** (two single-tank dives—same as a “2 tank dive” day). Use it like the hotel and flight bands: compare derived costs from packages (`dives/[trip]/costs.md` or quotes) by computing **(price for N dives) ÷ N × 2** for a two-dive slice, or **half the quoted day rate** if pricing is per two-dive trip. If a destination’s going rate is **above £150** for that two-dive block, call it out as over the usual budget unless there is a strong reason (e.g. long boat day, park fees bundled, specialty site).

