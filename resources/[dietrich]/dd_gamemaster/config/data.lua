GM = GM or {}
T = T or Bridge.T

local Data = {}

Data.categories = {
  { id = 'npcs', label = T('NPCs', 'NPCs'), order = 1, icon = '👥' },
  { id = 'animals', label = T('Animals', 'Animals'), order = 2, icon = '🐾' },
}


Data.items = {
  -- { id = 'sheriff', name = 'Sheriff Johnson', type = 'npc', image = 'images/items/sheriff.webp', tags = {'lawman','authority'}, model = 'CS_LawCarl', condition = 'isAdmin'},
  -- { id = 'outlaw', name = 'Bandit Pete', type = 'npc', image = 'images/items/outlaw.webp', tags = {'criminal','hostile'}, model = 'CS_ChainPrisoner_01', condition = 'anyone' }
}

-- Extend explicit generated items (from full peds list)
-- - RedM list:    config/data_items_generated.lua  -> GM.DataGeneratedItems
-- - FiveM list:   config/data_items_generated_fivem.lua -> GM.DataGeneratedItemsFiveM
do
  for _, it in ipairs(GM.DataGeneratedItems) do
    table.insert(Data.items, it)
  end
end

Data.defaultFavorites = { nil, nil, nil, nil, nil, nil, nil, nil, nil }

-- Conditions registry
Data.conditions = {
  anyone = function()
    return true
  end,
  isAdmin = function()
    -- Replace with your ACL system; this is a stub
    local player = Bridge.getPlayerData(source)
    if player.job == 'admin' then
      return true
    end
    return false
  end,
  isGM = function()
    -- Example: gated behind a simple config flag or job check
    return (Config and Config.GMOnly) and true or false
  end
}

-- List of horse models used for the "Spawn on Horse" option
Data.horseMountModels = {
  'A_C_Horse_Arabian_Black',
  'A_C_Horse_Arabian_RedChestnut',
  'A_C_Horse_Arabian_RoseGreyBay',
  'A_C_Horse_Turkoman_Gold',
  'A_C_Horse_Turkoman_Silver',
  'A_C_Horse_AmericanPaint_Overo',
}


GM.Data = Data




