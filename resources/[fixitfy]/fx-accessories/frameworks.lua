
--  Fx-Accessories | frameworks.lua
--  Fixitfy Development
--  Auto-detects VORP and RSG on startup.
--  Both frameworks are fully supported out of the box.
--
--  Open Source: To add a custom framework, scroll to the
--  CUSTOM FRAMEWORK TEMPLATE section at the bottom of this
--  file and follow the instructions there.


Framework = "NONE"
FX        = {}

-- ── Internal helpers (shared, not part of the public API) ───

local function BuildUsableData(source, item)
    return { source = source, item = item }
end

local function ResolveLocale(msg, ...)
    if type(msg) ~= "string" then return tostring(msg) end
    local key = msg:match("^%[(.-)%]$")
    if key and Config.Locales then
        local lc = Config.Locales[Config.Locale] or Config.Locales["en"]
        if lc and lc[key] then msg = lc[key] end
    end
    if select('#', ...) > 0 then
        msg = string.format(msg, ...)
    end
    return msg
end

-- ── Framework detection ──────────────────────────────────────

if GetResourceState('rsg-core') == 'started' then
    Framework = "RSG"
elseif GetResourceState('vorp_core') == 'started' then
    Framework = "VORP"
end

print("^2[Accessories]^0 Framework: ^3" .. Framework .. "^0")


--  SERVER-SIDE

