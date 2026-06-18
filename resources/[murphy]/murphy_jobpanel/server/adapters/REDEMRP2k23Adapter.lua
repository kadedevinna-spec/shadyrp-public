if Config.framework == "REDEMRP2k23" then
    Inventory = {}

    TriggerEvent("redemrp_inventory:getData", function (data)
        Inventory = data
    end)

    local RedEM = exports["redem_roleplay"]:RedEM()
    
    
    function GetCharJob(targetID)
        local user = RedEM.GetPlayer(targetID)
        if user then 
            job = RedEM.GetPlayer(targetID).job
        else job = nil end
        return job
    end

    function GetCharJobGrade(targetID) 
        local user = RedEM.GetPlayer(targetID)
        if user then 
            jobgrade = RedEM.GetPlayer(targetID).jobgrade
        else jobgrade = nil end
        return jobgrade
    end
    
    function GetCharIdentifier(targetID)
        local user = RedEM.GetPlayer(targetID)
        local citizenid = nil
        if user then 
            citizenid = RedEM.GetPlayer(targetID).citizenid
        end
        return citizenid
    end
    
    function GetCharFirstname(targetID)
        return RedEM.GetPlayer(targetID).firstname
    end
    
    function GetCharLastname(targetID)
        return RedEM.GetPlayer(targetID).lastname
    end
    
    function GetCharMoney(targetID)
        return RedEM.GetPlayer(targetID).money
    end
    
    function RemoveCurrency(targetID, amount)
        RedEM.GetPlayer(targetID).RemoveMoney(tonumber(amount))
    end

    function AddCurrency(targetID, amount)
        RedEM.GetPlayer(targetID).AddMoney(tonumber(amount))
    end
    
    function GetCharGroup(targetID)
        return RedEM.GetPlayer(targetID).group
    end
    
    function GiveItem(src, item, amount, meta)
        local _meta = meta
        local ItemData = Inventory.getItem(src, item, _meta)
        local result = ItemData.AddItem(amount)
        return result
    end
    
    function RemoveItem(src, item, amount, meta)
        local _meta = meta
        local ItemData = Inventory.getItem(src, item, _meta)
        local result = ItemData.RemoveItem(amount)
        return result
    end

    function GetItemAmount(src, item)
        local ItemData = Inventory.getItem(src, item)
        return ItemData.ItemAmount
    end

    function OpenStash(src, stash, weight)
        TriggerClientEvent("redemrp_inventory:OpenStash", src, stash, weight)
    end

    function SetCharJob(targetID, job)
        local user = RedEM.GetPlayer(targetID)
        user.SetJob(job)    
    end

    function SetCharJobGrade(targetID, jobgrade)
        local user = RedEM.GetPlayer(targetID)
        user.SetJobGrade(jobgrade)    
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
                            local trgtuser = RedEM.GetPlayer(v.id)
                            local sourcetrgt = v.id
                            trgtuser.SetJob("unemployed")
                            trgtuser.SetJobGrade(0)
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