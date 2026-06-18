--- Hooks: post-processing extension points for entity creation
-- Override these to attach custom logic after dd_gamemaster creates entities.
-- @class Hooks
-- @field onPedCreated function
-- @field onObjectCreated function
-- @field onVehicleCreated function
Hooks = Hooks or {}

--- Called after a ped is created by dd_gamemaster
-- @param ped (entity id)
-- @param data: model (string|hash), modelHash (number), x,y,z (number), heading (number), isNetworked (boolean)
function Hooks.onPedCreated(ped, data)
  --Bridge.Debug('onPedCreated', ped, json.encode(data))

  -- if you use POS-Zombie all peds need to have a special decorator to not get deleted by the POS-Zombie script when spawning them in the zombie zones
  --DecorSetBool(ped, 'ZombieProtected', true)
end

--- Called after an object is created by dd_gamemaster
-- @param obj (entity id)
-- @param data: model (string|hash), modelHash (number), x,y,z (number), rx, ry, rz (number), isNetworked (boolean)
function Hooks.onObjectCreated(obj, data)
  --Bridge.Debug('onObjectCreated', obj, json.encode(data))
end

--- Called after a vehicle is created by dd_gamemaster
-- @param veh (entity id)
-- @param data: model (string|hash), modelHash (number), x,y,z (number), heading (number), isNetworked (boolean)
function Hooks.onVehicleCreated(veh, data)
  --Bridge.Debug('onVehicleCreated', veh, json.encode(data))
end

function Hooks.onImpersonate(targetPed, data)
  --Bridge.Debug('onImpersonate', targetPed, json.encode(data))
  -- add custom logic here like stopping a script or doing something or healing the player or anything else
end

function Hooks.onRevertImpersonate(data)
  --Bridge.Debug('onRevertImpersonate', json.encode(data))
end