if IsDuplicityVersion() then

    -- txAdmin grants 'txAdmin.login' to all identified admins at connect time.
    -- Also accept 'command' ACE as a fallback for non-txAdmin setups.
    local function IsTxAdmin(src)
        if IsPlayerAceAllowed(src, "txAdmin.login") then return true end
        if IsPlayerAceAllowed(src, "command")       then return true end
        return false
    end

    -- ── VORP ─────────────────────────────────────────────────
    if Framework == "VORP" then

        local VorpInv = exports.vorp_inventory:vorp_inventoryApi()

        function FX.GetItemCount(src, itemName)
            return VorpInv.getItemCount(src, itemName) or 0
        end

        local _canCarryChecked = false
        function FX.CanCarryItem(src, itemName, count)
            local ok, result = pcall(function()
                return VorpInv.canCarryItem(src, itemName, count)
            end)
            if not _canCarryChecked then
                _canCarryChecked = true
                if not ok or result == nil then
                    print("^3[FX-Accessories] WARNING: vorp_inventory canCarryItem API not available — inventory weight check inactive^0")
                end
            end
            if ok and result ~= nil then return result end
            return true
        end

        function FX.AddItem(src, itemName, count)
            local ok, err = pcall(function()
                VorpInv.addItem(src, itemName, count)
            end)
            if not ok then
                print("^1[FX-Accessories] AddItem error: " .. tostring(err) .. "^0")
            end
            return ok
        end

        function FX.GetPlayerMoney(src, moneytype)
            local core = exports['vorp_core']:GetCore()
            local user = core.getUser(src)
            if not user then return 0 end
            local char = user.getUsedCharacter
            if type(char) == "function" then char = char(user) end
            if not char then return 0 end
            if moneytype == "gold" then
                return char.gold or 0
            end
            return char.money or 0
        end

        function FX.RemovePlayerMoney(src, amount, moneytype)
            local core = exports['vorp_core']:GetCore()
            local user = core.getUser(src)
            if not user then return false end
            local char = user.getUsedCharacter
            if type(char) == "function" then char = char(user) end
            if not char then return false end
            if moneytype == "gold" then
                if (char.gold or 0) < amount then return false end
                char.removeCurrency(1, amount)
            else
                if (char.money or 0) < amount then return false end
                char.removeCurrency(0, amount)
            end
            return true
        end

        function FX.AddPlayerMoney(src, amount, moneytype)
            local core = exports['vorp_core']:GetCore()
            local user = core.getUser(src)
            if not user then return end
            local char = user.getUsedCharacter
            if type(char) == "function" then char = char(user) end
            if not char then return end
            if moneytype == "gold" then
                char.addCurrency(1, amount)
            else
                char.addCurrency(0, amount)
            end
        end

        function FX.RegisterUsableItem(itemName, callBack)
            VorpInv.RegisterUsableItem(itemName, function(data)
                -- VORP calls this callback inside pcall(). Any Citizen.Await (promise-based
                -- native or API call) or scheduler-level error inside a pcall causes the
                -- FiveM scheduler to fail with "bad argument #1 to 'format' (number expected,
                -- got nil)" because the error object escapes the error boundary in an
                -- unexpected form. CreateThread gives the callback its own coroutine context,
                -- completely detached from VORP's pcall, so yields and errors are handled
                -- normally by FiveM's own scheduler.
                local built = BuildUsableData(data.source, data.item)
                CreateThread(function()
                    callBack(built)
                end)
            end)
        end

        function FXCloseInventory(src)
            VorpInv.CloseInv(src)
        end

        function FX.GetPlayerJob(src)
            local ok, core = pcall(function() return exports['vorp_core']:GetCore() end)
            if not ok or not core then return "" end
            local user = core.getUser(src)
            if not user then return "" end
            local char = user.getUsedCharacter
            if type(char) == "function" then char = char(user) end
            if not char then return "" end
            return tostring(char.job or "")
        end

        function FX.IsAccadminAllowed(src)
            if Config.AccadminAdminOnly then
                return IsTxAdmin(src)
            end
            local target = Config.AllowedAccAdmin or ""
            -- 1. ACE permission (add_ace identifier.xxx <target> allow)
            if IsPlayerAceAllowed(src, target) then return true end
            -- 2. VORP checks — getGroup and getUsedCharacter are properties, not functions
            local core = (type(VorpCore) == "table" and VorpCore) or exports['vorp_core']:GetCore()
            local user = core.getUser(src)
            if not user then return false end
            -- getGroup can be a property (string) or a method depending on VORP version.
            local grp = user.getGroup
            if type(grp) == "function" then grp = grp(user) end
            if grp == target then return true end
            local char = user.getUsedCharacter
            if type(char) == "function" then char = char(user) end
            if type(char) == "table" and (char.job or "") == target then return true end
            return false
        end

    -- ── RSG ──────────────────────────────────────────────────
    elseif Framework == "RSG" then

        local RSGCore = exports['rsg-core']:GetCoreObject()

        function FX.GetItemCount(src, itemName)
            local Player = RSGCore.Functions.GetPlayer(src)
            if not Player then return 0 end
            local items = Player.PlayerData.items
            if not items then return 0 end
            for _, item in pairs(items) do
                if item.name == itemName then
                    return item.amount or 0
                end
            end
            return 0
        end

        local _canCarryChecked = false
        function FX.CanCarryItem(src, itemName, count)
            local Player = RSGCore.Functions.GetPlayer(src)
            if not Player then return false end
            local ok, result = pcall(function()
                return Player.Functions.CanAddItem(itemName, count)
            end)
            if not _canCarryChecked then
                _canCarryChecked = true
                if not ok or result == nil then
                    print("^3[FX-Accessories] WARNING: rsg-core CanAddItem API not available — inventory weight check inactive^0")
                end
            end
            if ok and result ~= nil then return result end
            return true
        end

        function FX.AddItem(src, itemName, count)
            local Player = RSGCore.Functions.GetPlayer(src)
            if not Player then return false end
            local ok, err = pcall(function()
                Player.Functions.AddItem(itemName, count)
                TriggerClientEvent("rsg-inventory:client:ItemUpdate", src)
            end)
            if not ok then
                print("^1[FX-Accessories] AddItem error: " .. tostring(err) .. "^0")
            end
            return ok
        end

        function FX.GetPlayerMoney(src, moneytype)
            local Player = RSGCore.Functions.GetPlayer(src)
            if not Player then return 0 end
            if moneytype == "gold" then
                return Player.PlayerData.money["gold"] or 0
            end
            return Player.PlayerData.money["cash"] or 0
        end

        function FX.RemovePlayerMoney(src, amount, moneytype)
            local Player = RSGCore.Functions.GetPlayer(src)
            if not Player then return false end
            local mtype = (moneytype == "gold") and "gold" or "cash"
            if (Player.PlayerData.money[mtype] or 0) < amount then return false end
            Player.Functions.RemoveMoney(mtype, amount)
            return true
        end

        function FX.AddPlayerMoney(src, amount, moneytype)
            local Player = RSGCore.Functions.GetPlayer(src)
            if not Player then return end
            local mtype = (moneytype == "gold") and "gold" or "cash"
            Player.Functions.AddMoney(mtype, amount)
        end

        function FX.RegisterUsableItem(itemName, callBack)
            RSGCore.Functions.CreateUseableItem(itemName, function(source, item)
                local data = BuildUsableData(source, item)
                data.item.metadata = item.info
                -- Wrap in CreateThread so any yield-based calls inside callBack
                -- run in their own coroutine, matching the VORP pattern.
                CreateThread(function()
                    callBack(data)
                end)
            end)
        end

        function FXCloseInventory(src)
            TriggerClientEvent("rsg-inventory:client:closeinv", src)
        end

        function FX.GetPlayerJob(src)
            local Player = RSGCore.Functions.GetPlayer(src)
            if not Player then return "" end
            return tostring((Player.PlayerData.job and Player.PlayerData.job.name) or "")
        end

        function FX.IsAccadminAllowed(src)
            if Config.AccadminAdminOnly then
                return IsTxAdmin(src)
            end
            local target = Config.AllowedAccAdmin or ""
            -- 1. ACE permission
            if IsPlayerAceAllowed(src, target) then return true end
            -- 2. RSG permission check
            if RSGCore.Functions.HasPermission(src, target) then return true end
            -- 3. RSG job check
            local Player = RSGCore.Functions.GetPlayer(src)
            if not Player then return false end
            return (Player.PlayerData.job and Player.PlayerData.job.name or "") == target
        end

    -- ── No framework / custom ─────────────────────────────────
    else
        --[[
            No framework detected. Items are handed out at count = 1
            so the script stays functional even without an inventory.
            Replace these stubs when you add your own framework below.
        --]]
        function FX.GetItemCount(_, _)              return 1     end
        function FX.CanCarryItem(_, _, _)           return true  end
        function FX.AddItem(_, _, _)           return true       end
        function FX.GetPlayerMoney(_, _)            return 999   end
        function FX.RemovePlayerMoney(_, _, _)      return true  end
        function FX.AddPlayerMoney(_, _, _)                      end
        function FX.RegisterUsableItem(_, _)                     end
        function FXCloseInventory(_)                             end
        function FX.GetPlayerJob(_)         return ""            end

        function FX.IsAccadminAllowed(src)
            if Config.AccadminAdminOnly then
                return IsTxAdmin(src)
            end
            return IsPlayerAceAllowed(src, Config.AllowedAccAdmin or "")
        end
    end

    -- Shared server → client notification (all frameworks)
    function FX.Notify(src, msg, ...)
        TriggerClientEvent("Accessories:client:notify", src, ResolveLocale(msg, ...))
    end


