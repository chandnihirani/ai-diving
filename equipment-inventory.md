## Equipment Inventory (owned vs rented)

Last updated: 2026-03-23

This file is the source of truth for what you **own** vs what you typically **rent** for trips, so the agent can:
- estimate equipment rental costs more accurately
- avoid assuming you own core scuba gear (regulator/BCD/fins/wetsuit) unless you explicitly say so
- incorporate any planned dive computer purchase into future budget discussions

### Structured inventory (machine-readable)

```yaml
owned_items:
  - name: dive mask
    quantity: 1
    notes: "Owned"
  - name: snorkel
    quantity: 1
    notes: "Owned"

rented_items_by_default:
  - name: BCD (buoyancy compensator device)
  - name: regulator + octopus
  - name: fins
  - name: wetsuit (incl. hood/gloves/boots when needed)
  - name: weight system
  - name: dive computer

dive_computer_purchase_status:
  intent: "considering"
  has_minimum_requirement_for_next_trips: false
  expected_nitrox_compatibility_need: true
```

### Human notes
- Physical storage location (optional): `TBD` (tell me where you want to store it at home, e.g. "under bed", "garage shelf", etc., if you want this captured).
- Right now, you own only a **mask** and **snorkel**; everything else is typically **rented** each trip.
- You’re considering buying a **dive computer** to reduce reliance on rentals and to support Nitrox-friendly diving later.

