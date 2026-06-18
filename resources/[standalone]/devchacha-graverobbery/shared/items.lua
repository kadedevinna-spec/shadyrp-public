--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║  devchacha-graverobbery  —  Shared Items                    ║
    ║                                                              ║
    ║  Copy the items below into your rsg-core/shared/items.lua   ║
    ║  Skip any items that already exist in your items.lua         ║
    ╚══════════════════════════════════════════════════════════════╝
]]

local Items = {

    -- ══════════════════════════════════════
    -- COINS
    -- ══════════════════════════════════════
    ['coin_half_penny']       = { name = 'coin_half_penny',       label = '1796 Half Penny',               weight = 5,   type = 'item', image = 'coin_half_penny.png',       unique = false, useable = false, shouldClose = false, combinable = nil, description = 'An old copper half penny coin.' },
    ['coin_penny_1787']       = { name = 'coin_penny_1787',       label = '1787 Penny',                    weight = 5,   type = 'item', image = 'coin_penny_1787.png',       unique = false, useable = false, shouldClose = false, combinable = nil, description = 'An old copper penny from 1787.' },
    ['coin_penny_1789']       = { name = 'coin_penny_1789',       label = '1789 Penny',                    weight = 5,   type = 'item', image = 'coin_penny_1789.png',       unique = false, useable = false, shouldClose = false, combinable = nil, description = 'An old copper penny from 1789.' },
    ['coin_nickel_1792']      = { name = 'coin_nickel_1792',      label = '1792 Nickel',                   weight = 5,   type = 'item', image = 'coin_nickel_1792.png',      unique = false, useable = false, shouldClose = false, combinable = nil, description = 'An old nickel coin from 1792.' },
    ['coin_half_dime']        = { name = 'coin_half_dime',        label = 'Half Dime',                     weight = 5,   type = 'item', image = 'coin_half_dime.png',        unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A small silver half dime coin.' },
    ['coin_quarter_1792']     = { name = 'coin_quarter_1792',     label = '1792 Quarter',                  weight = 5,   type = 'item', image = 'coin_quarter_1792.png',     unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A quarter dollar from 1792.' },
    ['coin_quarter_1792_2']   = { name = 'coin_quarter_1792_2',   label = '1792 Quarter (Variant)',        weight = 5,   type = 'item', image = 'coin_quarter_1792_2.png',   unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A rare variant quarter from 1792.' },
    ['coin_gold_dollar']      = { name = 'coin_gold_dollar',      label = 'Gold Dollar',                   weight = 5,   type = 'item', image = 'coin_gold_dollar.png',      unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A golden dollar coin.' },
    ['coin_five_dollar']      = { name = 'coin_five_dollar',      label = 'Five Dollar Coin',              weight = 5,   type = 'item', image = 'coin_five_dollar.png',      unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A five dollar gold coin.' },
    ['coin_gold_quarter']     = { name = 'coin_gold_quarter',     label = 'Gold Quarter',                  weight = 5,   type = 'item', image = 'coin_gold_quarter.png',     unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A gold quarter eagle coin.' },
    ['coin_half_eagle']       = { name = 'coin_half_eagle',       label = 'Half Eagle',                    weight = 5,   type = 'item', image = 'coin_half_eagle.png',       unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A five dollar half eagle gold coin.' },
    ['coin_gold_eagle']       = { name = 'coin_gold_eagle',       label = 'Gold Eagle',                    weight = 10,  type = 'item', image = 'coin_gold_eagle.png',       unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A ten dollar eagle gold coin.' },
    ['coin_new_yorke']        = { name = 'coin_new_yorke',        label = 'New Yorke Token',               weight = 5,   type = 'item', image = 'coin_new_yorke.png',        unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A rare New Yorke trade token.' },

    -- ══════════════════════════════════════
    -- RINGS
    -- ══════════════════════════════════════
    ['silver_ring']           = { name = 'silver_ring',           label = 'Silver Ring',                   weight = 10,  type = 'item', image = 'silver_ring.png',           unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A simple silver ring.' },
    ['wedding_ring']          = { name = 'wedding_ring',          label = 'Wedding Ring',                  weight = 10,  type = 'item', image = 'wedding_ring.png',          unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Someone is missing this.' },
    ['platinum_ring']         = { name = 'platinum_ring',         label = 'Platinum Ring',                 weight = 10,  type = 'item', image = 'platinum_ring.png',         unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A valuable platinum ring.' },

    -- ══════════════════════════════════════
    -- NECKLACES
    -- ══════════════════════════════════════
    ['necklace_pearl_rou']          = { name = 'necklace_pearl_rou',          label = 'Pearl Necklace',                   weight = 50,  type = 'item', image = 'necklace_pearl_rou.png',          unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A beautiful pearl necklace.' },
    ['necklace_pearl_pelle']        = { name = 'necklace_pearl_pelle',        label = 'Pearl Pendant',                    weight = 50,  type = 'item', image = 'necklace_pearl_pelle.png',        unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A pearl pendant necklace.' },
    ['necklace_gold_ring']          = { name = 'necklace_gold_ring',          label = 'Gold Ring Necklace',               weight = 50,  type = 'item', image = 'necklace_gold_ring.png',          unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A gold chain with a ring.' },
    ['necklace_gold_cross']         = { name = 'necklace_gold_cross',         label = 'Gold Cross Necklace',              weight = 50,  type = 'item', image = 'necklace_gold_cross.png',         unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A gold cross on a chain.' },
    ['necklace_ancient']            = { name = 'necklace_ancient',            label = 'Ancient Necklace',                 weight = 50,  type = 'item', image = 'necklace_ancient.png',            unique = false, useable = false, shouldClose = false, combinable = nil, description = 'An ancient necklace of unknown origin.' },
    ['necklace_mini_blakely']       = { name = 'necklace_mini_blakely',       label = 'Blakely Miniature Necklace',       weight = 50,  type = 'item', image = 'necklace_mini_blakely.png',       unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A delicate miniature necklace.' },
    ['necklace_amethyst_braxton']   = { name = 'necklace_amethyst_braxton',   label = 'Amethyst Necklace (Braxton)',      weight = 50,  type = 'item', image = 'necklace_amethyst_braxton.png',   unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A rare amethyst necklace.' },
    ['necklace_amethyst_richelieu'] = { name = 'necklace_amethyst_richelieu', label = 'Amethyst Necklace (Richelieu)',    weight = 50,  type = 'item', image = 'necklace_amethyst_richelieu.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A highly valuable amethyst necklace.' },

    -- ══════════════════════════════════════
    -- GEMS & VALUABLES
    -- ══════════════════════════════════════
    ['diamond']               = { name = 'diamond',               label = 'Diamond',                       weight = 5,   type = 'item', image = 'diamond.png',               unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A flawless diamond.' },
    ['ruby']                  = { name = 'ruby',                  label = 'Ruby',                          weight = 5,   type = 'item', image = 'ruby.png',                  unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A blood red ruby.' },
    ['sapphire']              = { name = 'sapphire',              label = 'Sapphire',                      weight = 5,   type = 'item', image = 'sapphire.png',              unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A deep blue sapphire.' },
    ['emerald']               = { name = 'emerald',               label = 'Emerald',                       weight = 5,   type = 'item', image = 'emerald.png',               unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A vibrant green emerald.' },
    ['gold_bar']              = { name = 'gold_bar',              label = 'Gold Bar',                      weight = 100, type = 'item', image = 'gold_bar.png',              unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A heavy bar of solid gold.' },
    ['antique_jewelry_box']   = { name = 'antique_jewelry_box',   label = 'Antique Jewelry Box',           weight = 100, type = 'item', image = 'antique_jewelry_box.png',   unique = false, useable = false, shouldClose = false, combinable = nil, description = 'An ornate antique jewelry box.' },
    ['art_golden_chalice']    = { name = 'art_golden_chalice',    label = 'Golden Chalice',                weight = 100, type = 'item', image = 'art_golden_chalice.png',    unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A ceremonial golden cup.' },
    ['pocket_watch_silver']   = { name = 'pocket_watch_silver',   label = 'Silver Pocket Watch',           weight = 10,  type = 'item', image = 'pocket_watch_silver.png',   unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A silver time piece.' },

    -- ══════════════════════════════════════
    -- MISC
    -- ══════════════════════════════════════
    ['tooth_gold']            = { name = 'tooth_gold',            label = 'Gold Tooth',                    weight = 10,  type = 'item', image = 'tooth_gold.png',            unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A golden tooth pulled from... somewhere.' },
    ['cigar']                 = { name = 'cigar',                 label = 'Cigar',                         weight = 10,  type = 'item', image = 'cigar.png',                 unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A fine cigar.' },

    -- ══════════════════════════════════════
    -- ROBBERY LEDGER (needed for house robbery)
    -- ══════════════════════════════════════
    ['robbery_ledger']        = { name = 'robbery_ledger',        label = 'Robbery Ledger',                weight = 200, type = 'item', image = 'robbery_ledger.png',        unique = false, useable = false, shouldClose = false, combinable = nil, description = 'A book containing records of houses and valuable targets.' },
}

return Items
