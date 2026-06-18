
--  Accessories | fx_accessories.sql

--  Last Updated: 2026-04-09
--  Run ONLY the section that matches your framework.
--  VORP  → Section 1  (SQL — run in your database)
--  RSG   → Section 2  (Lua — paste into your items shared file)



--  SECTION 1 — VORP CORE
--  Table: `items`  (vorp_inventory)


INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `groupId`, `rarityId`, `metadata`, `desc`, `weight`, `degradation`)
VALUES
    -- ── ALL (unisex) ─────────────────────────────────────────
    ('nativeheadband',    'Native Head Band',           1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('skullmaskred',      'Skull Mask Red',             1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('skullmaskmarked',   'Skull Mask Marked',          1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('skullmaskgreen',    'Skull Mask Green',           1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('largebraidedbag',   'Large Braided Bag',          1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('babystroller',      'Baby Stroller',              1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('babydoll',          'Baby Doll',                  1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('brose',             'Red Rose',                   1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('candelabrum',       'Candelabrum',                1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('goldenbracelett',   'Golden Bracelet',            1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('marriageproposal',  'Marriage Proposal Ring',     1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('goldenring',        'Golden Ring (R)',             1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('redstonering',      'Red Stone Ring (L)',          1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('whiteflag',         'White Flag',                 1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('donationbanner',    'Donation Banner',            1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('redwineglass',      'Red Wine Glass',             1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('photomachine',      'Photo Machine',              1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('leatherhandbag',    'Leather Handbag',            1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('moneybag',          'Money Bag',                  1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('brownsmallbag',     'Brown Small Bag',            1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('hornaccessorybelt', 'Horn Belt Accessory',        1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    

    -- ── FEMALE ───────────────────────────────────────────────
    ('bluebrooch',        'Blue Brooch',                1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('jewelaryneck',      'Silver Necklace',            1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('redstonenecklace',  'Red Stone Necklace',         1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('pearlnecklace',     'Pearl Necklace',             1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('pearlcrowns',       'Pearl Crown',                1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('pearlearring',      'Pearl Earring (L)',           1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('greenarring',       'Green Earring (R)',           1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('weddingringf',      'Wedding Ring (R)',            1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('yellowparasol',     'Yellow Parasol',             1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('featherbracelet',   'Feather Bracelet',           1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('mirrorhand',        'Pocket Mirror',              1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('smallredstonering', 'Small Red Stone Ring (L)',   1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('floweredsuitcase',  'Flowered Suitcase (L)',      1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('gemstonebracelet',  'Gemstone Bracelet (R)',      1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('smallhandbag',      'Small Handbag (L)',           1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('goldenbracelettr',  'Golden Bracelet (R)',         1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),

    -- ── MALE ─────────────────────────────────────────────────
    ('bearclawnecklace',  'Bear Claw Necklace',         1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('skullmask',         'Skull Mask',                 1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('pigmask',           'Pig Mask',                   1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('ropeheadband',      'Rope Head Band',             1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('saddlebag',         'Saddle Bag',                 1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('silverring',        'Silver Ring',                1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('weddingringsilver', 'Silver Wedding Ring',        1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0),
    ('brownhandbag',      'Brown Handbag',              1, 1, 'item_standard', 1, 1, 1, '{}', 'Accessory item used by Accessories', 0, 0)

ON DUPLICATE KEY UPDATE
    `label`       = VALUES(`label`),
    `limit`       = VALUES(`limit`),
    `can_remove`  = VALUES(`can_remove`),
    `type`        = VALUES(`type`),
    `usable`      = VALUES(`usable`),
    `groupId`     = VALUES(`groupId`),
    `rarityId`    = VALUES(`rarityId`),
    `metadata`    = VALUES(`metadata`),
    `desc`        = VALUES(`desc`),
    `weight`      = VALUES(`weight`),
    `degradation` = VALUES(`degradation`);



--  SECTION 2 — RSG CORE
--  File: rsg-inventory/shared/items.lua  (or equivalent)
--  Paste the Lua block below into your RSG items shared file.
--  DO NOT run this as SQL.


--[[

    -- ── ALL (unisex) ─────────────────────────────────────────
    ['nativeheadband']    = { ['name'] = 'nativeheadband',    ['label'] = 'Native Head Band',         ['weight'] = 0, ['type'] = 'item', ['image'] = 'nativeheadband.png',    ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['skullmaskred']      = { ['name'] = 'skullmaskred',      ['label'] = 'Skull Mask Red',           ['weight'] = 0, ['type'] = 'item', ['image'] = 'skullmaskred.png',      ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['skullmaskmarked']   = { ['name'] = 'skullmaskmarked',   ['label'] = 'Skull Mask Marked',        ['weight'] = 0, ['type'] = 'item', ['image'] = 'skullmaskmarked.png',   ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['skullmaskgreen']    = { ['name'] = 'skullmaskgreen',    ['label'] = 'Skull Mask Green',         ['weight'] = 0, ['type'] = 'item', ['image'] = 'skullmaskgreen.png',    ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['largebraidedbag']   = { ['name'] = 'largebraidedbag',   ['label'] = 'Large Braided Bag',        ['weight'] = 0, ['type'] = 'item', ['image'] = 'largebraidedbag.png',   ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['babystroller']      = { ['name'] = 'babystroller',      ['label'] = 'Baby Stroller',            ['weight'] = 0, ['type'] = 'item', ['image'] = 'babystroller.png',      ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['babydoll']          = { ['name'] = 'babydoll',          ['label'] = 'Baby Doll',                ['weight'] = 0, ['type'] = 'item', ['image'] = 'babydoll.png',          ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['brose']             = { ['name'] = 'brose',             ['label'] = 'Red Rose',                 ['weight'] = 0, ['type'] = 'item', ['image'] = 'brose.png',             ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['candelabrum']       = { ['name'] = 'candelabrum',       ['label'] = 'Candelabrum',              ['weight'] = 0, ['type'] = 'item', ['image'] = 'candelabrum.png',       ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['goldenbracelett']   = { ['name'] = 'goldenbracelett',   ['label'] = 'Golden Bracelet',          ['weight'] = 0, ['type'] = 'item', ['image'] = 'goldenbracelett.png',   ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['marriageproposal']  = { ['name'] = 'marriageproposal',  ['label'] = 'Marriage Proposal Ring',   ['weight'] = 0, ['type'] = 'item', ['image'] = 'marriageproposal.png',  ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['goldenring']        = { ['name'] = 'goldenring',        ['label'] = 'Golden Ring (R)',           ['weight'] = 0, ['type'] = 'item', ['image'] = 'goldenring.png',        ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['redstonering']      = { ['name'] = 'redstonering',      ['label'] = 'Red Stone Ring (L)',        ['weight'] = 0, ['type'] = 'item', ['image'] = 'redstonering.png',      ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['whiteflag']         = { ['name'] = 'whiteflag',         ['label'] = 'White Flag',               ['weight'] = 0, ['type'] = 'item', ['image'] = 'whiteflag.png',         ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['donationbanner']    = { ['name'] = 'donationbanner',    ['label'] = 'Donation Banner',          ['weight'] = 0, ['type'] = 'item', ['image'] = 'donationbanner.png',    ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['redwineglass']      = { ['name'] = 'redwineglass',      ['label'] = 'Red Wine Glass',           ['weight'] = 0, ['type'] = 'item', ['image'] = 'redwineglass.png',      ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['photomachine']      = { ['name'] = 'photomachine',      ['label'] = 'Photo Machine',            ['weight'] = 0, ['type'] = 'item', ['image'] = 'photomachine.png',      ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['leatherhandbag']    = { ['name'] = 'leatherhandbag',    ['label'] = 'Leather Handbag',          ['weight'] = 0, ['type'] = 'item', ['image'] = 'leatherhandbag.png',    ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['moneybag']          = { ['name'] = 'moneybag',          ['label'] = 'Money Bag',                ['weight'] = 0, ['type'] = 'item', ['image'] = 'moneybag.png',          ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['brownsmallbag']     = { ['name'] = 'brownsmallbag',     ['label'] = 'Brown Small Bag',          ['weight'] = 0, ['type'] = 'item', ['image'] = 'brownsmallbag.png',     ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['hornaccessorybelt'] = { ['name'] = 'hornaccessorybelt', ['label'] = 'Horn Belt Accessory',      ['weight'] = 0, ['type'] = 'item', ['image'] = 'hornaccessorybelt.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },

    -- ── FEMALE ───────────────────────────────────────────────
    ['bluebrooch']        = { ['name'] = 'bluebrooch',        ['label'] = 'Blue Brooch',              ['weight'] = 0, ['type'] = 'item', ['image'] = 'bluebrooch.png',        ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['jewelaryneck']      = { ['name'] = 'jewelaryneck',      ['label'] = 'Silver Necklace',          ['weight'] = 0, ['type'] = 'item', ['image'] = 'jewelaryneck.png',      ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['redstonenecklace']  = { ['name'] = 'redstonenecklace',  ['label'] = 'Red Stone Necklace',       ['weight'] = 0, ['type'] = 'item', ['image'] = 'redstonenecklace.png',  ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['pearlnecklace']     = { ['name'] = 'pearlnecklace',     ['label'] = 'Pearl Necklace',           ['weight'] = 0, ['type'] = 'item', ['image'] = 'pearlnecklace.png',     ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['pearlcrowns']       = { ['name'] = 'pearlcrowns',       ['label'] = 'Pearl Crown',              ['weight'] = 0, ['type'] = 'item', ['image'] = 'pearlcrowns.png',       ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['pearlearring']      = { ['name'] = 'pearlearring',      ['label'] = 'Pearl Earring (L)',         ['weight'] = 0, ['type'] = 'item', ['image'] = 'pearlearring.png',      ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['greenarring']       = { ['name'] = 'greenarring',       ['label'] = 'Green Earring (R)',         ['weight'] = 0, ['type'] = 'item', ['image'] = 'greenarring.png',       ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['weddingringf']      = { ['name'] = 'weddingringf',      ['label'] = 'Wedding Ring (R)',          ['weight'] = 0, ['type'] = 'item', ['image'] = 'weddingringf.png',      ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['yellowparasol']     = { ['name'] = 'yellowparasol',     ['label'] = 'Yellow Parasol',           ['weight'] = 0, ['type'] = 'item', ['image'] = 'yellowparasol.png',     ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['featherbracelet']   = { ['name'] = 'featherbracelet',   ['label'] = 'Feather Bracelet',         ['weight'] = 0, ['type'] = 'item', ['image'] = 'featherbracelet.png',   ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['mirrorhand']        = { ['name'] = 'mirrorhand',        ['label'] = 'Pocket Mirror',            ['weight'] = 0, ['type'] = 'item', ['image'] = 'mirrorhand.png',        ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['smallredstonering'] = { ['name'] = 'smallredstonering', ['label'] = 'Small Red Stone Ring (L)', ['weight'] = 0, ['type'] = 'item', ['image'] = 'smallredstonering.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['floweredsuitcase']  = { ['name'] = 'floweredsuitcase',  ['label'] = 'Flowered Suitcase (L)',    ['weight'] = 0, ['type'] = 'item', ['image'] = 'floweredsuitcase.png',  ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['gemstonebracelet']  = { ['name'] = 'gemstonebracelet',  ['label'] = 'Gemstone Bracelet (R)',    ['weight'] = 0, ['type'] = 'item', ['image'] = 'gemstonebracelet.png',  ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['smallhandbag']      = { ['name'] = 'smallhandbag',      ['label'] = 'Small Handbag (L)',         ['weight'] = 0, ['type'] = 'item', ['image'] = 'smallhandbag.png',      ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },

    -- ── MALE ─────────────────────────────────────────────────
    ['bearclawnecklace']  = { ['name'] = 'bearclawnecklace',  ['label'] = 'Bear Claw Necklace',       ['weight'] = 0, ['type'] = 'item', ['image'] = 'bearclawnecklace.png',  ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['skullmask']         = { ['name'] = 'skullmask',         ['label'] = 'Skull Mask',               ['weight'] = 0, ['type'] = 'item', ['image'] = 'skullmask.png',         ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['pigmask']           = { ['name'] = 'pigmask',           ['label'] = 'Pig Mask',                 ['weight'] = 0, ['type'] = 'item', ['image'] = 'pigmask.png',           ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['ropeheadband']      = { ['name'] = 'ropeheadband',      ['label'] = 'Rope Head Band',           ['weight'] = 0, ['type'] = 'item', ['image'] = 'ropeheadband.png',      ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['saddlebag']         = { ['name'] = 'saddlebag',         ['label'] = 'Saddle Bag',               ['weight'] = 0, ['type'] = 'item', ['image'] = 'saddlebag.png',         ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['silverring']        = { ['name'] = 'silverring',        ['label'] = 'Silver Ring',              ['weight'] = 0, ['type'] = 'item', ['image'] = 'silverring.png',        ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['weddingringsilver'] = { ['name'] = 'weddingringsilver', ['label'] = 'Silver Wedding Ring',      ['weight'] = 0, ['type'] = 'item', ['image'] = 'weddingringsilver.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['brownhandbag']      = { ['name'] = 'brownhandbag',      ['label'] = 'Brown Handbag',            ['weight'] = 0, ['type'] = 'item', ['image'] = 'brownhandbag.png',      ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },
    ['goldenbracelettr']  = { ['name'] = 'goldenbracelettr',  ['label'] = 'Golden Bracelet (R)',      ['weight'] = 0, ['type'] = 'item', ['image'] = 'goldenbracelettr.png',  ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Accessory item used by Accessories' },

--]]