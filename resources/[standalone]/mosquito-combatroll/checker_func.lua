function SubStamina(amount)
    local playerPed = PlayerPedId()
    local stamina = GetPedStamina(playerPed)
    ChangePedStamina(playerPed, -amount)
end

function DoesPlayerHaveStamina(amount)
    local playerPed = PlayerPedId()
    local stamina = GetPedStamina(playerPed)
    return stamina >= amount
end

function IsAllowedToRoll()
    local ped = PlayerPedId()
    local falling = IsPedFalling(ped)
    local jumping = IsPedJumping(ped)
    local vaulting = IsPedVaulting(ped)
    local climbing = IsPedClimbing(ped)
    local sliding = IsPedSliding(ped)
    local ragdolled = IsPedRagdoll(ped)
    local meleecombat = IsPedInMeleeCombat(ped)
    -- local _, weaponHash = GetCurrentPedWeapon(ped, true)

    -- local isMelee = IsWeaponMeleeWeapon(weaponHash)
    -- local isKnife = IsWeaponKnife(weaponHash)
    -- local isLasso = IsWeaponLasso(weaponHash)
    -- local isLantern = IsWeaponLantern(weaponHash)
    -- local isThrowable = IsWeaponThrowable(weaponHash)
    -- local isTorch = IsWeaponTorch(weaponHash)
    -- local isOneHanded = IsWeaponOneHanded(weaponHash)

    -- print("isMelee:", isMelee)
    -- print("isKnife:", isKnife)
    -- print("isLasso:", isLasso)
    -- print("isLantern:", isLantern)
    -- print("isThrowable:", isThrowable)
    -- print("isTorch:", isTorch)
    -- print("isOneHanded:", isOneHanded)

    if (falling == 1 or falling == true or
        jumping == 1 or jumping == true or
        vaulting == 1 or vaulting == true or
        sliding == 1 or sliding == true or
        climbing == 1 or climbing == true or
        meleecombat == 1 or meleecombat == true or
        ragdolled == 1 or ragdolled == true) then
        return false
    end

    -- if (isMelee == true or isMelee == 1 or
    --     isKnife == true or isKnife == 1 or
    --     isLasso == true or isLasso == 1 or
    --     isLantern == true or isLantern == 1 or
    --     isTorch == true or isTorch == 1) then
    --     return true
    -- end

    -- return false
    return true
end