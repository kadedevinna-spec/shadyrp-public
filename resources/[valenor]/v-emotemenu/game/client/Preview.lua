local PREVIEW_FORWARD           =  -1.6
local PREVIEW_LATERAL           = 0.2
local PREVIEW_ALPHA             = 150

local ClonePreviewState = {
  single = nil,
  couple = { a = nil, b = nil },
  props  = {},
  loop   = {}
}

local function ClonePreviewStopAllLoops()
  for ped, node in pairs(ClonePreviewState.loop) do
    if node.active then node.active = false end
  end
  ClonePreviewState.loop = {}
end

local function ClonePreviewGetOffsetPosYaw(anchorEntity, offY, offX, offZ, groundSnapWhenZero)
  local base = GetEntityCoords(anchorEntity)
  local heading = GetEntityHeading(anchorEntity)
  local rad = math.rad(heading)

  local fx = math.sin(rad)
  local fy = -math.cos(rad)
  local rx = -fy
  local ry =  fx

  local x = base.x + (offY or 0.0) * fx + (offX or 0.0) * rx
  local y = base.y + (offY or 0.0) * fy + (offX or 0.0) * ry
  local z

  local zOff = tonumber(offZ) or 0.0
  if groundSnapWhenZero and zOff == 0.0 then
    local found, gz = GetGroundZFor_3dCoord(x, y, base.z + 1.0, false)
    z = found and (gz + 0.02) or base.z
  else
    z = base.z + zOff
  end

  return vector3(x, y, z)
end


local function ClonePreviewStartEmoteLoop(ped, emoteName)
  local node = ClonePreviewState.loop[ped]
  if node and node.active then node.active = false end
  node = { active = true, name = emoteName }
  ClonePreviewState.loop[ped] = node
  Citizen.CreateThread(function()
    while node.active and DoesEntityExist(ped) do
      Citizen.Wait(4500)
      if not DoesEntityExist(ped) or not node.active then break end
      TaskEmote(ped, 0, 2, GetHashKey(node.name), true, true, true, true, true)
      SetPedKeepTask(ped, true)
    end
  end)
end

local function ClonePreviewGetOffsetPos(entity, forwardDist, lateralOffset, extraZ)
  local zOff = tonumber(extraZ) or 0.0
  local fwd = GetEntityForwardVector(entity)
  local fx, fy = fwd.x, fwd.y
  local fmag = math.sqrt(fx*fx + fy*fy); if fmag < 0.001 then fmag = 1.0 end
  fx, fy = fx / fmag, fy / fmag
  local rx, ry = -fy, fx
  local rmag = math.sqrt(rx*rx + ry*ry); if rmag < 0.001 then rmag = 1.0 end
  rx, ry = rx / rmag, ry / rmag
  local base = GetEntityCoords(entity)
  local x = base.x + fx * (forwardDist or 0.0) + rx * (lateralOffset or 0.0)
  local y = base.y + fy * (forwardDist or 0.0) + ry * (lateralOffset or 0.0)
  local z
  if zOff == 0.0 then
    local found, gz = GetGroundZFor_3dCoord(x, y, base.z + 1.0, false)
    z = found and (gz + 0.02) or base.z
  else
    z = base.z + zOff
  end
  return vector3(x, y, z)
end

local function ResolveAnimFlag(loop, movable, stopLastFrame)
  if not loop and not movable and not stopLastFrame then
    return 0
  elseif loop and not movable then
    return 1
  elseif not loop and not movable and stopLastFrame then
    return 2
  elseif not loop and movable and stopLastFrame then
    return 30
  elseif loop and movable then
    return 31
  elseif not loop and movable then
    return 28
  end
  return 0
end

local function ClonePreviewSetPreviewPedFlags(ped, alpha)
  SetEntityInvincible(ped, true)
  SetBlockingOfNonTemporaryEvents(ped, true)
  SetPedCanRagdoll(ped, false)
  SetEntityAlpha(ped, alpha or PREVIEW_ALPHA, false)
  SetEntityCollision(ped, false, false)
  SetEntityNoCollisionEntity(ped, PlayerPedId(), true)
  SetEntityHasGravity(ped, false)
  FreezeEntityPosition(ped, true)
  if SetPedCurrentWeaponVisible then SetPedCurrentWeaponVisible(ped, false, true, true, true) end
end

