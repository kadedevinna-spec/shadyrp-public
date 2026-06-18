--- Face cam + world-coordinate showcase slots per store (`config.cameras.catalog`, `config.displayCase`).

local storeFaceCam = nil

local displayCache = {}
local spawnPending = {}
local displayProp = nil
local displayPropKey = nil
local displayBaseEuler = { x = 0.0, y = 0.0, z = 0.0 }
local displayDragEuler = { x = 0.0, y = 0.0, z = 0.0 }

local lastStoreCamEaseOut = 700

local CREATE_WEAPON_OBJECT = 0x9541D3CF0D398F36

local function clamp(v, lo, hi)
    if v < lo then return lo end
    if v > hi then return hi end
    return v
end

local function cfgVec3(v)
    if not v then return nil end
    local x = v.x or v.X
    if x == nil then return nil end
    return vector3(tonumber(x) or 0.0, tonumber(v.y or v.Y) or 0.0, tonumber(v.z or v.Z) or 0.0)
end

local function visualStoreId(storeId)
    if GS_GetVisualStoreId then
        return GS_GetVisualStoreId(storeId)
    end
    return storeId
end

--- cameras.catalog pest-style: coords (world) + heading (yaw) + pitch + fov + eases (required coords + heading).
--- Legacy fallback: `.camera` with same keys.
local function mergedCamera(storeId)
    local cfgStoreId = visualStoreId(storeId)
    local st = Config.Stores and Config.Stores[cfgStoreId]
    local camRoot = st and st.cameras
    local sc = camRoot and type(camRoot.catalog) == 'table' and camRoot.catalog or nil
    if not sc and st and type(st.camera) == 'table' then
        sc = st.camera
    end
    if type(sc) ~= 'table' then
        print(('^3[general_store]^0 Missing cameras.catalog for store %q.'):format(tostring(cfgStoreId)))
        return nil
    end
    local coords = cfgVec3(sc.coords)
    if not coords then
        print(('^3[general_store]^0 cameras.catalog.coords (vector3) required for store %q.'):format(tostring(cfgStoreId)))
        return nil
    end
    local heading = tonumber(sc.heading)
    if heading == nil then
        print(('^3[general_store]^0 cameras.catalog.heading required for store %q.'):format(tostring(cfgStoreId)))
        return nil
    end
    return {
        coords = coords,
        heading = heading,
        pitch = tonumber(sc.pitch) or -7.5,
        fov = tonumber(sc.fov) or 42.5,
        easeIn = tonumber(sc.easeIn) or 950,
        easeOut = tonumber(sc.easeOut) or 700,
    }
end

--- World slot for showcase prop (coords + euler). Each store defines weapon + object.
local function mergedDisplayCase(storeId, kind)
    local cfgStoreId = visualStoreId(storeId)
    local st = Config.Stores and Config.Stores[cfgStoreId]
    local root = st and st.displayCase
    if type(root) ~= 'table' then
        print(('^3[general_store]^0 Missing displayCase for store %q.'):format(tostring(cfgStoreId)))
        return {
            coords = vector3(0.0, 0.0, 0.0),
            rotation = { x = 0.0, y = 0.0, z = 0.0 },
            validSlot = false,
        }
    end
    local def = root[kind]
    if type(def) ~= 'table' then
        print(('^3[general_store]^0 Missing displayCase.%s for store %q.'):format(kind, tostring(cfgStoreId)))
        return { coords = vector3(0, 0, 0), rotation = { x = 0.0, y = 0.0, z = 0.0 }, validSlot = false }
    end
    local c = cfgVec3(def.coords)
    if not c then
        print(
            ('^3[general_store]^0 displayCase.%s.coords (vector3) required for store %q.'):format(kind, tostring(cfgStoreId))
        )
        return { coords = vector3(0, 0, 0), rotation = { x = 0.0, y = 0.0, z = 0.0 }, validSlot = false }
    end
    local rot = type(def.rotation) == 'table' and def.rotation or {}
    return {
        coords = c,
        rotation = {
            x = tonumber(rot.x) or tonumber(rot.X) or 0.0,
            y = tonumber(rot.y) or tonumber(rot.Y) or 0.0,
            z = tonumber(rot.z) or tonumber(rot.Z) or 0.0,
        },
        validSlot = true,
    }
end

local function gsLoadModel(modelHash)
    if not modelHash or modelHash == 0 then return false end
    RequestModel(modelHash, false)
    local deadline = GetGameTimer() + 10000
    while not HasModelLoaded(modelHash) do
        if GetGameTimer() > deadline then return false end
        Wait(10)
    end
    return true
end

