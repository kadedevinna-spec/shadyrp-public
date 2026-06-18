-- local objectHash = GetHashKey("mp001_p_cratetwin01x")
-- RequestModel(objectHash)
-- local screenX, screenY = 0.5, 0.5 -- Center of the screen
-- local worldVector, normalVector = GetWorldCoordFromScreenCoord(screenX, screenY)
--  x, y, z = table.unpack(worldVector)

-- -- Get the camera's forward vector
-- local camRot = GetGameplayCamRot(2)
-- local camForward = vector3(
--     -math.sin(math.rad(camRot.z)) * math.abs(math.cos(math.rad(camRot.x))),
--     math.cos(math.rad(camRot.z)) * math.abs(math.cos(math.rad(camRot.x))),
--     math.sin(math.rad(camRot.x))
-- )

-- -- Offset the spawn position in front of the camera
-- local offset = 5.0 -- Distance in front of the camera
-- local spawnPos = vector3(
--     x + camForward.x * offset,
--     y + camForward.y * offset,
--     z + camForward.z * offset
-- )
-- while not HasModelLoaded(objectHash) do
--     Wait(1)
-- end
-- local object = CreateObject(objectHash, spawnPos.x, spawnPos.y, spawnPos.z, true, true, false)
-- Citizen.CreateThread(function()
--     while true do
--         Wait(10)
--         local screenX, screenY = 0.5, 0.5 -- Center of the screen
--         local worldVector, normalVector = GetWorldCoordFromScreenCoord(screenX, screenY)
--          x, y, z = table.unpack(worldVector)
        
--         -- Get the camera's forward vector
--         local camRot = GetGameplayCamRot(2)
--         local camForward = vector3(
--             -math.sin(math.rad(camRot.z)) * math.abs(math.cos(math.rad(camRot.x))),
--             math.cos(math.rad(camRot.z)) * math.abs(math.cos(math.rad(camRot.x))),
--             math.sin(math.rad(camRot.x))
--         )
        
--         -- Offset the spawn position in front of the camera
--         local offset = 5.0 -- Distance in front of the camera
--         local spawnPos = vector3(
--             x + camForward.x * offset,
--             y + camForward.y * offset,
--             z + camForward.z * offset
--         )
        

--         SetEntityCollision(object, false, false)
--         SetEntityAlpha(object, 200, false)
--         -- SetEntityScale(object, 0.5, 0.5, 0.5) -- Scale down the object
--         Citizen.InvokeNative(0x445D7D8EA66E373E, object, spawnPos.x, spawnPos.y, spawnPos.z, 0, 0, 0, -1, true, 0, 0, 0, 0, 0)
--     end
-- end)