local function ClonePreviewCloneMyPedAt(coords, heading, alpha)
  local me = PlayerPedId()
  local model = GetEntityModel(me)
  RequestModel(model)
  while not HasModelLoaded(model) do Citizen.Wait(0) end
  local ped
  if ClonePed then
    ped = ClonePed(me, false, false, false)
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, true)
    SetEntityHeading(ped, heading)
  else
    ped = CreatePed(model, coords.x, coords.y, coords.z, heading, false, false, false, false)
  end
  ClonePreviewSetPreviewPedFlags(ped, alpha)
  SetPedAsNoLongerNeeded(ped)
  return ped
end

local function ClonePreviewDeleteEntitySafe(ent)
  if ent and DoesEntityExist(ent) then
    SetEntityAsMissionEntity(ent, true, true)
    DeleteEntity(ent)
  end
end

local function ClonePreviewCleanup()
  ClonePreviewStopAllLoops()
  if ClonePreviewState.single then ClonePreviewDeleteEntitySafe(ClonePreviewState.single) end
  if ClonePreviewState.couple.a then ClonePreviewDeleteEntitySafe(ClonePreviewState.couple.a) end
  if ClonePreviewState.couple.b then ClonePreviewDeleteEntitySafe(ClonePreviewState.couple.b) end
  for _,obj in ipairs(ClonePreviewState.props) do ClonePreviewDeleteEntitySafe(obj) end
  ClonePreviewState.single = nil
  ClonePreviewState.couple = { a = nil, b = nil }
  ClonePreviewState.props  = {}
end

local function RotateOffsetByHeading(offset, heading)
  local rad = math.rad(heading or 0.0)
  local sinHeading = math.sin(rad)
  local cosHeading = math.cos(rad)

  local offX = (offset.x or 0.0)
  local offY = (offset.y or 0.0)
  local offZ = (offset.z or 0.0)

  local rotatedX = offX * cosHeading - offY * sinHeading
  local rotatedY = offX * sinHeading + offY * cosHeading

  return vector3(rotatedX, rotatedY, offZ)
end

local function ClonePreviewCreateProps(ped, propData, attachToPed)
  if not propData then return {} end

  if attachToPed == nil then attachToPed = true end

  local propList = propData
  if propData.propName or propData.propBone or propData.propPosition or propData.propRotation then
    propList = { propData }
  end

  local created = {}
  for _, option in pairs(propList) do
    if option then
      local propName = option.propName
      if propName and propName ~= "" then
        local propHash = GetHashKey(propName)
        if not IsModelValid(propHash) then goto continue end
        RequestModel(propHash)
        while not HasModelLoaded(propHash) do Citizen.Wait(0) end
        local obj = CreateObject(propHash, 0.0, 0.0, 0.0, false, false, false)
        if obj and obj ~= 0 then
          if attachToPed then
            local boneIndex = option.propBone or 60309
            local pos = option.propPosition or vector3(0.0, 0.0, 0.0)
            local rot = option.propRotation or vector3(0.0, 0.0, 0.0)
            AttachEntityToEntity(obj, ped, GetPedBoneIndex(ped, boneIndex), pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, true, true, false, true, 1, true)
            table.insert(created, {
              entity = obj,
              option = option,
              position = nil,
              heading = nil
            })
          else
            local pos = option.propPosition or vector3(0.0, 0.0, 0.0)
            local rot = option.propRotation or vector3(0.0, 0.0, 0.0)
            local pedCoords = GetEntityCoords(ped)
            local pedHeading = GetEntityHeading(ped)
            local rotatedOffset = RotateOffsetByHeading(pos, pedHeading)
            local worldPos = vector3(
              pedCoords.x + rotatedOffset.x,
              pedCoords.y + rotatedOffset.y,
              pedCoords.z + rotatedOffset.z
            )
            SetEntityCoordsNoOffset(obj, worldPos.x, worldPos.y, worldPos.z, false, false, false)
            SetEntityRotation(obj, rot.x or 0.0, rot.y or 0.0, pedHeading + (rot.z or 0.0), 2, true)
            if option.placeOnGround ~= false then
              PlaceObjectOnGroundProperly(obj)
            end
            FreezeEntityPosition(obj, true)
            local finalPos = GetEntityCoords(obj)
            local finalHeading = GetEntityHeading(obj)
            table.insert(created, {
              entity = obj,
              option = option,
              position = finalPos,
              heading = finalHeading
            })
          end
          table.insert(ClonePreviewState.props, obj)
        end
        SetModelAsNoLongerNeeded(propHash)
      end
    end
    ::continue::
  end

  return created
end

local function hasAdvancedPose(d)
  return d and (d.posX or d.posY or d.posZ or d.rotX or d.rotY or d.rotZ)
end