function GS_KillPreviousShopCamNow()
    if not storeFaceCam then return end
    local cam = storeFaceCam
    storeFaceCam = nil
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam, false)
end

--- Smooth blend out — call when closing the catalog UI
function GS_DestroyStoreFaceCam()
    if not storeFaceCam then return end
    local cam = storeFaceCam
    storeFaceCam = nil
    local easeOut = lastStoreCamEaseOut or 700
    RenderScriptCams(false, true, easeOut, true, false)
    SetTimeout(easeOut, function()
        if cam then
            DestroyCam(cam, false)
        end
    end)
end

--- @param _ped unused (kept for call-site compat)
--- @param storeId Config.Stores key
function GS_CreateStoreFaceCam(_ped, storeId)
    GS_KillPreviousShopCamNow()

    local camCfg = mergedCamera(storeId)
    if not camCfg then return end

    lastStoreCamEaseOut = camCfg.easeOut or 700

    local coords = camCfg.coords
    local pitch = camCfg.pitch or -7.5
    local yaw = camCfg.heading or 0.0
    local fov = camCfg.fov or 42.5
    local easeIn = camCfg.easeIn or 950

    CreateThread(function()
        local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        storeFaceCam = cam
        SetCamCoord(cam, coords.x, coords.y, coords.z)
        SetCamRot(cam, pitch, 0.0, yaw, 2)
        SetCamFov(cam, fov)
        SetCamActive(cam, true)
        Wait(0)
        RenderScriptCams(true, true, easeIn, true, false)
    end)
end

local function setHiddenShowcase(ent)
    if not ent or ent == 0 or not DoesEntityExist(ent) then return end
    SetEntityAlpha(ent, 0, false)
end

local function setVisibleShowcase(ent)
    if not ent or ent == 0 or not DoesEntityExist(ent) then return end
    ResetEntityAlpha(ent)
    SetEntityAlpha(ent, 255, false)
end


local function setDisplayGeometry(ent, coords, euler)
    if not ent or ent == 0 then return end
    SetEntityAsMissionEntity(ent, true, true)
    FreezeEntityPosition(ent, true)
    SetEntityCoordsNoOffset(ent, coords.x, coords.y, coords.z, false, false, false)
    SetEntityCollision(ent, false, false)
    SetEntityRotation(ent, euler.x, euler.y, euler.z, 2, true)
end

local function resolveWeaponPropKey(raw)
    local wmap = Config.WeaponModels or {}
    if type(raw) ~= 'string' then return joaat(tostring(raw or '')) end
    local key = raw:lower()
    local mapped = wmap[key] or wmap[raw]
    if mapped then
        return joaat(mapped)
    end
    local h = joaat(key)
    if h ~= 0 then return h end
    return joaat(raw)
end

local function spawnWeaponObject(coords, weaponHash)
    local obj = Citizen.InvokeNative(CREATE_WEAPON_OBJECT, weaponHash, 0, coords.x, coords.y, coords.z, true, 1.0, 0)
    if obj and tonumber(obj) and tonumber(obj) ~= 0 and DoesEntityExist(obj) then
        return tonumber(obj)
    end
    return 0
end

local function displayKindFor(typeStr)
    if type(typeStr) == 'string' and typeStr:lower() == 'weapon' then return 'weapon' end
    return 'object'
end

function GS_ClearDisplayPropOnly()
    if displayProp and displayProp ~= 0 and DoesEntityExist(displayProp) then
        setHiddenShowcase(displayProp)
    end
    displayProp = nil
    displayPropKey = nil
    displayDragEuler = { x = 0.0, y = 0.0, z = 0.0 }
    displayBaseEuler = { x = 0.0, y = 0.0, z = 0.0 }
end

function GS_ClearDisplayCache()
    for _, ent in pairs(displayCache) do
        if type(ent) == 'number' and ent ~= 0 and DoesEntityExist(ent) then
            SetEntityAsMissionEntity(ent, true, true)
            DeleteEntity(ent)
        end
    end
    displayCache = {}
    spawnPending = {}
    displayProp = nil
    displayPropKey = nil
    displayDragEuler = { x = 0.0, y = 0.0, z = 0.0 }
    displayBaseEuler = { x = 0.0, y = 0.0, z = 0.0 }
end

