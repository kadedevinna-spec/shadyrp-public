-- When a tax is paid on a ranch, the amount will go to this function. Create whatever logic you find necessary for your server's economy.
function GetPayedTaxes(ranchId, money)
    -- if you have btc-business, use the localId of your business and this export:
    -- local localid = 'government'
    -- local addMoney = money
    --   exports['btc-business']:AdministrationTaxes(localId, addMoney)
end

function WhenBuyRanch(ranchId, playerSource)
end

function WhoCanBuyRanch(ranchId, playerSource)
    return true -- if false the ranch buy is cancelled
end

function WhenTransferRanch(ranchId, oldOwnerSource, newOwnerSource)
end

function WhoCanTransferRanch(ranchId, oldOwnerSource, newOwnerSource)
    return true -- if false the ranch transfer is cancelled
end

function WhenDeleteRanch(ranchId)
end

---- if you need remove a ranch use the event:
---- TriggerEvent(btc-ranch:server:deleteRanch, ranchId)
--- dont forget to remove the job of the player

-------------------------------------------------------
----- For that logic you need useOtherTaxesApply = true
--------------------------------------------------------

useOtherTaxesApply = false ---- if true, the taxes use the lógic bellow
function UseOtherTaxesApply(ranchId, ranchMoney)
    ----- use your logic to remove money if you want add a Bank


    ---- use for foreclosed a ranch
    --- UpdateRanchField(ranchId, 'status', 'foreclosed')


    ---- use for active a ranch
    --- UpdateRanchField(ranchId, 'status', 'active')
    --- and
    --- UpdateTaxDate(ranchId)
end

function WhenNeedPayTaxesWithMenu(ranchId, playerSource)
    ----- use your logic to remove money if you want add a Bank


    ---- use for foreclosed a ranch
    --- UpdateRanchField(ranchId, 'status', 'foreclosed')


    ---- use for active a ranch
    --- UpdateRanchField(ranchId, 'status', 'active')
    --- and
    --- UpdateTaxDate(ranchId)
end

-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
