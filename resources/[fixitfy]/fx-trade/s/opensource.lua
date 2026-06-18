if Config.OpenTradeCommand then
    RegisterCommand(Config.OpenTradeCommand,function(source,args) -- With Player Selection
        TriggerClientEvent('fx-trade:client:playerSeleciton',source)
    end)
end

RegisterNetEvent('fx-trade:server:sendTrade',function(target)
    openTradeFunc(source,target)
end)



-- RegisterCommand('opentrade',function(source,args) -- With Command
--     openTradeFunc(source,args[1])
-- end)