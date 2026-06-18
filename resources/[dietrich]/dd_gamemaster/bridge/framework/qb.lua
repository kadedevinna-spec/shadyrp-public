-- QBCore framework implementation (FiveM)

Bridge = Bridge or {}

local impl = {}

-- Load QBCore
if GetResourceState and GetResourceState('qb-core') == 'started' then
  if exports and exports['qb-core'] and exports['qb-core'].GetCoreObject then
    Bridge.QBCore = exports['qb-core']:GetCoreObject()
  elseif exports and exports['qb-core'] and exports['qb-core'].GetSharedObject then
    Bridge.QBCore = exports['qb-core']:GetSharedObject()
  end
end

local function _player(src)
  if not Bridge.QBCore or not Bridge.QBCore.Functions then return nil end
  return Bridge.QBCore.Functions.GetPlayer(src)
end

function impl.getPlayerData(src)
  if Bridge.isServer then
    local ply = _player(src)
    if not ply or not ply.PlayerData then return {} end
    local pd = ply.PlayerData
    return {
      identifier = pd.license or pd.steam or pd.citizenid,
      citizenid  = pd.citizenid,
      charid     = pd.citizenid,
      name       = pd.charinfo and (pd.charinfo.firstname .. ' ' .. pd.charinfo.lastname) or 'Unknown',
      money      = pd.money and pd.money.cash or 0,
      job        = pd.job and pd.job.name or 'unemployed',
      group      = pd.gang and pd.gang.name or (pd.job and pd.job.name or 'default'),
      isMale     = pd.charinfo and pd.charinfo.gender == 0,
      isPlayer   = true,
    }
  else
    if Bridge.QBCore and Bridge.QBCore.Functions and Bridge.QBCore.Functions.GetPlayerData then
      local pd = Bridge.QBCore.Functions.GetPlayerData()
      if not pd then return {} end
      return {
        citizenid  = pd.citizenid,
        charid     = pd.citizenid,
        name       = pd.charinfo and (pd.charinfo.firstname .. ' ' .. pd.charinfo.lastname) or 'Unknown',
        money      = pd.money and pd.money.cash or 0,
        job        = pd.job and pd.job.name or 'unemployed',
        group      = pd.gang and pd.gang.name or (pd.job and pd.job.name or 'default'),
        isMale     = pd.charinfo and pd.charinfo.gender == 0,
        isPlayer   = true,
      }
    end
  end
  return {}
end

function impl.setJob(src, job)
  local ply = _player(src)
  if ply and ply.Functions and ply.Functions.SetJob then ply.Functions.SetJob(job) end
end

--get job
function impl.getJob(src)
  local ply = _player(src)
  if ply and ply.Functions and ply.Functions.GetJob then
    return ply.Functions.GetJob()
  end
  return 'unemployed'
end

function impl.giveItem(src, item, amount)
  local ply = _player(src)
  if ply and ply.Functions and ply.Functions.AddItem then ply.Functions.AddItem(item, amount or 1) end
end

function impl.removeItem(src, item, amount)
  local ply = _player(src)
  if ply and ply.Functions and ply.Functions.RemoveItem then ply.Functions.RemoveItem(item, amount or 1) end
end

function impl.giveWeapon(src, weapon, ammo)
  local ply = _player(src)
  if ply and ply.Functions and ply.Functions.AddItem then
    ply.Functions.AddItem(weapon, 1, false, { ammo = ammo or 0 })
  end
end

function impl.giveMoney(src, amount)
  local ply = _player(src)
  if ply and ply.Functions and ply.Functions.AddMoney then ply.Functions.AddMoney('cash', amount or 0) end
end

function impl.removeMoney(src, amount)
  local ply = _player(src)
  if ply and ply.Functions and ply.Functions.RemoveMoney then ply.Functions.RemoveMoney('cash', amount or 0) end
end

function impl.notify(title, text, dict, icon, duration, color, src)
  local notifyType = 'inform'
  if color == 'COLOR_RED' then notifyType = 'error' elseif color == 'COLOR_GREEN' then notifyType = 'success' end
  local payload = { description = text, duration = duration or 5000, type = notifyType }
  if Bridge.isClient then
    TriggerEvent('ox_lib:notify', payload)
  else
    TriggerClientEvent('ox_lib:notify', src, payload)
  end
end

