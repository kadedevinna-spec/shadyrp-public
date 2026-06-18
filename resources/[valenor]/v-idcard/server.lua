--[[
    ═══════════════════════════════════════════════════════════════════════
    V-IDCARD SERVER SIDE
    by Valenor Studio
    ═══════════════════════════════════════════════════════════════════════
--]]

--[[
    ═══════════════════════════════════════════════════════════════════════
    HELPER FUNCTIONS
    ═══════════════════════════════════════════════════════════════════════
--]]

function GetPlayerIdentifierBySource(source)
    local playerLicense = GetPlayerIdentifierByType(source, 'license')
    return playerLicense
end

function GenerateRegistryNo()
    local registryNo = math.random(100000, 999999)
    return tostring(registryNo)
end

function GetCurrentDate()
    local currentDate = os.date('%d/%m/' .. Config.RegistryYear)
    return currentDate
end

function ShowNotification(source, message, duration)
    if Config.Framework and Config.Framework.Notifications then
        Config.Framework.Notifications.ShowNotification(source, message, duration)
    else
        TriggerClientEvent('vorp:TipRight', source, message, duration)
    end
end

function AddInventoryItem(source, itemName, count, metadata)
    if Config.Framework and Config.Framework.Inventory then
        Config.Framework.Inventory.AddItem(source, itemName, count, metadata)
    else
        exports.vorp_inventory:addItem(source, itemName, count, metadata)
    end
end

function RemoveInventoryItem(source, itemName, count)
    if Config.Framework and Config.Framework.Inventory then
        Config.Framework.Inventory.RemoveItem(source, itemName, count)
    else
        exports.vorp_inventory:subItem(source, itemName, count, nil)
    end
end

--[[
    ═══════════════════════════════════════════════════════════════════════
    VALIDATION FUNCTIONS
    ═══════════════════════════════════════════════════════════════════════
--]]

function ValidateDateOfBirth(dateStr)
    if not dateStr or dateStr == "" then
        return false
    end
    
    local day, month, year = string.match(dateStr, "^(%d%d)/(%d%d)/(%d%d%d%d)$")
    
    if not day or not month or not year then
        return false
    end
    
    day = tonumber(day)
    month = tonumber(month)
    year = tonumber(year)
    
    if year < Config.DateOfBirth.MinYear or year > Config.DateOfBirth.MaxYear then
        return false
    end
    
    if month < 1 or month > 12 then
        return false
    end
    
    if day < 1 or day > 31 then
        return false
    end
    
    return true
end

function ValidateGender(gender)
    if not Config.Gender.Enabled then return true end
    if not gender or gender == "" then return false end
    
    for _, allowed in ipairs(Config.Gender.AllowedValues) do
        local compareGender = Config.Gender.CaseSensitive and gender or string.lower(gender)
        local compareAllowed = Config.Gender.CaseSensitive and allowed or string.lower(allowed)
        if compareGender == compareAllowed then
            return true
        end
    end
    return false
end

function ValidateWeight(weight)
    if not Config.Weight.Enabled then return true end
    if not weight or weight == "" then return false end
    
    local numWeight = tonumber(weight:match("^(%d+)"))
    if not numWeight then return false end
    return numWeight >= Config.Weight.Min and numWeight <= Config.Weight.Max
end

function ValidateHeight(height)
    if not Config.Height.Enabled then return true end
    if not height or height == "" then return false end
    
    local numHeight = tonumber(height:match("^(%d+)"))
    if not numHeight then return false end
    return numHeight >= Config.Height.Min and numHeight <= Config.Height.Max
end

function ContainsBlacklistedWord(text)
    if not Config.BlacklistWords.Enabled then return false end
    if not text or text == "" then return false end
    
    local lowerText = string.lower(text)
    for _, word in ipairs(Config.BlacklistWords.Words) do
        if string.find(lowerText, string.lower(word)) then
            return true
        end
    end
    return false
