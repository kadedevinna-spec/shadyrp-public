Config = {}
Config.Language = "en"
Config.Locale = {
    ["en"] = {
        ["open_door"] = "~COLOR_GREENLIGHT~Open ~COLOR_PURE_WHITE~| ~COLOR_YELLOWLIGHT~Secret Door",
        ["close_door"] = "~COLOR_REDLIGHT~Close ~COLOR_PURE_WHITE~| ~COLOR_YELLOWLIGHT~Secret Door",
        ["nojob"] = "You need to be %{job} (min grade %{grade}) to do this!",
        ["noitem"] = "You need %{count}x %{item} to open this door!",
    }
}

Config.Prompts = {
	["door"] = {
	    Label = "Interaction Secret Door",
        distance = 3.0,
	    Keys = {
            [1] = {
                Key = 0xC7B5340A,
                Label = "Interaction",
                HoldTime = 500
            },
	    }
	},
}

Config.SecretDoors = {
    ["hood1"] = {
        propName = "p_gunsmithtrapdoor01x",
        mainCoord = vector3(-1506.7737, -307.0448, 128.7368),
        doorId = 1,
        firstClose = true, --If the door is closed when the server starts.
        openAnim = {
            dict = "mech_pickup@loot@cash_register@open",
            name = "enter_short",
            flag = 1,
            duration = 1000,   
        },
        closeAnim = {
            dict = "mech_pickup@loot@cash_register@open",
            name = "enter_short",
            flag = 1,
            duration = 1000,   
        },
        jobRequired = false,
        -- jobRequired = { --Example for job restriction
        --     ["vander"] = 0, --Those with a rank of 0 or higher can access.
        --     ["police"] = 0, --Those with a rank of 0 or higher can access.
        -- },
        itemRequired = { --Example for item restriction
            { name = "lockpick", count = 1, remove = false }, --You need 1 hood_key to open the door. If remove is true, it will be removed from the inventory when used.
        },
        door1 = {
            open = {
                coord = vector3(-1508.522461, -306.418762, 128.449997),
                rotation = vector3(0.000006, 29.999983, 24.917673),
            },
            close = {
                coord = vector3(-1508.47998046875, -306.61, 128.33),
                rotation = vector3(-35, 139.99, 178.49),
            }
        },
        door2 = {
            open = {
                coord = vector3(-1507.494629, -308.603516, 128.449997),
                rotation = vector3(-0.000006, -30.000031, -155.081482),
            },
            close = {
                coord = vector3(-1507.6300048828125, -308.4800109863281, 128.3800048828125),
                rotation = vector3(-58.99999618530273, -90, 115.0),
            }
        },
    },
    ["hood2"] = {
        propName = "p_gunsmithtrapdoor01x",
        mainCoord = vector3(-2179.773926, -927.320007, 117.610001),
        doorId = 1,
        firstClose = true, --If the door is closed when the server starts.
        openAnim = {
            dict = "mech_pickup@loot@cash_register@open",
            name = "enter_short",
            flag = 1,
            duration = 1000,   
        },
        closeAnim = {
            dict = "mech_pickup@loot@cash_register@open",
            name = "enter_short",
            flag = 1,
            duration = 1000,   
        },
        jobRequired = false,
        -- jobRequired = { --Example for job restriction
        --     ["vander"] = 0, --Those with a rank of 0 or higher can access.
        --     ["police"] = 0, --Those with a rank of 0 or higher can access.
        -- },
        door1 = {
            open = {
                coord = vector3(-2180.800049, -925.109985, 117.610001),
                rotation = vector3(0.000006, 29.999983, 24.917673),
            },
            close = {
                coord = vector3(-2180.800049, -925.109985, 117.610001),
                rotation = vector3(-35, 139.99, 178.49),
            }
        },
        door2 = {
            open = {
                coord = vector3(-2179.773926, -927.320007, 117.610001),
                rotation = vector3(-0.000006, -30.000031, -155.081482),
            },
            close = {
                coord = vector3(-2179.773926, -927.320007, 117.610001),
                rotation = vector3(-58.99999618530273, -90, 115.0),
            }
        },
    },
    ["hood3"] = {
        propName = "p_gunsmithtrapdoor01x",
        mainCoord = vector3(-2716.018798828125, -2666.509521484375, 68.82865905761719),
        doorId = 1,
        firstClose = true, --If the door is closed when the server starts.
        openAnim = {
            dict = "mech_pickup@loot@cash_register@open",
            name = "enter_short",
            flag = 1,
            duration = 1000,   
        },
        closeAnim = {
            dict = "mech_pickup@loot@cash_register@open",
            name = "enter_short",
            flag = 1,
            duration = 1000,   
        },
        jobRequired = false,
        -- jobRequired = { --Example for job restriction
        --     ["vander"] = 0, --Those with a rank of 0 or higher can access.
        --     ["police"] = 0, --Those with a rank of 0 or higher can access.
        -- },
        door1 = {
            open = {
                coord = vector3(-2717.050048828125, -2664.300048828125, 68.83000183105469),
                rotation = vector3(0.000006, 29.999983, 24.917673),
            },
            close = {
                coord = vector3(-2717.050048828125, -2664.300048828125, 68.82865905761719),
                rotation = vector3(-35, 139.99, 178.49),
            }
        },
        door2 = {
            open = {
                coord = vector3(-2716.018798828125, -2666.509521484375, 68.82865905761719),
                rotation = vector3(-0.000006, -30.000031, -155.081482),
            },
            close = {
                coord = vector3(-2716.018798828125, -2666.509521484375, 68.82865905761719),
                rotation = vector3(-58.99999618530273, -90, 115.0),
            }
        },
    },
    ["hood4"] = {
        propName = "p_gunsmithtrapdoor01x",
        mainCoord = vector3(-5885.662109375, -2762.184326171875, -4.75),
        doorId = 1,
        firstClose = true, --If the door is closed when the server starts.
        openAnim = {
            dict = "mech_pickup@loot@cash_register@open",
            name = "enter_short",
            flag = 1,
            duration = 1000,   
        },
        closeAnim = {
            dict = "mech_pickup@loot@cash_register@open",
            name = "enter_short",
            flag = 1,
            duration = 1000,   
        },
        jobRequired = false,
        -- jobRequired = { --Example for job restriction
        --     ["vander"] = 0, --Those with a rank of 0 or higher can access.
        --     ["police"] = 0, --Those with a rank of 0 or higher can access.
        -- },
        door1 = {
            open = {
                coord = vector3(-5885.662109375, -2762.184326171875, -4.75),
                rotation = vector3(0.000006, 29.999983, 24.917673),
            },
            close = {
                coord = vector3(-5885.662109375, -2762.184326171875, -4.75),
                rotation = vector3(-35, 139.99, 178.49),
            }
        },
        door2 = {
            open = {
                coord = vector3(-5884.64013671875, -2764.389892578125, -4.75),
                rotation = vector3(-0.000006, -30.000031, -155.081482),
            },
            close = {
                coord = vector3(-5884.64013671875, -2764.389892578125, -4.75),
                rotation = vector3(-58.99999618530273, -90, 115.0),
            }
        },
    },
    ["hood5"] = {
        propName = "p_gunsmithtrapdoor01x",
        mainCoord = vector3(-174.4862823486328, 1354.478759765625, 167.89999389648438),
        doorId = 1,
        firstClose = true, --If the door is closed when the server starts.
        openAnim = {
            dict = "mech_pickup@loot@cash_register@open",
            name = "enter_short",
            flag = 1,
            duration = 1000,   
        },
        closeAnim = {
            dict = "mech_pickup@loot@cash_register@open",
            name = "enter_short",
            flag = 1,
            duration = 1000,   
        },
        jobRequired = false,
        -- jobRequired = { --Example for job restriction
        --     ["vander"] = 0, --Those with a rank of 0 or higher can access.
        --     ["police"] = 0, --Those with a rank of 0 or higher can access.
        -- },
        door1 = {
            open = {
                coord = vector3(-175.50999450683594, 1356.68994140625, 167.89999389648438),
                rotation = vector3(0.000006, 29.999983, 24.917673),
            },
            close = {
                coord = vector3(-175.50999450683594, 1356.68994140625, 167.89999389648438),
                rotation = vector3(-35, 139.99, 178.49),
            }
        },
        door2 = {
            open = {
                coord = vector3(-174.4862823486328, 1354.478759765625, 167.89999389648438),
                rotation = vector3(-0.000006, -30.000031, -155.081482),
            },
            close = {
                coord = vector3(-174.4862823486328, 1354.478759765625, 167.89999389648438),
                rotation = vector3(-58.99999618530273, -90, 115.0),
            }
        },
    },
}

