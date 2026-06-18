# Pickaxe Config Tutorial

This guide is for people who only edit configs and want to tune the pickaxe system safely.

Main file to edit:

- `config/config_tools.lua`

## 1. Understand The 3 Pickaxe Values

Each pickaxe tracks:

- `sharpness`: how efficient mining feels right now.
- `durability`: true lifespan. If this reaches 0, the pickaxe breaks.
- `timesRepaired`: how many anvil repairs this exact pickaxe has used.

You do not need to manually add `timesRepaired` to old items. If missing, it is treated like `0`.

## 2. Per-Hit Wear Settings

Inside each `Config.PickaxeData[index]`:

```lua
SharpnessDeduct = { 0.1, 0.2 }
PermanentDurabilityDeduct = { 0.045, 0.09 }
```

How to read these:

- Table format `{ min, max }` means random loss between min and max each hit.
- Number format like `0.15` means fixed loss each hit.

Balancing advice:

- Increase `SharpnessDeduct` to force frequent grindstone/wetstone usage.
- Increase `PermanentDurabilityDeduct` to shorten total lifetime.

## 3. Mining Slowdown From Low Sharpness

Also per pickaxe:

```lua
SharpnessPenaltyThreshold = 40
SharpnessPenaltyMaxMultiplier = 2.0
```

Meaning:

- At or above threshold: no slowdown.
- Below threshold: mining gets slower.
- At 0 sharpness: up to `SharpnessPenaltyMaxMultiplier` times slower.

Quick tuning:

- Higher `SharpnessPenaltyThreshold` = slowdown starts earlier.
- Higher `SharpnessPenaltyMaxMultiplier` = worse low-sharpness performance.

## 4. Wetstone Behavior

Global wetstone sharpness restore:

```lua
Config.PickaxeWetStoneSharpnessIncrease = {
	[1] = 25,
	[2] = 20,
	[3] = 15,
	[4] = 10
}
```

This only restores `sharpness`, not true `durability`.

## 5. Grindstone Behavior

Grindstone timing is here:

```lua
Config.GrindstoneTime = {
	[1] = 15 * 1000,
	[2] = 25 * 1000,
	[3] = 35 * 1000,
	[4] = 55 * 1000
}
```

Grindstone sets sharpness back to 100. It does not restore true durability.

## 6. Anvil Repair Tiers (Most Important)

Per pickaxe, under:

```lua
AnvilRepair = {
	DurationMs = 15000,
	RequiredItemsByDurability = { ... }
}
```

Important naming note:

- `RequiredItemsByDurability` key name stayed the same.
- The index now means **repair number** (based on `timesRepaired + 1`).

Example:

```lua
RequiredItemsByDurability = {
	[1] = { DurabilityIncrease = 40.0, RequiredItems = { { item = "iron_nugget", label = "Iron Nugget", amount = 1 } } },
	[2] = { DurabilityIncrease = 30.0, RequiredItems = { { item = "iron_nugget", label = "Iron Nugget", amount = 2 } } },
	[3] = { DurabilityIncrease = 22.0, RequiredItems = { { item = "iron_nugget", label = "Iron Nugget", amount = 3 } } }
}
```

How this works:

- First repair uses tier `[1]`.
- Second repair uses tier `[2]`.
- Third repair uses tier `[3]`.
- If the pickaxe needs a tier that does not exist, it is no longer repairable.

So the highest index you define is the max repairs that pickaxe can ever have.

## 7. How To Make A Pickaxe Last Longer

Choose one or combine:

- Lower `PermanentDurabilityDeduct`.
- Increase `DurabilityIncrease` in repair tiers.
- Add more repair tiers (`[6]`, `[7]`, etc).
- Reduce sharpness slowdown penalties so it stays usable while dull.

## 8. How To Make A Pickaxe More Hardcore

Choose one or combine:

- Raise `PermanentDurabilityDeduct`.
- Lower `DurabilityIncrease` values in later tiers.
- Increase item costs in `RequiredItems` each tier.
- Use fewer repair tiers.
- Raise sharpness penalties.

## 9. Recommended Safe Pattern

For stable economy and clear progression:

- Early repairs: larger restore, lower material cost.
- Late repairs: smaller restore, higher material cost.
- Better pickaxe tiers: lower permanent wear and/or better penalties.

## 10. Quick Checklist After Editing

- Every repair tier has `DurabilityIncrease`.
- Every repair tier has at least one valid item in `RequiredItems`.
- No gaps in tier indexes unless intentionally making a hard cap.
- Sharpness and durability numbers are reasonable (not huge spikes).