--- World euler for prop; optional catalog `propRotation` overrides components (no NPC blend).
local function displayEuler(dc, customRot)
    local ex = dc.rotation.x
    local ey = dc.rotation.y
    local ez = dc.rotation.z
    if type(customRot) ~= 'table' then return ex, ey, ez end
    if customRot.x ~= nil then ex = tonumber(customRot.x) elseif customRot.X ~= nil then ex = tonumber(customRot.X) end
    if customRot.y ~= nil then ey = tonumber(customRot.y) elseif customRot.Y ~= nil then ey = tonumber(customRot.Y) end
    if customRot.z ~= nil then ez = tonumber(customRot.z) elseif customRot.Z ~= nil then ez = tonumber(customRot.Z) end
    return ex or 0.0, ey or 0.0, ez or 0.0
end

--- Modular per-store: uses that store's `displayCase.[kind].coords` (world).
function GS_ShowcaseSpawn(storeId, propKey, propTypeStr, propRotationOverride)
    if type(storeId) ~= 'string' or storeId == '' or not propKey or propKey == '' then
        GS_ClearDisplayPropOnly()
        return
    end

    local kind = displayKindFor(propTypeStr)
    local dc = mergedDisplayCase(storeId, kind)
    if not dc.validSlot then
        GS_ClearDisplayPropOnly()
        return
    end

    local rx, ry, rz = displayEuler(dc, propRotationOverride)
    displayBaseEuler = { x = rx, y = ry, z = rz }
    displayDragEuler = { x = 0.0, y = 0.0, z = 0.0 }

    local cacheKey = storeId .. '|' .. kind .. '|' .. tostring(propKey)

    if displayProp and displayProp ~= 0 and DoesEntityExist(displayProp) and cacheKey ~= displayPropKey then
        setHiddenShowcase(displayProp)
    end

    local cached = displayCache[cacheKey]
    if cached and cached ~= 0 and DoesEntityExist(cached) then
        displayProp = cached
        displayPropKey = cacheKey
        setVisibleShowcase(displayProp)
        local dcFresh = mergedDisplayCase(storeId, kind)
        if dcFresh.validSlot then
            local ex, ey, ez = displayEuler(dcFresh, propRotationOverride)
            displayBaseEuler = { x = ex, y = ey, z = ez }
            displayDragEuler = { x = 0.0, y = 0.0, z = 0.0 }
            setDisplayGeometry(displayProp, dcFresh.coords, displayBaseEuler)
        end
        return
    end

    if spawnPending[cacheKey] then return end
    spawnPending[cacheKey] = true

    CreateThread(function()
        local dc2 = mergedDisplayCase(storeId, kind)
        if not dc2.validSlot then
            spawnPending[cacheKey] = nil
            return
        end
        local coords = dc2.coords
        local ex, ey, ez = displayEuler(dc2, propRotationOverride)

        local ent = 0
        if kind == 'weapon' then
            ent = spawnWeaponObject(coords, resolveWeaponPropKey(propKey))
        end
        if ent == 0 then
            local oh = joaat(propKey)
            if gsLoadModel(oh) then
                ent = CreateObject(oh, coords.x, coords.y, coords.z, false, false, false, false, false)
                if type(ent) == 'number' and ent ~= 0 then SetEntityAsMissionEntity(ent, true, true) end
            end
        end

        if ent == 0 or not DoesEntityExist(ent) then
            spawnPending[cacheKey] = nil
            return
        end

        displayCache[cacheKey] = ent
        if displayProp and displayProp ~= 0 and displayProp ~= ent and DoesEntityExist(displayProp) then
            setHiddenShowcase(displayProp)
        end
        displayProp = ent
        displayPropKey = cacheKey
        displayBaseEuler = { x = ex, y = ey, z = ez }
        displayDragEuler = { x = 0.0, y = 0.0, z = 0.0 }
        setDisplayGeometry(ent, coords, displayBaseEuler)
        setVisibleShowcase(ent)
        spawnPending[cacheKey] = nil
    end)
end

function GS_ShowcaseRotate(dyaw, dpitch)
    if not displayProp or displayProp == 0 or not DoesEntityExist(displayProp) then return end

    local s = Config.DisplayDragSensitivity or { yaw = 0.65, pitch = 0.65 }
    local wy = tonumber(dyaw) or 0.0
    local px = tonumber(dpitch) or 0.0

    displayDragEuler.z = displayDragEuler.z + wy * (s.yaw or 0.65)
    displayDragEuler.x =
        clamp(displayDragEuler.x - px * (s.pitch or 0.65), -88.0, 88.0)

    SetEntityRotation(
        displayProp,
        displayBaseEuler.x + displayDragEuler.x,
        displayBaseEuler.y + displayDragEuler.y,
        displayBaseEuler.z + displayDragEuler.z,
        2,
        true
    )
end

function GS_TeardownAll()
    GS_KillPreviousShopCamNow()
    GS_ClearDisplayCache()
end
