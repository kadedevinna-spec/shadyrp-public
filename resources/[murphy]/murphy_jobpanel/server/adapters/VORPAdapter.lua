if Config.framework == 'vorp' then
    VorpInv = exports.vorp_inventory:vorp_inventoryApi()
    
    local VorpCore = {}
    
    TriggerEvent("getCore",function(core)
        VorpCore = core
    end)
    
    
    function GetCharJob(targetID) 
        local user = VorpCore.getUser(targetID)
        if user then 
            job = VorpCore.getUser(targetID).getUsedCharacter.job
        else job = nil end
        return job
    end

    function GetCharJobGrade(targetID) 
        local user = VorpCore.getUser(targetID)
        if user then 
            job = VorpCore.getUser(targetID).getUsedCharacter.jobGrade
        else job = nil end
        return job
    end
    
    function GetCharIdentifier(targetID)
        return VorpCore.getUser(targetID).getUsedCharacter.charIdentifier
    end
    
    function GetCharFirstname(targetID)
        return VorpCore.getUser(targetID).getUsedCharacter.firstname
    end
    
    function GetCharLastname(targetID)
        return VorpCore.getUser(targetID).getUsedCharacter.lastname
    end
    
    function GetCharMoney(targetID)
        return VorpCore.getUser(targetID).getUsedCharacter.money
    end

    function AddCurrency(targetID, amount)
        VorpCore.getUser(targetID).getUsedCharacter.addCurrency(0, amount)
    end
    
    function RemoveCurrency(targetID, amount)
        VorpCore.getUser(targetID).getUsedCharacter.removeCurrency(0, amount)
    end
    
    function GetCharGroup(targetID)
        return VorpCore.getUser(targetID).getUsedCharacter.group
    end

    function GiveItem(src, item, amount, meta)
        local _meta = meta
        local result = VorpInv.addItem(src, item, amount, _meta)
        return result
    end

    function RemoveItem(src, item, amount, meta)
        local _meta = meta
        local result = VorpInv.subItem(src, item, amount, _meta)
        return result
    end

    function GetItemAmount(src, item)
        local ItemData = VorpInv.getItemCount(src, item)
        return ItemData
    end

    function OpenStash(src, stash, weight)
        if exports.vorp_inventory:isCustomInventoryRegistered(stash) then
            VorpInv.OpenInv(src, stash)
        else
            --- register custom inventory
            exports.vorp_inventory:registerInventory({ 
            id = stash,
            name = stash,
            limit = weight,
            acceptWeapons = true,
            shared = true,
            limitedItems = {},
            ignoreItemStackLimit = true,
            whitelistItems = false,
            PermissionTakeFrom = {},
            PermissionMoveTo = {},
            UsePermissions = false,
            UseBlackList = false,
            BlackListItems = {},
            whitelistWeapons = false,
            limitedWeapons = {} 
        })
        VorpInv.OpenInv(src, stash)
        end
    end

    function SetCharJob(targetID, job)
        local Character = VorpCore.getUser(targetID).getUsedCharacter
        Character.setJob(job)
    end

    function SetCharJobGrade(targetID, jobgrade)
        local Character = VorpCore.getUser(targetID).getUsedCharacter
        Character.setJobGrade(jobgrade)
    end

    
    function GetFireList(job)
        local FireList = {}
        local Employees = MySQL.query.await("SELECT * FROM characters WHERE job = :job", { job = job })
        for _,Employee in pairs(Employees) do
            table.insert(FireList, {char = Employee.firstname.." "..Employee.lastname, name = "OFFLINE", id = Employee.identifier, charid = Employee.characterid})
        end
        return FireList
    end

    function FireChar(_source, job, id, charid)
        local FireList = {}
        for _,targetId in ipairs(GetPlayers()) do
                local targetJob = GetCharJob(targetId)
                if targetJob == job then
                    local targetName = GetCharFirstname(targetId) .. " " ..  GetCharLastname(targetId)
                    local characterid = targetUser.charid
                    local identifier = targetUser.identifier
                    table.insert(FireList, {char = targetName,  charid = characterid , steam = identifier, id = tonumber(targetId)})
                end
        end
        if JobsConfig[job] then
            if JobsConfig[job].Grades[grade].Personnel then
                local Employee = MySQL.query.await("SELECT * FROM characters WHERE identifier = :identifier AND characterid = :charid", { identifier = id, charid = charid })
                if Employee[1] then
                    Employee = Employee[1]
                    if Employee.identifier == id and Employee.characterid == charid then
                        MySQL.query.await("UPDATE characters SET job = 'unemployed', jobgrade = 0 WHERE identifier = :identifier AND characterid = :charid", { identifier = id, charid = charid })
                        TriggerClientEvent("murphy_job:client:OpenBossMenu", _source, JobLedgers[job])
                    end
                    for k, v in pairs(FireList) do
                        if v.steam == id and v.charid == charid then
                            local sourcetrgt = v.id
                            local Character = VorpCore.getUser(sourcetrgt).getUsedCharacter
                            Character.setJob("unemployed")
                            Character.setJobGrade(0)
                            TriggerEvent("murphy_menu:server:RequestJob", sourcetrgt)
                        end
                    end
                end
            end
        end
    end

    function DoPay()
        for _,playerId in ipairs(GetPlayers()) do
            local id = tonumber(playerId)
            local job = GetCharJob(id)
            local grade = tonumber(GetCharJobGrade(id))
            if JobsConfig[job] then
                if JobsConfig[job].Grades[grade] then
                    if JobsConfig[job].Grades[grade].Pay then
                        local pay = JobsConfig[job].Grades[grade].Pay
                        local citizenid = GetCharIdentifier(id)
                        TriggerEvent('murphy_banking:dopay', citizenid, pay)
                    end
                end
            end
        end
    end

    function IsJobOnline(job)
        local result = false
        for _,targetId in ipairs(GetPlayers()) do
            local targetJob = GetCharJob(targetId)
            if targetJob == job then
                result = true
            end
        end
        return result
    end
end
