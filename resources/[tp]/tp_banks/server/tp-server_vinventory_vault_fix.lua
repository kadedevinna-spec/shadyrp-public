print('[tp_banks vault fix] robust vault version loaded')

RegisterNetEvent('tp_banks:server:openOrBuyVInventoryVault', function(iban)
    local src = source

    if not iban or iban == '' then
        print('[tp_banks vault fix] Missing IBAN')
        return
    end

    exports.oxmysql:query(
        'SELECT * FROM tp_bank_accounts WHERE iban = ? LIMIT 1',
        { iban },
        function(result)
            if not result or not result[1] then
                print('[tp_banks vault fix] No account found for IBAN:', iban)
                return
            end

            local row = result[1]

            print('[tp_banks vault fix] account row:', json.encode(row))

            -- TP Banks may store vault/container status as:
            -- container = 1
            -- container = "1"
            -- container = "bank_GR..."
            -- container_id = "bank_GR..."
            -- vault/storage fields depending on version
            local rawContainer = row.container
            local containerId = row.container_id or row.containerId or row.storage or row.vault

            local hasVault = false

            if rawContainer ~= nil then
                local c = tostring(rawContainer)

                if c ~= '' and c ~= '0' and c ~= 'false' and c ~= 'nil' then
                    hasVault = true
                end
            end

            if containerId ~= nil then
                local cid = tostring(containerId)

                if cid ~= '' and cid ~= '0' and cid ~= 'false' and cid ~= 'nil' then
                    hasVault = true
                end
            end

            if hasVault then
                local stashId = nil

                if containerId and tostring(containerId) ~= '' and tostring(containerId) ~= '0' then
                    stashId = tostring(containerId)
                elseif rawContainer and tostring(rawContainer):find('bank_') then
                    stashId = tostring(rawContainer)
                else
                    stashId = 'bank_' .. iban
                end

                print('[tp_banks vault fix] Opening vault:', stashId)

                -- Hide/close the banking UI first so v-inventory is not cluttered
                TriggerClientEvent('tp_banks:client:hideBankingForVault', src)

                -- Small delay so the bank UI has time to close before inventory opens
                SetTimeout(250, function()
                    exports['rsg-inventory']:OpenInventory(src, stashId, {
                        label = 'Bank Vault',
                        slots = 50,
                        maxweight = 50000
                    })
                end)

                return
            end

            print('[tp_banks vault fix] No vault yet, buying vault for:', iban)

            TriggerClientEvent('tp_banks:client:buyVaultFromNUI', src, iban)
        end
    )
end)