Config.YmapSpawner = {
    ["hood1"] = {
        spawnDistance = 50,
        DefaultRoomCoord = vector3(-1507.2708, -304.6730, 128.4547),
        objects = {
            {
                model = `p_gunsmithtrapdoor01x`,
                coords = vec3(-1508.522461,-306.418762,128.449997),
                rotation = vec3(0.000006,29.999983,24.917673),
            },
            {
                model = `p_gunsmithtrapdoor01x`,
                coords = vec3(-1507.494629,-308.603516,128.449997),
                rotation = vec3(-0.000006,-30.000031,-155.081482),
            },
        }
    },
    ["hood2"] = {
        spawnDistance = 50,
        DefaultRoomCoord = vector3(-2179.773926, -927.320007, 117.610001),
        objects = {
            {
                model = `p_gunsmithtrapdoor01x`,
                coords = vec3(-2180.800049, -925.109985, 117.610001),
                rotation = vec3(0.000006,29.999983,24.917673),
            },
            {
                model = `p_gunsmithtrapdoor01x`,
                coords = vec3(-2179.773926, -927.320007, 117.610001),
                rotation = vec3(-0.000006,-30.000031,-155.081482),
            },
        }
    },
    ["hood3"] = {
        spawnDistance = 50,
        DefaultRoomCoord = vector3(-2716.018798828125, -2666.509521484375, 68.82865905761719),
        objects = {
            {
                model = `p_gunsmithtrapdoor01x`,
                coords = vec3(-2717.050048828125, -2664.300048828125, 68.83000183105469),
                rotation = vec3(0.000006,29.999983,24.917673),
            },
            {
                model = `p_gunsmithtrapdoor01x`,
                coords = vec3(-2716.018798828125, -2666.509521484375, 68.82865905761719),
                rotation = vec3(-0.000006,-30.000031,-155.081482),
            },
        }
    },
    ["hood4"] = {
        spawnDistance = 50,
        DefaultRoomCoord = vector3(-5885.662109375, -2762.184326171875, -4.75),
        objects = {
            {
                model = `p_gunsmithtrapdoor01x`,
                coords = vec3(-5885.662109375, -2762.184326171875, -4.75),
                rotation = vec3(0.000006,29.999983,24.917673),
            },
            {
                model = `p_gunsmithtrapdoor01x`,
                coords = vec3(-5884.64013671875, -2764.389892578125, -4.75),
                rotation = vec3(-0.000006,-30.000031,-155.081482),
            },
        }
    },
    ["hood5"] = {
        spawnDistance = 50,
        DefaultRoomCoord = vector3(-174.4862823486328, 1354.478759765625, 167.89999389648438),
        objects = {
            {
                model = `p_gunsmithtrapdoor01x`,
                coords = vec3(-175.50999450683594, 1356.68994140625, 167.89999389648438),
                rotation = vec3(0.000006,29.999983,24.917673),
            },
            {
                model = `p_gunsmithtrapdoor01x`,
                coords = vec3(-174.4862823486328, 1354.478759765625, 167.89999389648438),
                rotation = vec3(-0.000006,-30.000031,-155.081482),
            },
        }
    },
}


