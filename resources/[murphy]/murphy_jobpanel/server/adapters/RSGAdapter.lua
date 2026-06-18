if Config.framework == 'rsg-core' then
    local CORE = exports['rsg-core']:GetCoreObject()

    function GetCharJob(targetID)
        targetID = tonumber(targetID)
        local user = CORE.Functions.GetPlayer(targetID)
        if user then 
            job = CORE.Functions.GetPlayer(targetID).PlayerData.job.name
        else job = nil end
        return job
    end

    function GetCharJobGrade(targetID) 
        targetID = tonumber(targetID)
        local user = CORE.Functions.GetPlayer(targetID)
        if user then 
            job = CORE.Functions.GetPlayer(targetID).PlayerData.job.grade.level
        else job = nil end
        return job
    end

    function GetCharIdentifier(targetID)
        targetID = tonumber(targetID)
        if CORE.Functions.GetPlayer(targetID) then
            local result = CORE.Functions.GetPlayer(targetID).PlayerData.citizenid
            return result
        else
            return false
        end
    end

    function GetCharFirstname(targetID)
        targetID = tonumber(targetID)
        return CORE.Functions.GetPlayer(targetID).PlayerData.charinfo.firstname
    end

    function GetCharLastname(targetID)
        targetID = tonumber(targetID)
        return CORE.Functions.GetPlayer(targetID).PlayerData.charinfo.lastname
    end

    function GetCharMoney(targetID)
        targetID = tonumber(targetID)
        return CORE.Functions.GetPlayer(targetID).PlayerData.money["cash"]
    end

    function AddCurrency(targetID, amount)
        targetID = tonumber(targetID)
        local Player = CORE.Functions.GetPlayer(targetID)
        Player.Functions.AddMoney("cash", amount)
    end

    function RemoveCurrency(targetID, amount)
        targetID = tonumber(targetID)
        local Player = CORE.Functions.GetPlayer(targetID)
        Player.Functions.RemoveMoney("cash", amount)
    end

    function GetCharGroup(targetID)
        targetID = tonumber(targetID)
        local permissions = CORE.Functions.GetPermission(targetID)
        for k, v in pairs(permissions) do
            return k
        end
    end
    
    function GiveItem(src, item, amount, meta)
        local Player = CORE.Functions.GetPlayer(src)
        local _meta = meta
        local result = Player.Functions.AddItem(item, amount)
        return result
    end
    
    function RemoveItem(src, item, amount, meta)
        local Player = CORE.Functions.GetPlayer(src)
        local _meta = meta
        local result = Player.Functions.RemoveItem(item, amount)
        return result
    end

    function GetItemAmount(src, item)
        local Player = CORE.Functions.GetPlayer(src)
        local _meta = meta
        local result = Player.Functions.GetItemByName(item, amount)
        if result then
            amount = result.amount
        else
            amount = 0
        end

        return amount
    end

    function OpenStash(src, stash, weight)
        TriggerClientEvent("murphy_job:openstash", src, "stash", stash, false, {
            maxweight = weight,
            slots = 25,
        })
    end

    function SetCharJob(targetID, job)
        CORE.Functions.SetJob(targetID, job, 1)
        return 
    end

    function SetCharJobGrade(targetID, jobgrade)
        CORE.Functions.SetJob(targetID, CORE.Functions.GetPlayer(targetID).PlayerData.job.name, jobgrade)
    end

    function GetFireList(job)
        local FireList = {}
        local Employees = MySQL.query.await("SELECT * FROM players WHERE job = :job", { job = job })
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
                local Employee = MySQL.query.await("SELECT * FROM players WHERE identifier = :identifier AND characterid = :charid", { identifier = id, charid = charid })
                if Employee[1] then
                    Employee = Employee[1]
                    if Employee.identifier == id and Employee.characterid == charid then
                        MySQL.query.await("UPDATE players SET job = 'unemployed', jobgrade = 0 WHERE identifier = :identifier AND characterid = :charid", { identifier = id, charid = charid })
                        TriggerClientEvent("murphy_job:client:OpenBossMenu", _source, JobLedgers[job])
                    end
                    for k, v in pairs(FireList) do
                        if v.steam == id and v.charid == charid then
                            local sourcetrgt = v.id
                            SetCharJob(sourcetrgt, "unemployed")
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
