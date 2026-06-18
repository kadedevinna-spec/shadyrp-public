

-----------------------------------------------------------
--[[ API Events ]]--
-----------------------------------------------------------

/* 
   We provide the events in purpose to change the trigger 
   event names if anyone is interested.
*/

-- @param iban    : The IBAN from a Banking Account.
-- @param reason  : The reason of the transaction bill.
-- @param account : "cash", "gold"
-- @param cost    : The cost of the transaction bill that was successfull.
RegisterServerEvent('tp_banks:server:createTransactionHistoryRecord')
AddEventHandler('tp_banks:server:createTransactionHistoryRecord', function(iban, reason, account, cost)
  CreateTransactionHistoryRecord(iban, reason, account, cost)
end)

-- @param iban    : The IBAN from a Banking Account.
-- @param reason  : The reason of the transaction bill.
-- @param account : "cash", "gold"
-- @param cost    : The cost of the transaction bill that was successfull.
RegisterServerEvent('tp_banks:server:createBill')
AddEventHandler('tp_banks:server:createBill', function(iban, reason, account, cost)
  CreateBill(iban, reason, account, cost)
end)

-----------------------------------------------------------
--[[ Functions ]]--
-----------------------------------------------------------

-- The specified function @DepositGovernmentBanksSharedAmount() is executed on deposits or transfers that have fees.
-- It is used for adding money on the Bank Accounts for the robberies (not player bank accounts, real banks).
function DepositGovernmentBanksSharedAmount(amount)

    local Accounts = GetAccounts()

    local count, banks = 0, {}

    for index, account in pairs (Accounts) do

        -- We check if the bank account does NOT belong to a player but the system itself by checking
        -- for "0" on identifier and charidentifier.
        if tostring(account.identifier) == '0' and tostring(account.charidentifier) == '0' then

            count = count + 1 -- We need the total BANKS count so we can calculate the amount of money.
            table.insert(banks, account.iban) -- We insert the BANK to the banks list.
        end

    end

    -- After getting the count and banks (system banks), we calculate the amount of money
    -- in order to be shared properly to all banks because if we don't, the rest banks who are far away
    -- might never be able to be robbed if there are barely any transactions.
    if count > 0 then

        -- If received amount is 10 from a transfer, total bank accounts are 5, each bank receives 2.
        local sharedAmount = ( amount / count )

        for index, iban in pairs (banks) do
            DepositAccount(iban, 'TAX RECEIVED', 'cash', sharedAmount)
        end

    end

end


-- @param source       : returns the online player id (source) who performed the payment - (integer)
-- @param iban         : returns the iban account - (string)

-- @param data         : returns the paid bill data (the bill has been permanently removed already, we provide only the data.) - (table form)
-- @param data.reason  : returns the reason of the bill transaction.
-- @param data.issuer  : returns the issuer.
-- @param data.account : returns the transaction account type (cash or gold).
-- @param data.cost    : returns the cost (amount) of the bill.
-- @param data.date    : returns the date that a bill transaction has been created.

-- (!) What is the point of the specified function? The point is to support scripts of your own or from other developers for bill transactions.
-- How can this be done? 

-- Lets say we are paying a saloon job that created a bill, what we want to check if the bill was created properly, is the reason and the issuer.
-- Through the data that we provide, we would check if the reason is "ALCOHOL" and the issuer (the job name) should be "valentinesaloon" <= job name.
-- By that, we would be able to create a great system for deposits on a society script.
function OnExecuteBillPayment(source, iban, data)

end

-- @param bankName            : returns the name of the bank that gets robbed (VALENTINE, RHODES, etc.).
-- @param jobList             : returns a table form.
-- @param jobList.count       : returns the total players with the required police job.
-- @param jobList.players     : returns the players on a table form.
function NotifyPolice(bankName, jobList)

	if jobList.count > 0 then
        
		for _i, allowedPlayer in pairs (jobList.players) do

            allowedPlayer.source = tonumber(allowedPlayer.source)

            local BankLabel  = Config.Banks[bankName].Name
            local NotifyData = Locales['BANK_ROBBERY_STARTED_ALERT']
            
            TriggerClientEvent("tp_notify:sendNotification", allowedPlayer.source, NotifyData.title, string.format(NotifyData.message, BankLabel), NotifyData.icon, "info", NotifyData.duration)
        
		end

	end
    
end