function GetAccess(target, charid, guests)
	local targetid = GetCharIdentifier(target)
	local result = false
	if tostring(charid) == tostring(targetid) then
		result = true
	else
		local guestList = {}
		if guests then
			guestList = guests
		end

		for k, v in pairs(guestList) do
			if targetid == v then
				result = true
			end
		end
	end
	return result
end

RegisterServerEvent("murphy_camp:savecampfire", function(key, data)
	local _source = source
	local charid = GetCharIdentifier(_source)
	local coords = vector3(data.coords.x, data.coords.y, data.coords.z)
	local rota = data.heading
	local model = Config.Campfire[key].props or Config.Campfire[key].propset
	local campfire = { model = model, coords = coords, rota = rota }
	if Config.Campfire[key].propset then
		campfire.propset = true
	end
	local campfire = json.encode(campfire)
	MySQL.query('SELECT * FROM murphy_camp WHERE `charid`=@charid;',
		{
			charid = charid
		}, function(result)
			if #result >= Config.CampLimit then
				TriggerClientEvent('murphy_camp:ShowAdvancedRightNotification', _source, Translate[23],
					"itemtype_textures", "itemtype_camp", "COLOR_WHITE", 4000)
			else
				MySQL.insert(
					'INSERT INTO murphy_camp (`charid`, `campfire`, `fuel`, `guests`) VALUES (@charid, @campfire, @fuel , @guests);',
					{
						charid = charid,
						campfire = campfire,
						fuel = Config.BasicFuel,
						guests = json.encode({})
					},
					function(insertId)
						if insertId then
							print("Campfire created with ID: " .. insertId)
							MySQL.query('SELECT * FROM murphy_camp WHERE id = @id', { id = insertId }, function(result)
								if result[1] then
									local newdata = {
										charid = result[1].charid,
										guests = json.decode(result[1].guests),
										campfire = json.decode(result[1].campfire),
										props = json.decode(result[1].props or '{}'),
										fuel = result[1].fuel
									}
									-- ... suite du code ...
									local campfireid = result[1].id
									print("Campfire created with ID: " .. campfireid)
									print("^4[DB]^0 Loaded camp with ID: " ..
										campfireid .. " for charid: " .. newdata.charid)
									Camps[campfireid] = newdata
									local campfirecoords = coords
									local players = GetPlayers()
									for k, v in pairs(players) do
										local playercoords = GetEntityCoords(GetPlayerPed(v))
										if #(playercoords - campfirecoords) < Config.DisplayDistance * 1.3 then
											Callback.triggerClient("murphy_camp:UpdateCamp", v, function() end,
												campfireid, Camps[campfireid])
										end
									end
									RemoveItem(_source, Config.Campfire[key].item, 1, {})
								end
							end)
						end
					end
				)
			end
		end)
end)


RegisterServerEvent("murphy_camp:savefurnitures", function(key, data, id, maxstash)
	local _source = source
	local campfireid = id

	if GetAccess(_source, Camps[campfireid].charid, Camps[campfireid].guests) then
		local coords = vector3(data.coords.x, data.coords.y, data.coords.z)
		local rota = data.heading
		local parameter = {}
		if Config.Furnitures[key].props then
			parameter = { coords = coords, model = Config.Furnitures[key].props, rota = rota, propset = false }
		elseif Config.Furnitures[key].propset then
			parameter = { coords = coords, model = Config.Furnitures[key].propset, rota = rota, propset = true }
		end
		local props = Camps[campfireid].props
		local actualstash = 0
		local modelinventory = Config.Furnitures[key].inventory or 0
		local canplace = false
		if modelinventory > 0 then
			for i, j in pairs(props) do
				local model = j.model
				for k, v in pairs(Config.Furnitures) do
					if v.inventory and v.inventory > 0 then
						if v.propset then
							if tablesAreEqual(v.propset, model) then
								actualstash = actualstash + 1
								break
							end
						else
							if v.props == model then
								actualstash = actualstash + 1
								break
							end
						end
					end
				end
			end
			if actualstash <= maxstash then
				canplace = true
			end
		else
			canplace = true
		end
		if canplace then
			local numBase0 = math.random(100, 999)
			local numBase1 = math.random(0, 9999)
			local generetedUid = string.format("%03d%04d", numBase0, numBase1)
			props[generetedUid] = parameter
			Camps[campfireid].props = props
			RemoveItem(_source, Config.Furnitures[key].item, 1, {})
			local campfirecoords = vector3(Camps[campfireid].campfire.coords.x, Camps[campfireid].campfire.coords.y,
				Camps[campfireid].campfire.coords.z)
			local players = GetPlayers()
			for k, v in pairs(players) do
				local playercoords = GetEntityCoords(GetPlayerPed(v))
				if #(playercoords - campfirecoords) < Config.DisplayDistance * 1.3 then
					Callback.triggerClient("murphy_camp:UpdateCamp", v, function() end, campfireid, Camps[campfireid])
				end
			end
		else
			TriggerClientEvent('murphy_camp:ShowAdvancedRightNotification', _source, Translate[32],
				"itemtype_textures", "itemtype_camp", "COLOR_WHITE", 4000)
		end
	else
		TriggerClientEvent('murphy_camp:ShowAdvancedRightNotification', _source, Translate[24],
			"itemtype_textures", "itemtype_camp", "COLOR_WHITE", 4000)
	end
end)

AddEventHandler('murphy_clothes:retrievecamp', function(id, callback)
	local Callback = callback
	MySQL.query('SELECT * FROM murphy_camp WHERE `id`=@id;',
		{
			id = id
		}, function(result)
			if result[1] then
				Callback(result[1])
			else
				Callback(false)
			end
		end)
end)
