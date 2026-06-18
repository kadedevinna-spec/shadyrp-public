--[[
    ╔═══════════════════════════════════════════════════════════════════╗
    ║                      V-IDCARD CONFIGURATION                       ║
    ║                         by Valenor Studio                         ║
    ╚═══════════════════════════════════════════════════════════════════╝
    
    This file contains all settings for the ID Card script.
    Server owners can edit this file to customize the script to their needs.
--]]

Config = {}

--[[
    ═══════════════════════════════════════════════════════════════════════
    FRAMEWORK TYPE SELECTOR
    ═══════════════════════════════════════════════════════════════════════
    
    Change this value to switch between frameworks:
    - "vorp" = VORP Core (default)
    - "rsg"  = RSG Core
    
    The script will automatically configure the correct exports based on
    this selection.
--]]

Config.FrameworkType = "rsg" -- Options: "vorp" or "rsg"

--[[
    ═══════════════════════════════════════════════════════════════════════
    FRAMEWORK SETTINGS (AUTO-CONFIGURED)
    ═══════════════════════════════════════════════════════════════════════
    
    These exports are automatically configured based on Config.FrameworkType.
--]]

-- Framework configurations for each supported framework
local FrameworkConfigs = {
    -- VORP Core Configuration
    vorp = {
        Inventory = {
            AddItem = function(source, itemName, count, metadata)
                exports.vorp_inventory:addItem(source, itemName, count, metadata)
            end,
            RemoveItem = function(source, itemName, count)
                exports.vorp_inventory:subItem(source, itemName, count, nil)
            end,
            RegisterUsableItem = function(itemName, callback)
                local VORPInv = exports.vorp_inventory:vorp_inventoryApi()
                VORPInv.RegisterUsableItem(itemName, callback)
            end
        },
        Notifications = {
            ShowNotification = function(source, message, duration)
                TriggerClientEvent('vorp:TipRight', source, message, duration)
            end,
            ShowNotificationClient = function(message, duration)
                TriggerEvent('vorp:TipRight', message, duration)
            end
        }
    },
    
    -- RSG Core Configuration
    rsg = {
        Inventory = {
            AddItem = function(source, itemName, count, metadata)
                local info = metadata or {}
                local RSGCore = exports['rsg-core']:GetCoreObject()
                if not RSGCore then return false end
                
                local itemData = {
                    name = itemName,
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
                
                if not RSGCore.Shared.Items[itemName] then
                    RSGCore.Shared.Items[itemName] = itemData
                end
                
                local Player = RSGCore.Functions.GetPlayer(source)
                if not Player then return false end
                
                local items = Player.PlayerData.items or {}
                local maxSlots = Player.PlayerData.slots or 40
                
                local slot = nil
                for i = 1, maxSlots do
                    if not items[i] then
                        slot = i
                        break
                    end
                end
                
                if not slot then return false end
                
                items[slot] = {
                    name = itemName,
                    amount = count,
                    info = info,
                    label = itemData.label,
                    description = itemData.description or '',
                    weight = itemData.weight or 0,
                    type = itemData.type or 'item',
                    unique = itemData.unique or false,
                    useable = itemData.useable or true,
                    image = itemData.image or (itemName .. '.png'),
                    shouldClose = itemData.shouldClose or true,
                    slot = slot
                }
                
                Player.Functions.SetPlayerData('items', items)
                TriggerClientEvent('rsg-inventory:client:ItemBox', source, itemData, 'add', count)
                return true
            end,
            RemoveItem = function(source, itemName, count)
                local RSGCore = exports['rsg-core']:GetCoreObject()
                if not RSGCore then return false end
                
                local Player = RSGCore.Functions.GetPlayer(source)
                if not Player then return false end
                
                local items = Player.PlayerData.items or {}
                
                for slot, item in pairs(items) do
                    if item and item.name == itemName then
                        if item.amount > count then
                            items[slot].amount = item.amount - count
                        else
                            items[slot] = nil
                        end
                        Player.Functions.SetPlayerData('items', items)
                        TriggerClientEvent('rsg-inventory:client:ItemBox', source, RSGCore.Shared.Items[itemName], 'remove', count)
                        return true
                    end
                end
                
                return false
            end,
            RegisterUsableItem = function(itemName, callback)
            end
        },
        Notifications = {
            ShowNotification = function(source, message, duration)
                TriggerClientEvent('rsg-core:Notify', source, message, 'primary', duration)
            end,
            ShowNotificationClient = function(message, duration)
                TriggerEvent('rsg-core:Notify', message, 'primary', duration)
            end
        }
    }
}

-- Auto-configure based on FrameworkType
Config.Framework = FrameworkConfigs[Config.FrameworkType]

--[[
    ═══════════════════════════════════════════════════════════════════════
    ID CARD CREATION LOCATIONS
    ═══════════════════════════════════════════════════════════════════════
    
    Coordinates for locations where players can create ID Cards.
    You can add as many locations as you want.
    
    Format: {x = X coord, y = Y coord, z = Z coord, heading = Direction, name = "Location Name"}
--]]

Config.CreateLocations = {
    {x = -798.57, y = -1194.53, z = 43.95, heading = 180.0, name = 'Blackwater Identifer'},   
    {x = 2594.58, y = -1307.08, z = 52.88, heading = 30.0, name = 'Saint Denis Identifer'}, 
} 

--[[
    ═══════════════════════════════════════════════════════════════════════
    PED AND INTERACTION SETTINGS
    ═══════════════════════════════════════════════════════════════════════
--]]

-- NPC model at ID Card creation point
-- To use a different NPC, enter the model hash here
Config.PedModel = 2133848994 

-- NPC interaction distance (meters)
-- Player will see the E key prompt when within this distance
Config.InteractionDistance = 2.0 

-- ID Card show distance (meters)
-- Maximum distance to show card to another player
Config.ShowCardDistance = 3.0

-- Card display duration (milliseconds)
-- How long the receiving player will see the card
Config.ShowCardDuration = 7000

--[[
    ═══════════════════════════════════════════════════════════════════════
    PHOTO SETTINGS
    ═══════════════════════════════════════════════════════════════════════
--]]

-- Default photo on creation screen
Config.DefaultPhoto = 'img/pp.png' 

-- Default photo on card display
Config.DefaultPhotoCard = 'img/pplast.png' 

--[[
    ═══════════════════════════════════════════════════════════════════════
    DATE OF BIRTH VALIDATION
    ═══════════════════════════════════════════════════════════════════════
    
    Year range that players can enter for date of birth.
    Format: DD/MM/YYYY
--]]

Config.DateOfBirth = {
    MinYear = 1820,  -- Minimum year
    MaxYear = 1907   -- Maximum year
}

-- Registry date year (day/month is automatically current date)
Config.RegistryYear = 1899

-- Registry number format (%s = random number)
Config.RegistryFormat = 'WE-%s'

--[[
    ═══════════════════════════════════════════════════════════════════════
    GENDER VALIDATION
    ═══════════════════════════════════════════════════════════════════════
    
    Allow players to only enter specified gender values.
--]]

Config.Gender = {
    Enabled = true,                          -- Enable/disable validation
    AllowedValues = {"Male", "Female"},      -- Allowed values
    CaseSensitive = false                    -- Case sensitivity
}

--[[
    ═══════════════════════════════════════════════════════════════════════
    WEIGHT VALIDATION
    ═══════════════════════════════════════════════════════════════════════
    
    Weight range that players can enter.
    Only numbers are accepted.
--]]

Config.Weight = {
    Enabled = true,   -- Enable/disable validation
    Min = 30,         -- Minimum weight (KG)
    Max = 200,        -- Maximum weight (KG)
    Unit = "KG"       -- Unit (only shown in error messages)
}

--[[
    ═══════════════════════════════════════════════════════════════════════
    HEIGHT VALIDATION
    ═══════════════════════════════════════════════════════════════════════
    
    Height range that players can enter.
    Only numbers are accepted.
--]]

Config.Height = {
    Enabled = true,   -- Enable/disable validation
    Min = 140,        -- Minimum height (CM)
    Max = 210,        -- Maximum height (CM)
    Unit = "CM"       -- Unit (only shown in error messages)
}

--[[
    ═══════════════════════════════════════════════════════════════════════
    BLACKLIST WORDS
    ═══════════════════════════════════════════════════════════════════════
    
    Words that are forbidden when creating an ID Card.
    All fields are checked (name, job, address, etc.)
--]]

Config.BlacklistWords = {
    Enabled = true,   -- Enable/disable blacklist system
    Words = {
        -- Profanity and inappropriate content (add as needed)
        "word1",
        "word2",
    }
}

--[[
    ═══════════════════════════════════════════════════════════════════════
    ITEM SETTINGS
    ═══════════════════════════════════════════════════════════════════════
--]]

-- Item name in inventory
Config.ItemName = 'idcard'

-- Item description (%s = Player name)
Config.ItemDescription = "%s's ID Card"

-- Database usage
Config.UseDatabase = true

--[[
    ═══════════════════════════════════════════════════════════════════════
    MESSAGES
    ═══════════════════════════════════════════════════════════════════════
    
    All notification and UI messages.
    You can translate to any language.
--]]

Config.Messages = {
    -- General messages
    press_e_to_create = 'Create Identification Card',
    card_created = 'Identification Card successfully created!',
    card_updated = 'Identification Card updated!',
    card_shown = 'Identification Card shown!',
    no_card = 'You dont have an Identification Card!',
    no_player_nearby = 'There is no one nearby!',
    wrong_location = 'You cant create an Identification Card here!',
    
    -- Error messages
    invalid_data = 'You provided invalid data!',
    invalid_dob = 'Invalid date of birth! Format: DD/MM/YYYY (Year: %d-%d)',
    invalid_gender = 'Invalid gender! Allowed values: %s',
    invalid_weight = 'Invalid weight! Must be between %d and %d %s',
    invalid_height = 'Invalid height! Must be between %d and %d %s',
    blacklisted_word = 'Your ID Card contains forbidden words!',
    
    -- Process messages
    already_has_card = 'You already have an Identification Card!',
    writing_card = 'Your Identification Card is being prepared...',
    taking_photo = 'Your photo is being taken...',
    photo_taken = 'Your photo for the Identification Card has been taken!'
}