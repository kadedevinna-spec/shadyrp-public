# 🪦 devchacha-graverobbery

![Banner](html/images/banner.png)

A grave robbery & prayer script for RedM using **ox_lib**, **ox_target**, and **rsg-core**.

---

## Features

- **Rob Grave** — Dig up graves with a shovel animation and loot valuables
- **Pray** — Kneel and pay respects with random prayer animations (no loot)
- **Dirt Pile Visual** — A dirt pile prop spawns after robbing, showing the grave has been disturbed
- **Permanently Looted** — Once any player robs a grave, it stays locked for everyone until server restart
- **Robbery Ledger** — Rare chance to find the book needed to start house robberies
- **Weighted Loot** — Configurable weighted random rewards (coins, rings, necklaces, gems, etc.)
- **Skill Check** — ox_lib skill check before digging
- **Civilian Snitching** — Nearby NPCs may report you to the law
- **Police Alerts** — Law enforcement gets a notification + map blip with GPS route
- **Night Only** — Optionally restrict grave robbing to nighttime (22:00 - 05:00)
- **100+ Grave Models** — Supports all gravestone props in RDR2

---

## Dependencies

- [rsg-core](https://github.com/Starter-Framework/rsg-core)
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_target](https://github.com/overextended/ox_target)

---

## Installation

1. Place `devchacha-graverobbery` in your `resources` folder
2. Add `ensure devchacha-graverobbery` to your `server.cfg`
3. Copy items from `shared/items.lua` into `rsg-core/shared/items.lua` (skip duplicates)
4. Copy images from `html/images/` into `rsg-inventory/html/images/`

---

## How It Works

### Robbing
1. Third Eye a grave → select **Rob Grave**
2. Pass the skill check
3. Digging animation plays with shovel attached to hand
4. Loot is given + a dirt pile spawns at the grave
5. Grave is permanently locked for all players
6. Nearby NPCs may snitch to the law

### Praying
1. Third Eye a grave → select **Pray**
2. Random prayer/mourning animation plays
3. Press **Backspace** to stop
4. No loot — works on robbed graves too

### Police
- Law jobs receive notification + blip with GPS route
- Blip auto-removes after 5 minutes (configurable)

---

## File Structure

```
devchacha-graverobbery/
├── fxmanifest.lua
├── config.lua
├── client/main.lua
├── server/main.lua
├── shared/items.lua
├── locales/en.json
├── html/images/
└── README.md
```

---

## Loot Table

| Category | Items |
|---|---|
| **Coins** | Half Penny, 1787 Penny, 1789 Penny, 1792 Nickel, Half Dime, 1792 Quarter (x2), Gold Dollar, Five Dollar, Gold Quarter, Half Eagle, Gold Eagle, New Yorke Token |
| **Rings** | Silver Ring, Wedding Ring, Platinum Ring |
| **Necklaces** | Pearl, Pearl Pendant, Gold Ring, Gold Cross, Ancient, Blakely Miniature, Amethyst Braxton, Amethyst Richelieu |
| **Gems** | Diamond, Ruby, Sapphire, Emerald |
| **Valuables** | Gold Bar, Antique Jewelry Box, Golden Chalice, Silver Pocket Watch |
| **Misc** | Gold Tooth, Cigar |
| **Special** | 📕 Robbery Ledger *(rare — needed for house robberies)* |

---

## Credits

- **Author**: devchacha
- **Framework**: RSG-Core
