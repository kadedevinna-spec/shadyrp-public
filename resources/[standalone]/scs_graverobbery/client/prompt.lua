---@class PromptManager
local PromptManager = {}

local RSGCore = exports['rsg-core']:GetCoreObject()
local config = require 'shared.config'

-- Track created prompts for cleanup
local createdPrompts = {}

---@param graveId string
---@param coords vector3
---@param grave table
---@return boolean success
function PromptManager.createRummagePrompt(graveId, coords, grave)
    if config.interact ~= "rsg" then
        return false
    end
    
    local promptId = 'grave_rummage_' .. graveId
    
    -- Check if prompt already exists
    if createdPrompts[promptId] then
        if config.debug then
            print("^3[DEBUG] Rummage prompt already exists for grave " .. graveId .. "^7")
        end
        return true
    end
    
    -- Create the rummage prompt
    exports['rsg-core']:createPrompt(
        promptId,
        coords,
        RSGCore.Shared.Keybinds[config.Keybind.rummageThroughDirt],
        config.Prompts.RummageDirt,
        { 
            type = 'client', 
            event = 'scs_graverobbery:client:rummageGrave', 
            args = { grave.coords, tostring(grave.id) } 
        }
    )
    
    -- Track the created prompt
    createdPrompts[promptId] = true
    
    if config.debug then
        print("^2[DEBUG] Created rummage prompt for dug grave " .. graveId .. " at " .. coords.x .. ", " .. coords.y .. ", " .. coords.z .. "^7")
    end
    
    return true
end

---@param graveId string
---@return boolean success
function PromptManager.deleteRummagePrompt(graveId)
    if config.interact ~= "rsg" then
        return false
    end
    
    local promptId = 'grave_rummage_' .. graveId
    
    if createdPrompts[promptId] then
        exports['rsg-core']:deletePrompt(promptId)
        createdPrompts[promptId] = nil
        
        if config.debug then
            print("^3[DEBUG] Deleted rummage prompt for grave " .. graveId .. "^7")
        end
        return true
    end
    
    return false
end

---@return number count
function PromptManager.cleanupAllPrompts()
    local count = 0
    
    for promptId, _ in pairs(createdPrompts) do
        exports['rsg-core']:deletePrompt(promptId)
        count = count + 1
    end
    
    -- Clear the tracking table
    createdPrompts = {}
    
    if config.debug and count > 0 then
        print("^3[DEBUG] Cleaned up " .. count .. " rummage prompts^7")
    end
    
    return count
end

return PromptManager
