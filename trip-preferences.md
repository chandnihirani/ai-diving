## Trip Preferences (always-on constraints)

Last updated: 2026-06-01

This file defines the rules the agent should treat as “hard” filters vs “preferences” when suggesting dive trips.

### Structured constraints (machine-readable)

```yaml
trip_cadence:
  per_year_target_min: 2
  per_year_target_max: 3

europe_proximity:
  within_flight_time_hours_from_london_max: 6
  min_europe_trips_within_that_window_per_year: 2
  region_preference: ["Europe", "Med"]

seasonality_water_temperature_bottom_celsius:
  # Interpretation: you said you don't want to be in water below ~20/22C.
  # We'll use a two-tier rule:
  # - hard exclude if expected bottom temperature < 20C
  # - strongly avoid if expected bottom temperature < 22C, unless there is a good reason
  hard_exclude_below_c: 20
  strongly_avoid_below_c: 22
  allow_recommendation_below_strongly_avoid_with_good_reason: true
  good_reason_examples:
    - "This is a best-fit trip for variety/progression and the colder-water risk is acceptable for you"
    - "Expected conditions are more favorable than typical (e.g., unusual warm season) and you still want it"

flight_constraints_europe:
  require_direct_flights: true
  preferred_airlines: ["easyJet", "Ryanair"]
  # London-area airports the agent may consider for Europe direct flights.
  london_airports_preferred: ["LGW", "STN", "LHR", "LCY"]
  london_airports_secondary_only_if_very_good_deal: ["LTN"]

long_haul_preferences:
  max_long_haul_trips_per_year: 1
  style_preference: ["liveaboard", "exotic/long-distance one-off"]

# Treat like Europe for trip planning (direct budget flights, ~5–5.5h from London).
red_sea_egypt:
  planning_tier: "europe_equivalent"
  notes: "Sharm/Hurghada — easyJet/TUI direct; not counted against long-haul/exotic slot."
  resort_week_planned: "2026-09"  # Sharm — northern classics + Thistlegorm; see dives/egypt-sharm/planning.md

# After Sep 2026 Sharm: pause further Red Sea trips 1–2 years; next Egypt dive should be Brothers-style liveaboard (~2028+).
red_sea_next:
  format: "liveaboard"
  focus: ["Brothers", "Daedalus", "Elphinstone"]
  defer_until: "2028"
  reason: "2026 Sharm covers northern resort + Thistlegorm; 2027 focus Caribbean & Asia; avoid Red Sea fatigue/repeat."

region_focus_2027:
  priority: ["Caribbean", "Asia"]
  deprioritize: ["Red Sea", "Egypt", "Med repeat hops"]
  notes: "Unless user explicitly reopens a region."

destinations_deferred:
  cyprus:
    defer_until: "2027"
    reason: "Med culture/overlap with Malta; Sicily holiday 2026 without diving — save Zenobia for next year."
  red_sea_liveaboard:
    defer_until: "2028"
    reason: "Sharm Sep 2026 first; Brothers/Daedalus/Elphinstone liveaboard after 1–2 year Red Sea break and readiness."
  red_sea_resort_return:
    defer_until: "2028"
    reason: "One northern Red Sea resort week in 2026; Hurghada/Sharm repeat not planned before Caribbean/Asia 2027."
```

### Notes / intent (human-readable)
- “Water temperature” refers to **bottom temperatures**, not surface temperatures.
- If expected bottom temp is under `22C`, the agent should generally recommend skipping (e.g., Malta in February), unless there is a clear, strong reason.
- What counts as a “strong reason”:
  - You have signaled (explicitly in chat) that you are deliberately entering a **cold-water phase** (e.g., Norway cold-water diving), or the trip is explicitly a **cold-water-first** plan.
  - The destination is unusually well-matched to a specific progression goal that you want to prioritize *now* (e.g., training/experience you can't get elsewhere), and the cold-water penalty is acceptable in context.
  - Otherwise, prefer warmer-season alternatives (e.g., shift Malta to July/August rather than “forcing” a cold-month trip).
- If we can’t reliably estimate expected **bottom** temperature for a specific season/location, treat it as “unknown” and either:
  - ask you for confirmation, or
  - prefer destinations where the typical diving season is well documented.
- Europe trips should be **direct-flight only** from London (where feasible), and should prioritize low-cost airlines.
- **Egypt (Red Sea — Sharm/Hurghada):** treat as **Europe-equivalent** for planning: direct budget flights (~5–5.5 h), same trip style as Med hops — **not** the annual long-haul/exotic slot (that stays for Kenya-style trips).
- **Cyprus:** defer to **2027** unless you explicitly reopen it — Med overlap with Malta + recent Sicily holiday makes it feel repetitive for 2026.
- **Red Sea / Egypt:** **Sep 2026 Sharm** is the planned **northern resort + Thistlegorm** trip. Then **1–2 year pause** on Red Sea — do **not** suggest Hurghada/Sharm again until **~2028** unless you reopen. **2027** trip ideas should lean **Caribbean** and **Asia** (long-haul slot). Next Red Sea dive should be **Brothers / Daedalus / Elphinstone liveaboard**, not another 10-dive resort pack.

