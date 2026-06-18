Framework = "none"
FXTarget  = { system = nil }

if GetResourceState('rsg-core') == 'started' then
    Framework = "RSG"
    print("^2[INFO]^0 Framework selected: ^3" .. Framework .. "^0")
elseif GetResourceState('vorp_core') == 'started' then
    Framework = "VORP"
    print("^2[INFO]^0 Framework selected: ^3" .. Framework .. "^0")
else
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2000)
            print("^1[ERROR]^0 No suitable framework found. Please install vorp_core or rsg-core.")
        end
    end)
end

-- ─── SERVER ──────────────────────────────────────────────────────────────────

if IsDuplicityVersion() then

    if Framework == "VORP" then
        local VorpCore = {}
        TriggerEvent("getCore", function(core)
            VorpCore = core
        end)

        function FXGetPlayerData(src)
            local User = VorpCore.getUser(src)
            if not User then return nil end
            local Character = User.getUsedCharacter
            if not Character then return nil end
            return {
                -- charidentifier is the correct VORP field; charIdentifier kept as fallback
                charid = Character.charidentifier or Character.charIdentifier,
                job    = Character.job,
            }
        end

        function FXGetPlayerGroup(src)
            local User = VorpCore.getUser(src)
            if User then return User.getGroup end
            return nil
        end

        function FXHasItem(src, item)
            local retval = exports.vorp_inventory:getItem(src, item)
            return retval ~= nil and retval.count and retval.count > 0
        end

        function FXGetItemCount(src, itemName)
            local retval = exports.vorp_inventory:getItem(src, itemName)
            return (retval and retval.count) or 0
        end

        function FXRemoveItem(src, item, count)
            exports.vorp_inventory:subItem(src, item, tonumber(count or 1))
        end

        function FXAddItem(src, itemName, itemCount, Metadata)
            local count = tonumber(itemCount or 1)
            if Metadata and next(Metadata) then
                -- unique=true prevents stacking onto existing metadata slots
                for _ = 1, count do
                    exports.vorp_inventory:addItem(tonumber(src), itemName, 1, Metadata, function() end, true)
                end
            else
                exports.vorp_inventory:addItem(tonumber(src), itemName, count, {}, function() end, false)
            end
        end

        -- Scan getUserInventoryItems for keyed doorkeys only (VORP may skip metadata-less items)
        local function _vorp_scan_keyed(src, itemName)
            local p = promise.new()
            exports.vorp_inventory:getUserInventoryItems(src, function(data)
                local keyed = {}

                -- Parse metadata regardless of whether VORP returns it as table or JSON string
                local function parseMeta(v)
                    local raw = v.metadata or v.meta
                    if type(raw) == 'table' then return raw end
                    if type(raw) == 'string' and raw ~= '' and raw ~= '{}' then
                        local ok2, decoded = pcall(json.decode, raw)
                        if ok2 and type(decoded) == 'table' then return decoded end
                    end
                    return {}
                end

                for _, v in pairs(data or {}) do
                    if v.name and v.name:lower() == itemName:lower() then
                        local meta = parseMeta(v)
                        if meta.door_name and meta.door_name ~= '' then
                            keyed[#keyed+1] = { id = v.id, door_name = tostring(meta.door_name) }
                        end
                    end
                end
                p:resolve(keyed)
            end)
            return Citizen.Await(p)
        end

        function FXGetBlankKeyCount(src, itemName)
            local totalItem = exports.vorp_inventory:getItem(src, itemName)
            local total = (totalItem and totalItem.count) or 0
            local keyed = _vorp_scan_keyed(src, itemName)
            return math.max(0, total - #keyed)
        end

        function FXHasDoorKey(src, itemName, doorName)
            local keyed = _vorp_scan_keyed(src, itemName)
            for _, k in ipairs(keyed) do
                if k.door_name == doorName then return true end
            end
            return false
        end

        function FXRemoveBlankKeys(src, itemName, count)
            -- Blank keys have no metadata so use subItem by name directly.
            local p = promise.new()
            exports.vorp_inventory:subItem(src, itemName, tonumber(count), {}, function(success)
                p:resolve(success == true)
            end)
            return Citizen.Await(p)
        end

    elseif Framework == "RSG" then
        local RSGCore = exports['rsg-core']:GetCoreObject()

        function FXGetPlayerData(src)
            local Player = RSGCore.Functions.GetPlayer(tonumber(src))
            if not Player then return nil end
            return {
                charid = Player.PlayerData.citizenid,
                job    = Player.PlayerData.job and Player.PlayerData.job.name or nil,
            }
        end

        function FXGetPlayerGroup(src)
            if RSGCore.Functions.HasPermission(src, "admin") then return "admin" end
            if RSGCore.Functions.HasPermission(src, "mod")   then return "mod"   end
            return "user"
        end

        function FXHasItem(src, item)
            local Player = RSGCore.Functions.GetPlayer(tonumber(src))
            if not Player or not Player.PlayerData or not Player.PlayerData.items then return false end
            for _, v in pairs(Player.PlayerData.items) do
                if v.name and v.name:lower() == item:lower() and (v.amount or v.count or 0) > 0 then
                    return true
                end
            end
            return false
        end

        function FXGetItemCount(src, itemName)
            local Player = RSGCore.Functions.GetPlayer(tonumber(src))
            if not Player or not Player.PlayerData or not Player.PlayerData.items then return 0 end
            local count = 0
            for _, v in pairs(Player.PlayerData.items) do
                if v.name and v.name:lower() == itemName:lower() then
                    count = count + (v.amount or v.count or 0)
                end
            end
            return count
        end

        function FXRemoveItem(src, item, count)
            local Player = RSGCore.Functions.GetPlayer(tonumber(src))
            if not Player then return end
            Player.Functions.RemoveItem(item, tonumber(count or 1))
        end

        function FXAddItem(src, itemName, itemCount, Metadata)
            local Player = RSGCore.Functions.GetPlayer(tonumber(src))
            if not Player then return end
            Player.Functions.AddItem(itemName, tonumber(itemCount or 1), false, Metadata or {})
        end

        function FXGetBlankKeyCount(src, itemName)
            local Player = RSGCore.Functions.GetPlayer(tonumber(src))
            if not Player or not Player.PlayerData or not Player.PlayerData.items then return 0 end
            local count = 0
            for _, v in pairs(Player.PlayerData.items) do
                if v.name and v.name:lower() == itemName:lower() then
                    local info = v.info or {}
                    if not info.door_name or info.door_name == '' then
                        count = count + (v.amount or v.count or 1)
                    end
                end
            end
            return count
        end

        function FXHasDoorKey(src, itemName, doorName)
            local Player = RSGCore.Functions.GetPlayer(tonumber(src))
            if not Player or not Player.PlayerData or not Player.PlayerData.items then return false end
            for _, v in pairs(Player.PlayerData.items) do
                if v.name and v.name:lower() == itemName:lower() then
                    local info = v.info or {}
                    if info.door_name and info.door_name == doorName then return true end
                end
            end
            return false
        end

        function FXRemoveBlankKeys(src, itemName, count)
            local Player = RSGCore.Functions.GetPlayer(tonumber(src))
            if not Player or not Player.PlayerData or not Player.PlayerData.items then return false end
            local removed = 0
            for slot, v in pairs(Player.PlayerData.items) do
                if removed >= count then break end
                if v.name and v.name:lower() == itemName:lower() then
                    local info = v.info or {}
                    if not info.door_name or info.door_name == '' then
                        Player.Functions.RemoveItem(itemName, 1, slot)
                        removed = removed + 1
                    end
                end
            end
            return removed >= count
        end
    end

    -- Fallback stubs if no framework matched
    if not FXHasItem           then function FXHasItem(_src, _item)                       return true end end
    if not FXGetItemCount      then function FXGetItemCount(_src, _item)                  return 0    end end
    if not FXRemoveItem        then function FXRemoveItem(_src, _item, _count)            end end
    if not FXAddItem           then function FXAddItem(_src, _item, _count, _meta)        end end
    if not FXGetBlankKeyCount  then function FXGetBlankKeyCount(_src, _item)              return 99   end end
    if not FXHasDoorKey        then function FXHasDoorKey(_src, _item, _door)             return true end end
    if not FXRemoveBlankKeys   then function FXRemoveBlankKeys(_src, _item, _count)       end end

-- ─── CLIENT ──────────────────────────────────────────────────────────────────

else

    -- Detect which target system is installed
    CreateThread(function()
        if not Config.Settings.UseTarget then return end
        if GetResourceState('ox_target') == 'started' then
            FXTarget.system = 'ox_target'
        elseif GetResourceState('pc_interaction') == 'started' then
            FXTarget.system = 'pc_interaction'
        elseif GetResourceState('murphy_interact') == 'started' then
            FXTarget.system = 'murphy_interact'
        else
            Config.Settings.UseTarget = false
            print('^1[FX-Doorlock]^0 UseTarget is true but no supported target resource found. Falling back to prompts.')
        end
        print(('[FX-Doorlock] Target system: %s'):format(FXTarget.system or 'none (prompts)'))
    end)

    -- Add target options to a door entity
    function FXTarget:AddDoor(entity, door)
        if not Config.Settings.UseTarget or not entity or not self.system then return end

        local function interactCb()
            TriggerEvent('fx-doorlock:local:targetInteract', door.id)
        end
        local function lockpickCb()
            TriggerEvent('fx-doorlock:local:targetLockpick', door.id)
        end

        local opts = {
            {
                label    = door.locked and 'Unlock Door' or 'Lock Door',
                icon     = door.locked and 'fas fa-lock-open' or 'fas fa-lock',
                onSelect = interactCb,
            },
        }
        if door.locked and door.lockpickable then
            opts[#opts + 1] = {
                label    = 'Pick Lock',
                icon     = 'fas fa-key',
                onSelect = lockpickCb,
            }
        end

        if self.system == 'ox_target' then
            exports.ox_target:addLocalEntity(entity, opts)
        elseif self.system == 'pc_interaction' then
            for _, o in ipairs(opts) do
                exports.pc_interaction:AddEntityInteraction({
                    entity = entity,
                    label  = o.label,
                    action = o.onSelect,
                })
            end
        elseif self.system == 'murphy_interact' then
            for _, o in ipairs(opts) do
                exports.murphy_interact:AddEntity({
                    entity     = entity,
                    label      = o.label,
                    onInteract = o.onSelect,
                })
            end
        end
    end

    -- Remove target options from a door entity
    function FXTarget:RemoveDoor(entity)
        if not Config.Settings.UseTarget or not entity or not self.system then return end
        if self.system == 'ox_target' then
            exports.ox_target:removeLocalEntity(entity)
        elseif self.system == 'pc_interaction' then
            exports.pc_interaction:RemoveEntityInteraction(entity)
        elseif self.system == 'murphy_interact' then
            exports.murphy_interact:RemoveEntity(entity)
        end
    end

end
