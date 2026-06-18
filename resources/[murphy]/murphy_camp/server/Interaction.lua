-- RegisterServerEvent("murphy_camp:CraftCheckQuantity", function(data, tag)
--     local _source = source
-- 	local ItemAmount = {}
-- 	local cancraft = true
-- 	local loweramount = 0
-- 	for k, v in pairs (data.need) do
-- 		if cancraft == true then
-- 			if GetItemAmount(_source, v[1]) < 1 then
-- 				cancraft = false
-- 			else
-- 				amnt = GetItemAmount(_source, v[1]) / v[2]
-- 				print (amnt)
-- 				table.insert(ItemAmount, amnt)
-- 			end
-- 		end
-- 	end
-- 	if cancraft == true then
-- 		loweramount = ItemAmount[1]
-- 		for index , quantity in pairs(ItemAmount) do
-- 			if quantity < loweramount then
-- 				loweramount = quantity
-- 			end
-- 		end
-- 		TriggerClientEvent("murphy_camp:CraftGetQuantity", _source, math.floor(loweramount), tag)
-- 	else
-- 		TriggerClientEvent("murphy_camp:CraftGetQuantity", _source, 0, tag)
-- 	end

-- end)

RegisterServerEvent("murphy_camp:GiveItem", function (item, amount)
	GiveItem(source, item, amount, {})
end)


function IsGuestOnline(charid, guests)
	local onlineplayers = {}
	for _,targetId in ipairs(GetPlayers()) do
		local targetcharid = GetCharIdentifier(targetId)
		for k, v in pairs(guests) do
			if tostring(targetcharid) == tostring(v) then
				table.insert(onlineplayers, GetEntityCoords(GetPlayerPed(targetId)))
				
			end
		end
		if tostring(targetcharid) == tostring(charid) then
			table.insert(onlineplayers, GetEntityCoords(GetPlayerPed(targetId)))
		end
	end
	return onlineplayers
end

local safeopened = {}
RegisterNetEvent("murphy_camp:asklockpick", function(stashid, weight, owner, guests, campcoords)
    local _source = source
	local onlineplayers = IsGuestOnline(owner, guests)
	if safeopened[stashid] == nil then
		local count = GetItemAmount(_source, Config.LockpickItem)
		if count >= 1 then
			RemoveItem(_source, Config.LockpickItem, 1, {})
			TriggerClientEvent('murphy_camp:dolockpick', _source, stashid, false, weight, onlineplayers, campcoords)
		else
			-- TriggerClientEvent("murphy_notify:NotifyLeft", _source, Config.Translate.Lockpick, Config.Translate.LockpickNeed, "scoretimer_textures", "scoretimer_generic_cross", 4000)
		end
	else
		TriggerClientEvent('murphy_camp:dolockpick', _source, stashid, true, weight, onlineplayers, campcoords)
	end

end)

RegisterNetEvent("murphy_camp:isopen", function(stashid)
    local _source = source
    safeopened[stashid] = true
--     local data = {
--         ['Player'] = _source, -- You need to set source here
--         ['Log'] = Config.DiscordLogs, -- Log name
--         ['Title'] = "Safe - Lockpick", -- Title
--         ['Message'] = GetCharFirstname(_source).. ' '..GetCharLastname(_source)..' break: '..stashid, -- Message
--         ['Color'] = 'blue', -- Set your color here check Config.Colors for available colors
--     }
-- TriggerEvent('murphy_discordlogs:SendLog', _source, data)
Wait(Config.BreakDelay*1000)
safeopened[stashid] = nil
end)