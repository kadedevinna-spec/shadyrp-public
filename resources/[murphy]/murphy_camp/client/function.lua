Citizen.CreateThread(function()
  while true do
    me = PlayerPedId()
    meCoords = GetEntityCoords(me, true, true)
    Wait(1000)
  end
end)

function SpawnPropset(model, x, y, z, heading)
  local coords = vector3(x, y, z)
  -- Spawn the propset
  RequestPropset(model)

  while not HasPropsetLoaded(model) do
    Wait(0)
  end

  local propset = CreatePropset(model, x, y, z, 0, heading, 1200.0, false, true)
  -- Give the propset time to fully load
  WaitForPropSetToLoad(propset)

  ReleasePropset(model)

  if not propset or propset < 1 then
    return false
  end
  local itemset = CreateItemset(true)
  local size = GetEntitiesFromPropset(propset, itemset, 0, false, false)

  local entities = {}
  local offset = vector2(0, 0)
  local _coords = vector3(0, 0, 0)

  if size and size > 0 then
    for i = 0, size - 1 do
      entities[#entities + 1] = GetIndexedItemInItemset(i, itemset)
      _coords = GetEntityCoords(entities[#entities])
      offset = offset + _coords.xy
      -- if networked then
      --   CloneEntity(entities[#entities])
      -- end
    end

    offset = vector2(offset.x / size, offset.y / size) - coords.xy

    for _, entity in pairs(entities) do
      coords = GetEntityCoords(entity)
      SetEntityCoords(entity, coords.x - offset.x, coords.y - offset.y, coords.z)
      FreezeEntityPosition(entity, true)
    end
  end

  if IsItemsetValid(itemset) then
    DestroyItemset(itemset)
  end

  -- DeletePropset(propset, false, false)

  return propset
end

function RequestPropset(hash)
  return Citizen.InvokeNative(0xF3DE57A46D5585E9, hash)
end

function ReleasePropset(hash)
  return Citizen.InvokeNative(0xB1964A83B345B4AB, hash)
end

function HasPropsetLoaded(hash)
  return Citizen.InvokeNative(0x48A88FC684C55FDC, hash)
end

function CreatePropset(hash, x, y, z, p4, p5, p6, p7, p8)
  return Citizen.InvokeNative(0xE65C5CBA95F0E510, hash, x, y, z, p4, p5, p6, p7, p8)
end

function DeletePropset(propSet, p1, p2)
  return Citizen.InvokeNative(0x58AC173A55D9D7B4, propSet, p1, p2)
end

function DoesPropsetExist(propSet)
  return Citizen.InvokeNative(0x7DDDCF815E650FF5, propSet)
end

function GetEntitiesFromPropset(propSet, itemSet, p2, p3, p4)
  return Citizen.InvokeNative(0x738271B660FE0695, propSet, itemSet, p2, p3, p4)
end

function IsPropSetFullyLoaded(propSet)
  return Citizen.InvokeNative(0xF42DB680A8B2A4D9, propSet)
end

function WaitForPropSetToLoad(propSet)
  local timeWaited = 0

  while not IsPropSetFullyLoaded(propSet) and timeWaited <= 500 do
    Wait(100)
    timeWaited = timeWaited + 100
  end

  return true
end

function GetAccess(charid, owner, guests)
  local result = false
  if tostring(charid) == tostring(owner) then
    result = true
  else
    local guestList = {}
    if guests then
      guestList = guests
    end
    for k, v in pairs(guestList) do
      if tostring(charid) == tostring(v) then
        result = true
      end
    end
  end
  return result
end

function TextEntry(label, placeholder, maxStringLenght)
  AddTextEntry('KTEXTTYPE_NUMERIC', label)
  DisplayOnscreenKeyboard(3, "KTEXTTYPE_NUMERIC", "", placeholder, "", "", "", maxStringLenght or 60)

  while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
    Wait(0)
  end

  if UpdateOnscreenKeyboard() ~= 2 then
    local result = GetOnscreenKeyboardResult() --Gets the result of the typing
    Wait(100)
    return result or ''
  else
    Wait(100)
    return ''
  end
end

function tablesAreEqual(table1, table2)
  if table1 == table2 then return true end
  if type(table1) ~= "table" or type(table2) ~= "table" then return false end

  for key, value in pairs(table1) do
    if type(value) == "table" then
      if not tablesAreEqual(value, table2[key]) then return false end
    else
      if value ~= table2[key] then return false end
    end
  end

  for key in pairs(table2) do
    if table1[key] == nil then return false end
  end

  return true
end

RegisterNetEvent('murphy_camp:Tip')
AddEventHandler('murphy_camp:Tip', function(text, duration)
  ShowTooltip(tostring(text), tonumber(duration))
end)
function bigInt(text)
  local string1 = DataView.ArrayBuffer(16)
  string1:SetInt64(0, text)
  return string1:GetInt64(0)
end

ShowTooltip = function(text, duration)
  local string = CreateVarString(10, "LITERAL_STRING", text)
  local Var0 = DataView.ArrayBuffer(8 * 7)
  local Var13 = DataView.ArrayBuffer(8 * 3)
  Var0:SetUint32(8 * 0, duration)
  Var0:SetInt32(8 * 1, 0)
  Var0:SetInt32(8 * 2, 0)
  Var0:SetInt32(8 * 3, 0)
  -- struct1.setBigInt64(8, BigInt(sound_dict), true); -- Notification sound optional
  -- struct1.setBigInt64(16, BigInt(sound), true);
  Var13:SetUint64(8 * 1, bigInt(string))
  Citizen.InvokeNative(0x049D5C615BD38BAD, Var0:Buffer(), Var13:Buffer(), 1)
end

function LoadTexture(dict)
  if Citizen.InvokeNative(0x7332461FC59EB7EC, dict) then
    RequestStreamedTextureDict(dict, true)
    while not HasStreamedTextureDictLoaded(dict) do
      Wait(1)
    end
    return true
  else
    return false
  end
end

RegisterNetEvent('murphy_camp:ShowAdvancedRightNotification')
AddEventHandler('murphy_camp:ShowAdvancedRightNotification', function(text, dict, icon, text_color, duration)
  local _dict = dict
  local _icon = icon
  if not LoadTexture(_dict) then
    _dict = "generic_textures"
    LoadTexture(_dict)
    _icon = "tick"
  end
  ShowAdvancedRightNotification(tostring(text), tostring(_dict), tostring(_icon), tostring(text_color),
    tonumber(duration))
end)
ShowAdvancedRightNotification = function(_text, _dict, icon, text_color, duration, quality)
  local text = CreateVarString(10, "LITERAL_STRING", _text)
  local dict = CreateVarString(10, "LITERAL_STRING", _dict)
  local sdict = CreateVarString(10, "LITERAL_STRING", "Transaction_Feed_Sounds")
  local sound = CreateVarString(10, "LITERAL_STRING", "Transaction_Positive")

  local struct1 = DataView.ArrayBuffer(8 * 7)
  struct1:SetInt32(8 * 0, duration)
  struct1:SetInt64(8 * 1, bigInt(sdict))
  struct1:SetInt64(8 * 2, bigInt(sound))

  local struct2 = DataView.ArrayBuffer(8 * 10)
  struct2:SetInt64(8 * 1, bigInt(text))
  struct2:SetInt64(8 * 2, bigInt(dict))
  struct2:SetInt64(8 * 3, bigInt(GetHashKey(icon)))
  struct2:SetInt64(8 * 5, bigInt(GetHashKey(text_color or "COLOR_WHITE")))
  struct2:SetInt32(8 * 6, quality or 1)

  Citizen.InvokeNative(0xB249EBCB30DD88E0, struct1:Buffer(), struct2:Buffer(), 1)
end

ShowTopNotif = function(title, subtext, duration)
  local struct1 = DataView.ArrayBuffer(8 * 7)
  struct1:SetInt32(8 * 0, duration)
  --struct1:SetInt64(8*1,bigInt(sound_dict))
  --struct1:SetInt64(8*2,bigInt(sound))
  local string1 = CreateVarString(10, "LITERAL_STRING", title)
  local string2 = CreateVarString(10, "LITERAL_STRING", subtext)
  local struct2 = DataView.ArrayBuffer(8 * 7)
  struct2:SetInt64(8 * 1, bigInt(string1))
  struct2:SetInt64(8 * 2, bigInt(string2))
  Citizen.InvokeNative(0xA6F4216AB10EB08E, struct1:Buffer(), struct2:Buffer(), 1, 1)
end

_Propset = {}
function RotateObject(_coord, _center, _angle)
  return vector2(
    (_coord.x - _center.x) * math.cos(_angle) - (_coord.y - _center.y) * math.sin(_angle) + _center.x,
    (_coord.x - _center.x) * math.sin(_angle) + (_coord.y - _center.y) * math.cos(_angle) + _center.y
  )
end

function _Propset:new(model, coords, networked, accessories, Zrota)
  local self = {}
  --setmetatable({}, self)
  self.model = model
  self.origin = coords.xyz
  self.networked = networked
  self.heading = Zrota

  self.move = function(NewCoords)
    local offset = vector3(0, 0, 0)
    if self.entities == nil then
      return
    end
    for _, entity in pairs(self.entities) do
      offset = GetEntityCoords(entity) - self.origin
      SetEntityCoords(entity, NewCoords.x + tonumber(offset.x), NewCoords.y + tonumber(offset.y),
        NewCoords.z + tonumber(offset.z))
    end
    self.origin = NewCoords
  end

  self.rotate = function(angle)
    if self.entities == nil then
      return
    end

    local rotation, coords
    local diffAngle = angle - self.heading -- Calculate the difference relative to the initial heading
    for _, entity in pairs(self.entities) do
      rotation = GetEntityRotation(entity, 2)
      coords = GetEntityCoords(entity)
      local newCoord = RotateObject(coords.xy, self.origin.xy, math.rad(diffAngle))
      SetEntityCoords(entity, newCoord.x, newCoord.y, coords.z)
      SetEntityRotation(entity, rotation.x, rotation.y, rotation.z + diffAngle, 2, false)
    end
    self.heading = angle -- Update the heading to the new angle
  end

  self.remove = function()
    if DoesPropSetExist(self.id) then
      DeletePropset(self.id, false, false)
    end
    setmetatable({}, nil)
  end

  local modelHash = GetHashKey(self.model)

  RequestPropset(modelHash)
  while not HasPropsetLoaded(modelHash) do
    Wait(0)
  end

  local propset = CreatePropset(modelHash, coords.x, coords.y, coords.z, 7, self.heading * 1.0, 1200.0, false, true)

  self.id = propset

  if not self.id or self.id < 1 then
    return self
  end

  -- Give the propset time to fully load

  while not IsPropSetFullyLoaded(propset) do
    Wait(100)
  end


  ReleasePropset(modelHash)

  -- Objects spawned as part of a propset are not networked, so clone
  -- those objects into your DB as new, networked objects, then delete
  -- the propset.
  local itemset = CreateItemset(true)
  local size = GetEntitiesFromPropset(self.id, itemset, 0, false, false)

  self.entities = {}
  local offset = vector2(0, 0)
  local _coords = vector3(0, 0, 0)

  if size and size > 0 then
    for i = 0, size - 1 do
      self.entities[#self.entities + 1] = GetIndexedItemInItemset(i, itemset)
      _coords = GetEntityCoords(self.entities[#self.entities])
      offset = offset + _coords.xy
      if networked then
        CloneEntity(self.entities[#self.entities])
      end
    end

    offset = vector2(offset.x / size, offset.y / size) - coords.xy

    for _, entity in pairs(self.entities) do
      coords = GetEntityCoords(entity)
      if not accessories then
        SetEntityCoords(entity, coords.x - offset.x, coords.y - offset.y, coords.z)
      end
      FreezeEntityPosition(entity, true)
    end
  end

  if IsItemsetValid(itemset) then
    DestroyItemset(itemset)
  end

  if self.networked then
    DeletePropset(self.id, false, false)
  end

  return self
end

function ScreenToWorld(distance, flags, toIgnore)
  local camRot = GetGameplayCamRot(0)
  local camPos = GetGameplayCamCoord(0)
  local cursor = vector2(0.5, 0.5)
  local cam3DPos, forwardDir = ScreenRelToWorld(camPos, camRot, cursor)
  cam3DPos = cam3DPos + forwardDir * 0.5
  local direction = camPos + forwardDir * distance
  local rayHandle = StartShapeTestRay(cam3DPos, direction, flags, toIgnore, 0)
  local a, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
  if entityHit >= 1 then
    entityType = GetEntityType(entityHit)
  end
  return hit, endCoords, surfaceNormal, entityHit, entityType, direction
end

function ScreenRelToWorld(camPos, camRot, cursor)
  local camForward = RotationToDirection(camRot)
  local rotUp = vector3(camRot.x + 1.0, camRot.y, camRot.z)
  local rotDown = vector3(camRot.x - 1.0, camRot.y, camRot.z)
  local rotLeft = vector3(camRot.x, camRot.y, camRot.z - 1.0)
  local rotRight = vector3(camRot.x, camRot.y, camRot.z + 1.0)
  local camRight = RotationToDirection(rotRight) - RotationToDirection(rotLeft)
  local camUp = RotationToDirection(rotUp) - RotationToDirection(rotDown)
  local rollRad = -(camRot.y * math.pi / 180.0)
  local camRightRoll = camRight * math.cos(rollRad) - camUp * math.sin(rollRad)
  local camUpRoll = camRight * math.sin(rollRad) + camUp * math.cos(rollRad)
  local point3DZero = camPos + camForward * 1.0
  local point3D = point3DZero + camRightRoll + camUpRoll
  local point2D = World3DToScreen2D(point3D)
  local point2DZero = World3DToScreen2D(point3DZero)
  local scaleX = (cursor.x - point2DZero.x) / (point2D.x - point2DZero.x)
  local scaleY = (cursor.y - point2DZero.y) / (point2D.y - point2DZero.y)
  local point3Dret = point3DZero + camRightRoll * scaleX + camUpRoll * scaleY
  local forwardDir = camForward + camRightRoll * scaleX + camUpRoll * scaleY
  return point3Dret, forwardDir
end

function PlaceOnGroundProperly(entity)
  local x, y, z = table.unpack(GetEntityCoords(entity))
  local found, groundz, normal = GetGroundZAndNormalFor_3dCoord(x, y, z)
  if found then
    SetEntityCoordsNoOffset(entity, x, y, groundz + normal.z, true)
  end
end

function RotationToDirection(rotation)
  local x = rotation.x * math.pi / 180.0
  --local y = rotation.y * math.pi / 180.0
  local z = rotation.z * math.pi / 180.0
  local num = math.abs(math.cos(x))
  return vector3((-math.sin(z) * num), (math.cos(z) * num), math.sin(x))
end

function World3DToScreen2D(pos)
  local _, sX, sY = GetScreenCoordFromWorldCoord(pos.x, pos.y, pos.z)
  return vector2(sX, sY)
end

function CreatePropsetWithMouse(model, flag, distance)
  --Setup promt
  PropsetPreview = {}

  local Origin = GetOffsetFromEntityInWorldCoords(me, 0.0, 1.0, -1.0)
  PropsetPreview = _Propset:new(model, Origin, false, false, 0.0)

  while PropsetPreview ~= nil and PropsetPreview.id == nil do
    Wait(100)
  end

  for _, entity in pairs(PropsetPreview.entities) do
    SetEntityCompletelyDisableCollision(entity, false, false)
    -- Citizen.InvokeNative(0x7DFB49BCDB73089A,entity,true)
    SetEntityAlpha(entity, 170, false)
  end

  local callback = promise.new()
  local previousCoord = Origin

  Citizen.CreateThread(function()
    while true do
      Wait(loopFast)

      DisplayPrompt('placement', "Murphy_camp")

      local hit, targetCoord = ScreenToWorld(distance, flag, me);
      Origin = GetEntityCoords(me)

      if hit and #(targetCoord - Origin) <= distance and #(previousCoord - targetCoord) > 0.025 then
        previousCoord = targetCoord

        PropsetPreview.move(targetCoord)
      end

      if IsControlPressed(0, `INPUT_SELECT_PREV_WEAPON`) then
        local NewAngle = (PropsetPreview.heading - 5 + 360) % 360
        PropsetPreview.rotate(NewAngle)
      end
      if IsControlPressed(0, `INPUT_SELECT_NEXT_WEAPON`) then
        local NewAngle = (PropsetPreview.heading + 5) % 360
        PropsetPreview.rotate(NewAngle)
      end

      if IsPromptCompleted('placement', 'INPUT_FRONTEND_ACCEPT') then
        callback:resolve({
          coords = PropsetPreview.origin,
          heading = PropsetPreview.heading
        })
        PropsetPreview.remove()
        break
      end

      if IsPromptCompleted('placement', 'INPUT_FRONTEND_CANCEL') then
        callback:resolve(nil)
        PropsetPreview.remove()
        break
      end
    end
  end)
  return Citizen.Await(callback)
end

_Prop = {}
function _Prop:new(model, coords, networked)
  local self = {}
  --setmetatable({}, self)
  self.model = model
  self.origin = coords.xyz
  self.networked = networked
  self.heading = 0
  self.rotation = vector3(0, 0, 0)
  self.move = function(NewCoords)
    SetEntityCoords(self.id, NewCoords)
    PlaceEntityOnGroundProperly(self.id) -- Place the prop on the ground properly
    self.origin = NewCoords
  end

  self.rotate = function(angle)
    local rotation, coords
    local diffAngle = self.heading - angle
    if diffAngle < 0 then
      diffAngle = diffAngle + 360
    end

    rotation = GetEntityRotation(self.id, 2)
    coords = GetEntityCoords(self.id)
    newCoord = RotateObject(coords.xy, self.origin.xy, math.rad(diffAngle))
    SetEntityCoords(self.id, newCoord.x, newCoord.y, coords.z)
    SetEntityRotation(self.id, rotation.x, rotation.y, rotation.z + diffAngle, 2, false)
    PlaceEntityOnGroundProperly(self.id) -- Place the prop on the ground properly
    self.heading = angle
    self.rotation = vector3(rotation.x, rotation.y, rotation.z + diffAngle)
  end

  self.remove = function()
    SetEntityAsMissionEntity(self.id)
    DeleteObject(self.id)
    setmetatable({}, nil)
  end

  local modelHash = GetHashKey(self.model)

  RequestModel(modelHash)
  while not HasModelLoaded(modelHash) do Wait(0) end

  local prop = CreateObject(model, coords.x, coords.y, coords.z, false, true, false)
  PlaceEntityOnGroundProperly(prop) -- Place the prop on the ground properly
  self.id = prop

  if not self.id or self.id < 1 then
    return self
  end



  -- Objects spawned as part of a propset are not networked, so clone
  -- those objects into your DB as new, networked objects, then delete
  -- the propset.

  return self
end

function CreatePropWithMouse(model, flag, distance)
  --Setup promt
  PropPreview = {}

  local Origin = GetOffsetFromEntityInWorldCoords(me, 0.0, 1.0, -1.0)
  PropPreview = _Prop:new(model, Origin, false)

  while PropPreview ~= nil and PropPreview.id == nil do
    Wait(100)
  end

  SetEntityCompletelyDisableCollision(PropPreview.id, false, false)
  -- Citizen.InvokeNative(0x7DFB49BCDB73089A,PropPreview.id,true)
  SetEntityAlpha(PropPreview.id, 170, false)

  local callback = promise.new()
  local previousCoord = Origin

  Citizen.CreateThread(function()
    while true do
      Wait(0)

      DisplayPrompt('placement', "Murphy_camp")
      local hit, targetCoord = ScreenToWorld(distance, flag, me);
      Origin = GetEntityCoords(me)

      if hit and #(targetCoord - Origin) <= distance and #(previousCoord - targetCoord) > 0.025 then
        previousCoord = targetCoord

        PropPreview.move(targetCoord)
      end

      if IsControlPressed(0, `INPUT_SELECT_PREV_WEAPON`) then
        local NewAngle = (PropPreview.heading - 5 + 360) % 360
        PropPreview.rotate(NewAngle)
      end
      if IsControlPressed(0, `INPUT_SELECT_NEXT_WEAPON`) then
        local NewAngle = (PropPreview.heading + 5) % 360
        PropPreview.rotate(NewAngle)
      end

      if IsPromptCompleted('placement', 'INPUT_FRONTEND_ACCEPT') then
        callback:resolve({
          coords = PropPreview.origin,
          heading = PropPreview.rotation
        })
        PropPreview.remove()
        break
      end

      if IsPromptCompleted('placement', 'INPUT_FRONTEND_CANCEL') then
        callback:resolve(nil)
        PropPreview.remove()
        break
      end
    end
  end)
  return Citizen.Await(callback)
end

GetTownNameAtCoords = function(coords)
  local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, coords, 1)
  if town_hash == GetHashKey("Annesburg") then
    return "Annesburg"
  elseif town_hash == GetHashKey("Annesburg") then
    return "Annesburg"
  elseif town_hash == GetHashKey("Armadillo") then
    return "Armadillo"
  elseif town_hash == GetHashKey("Blackwater") then
    return "Blackwater"
  elseif town_hash == GetHashKey("BeechersHope") then
    return "BeechersHope"
  elseif town_hash == GetHashKey("Braithwaite") then
    return "Braithwaite"
  elseif town_hash == GetHashKey("Butcher") then
    return "Butcher"
  elseif town_hash == GetHashKey("Caliga") then
    return "Caliga"
  elseif town_hash == GetHashKey("cornwall") then
    return "Cornwall"
  elseif town_hash == GetHashKey("Emerald") then
    return "Emerald"
  elseif town_hash == GetHashKey("lagras") then
    return "lagras"
  elseif town_hash == GetHashKey("Manzanita") then
    return "Manzanita"
  elseif town_hash == GetHashKey("Rhodes") then
    return "Rhodes"
  elseif town_hash == GetHashKey("Siska") then
    return "Siska"
  elseif town_hash == GetHashKey("StDenis") then
    return "SaintDenis"
  elseif town_hash == GetHashKey("Strawberry") then
    return "Strawberry"
  elseif town_hash == GetHashKey("Tumbleweed") then
    return "Tumbleweed"
  elseif town_hash == GetHashKey("valentine") then
    return "Valentine"
  elseif town_hash == GetHashKey("VANHORN") then
    return "Vanhorn"
  elseif town_hash == GetHashKey("Wallace") then
    return "Wallace"
  elseif town_hash == GetHashKey("wapiti") then
    return "Wapiti"
  elseif town_hash == GetHashKey("AguasdulcesFarm") then
    return "AguasdulcesFarm"
  elseif town_hash == GetHashKey("AguasdulcesRuins") then
    return "AguasdulcesRuins"
  elseif town_hash == GetHashKey("AguasdulcesVilla") then
    return "AguasdulcesVilla"
  elseif town_hash == GetHashKey("Manicato") then
    return "Manicato"
  else
    return false
  end
end

---@param location table the location of the blip
---@param name string name of the blip
---@param sprite string sprite of the blip
---@param blipHash? integer the type of blip
---@param color? string the blip color
---@return integer blip the blip ID
function Createblip(location, name, sprite, blipHash, color)
  if not blipHash then blipHash = 1664425300 end
  if type(sprite) == "string" then sprite = joaat(sprite) end
  local blip = BlipAddForCoords(blipHash, location.x, location.y, location.z)
  SetBlipSprite(blip, sprite)
  SetBlipName(blip, name)
  if color then
    BlipAddModifier(blip, GetHashFromString(color))
  end
  return blip
end

function RemoveEverything(k, v)
  if v.campfire.entity then
    exports.murphy_interact:RemoveInteraction(v.campfire.interacthandle, v.campfire.interacthandle)
    v.campfire.accessgranted = false
    if SpawnedSmoke[k] then
      -- print("^2[Camp]^0 Smoke for camp with ID: " .. tostring(campid) .. " exists, removing it.")
      if Citizen.InvokeNative(0x9DD5AFF561E88F2A, SpawnedSmoke[k]) then      -- DoesParticleFxLoopedExist
        Citizen.InvokeNative(0x459598F579C98929, SpawnedSmoke[k], false)     -- RemoveParticleFx
      end
      SpawnedSmoke[k] = nil
    end
    if type(v.campfire.entity) == "table" then
      for _, entity in pairs(v.campfire.entity) do
        DeletePropset(entity, false, false)
      end
    else
      SetEntityAsMissionEntity(v.campfire.entity)
      DeleteObject(v.campfire.entity)
    end
    v.campfire.entity = nil
    Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(v.campfire.veg), 0) -- REMOVE_VEG_MODIFIER_SPHERE
    v.campfire.veg = nil
    if v.campfire.murphy_craft then
      TriggerEvent("murphy_craft:RemoveCraftTable", v.campfire.murphy_craft)
    end
    -- RemoveBlip(v.campfire.blip)
    -- v.campfire.blip = nil
    for key, data in pairs(v.props) do
      exports.murphy_interact:RemoveInteraction(data.interacthandle, data.interacthandle)
      data.accessgranted = false
      if data.murphy_craft then
        TriggerEvent("murphy_craft:RemoveCraftTable", data.murphy_craft)
      end
      local crafttable =
      {
        name = "Feu de camp",                                          -- Blip name
        cat = { "food" },                                              -- Categories available at this crafting table
        coords = vector3(data.coords.x, data.coords.y, data.coords.z), -- Coordinates of the crafting table
        radius = 5.0,                                                  -- Radius around the crafting table where players have access to those categories

      }
      if data.entity then
        if type(data.entity) == "table" then
          for _, entity in pairs(data.entity) do
            SetEntityAsMissionEntity(entity)
            DeletePropset(entity, false, false)
          end
        else
          SetEntityAsMissionEntity(data.entity)
          DeleteObject(data.entity)
        end
        data.entity = nil
      end
      Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(data.veg), 0) -- REMOVE_VEG_MODIFIER_SPHERE
      data.veg = nil
    end
  end
end