end

function ValidateAllCardData(cardData)
    -- Blacklist check
    local fieldsToCheck = {
        cardData.fullname, cardData.bornIn, cardData.residence, cardData.employed,
        cardData.nationality, cardData.signature, cardData.eyesColor, cardData.hairColor
    }
    
    for _, field in ipairs(fieldsToCheck) do
        if ContainsBlacklistedWord(field) then
            return false, "blacklist"
        end
    end
    
    -- Date of Birth
    if not ValidateDateOfBirth(cardData.dateOfBirth) then
        return false, "dob"
    end
    
    -- Gender
    if not ValidateGender(cardData.gender) then
        return false, "gender"
    end
    
    -- Weight
    if not ValidateWeight(cardData.weight) then
        return false, "weight"
    end
    
    -- Height
    if not ValidateHeight(cardData.height) then
        return false, "height"
    end
    
    return true, nil
end

--[[
    ═══════════════════════════════════════════════════════════════════════
    EVENT HANDLERS
    ═══════════════════════════════════════════════════════════════════════
--]]

RegisterServerEvent('idcard:requestCardData')
AddEventHandler('idcard:requestCardData', function()
    local source = source
    TriggerClientEvent('idcard:openCreationmenu', source, nil)
end)

RegisterServerEvent('idcard:saveCardData')
AddEventHandler('idcard:saveCardData', function(cardData)
    local source = source
    local identifier = GetPlayerIdentifierBySource(source)
    
    -- Server-side validation
    local isValid, errorType = ValidateAllCardData(cardData)
    
    if not isValid then
        if errorType == "dob" then
            ShowNotification(source, string.format(Config.Messages.invalid_dob, Config.DateOfBirth.MinYear, Config.DateOfBirth.MaxYear), 4000)
        elseif errorType == "gender" then
            ShowNotification(source, string.format(Config.Messages.invalid_gender, table.concat(Config.Gender.AllowedValues, ", ")), 4000)
        elseif errorType == "weight" then
            ShowNotification(source, string.format(Config.Messages.invalid_weight, Config.Weight.Min, Config.Weight.Max, Config.Weight.Unit), 4000)
        elseif errorType == "height" then
            ShowNotification(source, string.format(Config.Messages.invalid_height, Config.Height.Min, Config.Height.Max, Config.Height.Unit), 4000)
        elseif errorType == "blacklist" then
            ShowNotification(source, Config.Messages.blacklisted_word, 4000)
        end
        return
    end
    
    local registryNo = GenerateRegistryNo()
    local issueDate = GetCurrentDate()
    
    local photoUrl = Config.DefaultPhotoCard
    
    if cardData.photoUrl and cardData.photoUrl ~= "" and string.find(cardData.photoUrl, "^http") then
        photoUrl = cardData.photoUrl
    end
    
    local itemDescription = string.format(Config.ItemDescription, cardData.fullname or "Unknown")
    
    exports.oxmysql:query('SELECT * FROM idcards WHERE identifier = ?', {identifier}, function(result)
        local fullCardData = {
            identifier = identifier,
            fullname = cardData.fullname,
            registryNo = registryNo,
            issueDate = issueDate,
            photoUrl = photoUrl,
            dateOfBirth = cardData.dateOfBirth,
            gender = cardData.gender,
            nationality = cardData.nationality,
            bornIn = cardData.bornIn,
            residence = cardData.residence,
            height = cardData.height,
            weight = cardData.weight,
            eyesColor = cardData.eyesColor,
            hairColor = cardData.hairColor,
            employed = cardData.employed,
            signature = cardData.signature
        }
        
        if result[1] ~= nil then
            exports.oxmysql:execute([[
                UPDATE idcards SET
                    fullname = ?, registryNo = ?, issueDate = ?, photoUrl = ?,
                    dateOfBirth = ?, gender = ?, nationality = ?, bornIn = ?,
                    residence = ?, height = ?, weight = ?, eyesColor = ?,
                    hairColor = ?, employed = ?, signature = ?
                WHERE identifier = ?
            ]], {
                cardData.fullname, registryNo, issueDate, photoUrl,
                cardData.dateOfBirth, cardData.gender, cardData.nationality, cardData.bornIn,
                cardData.residence, cardData.height, cardData.weight, cardData.eyesColor,
                cardData.hairColor, cardData.employed, cardData.signature,
                identifier
            }, function(success)
                if success then
                    -- Remove old card and give new one
                    RemoveInventoryItem(source, Config.ItemName, 1)
                    AddInventoryItem(source, Config.ItemName, 1, {description = itemDescription})
                    TriggerClientEvent('idcard:cardSaved', source, fullCardData)
                end
            end)
        else
            exports.oxmysql:execute([[
                INSERT INTO idcards (
                    identifier, fullname, registryNo, issueDate, photoUrl,
                    dateOfBirth, gender, nationality, bornIn, residence,
                    height, weight, eyesColor, hairColor, employed, signature
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ]], {
                identifier,
                cardData.fullname,
                registryNo,
                issueDate,
                photoUrl,
                cardData.dateOfBirth,
                cardData.gender,
                cardData.nationality,
                cardData.bornIn,
                cardData.residence,
                cardData.height,
                cardData.weight,
                cardData.eyesColor,
                cardData.hairColor,
                cardData.employed,
                cardData.signature
            }, function(success)
                if success then
                    AddInventoryItem(source, Config.ItemName, 1, {description = itemDescription})
                    TriggerClientEvent('idcard:cardSaved', source, fullCardData)
                end
            end)
        end
    end)
end)

RegisterServerEvent('idcard:requestShowCard')
AddEventHandler('idcard:requestShowCard', function(targetServerId)
    local source = source
    local identifier = GetPlayerIdentifierBySource(source)
    
    exports.oxmysql:query('SELECT * FROM idcards WHERE identifier = ?', {identifier}, function(result)
        if result[1] then
            TriggerClientEvent('idcard:showToPlayer', targetServerId, source, result[1])
            ShowNotification(source, Config.Messages.card_shown, 3000)
        else
            ShowNotification(source, Config.Messages.no_card, 3000)
        end
    end)
end)

RegisterServerEvent('idcard:requestOwnCard')
AddEventHandler('idcard:requestOwnCard', function()
    local source = source
    local identifier = GetPlayerIdentifierBySource(source)
    
    exports.oxmysql:query('SELECT * FROM idcards WHERE identifier = ?', {identifier}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('idcard:showOwnCard', source, result[1])
        else
            ShowNotification(source, Config.Messages.no_card, 3000)
        end
    end)
end)

--[[
    ═══════════════════════════════════════════════════════════════════════
    DATABASE SETUP
    ═══════════════════════════════════════════════════════════════════════
--]]

Citizen.CreateThread(function()
    Citizen.Wait(3000)
    
    exports.oxmysql:execute([[
        CREATE TABLE IF NOT EXISTS `idcards` (
            `id` INT(11) NOT NULL AUTO_INCREMENT,
            `identifier` VARCHAR(50) NOT NULL,
            `fullname` VARCHAR(100) NOT NULL,
            `dateOfBirth` VARCHAR(20) DEFAULT NULL,
            `gender` VARCHAR(20) DEFAULT NULL,
            `nationality` VARCHAR(50) DEFAULT NULL,
            `bornIn` VARCHAR(100) DEFAULT NULL,
            `residence` VARCHAR(100) DEFAULT NULL,
            `height` VARCHAR(20) DEFAULT NULL,
            `weight` VARCHAR(20) DEFAULT NULL,
            `eyesColor` VARCHAR(30) DEFAULT NULL,
            `hairColor` VARCHAR(30) DEFAULT NULL,
            `employed` VARCHAR(100) DEFAULT NULL,
            `signature` VARCHAR(100) DEFAULT NULL,
            `registryNo` VARCHAR(20) NOT NULL,
            `issueDate` VARCHAR(20) NOT NULL,
            `photoUrl` VARCHAR(255) DEFAULT 'img/pp.png',
            PRIMARY KEY (`id`),
            UNIQUE KEY `identifier` (`identifier`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]], {}, function(success)
        if success then
            print('[V-IDCard] ^2Database ready^0')
        end
    end)
    
    -- Only check/add items to database for VORP Core
    -- RSG Core uses shared/items.lua instead of database
    if Config.FrameworkType == "vorp" then
        Citizen.Wait(1000)
        exports.oxmysql:query('SELECT * FROM items WHERE item = ?', {'idcard'}, function(result)
            if not result or #result == 0 then
                exports.oxmysql:execute([[
                    INSERT INTO items (item, label, `limit`, can_remove, type, usable) 
                    VALUES (?, ?, ?, ?, ?, ?)
                    ON DUPLICATE KEY UPDATE label = VALUES(label)
                ]], {
                    'idcard',
                    'ID Card',
                    1,
                    1,
                    'item_standard',
                    1
                })
            end
        end)
    elseif Config.FrameworkType == "rsg" then
        -- RSG Core: Automatically add item to RSGCore.Shared.Items at runtime
        local RSGCore = exports['rsg-core']:GetCoreObject()
        if RSGCore then
            -- Check if item already exists
            if not RSGCore.Shared.Items[Config.ItemName] then
                RSGCore.Shared.Items[Config.ItemName] = {
                    name = Config.ItemName,
                    label = 'ID Card',
                    weight = 0,
                    type = 'item',
                    image = 'idcard.png',
                    unique = true,
                    useable = true,
                    shouldClose = true,
                    combinable = nil,
                    description = 'Identification Card'
                }
                print('[V-IDCard] ^2Item "' .. Config.ItemName .. '" automatically added to RSG Core^0')
            else
                print('[V-IDCard] ^2Item "' .. Config.ItemName .. '" already exists in RSG Core^0')
            end
        else
            print('[V-IDCard] ^1ERROR: Could not get RSGCore object for item registration^0')
        end
    end
end)

--[[
    ═══════════════════════════════════════════════════════════════════════
    ITEM USAGE REGISTRATION
    ═══════════════════════════════════════════════════════════════════════
--]]

Citizen.CreateThread(function()
    Citizen.Wait(5000) -- Wait for inventory to load
    
    if Config.FrameworkType == "rsg" then
        -- RSG Core: Use RSGCore.Functions.CreateUseableItem
        local RSGCore = exports['rsg-core']:GetCoreObject()
        if RSGCore then
            RSGCore.Functions.CreateUseableItem(Config.ItemName, function(source, item)
                TriggerClientEvent('idcard:useItem', source)
            end)
            print('[V-IDCard] ^2Usable item registered with RSG Core^0')
        else
            print('[V-IDCard] ^1ERROR: Could not get RSGCore object^0')
        end
    elseif Config.FrameworkType == "vorp" then
        -- VORP Core: Use vorp_inventory API
        local VORPInv = exports.vorp_inventory:vorp_inventoryApi()
        VORPInv.RegisterUsableItem(Config.ItemName, function(data)
            local source = data.source
            TriggerClientEvent('idcard:useItem', source)
        end)
        print('[V-IDCard] ^2Usable item registered with VORP Core^0')
    else
        -- Custom framework fallback
        if Config.Framework and Config.Framework.Inventory and Config.Framework.Inventory.RegisterUsableItem then
            Config.Framework.Inventory.RegisterUsableItem(Config.ItemName, function(data)
                local source = data.source
                TriggerClientEvent('idcard:useItem', source)
            end)
        end
    end
end)