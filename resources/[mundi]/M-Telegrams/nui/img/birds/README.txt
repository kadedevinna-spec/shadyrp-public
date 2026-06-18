Place your bird portrait images in this folder.
They are referenced from config.lua under Config.CarrierBirds.breeds[*].healthyImage / unhealthyImage.

Expected files for the default breeds:
  rock_pigeon_healthy.png     — Rock Pigeon (healthy state)
  rock_pigeon_injured.png     — Rock Pigeon (sick / dead state)
  homing_pigeon_healthy.png   — Homing Pigeon (healthy state)
  homing_pigeon_injured.png   — Homing Pigeon (sick / dead state)
  carrier_dove_healthy.png    — Carrier Dove (healthy state)
  carrier_dove_injured.png    — Carrier Dove (sick / dead state)

For custom breeds, add your image files here and reference them in config.lua as:
  healthyImage = "img/birds/your_filename.png"

Recommended image size: 512x512 px, transparent background (PNG).
