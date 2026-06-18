Config = Config or {}

--[[
    Society Crafting Configuration

    This file controls the placed crafting prop, station interaction behavior,
    and job-specific recipes. Recipes are keyed by the exact framework job name.
]]

-- Props available in the Society UI when placing a crafting station.
-- Bosses/admins can choose one of these models before placing the station.
Config.CraftingProp = {
    'p_workbench01x',
    'p_workbench02x',
    'p_workbenchdesk01x',
}

Config.Crafting = {
    -- Master toggle for the society crafting system.
    -- false = hides the crafting placement section in the Society UI and disables
    -- placed crafting props/interactions.
    Enabled = true,

    -- Default maximum quantity a player can craft at once when a recipe does
    -- not define maxCount, max_count, or max.
    MaxQuantity = 50,

    -- false = one active craft per player.
    -- true = players can start multiple timed crafts at the same time.
    AllowMultipleCrafts = false,

    -- How far away the placed crafting prop is streamed/spawned client-side.
    PropStreamDistance = 70.0,

    -- How far away the marker/drawtext/prompt logic can start displaying.
    DrawDistance = 18.0,

    -- How close the player must be to press/use the crafting interaction.
    InteractDistance = 2.2,

    -- Server-side validation distance when opening the crafting UI.
    OpenDistance = 3.0,

    Prompt = {
        -- RedM control hash used for prompt/drawtext activation.
        Control = 0x760A9C6F, -- G

        -- Text shown in drawtext mode, e.g. "[G] Open Crafting".
        KeyLabel = 'G',

        -- Prompt/drawtext visibility distance.
        DisplayDistance = 6.5,

        -- Vertical offset for drawtext above the station prop.
        TextOffsetZ = 1.0,
    },

    Marker = {
        -- Marker type used when Config.Mode uses marker/drawtext style.
        Type = 0x94FDAE17,

        -- true = marker is grounded at the station coords.
        SnapToGround = true,

        -- Small height lift to avoid z-fighting with the ground.
        LiftZ = 0.03,

        -- Marker size.
        Scale = { x = 0.9, y = 0.9, z = 0.18 },

        -- Marker color.
        Color = { r = 180, g = 135, b = 82, a = 190 },
    },
}

--[[
    Recipe Format

    Config.CraftingRecipes[jobName] = {
        {
            label = 'Display Name',
            item = 'output_item_name',
            amount = 1,
            duration = 8000, -- 8000+ is treated as milliseconds; small values are seconds.
            maxCount = 10,   -- Optional per-recipe quantity cap.
            ingredients = {
                { item = 'input_item', amount = 2 },
                { item = 'tool_item', amount = 1, consume = false },
            },
        },
    }

    Supported aliases:
    - inputs, ingredients, or materials
    - outputs, output, or top-level item/name
    - amount, count, or qty
    - maxCount, max_count, or max
    - duration/time/craftTimeSec or timeMs/durationMs
]]

-- Job-keyed crafting recipes. Use the exact framework job name.
-- If a job has no recipes here, its society cannot place a crafting station.
Config.CraftingRecipes = {
    -- Example blacksmith job.
    blacksmithV = {
        {
            label = 'Nails',
            item = 'nails',
            amount = 5,
            duration = 8000,
            ingredients = {
                { item = 'iron', amount = 3 },
                { item = 'wood', amount = 1 },
            },
        },
    },
}
