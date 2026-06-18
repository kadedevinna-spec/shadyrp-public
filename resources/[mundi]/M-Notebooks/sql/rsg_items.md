-- ╔═══════════════════════════════════════════════════════════════╗
-- ║           M-NOTEBOOKS — RSG-CORE ITEM DEFINITIONS             ║
-- ╚═══════════════════════════════════════════════════════════════╝
--
-- FILE:   rsg-core/shared/items.lua
-- PASTE:  Inside the RSGShared.Items = { ... } table
--
-- All three items use unique = true so each instance can store
-- its own metadata (notebookId, ink durability, page content).
--
-- IMAGES: Place notebook.png, pen.png, torn_page.png in
--         rsg-inventory/html/images/  (128×128 or 100×100 PNG)


-- ── Notebook ─────────────────────────────────────────────────
-- Useable — opens the notebook UI when used from inventory.
['notebook'] = {
    name        = 'notebook',
    label       = 'Notebook',
    weight      = 200,
    type        = 'item',
    image       = 'notebook.png',
    unique      = true,
    useable     = true,
    shouldClose = true,
    description = 'A leather-bound personal notebook',
},

-- ── Pen ──────────────────────────────────────────────────────
-- NOT directly useable — just needs to be in inventory to write.
['pen'] = {
    name        = 'pen',
    label       = 'Pen',
    weight      = 50,
    type        = 'item',
    image       = 'pen.png',
    unique      = true,
    useable     = false,
    shouldClose = false,
    description = 'A simple ink pen for writing',
},

-- ── Torn Page ────────────────────────────────────────────────
-- Useable — opens a viewer to read or place the page on a wall.
['torn_page'] = {
    name        = 'torn_page',
    label       = 'Torn Page',
    weight      = 10,
    type        = 'item',
    image       = 'torn_page.png',
    unique      = true,
    useable     = true,
    shouldClose = true,
    description = 'A page torn from a notebook',
},