function Notify(data)
    local text = data.text or "No message" 
    local time = data.time or 5000  
    local type = data.type or "info" 
    local dict = data.dict
    local icon = data.icon
    local color = data.color or 0
    local src = data.source
  
    if IsDuplicityVersion() then
        if Framework == "RSG" then
            text = string.gsub(text, "~.-~", "")
            TriggerClientEvent('ox_lib:notify', src, { title = text, type = type, duration = time })
        elseif Framework == "REDEMRP" then
            text = string.gsub(text, "~.-~", "")
            TriggerClientEvent("redem_roleplay:Tip", src, text, time)
        elseif Framework == "VORP" then
            if icon then
                TriggerClientEvent('vorp:ShowAdvancedRightNotification', src, text, dict, icon, color, time)
            else
                TriggerClientEvent("vorp:TipBottom",src, text, time, type)
            end
        end
    else
        if Framework == "RSG" then
            text = string.gsub(text, "~.-~", "")
            TriggerEvent('ox_lib:notify', { title = text, type = type, duration = time })
        elseif Framework == "REDEMRP" then
            text = string.gsub(text, "~.-~", "")
            TriggerEvent("redem_roleplay:Tip", text, time)
        elseif Framework == "VORP" then
            if icon then
                TriggerEvent("vorp:ShowAdvancedRightNotification", text, dict, icon, color, time)
            else
                TriggerEvent("vorp:TipBottom", text, time, type)
            end
        end
    end
end
  
function Locale(key, subs)
  local translate = Config.Locale[Config.Language][key] and Config.Locale[Config.Language][key] or "Config.Locale[" .. Config.Language .. "][" .. key .. "] doesn't exist"
  subs = subs and subs or {}
  for k, v in pairs(subs) do
      local templateToFind = '%${' .. k .. '}'
      local safeValue = tostring(v):gsub("%%", "%%%%")
      translate = translate:gsub(templateToFind, safeValue)
  end
  translate = tostring(translate):gsub("%%%%", "%%")
  return tostring(translate)
end
