RegisterNUICallback('openOrBuyVInventoryVault', function(data, cb)
    local iban = data and data.iban

    if not iban or iban == '' then
        print('[tp_banks vault fix] Missing IBAN from NUI')
        cb({ ok = false })
        return
    end

    TriggerServerEvent('tp_banks:server:openOrBuyVInventoryVault', iban)

    cb({ ok = true })
end)

RegisterNetEvent('tp_banks:client:buyVaultFromNUI', function(iban)
    print('[tp_banks vault fix] buyVaultFromNUI received:', iban)

    SendNUIMessage({
        action = 'buyVaultFromNUI',
        iban = iban
    })
end)

RegisterNetEvent('tp_banks:client:hideBankingForVault', function()
    SendNUIMessage({
        action = 'hardCloseBanking'
    })

    SetNuiFocus(false, false)
end)