local function ClonePreviewPlayScenario(animationData)
  ClonePreviewCleanup()

  local me = PlayerPedId()
  local heading = GetEntityHeading(me)
  local pos = ClonePreviewGetOffsetPos(me, 1.6, PREVIEW_LATERAL, 0.0)
  local ped = ClonePreviewCloneMyPedAt(pos, heading, PREVIEW_ALPHA)
  ClonePreviewState.single = ped

  local props = ClonePreviewCreateProps(ped, animationData.propOptions or animationData.propOption, false)
  local scenarioPos = GetEntityCoords(ped)
  local scenarioHeading = GetEntityHeading(ped)

  if #props > 0 then
    local primary = props[1]
    if primary.position then scenarioPos = primary.position end
    if primary.heading then scenarioHeading = primary.heading end
  end

  local scenarioHeadingOffset = animationData.scenarioHeadingOffset or 0.0
  local seatOffset = animationData.scenarioSeatOffset or vector3(0.0, 0.0, 0.0)
  local seatWorldOffset = RotateOffsetByHeading(seatOffset, scenarioHeading + scenarioHeadingOffset)
  scenarioPos = vector3(
    scenarioPos.x + seatWorldOffset.x,
    scenarioPos.y + seatWorldOffset.y,
    scenarioPos.z + seatWorldOffset.z
  )
  local scenario = animationData.scenario
  local scenarioHash = scenario
  if type(scenario) == "string" then
    scenarioHash = GetHashKey(scenario)
  end

  TaskStartScenarioAtPosition(
    ped,
    scenarioHash,
    scenarioPos.x,
    scenarioPos.y,
    scenarioPos.z,
    scenarioHeading + scenarioHeadingOffset,
    -1,
    false,
    true
  )
  SetPedKeepTask(ped, true)
end

function ClonePreviewPlayEmote(animationData)
  if animationData and animationData.scenario then
    ClonePreviewPlayScenario(animationData)
    return
  end

  ClonePreviewCleanup()
  local me = PlayerPedId()
  local heading = GetEntityHeading(me)
  local pos = ClonePreviewGetOffsetPos(me, 1.6, PREVIEW_LATERAL, 0.0)
  local ped = ClonePreviewCloneMyPedAt(pos, heading, PREVIEW_ALPHA)
  ClonePreviewState.single = ped

  if animationData.emote then
    local emoteHash = GetHashKey(animationData.emote)
    if string.find(animationData.emote, "KIT_EMOTE") then
      TaskEmote(ped, 0, 2, emoteHash, true, true, true, true, true)
      SetPedKeepTask(ped, true)
      local opt = animationData.options or {}
      if opt.loop then ClonePreviewStartEmoteLoop(ped, animationData.emote) end
    else
      TaskStartScenarioInPlace(ped, emoteHash, 0, true)
      SetPedKeepTask(ped, true)
    end
    return
  end

  if animationData.dict and animationData.name then
    RequestAnimDict(animationData.dict)
    while not HasAnimDictLoaded(animationData.dict) do Citizen.Wait(0) end
    local opt = animationData.options or {}
    local loop = opt.loop or false
    local movable = opt.movable or false
    local stopLast = opt.stop_last_frame or false
    local flag = ResolveAnimFlag(loop, movable, stopLast)
    TaskPlayAnim(ped, animationData.dict, animationData.name, 8.0, 8.0, -1, flag, 0.0, false, false, false)
   SetPedKeepTask(ped, true)
    ClonePreviewCreateProps(ped, animationData.propOptions or animationData.propOption, true)
  end
end