--  CLIENT-SIDE

else
    -- Base URL for item images served by the active inventory resource.
    -- FiveM exposes each resource's files/ entries via:
    --   https://cfx-nui-{resourceName}/{path}
    -- The UI uses this URL first; falls back to its own local folder on error.
    if Framework == "VORP" then
        FX.ItemImageBaseUrl = "https://cfx-nui-vorp_inventory/html/img/items/"
    elseif Framework == "RSG" then
        FX.ItemImageBaseUrl = "https://cfx-nui-rsg-inventory/html/images/"
    else
        FX.ItemImageBaseUrl = nil
    end
end

--[[

  CUSTOM FRAMEWORK TEMPLATE
  Copy the block below, paste it BEFORE the "No framework"
  else branch, and implement the four required functions.


HOW TO ADD YOUR FRAMEWORK
─────────────────────────
Step 1 – Detection (near the top of this file, inside the
         "Framework detection" section):

    elseif GetResourceState('my-core') == 'started' then
        Framework = "MYFX"

Step 2 – Server-side block (inside IsDuplicityVersion(),
         paste before the final "else" stub block):

    elseif Framework == "MYFX" then

        local MyCore = exports['my-core']:GetCoreObject()

        -- Return how many of itemName the player owns. Return 0 if none.
        function FX.GetItemCount(src, itemName)
            -- your implementation
            return 0
        end

        -- Register itemName as usable in your inventory.
        -- When used, call: callBack({ source = src, item = itemObject })
        function FX.RegisterUsableItem(itemName, callBack)
            -- your implementation
        end

        -- Register a server callback named eventName.
        -- Signature: callBack(source, cb, ...)
        function FXRegisterCallback(eventName, callBack, ...)
            -- your implementation
        end

        -- Close the inventory UI for player src after they use an item.
        function FXCloseInventory(src)
            -- your implementation
        end

Step 3 – Restart the resource. Done.

--]]