function impl.reloadPlayerPed(src)
  -- Reload the player's saved appearance using common QBCore-compatible resources
  if Bridge.isClient then
    local ped = PlayerPedId and PlayerPedId() or 0
    -- illenium-appearance (preferred)
    if exports['illenium-appearance'] and exports['illenium-appearance'].LoadPlayerSkin then
      exports['illenium-appearance']:LoadPlayerSkin()
      return
    end
    if exports['illenium-appearance'] and exports['illenium-appearance'].RefreshPed then
      exports['illenium-appearance']:RefreshPed(ped)
      return
    end
    -- fivem-appearance
    if exports['fivem-appearance'] and exports['fivem-appearance'].reloadSkin then
      exports['fivem-appearance']:reloadSkin()
      return
    end
    if exports['fivem-appearance'] and exports['fivem-appearance'].setPlayerAppearance then
      -- Some setups cache appearance on client; trigger a refresh event if available
      TriggerEvent('fivem-appearance:client:reloadSkin')
      return
    end
    -- qb-appearance
    
    TriggerEvent('qb-appearance:client:reloadSkin')

    TriggerServerEvent('qb-clothes:loadPlayerSkin')
    
  end
end

-- Snapshot the local player's current appearance (model + components + props)
function impl.snapshotAppearance(src)
  if not Bridge.isClient then return nil end
  local ped = PlayerPedId and PlayerPedId() or 0
  if ped == 0 then return nil end
  local snapshot = {
    model = GetEntityModel(ped),
    components = {},
    props = {},
  }
  for componentId = 0, 11 do
    snapshot.components[componentId] = {
      drawable = GetPedDrawableVariation(ped, componentId),
      texture = GetPedTextureVariation(ped, componentId),
      palette = (GetPedPaletteVariation and GetPedPaletteVariation(ped, componentId)) or 0,
    }
  end
  for propId = 0, 8 do
    local idx = GetPedPropIndex(ped, propId)
    snapshot.props[propId] = {
      index = idx,
      texture = (idx and idx ~= -1) and GetPedPropTextureIndex(ped, propId) or 0,
    }
  end
  return snapshot
end

-- Apply a previously captured appearance to the local player
function impl.applyAppearance(src, snapshot)
  if not Bridge.isClient or not snapshot or not snapshot.model then return end
  local ped = PlayerPedId and PlayerPedId() or 0
  if ped == 0 then return end
  -- Switch model exactly to snapshot model
  if RequestModel and HasModelLoaded then
    RequestModel(snapshot.model)
    local timeout = (GetGameTimer and (GetGameTimer() + 5000)) or 0
    while not HasModelLoaded(snapshot.model) do
      Wait(0)
      if GetGameTimer and GetGameTimer() > timeout then break end
    end
  end
  SetPlayerModel(PlayerId(), snapshot.model)
  if SetModelAsNoLongerNeeded then SetModelAsNoLongerNeeded(snapshot.model) end
  ped = PlayerPedId and PlayerPedId() or ped
  Wait(50)
  if SetPedDefaultComponentVariation then SetPedDefaultComponentVariation(ped) end
  for componentId = 0, 11 do
    local c = snapshot.components[componentId]
    if c then
      SetPedComponentVariation(ped, componentId, c.drawable or 0, c.texture or 0, c.palette or 0)
    end
  end
  if ClearAllPedProps then ClearAllPedProps(ped) end
  for propId = 0, 8 do
    local p = snapshot.props[propId]
    if p and p.index and p.index ~= -1 then
      SetPedPropIndex(ped, propId, p.index, p.texture or 0, true)
    else
      ClearPedProp(ped, propId)
    end
  end
end

function impl.registerUsableItem(itemName, cb)
  if not Bridge.isServer then return end
  if Bridge.QBCore and Bridge.QBCore.Functions and Bridge.QBCore.Functions.CreateUseableItem then
    Bridge.QBCore.Functions.CreateUseableItem(itemName, function(src, item)
      local usedName = (item and item.name) or itemName
      cb(src, usedName)
    end)
  end
end

function impl.closeInventory(src)
  if not Bridge.isServer then return end
  -- Inventory varies; try common resources
  TriggerClientEvent('inventory:client:close', src)
end

function impl.hasItem(src, itemName, amount)
  local ply = _player(src)
  if not ply or not ply.Functions or not ply.Functions.GetItemByName then return false end
  local item = ply.Functions.GetItemByName(itemName)
  local count = (item and (item.count or item.amount)) or 0
  return (count >= (amount or 1))
end

Bridge._fw_qb = impl