function ClonePreviewPlayCouple(animationData)
  if animationData and animationData.scenario then
    ClonePreviewPlayScenario(animationData)
    return
  end

  ClonePreviewCleanup()

  local me      = PlayerPedId()
  local baseH   = GetEntityHeading(me)

  local playerData = animationData.player or {}
  local targetData = animationData.target or {}

  local pX = tonumber(playerData.posX) or 0.0
  local pY = tonumber(playerData.posY) or 0.0
  local pZ = tonumber(playerData.posZ) or 0.0
  local pRX = tonumber(playerData.rotX) or 0.0
  local pRY = tonumber(playerData.rotY) or 0.0
  local pRZ = tonumber(playerData.rotZ) or 0.0

  local aPos = ClonePreviewGetOffsetPosYaw(me, (PREVIEW_FORWARD or 0.0) + pY, (PREVIEW_LATERAL or 0.0) + pX, pZ, true)
  local aPed = ClonePreviewCloneMyPedAt(aPos, baseH + pRZ, PREVIEW_ALPHA)

  local tX = tonumber(targetData.posX) or 0.35
  local tY = tonumber(targetData.posY) or 0.0
  local tZ = tonumber(targetData.posZ) or 0.0
  local tRX = tonumber(targetData.rotX) or 0.0
  local tRY = tonumber(targetData.rotY) or 0.0
  local tRZ = tonumber(targetData.rotZ) or 0.0

  local bPos = ClonePreviewGetOffsetPosYaw(aPed, tY, tX, tZ, true)
  local bPed = ClonePreviewCloneMyPedAt(bPos, (GetEntityHeading(aPed) + tRZ), PREVIEW_ALPHA)

  ClonePreviewState.couple.a = aPed
  ClonePreviewState.couple.b = bPed

  SetEntityNoCollisionEntity(aPed, bPed, true)
  SetEntityNoCollisionEntity(bPed, aPed, true)

  if ClonePreviewStartPosPin then
    ClonePreviewStartPosPin(aPed, aPos)
    ClonePreviewStartPosPin(bPed, bPos)
  end

  local pOpt  = playerData.options or {}
  local tOpt  = targetData.options or {}
  local pFlag = playerData.flag or ResolveAnimFlag(pOpt.loop or false, pOpt.movable or false, pOpt.stop_last_frame or false)
  local tFlag = targetData.flag or ResolveAnimFlag(tOpt.loop or false, tOpt.movable or false, tOpt.stop_last_frame or false)

  local pDict, pAnim = playerData.dict, playerData.anim
  local tDict, tAnim = targetData.dict, targetData.anim

  if pDict then RequestAnimDict(pDict) end
  if tDict then RequestAnimDict(tDict) end
  while (pDict and not HasAnimDictLoaded(pDict)) or (tDict and not HasAnimDictLoaded(tDict)) do
    Citizen.Wait(0)
  end

  if pDict and pAnim then
    TaskPlayAnimAdvanced(aPed, pDict, pAnim, aPos.x, aPos.y, aPos.z, pRX, pRY, baseH + pRZ, 8.0, 8.0, -1, pFlag, 0.0, 0, 0)
    if playerData.propOptions or playerData.propOption then
      ClonePreviewCreateProps(aPed, playerData.propOptions or playerData.propOption, true)
    end
  elseif playerData.emote then
    local emoteHash = GetHashKey(playerData.emote)
    if string.find(playerData.emote, "KIT_EMOTE") then
      TaskEmote(aPed, 0, 2, emoteHash, true, true, true, true, true)
      SetPedKeepTask(aPed, true)
      if (playerData.options or {}).loop and ClonePreviewStartEmoteLoop then
        ClonePreviewStartEmoteLoop(aPed, playerData.emote)
      end
    else
      TaskStartScenarioInPlace(aPed, emoteHash, 0, true)
      SetPedKeepTask(aPed, true)
    end
  end

  if tDict and tAnim then
    local aH = GetEntityHeading(aPed)
    TaskPlayAnimAdvanced(bPed, tDict, tAnim, bPos.x, bPos.y, bPos.z, tRX, tRY, aH + tRZ, 8.0, 8.0, -1, tFlag, 0.0, 0, 0)
    if targetData.propOptions or targetData.propOption then
      ClonePreviewCreateProps(bPed, targetData.propOptions or targetData.propOption, true)
    end
  elseif targetData.emote then
    local emoteHash = GetHashKey(targetData.emote)
    if string.find(targetData.emote, "KIT_EMOTE") then
      TaskEmote(bPed, 0, 2, emoteHash, true, true, true, true, true)
      SetPedKeepTask(bPed, true)
      if (targetData.options or {}).loop and ClonePreviewStartEmoteLoop then
        ClonePreviewStartEmoteLoop(bPed, targetData.emote)
      end
    else
      TaskStartScenarioInPlace(bPed, emoteHash, 0, true)
      SetPedKeepTask(bPed, true)
    end
  end
end


function ClonePreviewStop()
  ClonePreviewCleanup()
end

RegisterNUICallback('animationPreview', function(data, cb)
  ClonePreviewStop()
  local category = data.category
  local animationData = data.animationData
  if category == "Expressions" or category == "Walks" then
    ClonePreviewPlayEmote(animationData)
  elseif category == "Couple" or category == "Erotic" or category == "Love" or category == "Dance" or category == "Romance" then
    ClonePreviewPlayCouple(animationData)
  else
    ClonePreviewPlayEmote(animationData)
  end
  cb('ok')
end)

RegisterNUICallback('stopPreview', function(_, cb)
  ClonePreviewStop()
  cb('ok')
end)
