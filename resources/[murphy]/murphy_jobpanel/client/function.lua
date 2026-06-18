function tableContains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function LoadAnim(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
end

---@param location table the location of the blip
---@param name string name of the blip
---@param sprite string sprite of the blip
---@param blipHash? integer the type of blip
---@param color? string the blip color
---@return integer blip the blip ID
function CreateBlip(location, name, sprite, blipHash, color)
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

---@param location table the location of the blip
---@param radius number the radius of the blip
---@param name string name of the blip
---@param sprite string sprite of the blip
---@param blipHash? integer the type of blip
---@param color? string the blip color
---@return integer blip the blip ID
function CreateBlipRadius(location, radius, name, sprite, blipHash, color)
    if not blipHash then blipHash = 1664425300 end
    if type(sprite) == "string" then sprite = joaat(sprite) end
    local blip = BlipAddForRadius(blipHash, location.x, location.y, location.z, radius)
    SetBlipSprite(blip, sprite)
    SetBlipName(blip, name)
    if color then
      BlipAddModifier(blip, GetHashFromString(color))
    end
    return blip
end

---@param entity integer the location of the blip
---@param name string name of the blip
---@param blipHash? integer the type of blip
---@param color? string the blip color
---@param sprite? integer the blip sprite
---@return integer blip the blip ID
function CreateBlipEntity(entity, name, blipHash, color, sprite)
    if not blipHash then blipHash = 1664425300 end
    if type(sprite) == "string" then sprite = joaat(sprite) end
    local blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, blipHash, entity)
    SetBlipSprite(blip, sprite)
    SetBlipName(blip, name)
    if color then
      BlipAddModifier(blip, GetHashFromString(color))
    end
    return blip
end
  
function GetHashFromString(value)
if type(value) == "string" then
    local number = tonumber(value)
    if number then return number end
    return joaat(value)
end
return value
end

function PlacePedOnGroundProperly(ped)
	local x, y, z = table.unpack(GetEntityCoords(ped))
	local found, groundz, normal = GetGroundZAndNormalFor_3dCoord(x, y, z)
	if found then
		SetEntityCoordsNoOffset(ped, x, y, groundz + normal.z, true)
	end
end

animation = {}

animation.easeIn = 4.0
animation.easeOut = -4.

function animation.load(dict,waiter)
  if HasAnimDictLoaded(dict) then return end
  RequestAnimDict(dict)
  while waiter and not HasAnimDictLoaded(dict) do
    Wait(10)
  end
end

function animation.play(ped,dict,name,duration,flag,offset)
  if not duration then duration = -1 end
  if not flag then flag = 0 end
  if not offset then offset = 0.0 end
  animation.load(dict,true)
  TaskPlayAnim(ped, dict, name, animation.easeIn, animation.easeOut, duration, flag, offset, false, false, false)
  return GetAnimDuration(dict, name)*1000
end

---@param ped integer
---@param coords vector (vec3 or vec4)
---@param speed? number (default : 1.0)
---@param waiter? boolean (default: true if (coords == vec4) else false)
---@param distanceToStop? number Distance to accept the player is arrived
function animation.goToCoords(ped,coords,speed,waiter,distanceToStop)
  speed = speed or 1.0
  if waiter or type(coords) == "vector4" then
    local sequence = OpenSequenceTask(math.random(1000))
      TaskGoToCoordAnyMeans(0,coords.xyz,speed, 0, 0, 0, 0.1)
    CloseSequenceTask(sequence)
    ClearPedTasks(ped)
    TaskPerformSequence(ped,sequence)
    ClearSequenceTask(sequence)

    Wait(500)
    repeat
      Wait(0)
    until GetSequenceProgress(ped) == -1 or (distanceToStop and #(GetEntityCoords(ped) - coords.xyz) < distanceToStop)
    
    if type(coords) == "vector4" then
      animation.setDesiredHeading(ped,coords.w,true)
    end
  else
    TaskGoToCoordAnyMeans(ped,coords.xyz,speed, 0, 0, 0, 0.1)
  end
end

---@param ped integer
---@param heading number
---@param waiter? boolean default: true
function animation.setDesiredHeading(ped,heading,waiter)
  if waiter == nil then waiter = true end
  TaskAchieveHeading(ped,heading%360,10000)

  if waiter then
    Wait(1000)
    while not IsPedStill(ped) do
      Wait(100)
    end
  end
end

filename = function()
  local info = debug.getinfo(2, "S")
  local str = info.source:sub(2)
  return str:match("^.*/(.*).lua$") or str
end

  -- Function to load an animation dictionary
  function LoadAnim(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(1)
    end
end

function play_ambient_speech_from_entity(entity_id, sound_ref_string, sound_name_string, speech_params_string, speech_line)
  local struct = DataView.ArrayBuffer(128)
  local sound_name = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", sound_name_string, Citizen.ResultAsLong())
  local sound_ref = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", sound_ref_string, Citizen.ResultAsLong())
  local speech_params = GetHashKey(speech_params_string)
  local sound_name_BigInt = DataView.ArrayBuffer(16)
  sound_name_BigInt:SetInt64(0, sound_name)
  local sound_ref_BigInt = DataView.ArrayBuffer(16)
  sound_ref_BigInt:SetInt64(0, sound_ref)
  local speech_params_BigInt = DataView.ArrayBuffer(16)
  speech_params_BigInt:SetInt64(0, speech_params)
  struct:SetInt64(0, sound_name_BigInt:GetInt64(0))
  struct:SetInt64(8, sound_ref_BigInt:GetInt64(0))
  struct:SetInt32(16, speech_line)
  struct:SetInt64(24, speech_params_BigInt:GetInt64(0))
  struct:SetInt32(32, 0)
  struct:SetInt32(40, 1)
  struct:SetInt32(48, 1)
  struct:SetInt32(56, 1)
  Citizen.InvokeNative(0x8E04FEDD28D42462, entity_id, struct:Buffer())
end


RegisterNetEvent('murphy_jobpanel:ShowObjective')
AddEventHandler('murphy_jobpanel:ShowObjective', function(text, duration)
    ShowObjective(tostring(text), tonumber(duration))
end)

ShowObjective = function(text, duration)
  Citizen.InvokeNative("0xDD1232B332CBB9E7", 3, 1, 0)
  local string1 = CreateVarString(10, "LITERAL_STRING", text)
  local struct1 = DataView.ArrayBuffer(8*7)
  local struct2 = DataView.ArrayBuffer(8*3)
  struct1:SetInt32(8*0,duration)
  --struct1:SetInt64(8*1,bigInt(sound_dict))
  --struct1:SetInt64(8*2,bigInt(sound))
  struct2:SetInt64(8*1,bigInt(string1))

  Citizen.InvokeNative(0xCEDBF17EFCC0E4A4,struct1:Buffer(),struct2:Buffer(),1)
end

---@param action string
---@param soundset string
function PlaySound(action, soundset) 
  PlaySoundFrontend(action, soundset, true, 0)
end

function GetClosestPlayer(coords)
  local players = GetActivePlayers()
  local closestPlayer = nil
  local closestDistance = -1

  for _, playerId in ipairs(players) do
      local playerPed = GetPlayerPed(playerId)
      local playerCoords = GetEntityCoords(playerPed)
      local distance = #(coords - playerCoords)

      if closestDistance == -1 or distance < closestDistance then
          closestPlayer = playerId
          closestDistance = distance
      end
  end

  return closestPlayer, GetEntityCoords(GetPlayerPed(closestPlayer))
end