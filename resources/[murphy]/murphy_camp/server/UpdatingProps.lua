RegisterServerEvent("murphy_camp:updatecampfire", function(index, data)
	local _source = source
	local charid = GetCharIdentifier(_source)
	local campfireid = index
	if GetAccess(_source, Camps[campfireid].charid, Camps[campfireid].guests) then
		local coords = vector3(data.coords.x, data.coords.y, data.coords.z)
		local rota = data.heading
		local model = Camps[campfireid].campfire.model
		local propset = Camps[campfireid].campfire.propset
		local campfire = { model = model, coords = coords, rota = rota, propset = propset }
		Camps[campfireid].campfire = campfire
		local players = GetPlayers()
		for k, v in pairs(players) do
			local playercoords = GetEntityCoords(GetPlayerPed(v))
			local campfirecoords = vector3(Camps[campfireid].campfire.coords.x, Camps[campfireid].campfire.coords.y,
				Camps[campfireid].campfire.coords.z)
			if #(playercoords - campfirecoords) < Config.DisplayDistance * 1.3 then
				Callback.triggerClient("murphy_camp:UpdateCamp", v, function() end, campfireid, Camps[campfireid])
			end
		end
	else
		TriggerClientEvent('murphy_notify:Tip', _source, "You cannot edit this camp", 4000)
	end
end)

RegisterServerEvent("murphy_camp:updateprops", function(camp, index, data)
	local _source = source
	local charid = GetCharIdentifier(_source)
	local campfireid = camp
	if GetAccess(_source, Camps[campfireid].charid, Camps[campfireid].guests) then
		local coords = vector3(data.coords.x, data.coords.y, data.coords.z)
		local rota = data.heading
		local props = Camps[campfireid].props
		local model = props[index].model
		local propset = props[index].propset
		props[index] = { coords = coords, model = model, rota = rota, propset = propset }
		Camps[campfireid].props = props
		local players = GetPlayers()
		for k, v in pairs(players) do
			local playercoords = GetEntityCoords(GetPlayerPed(v))
			local campfirecoords = vector3(Camps[campfireid].campfire.coords.x, Camps[campfireid].campfire.coords.y,
				Camps[campfireid].campfire.coords.z)
			if #(playercoords - campfirecoords) < Config.DisplayDistance * 1.3 then
				Callback.triggerClient("murphy_camp:UpdateCamp", v, function() end, campfireid, Camps[campfireid])
			end
		end
	else
		TriggerClientEvent('murphy_notify:Tip', _source, "You cannot edit this camp", 4000)
	end
end)

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

RegisterServerEvent("murphy_camp:deleteprops", function(camp, index)
	local _source = source
	local charid = GetCharIdentifier(_source)
	local campfireid = camp

	if GetAccess(_source, Camps[campfireid].charid, Camps[campfireid].guests) then
		local props = Camps[campfireid].props
		local model = props[index].model
		for k, v in pairs(Config.Furnitures) do
			if v.propset then
				if tablesAreEqual(v.propset, model) then
					GiveItem(_source, v.item, 1, {})
				end
			else
				if v.props == model then
					GiveItem(_source, v.item, 1, {})
				end
			end
		end
		props[index] = nil
		Camps[campfireid].props = props
		local players = GetPlayers()
		for k, v in pairs(players) do
			local playercoords = GetEntityCoords(GetPlayerPed(v))
			local campfirecoords = vector3(Camps[campfireid].campfire.coords.x, Camps[campfireid].campfire.coords.y,
				Camps[campfireid].campfire.coords.z)
			if #(playercoords - campfirecoords) < Config.DisplayDistance * 1.3 then
				Callback.triggerClient("murphy_camp:UpdateCamp", v, function() end, campfireid, Camps[campfireid])
			end
		end
	else
		TriggerClientEvent('murphy_notify:Tip', _source, "You cannot edit this camp", 4000)
	end
end)

local function isCampAdmin(src)
	local group = GetCharGroup(src)
	if not group then return false end
	for _, g in pairs(Config.RemoveAllFurnitureAdminGroups or {}) do
		if group == g then return true end
	end
	return false
end

Callback.register("murphy_camp:IsCampAdmin", function(source)
	return isCampAdmin(source)
end)

RegisterServerEvent("murphy_camp:deleteallprops", function(camp)
	local _source = source
	local campfireid = camp
	if not Camps[campfireid] then return end

	local allowed = false
	local refund = false
	if Config.RemoveAllFurnitureMode == "owner" then
		local charid = GetCharIdentifier(_source)
		allowed = (tostring(charid) == tostring(Camps[campfireid].charid))
		refund = true
	elseif Config.RemoveAllFurnitureMode == "admin" then
		allowed = isCampAdmin(_source)
		refund = false
	end

	if not allowed then
		TriggerClientEvent('murphy_camp:ShowAdvancedRightNotification', _source, Translate[34],
			"itemtype_textures", "itemtype_camp", "COLOR_WHITE", 4000)
		return
	end

	local props = Camps[campfireid].props or {}
	if refund then
		for _, prop in pairs(props) do
			for _, v in pairs(Config.Furnitures) do
				if v.propset then
					if tablesAreEqual(v.propset, prop.model) then
						GiveItem(_source, v.item, 1, {})
						break
					end
				else
					if v.props == prop.model then
						GiveItem(_source, v.item, 1, {})
						break
					end
				end
			end
		end
	end

	Camps[campfireid].props = {}

	local campfirecoords = vector3(Camps[campfireid].campfire.coords.x, Camps[campfireid].campfire.coords.y,
		Camps[campfireid].campfire.coords.z)
	local players = GetPlayers()
	for k, v in pairs(players) do
		local playercoords = GetEntityCoords(GetPlayerPed(v))
		if #(playercoords - campfirecoords) < Config.DisplayDistance * 1.3 then
			Callback.triggerClient("murphy_camp:UpdateCamp", v, function() end, campfireid, Camps[campfireid])
		end
	end
end)

RegisterServerEvent("murphy_camp:deletecampfire", function(index)
	local _source = source
	local charid = GetCharIdentifier(_source)
	local campfireid = index

	if GetAccess(_source, Camps[campfireid].charid, Camps[campfireid].guests) then
		MySQL.update('DELETE FROM murphy_camp WHERE `id`=@id', { id = campfireid }, function(rowsChanged)
			if rowsChanged then
				for k, v in pairs(Config.Campfire) do
					if v.propset then
						if tablesAreEqual(v.propset, Camps[campfireid].campfire.model) then
							GiveItem(_source, v.item, 1, {})
							break
						end
					else
						if v.props == Camps[campfireid].campfire.model then
							GiveItem(_source, v.item, 1, {})
							break
						end
					end
				end
				local campfirecoords = vector3(Camps[campfireid].campfire.coords.x, Camps[campfireid].campfire.coords.y,
					Camps[campfireid].campfire.coords.z)
				Camps[campfireid] = nil
				local players = GetPlayers()
				for k, v in pairs(players) do
					local playercoords = GetEntityCoords(GetPlayerPed(v))
					if #(playercoords - campfirecoords) < Config.DisplayDistance * 1.3 then
						Callback.triggerClient("murphy_camp:UpdateCamp", v, function() end, campfireid, Camps
							[campfireid])
					end
				end
			end
		end)
	else
		TriggerClientEvent('murphy_notify:Tip', _source, "You cannot edit this camp", 4000)
	end
end)
