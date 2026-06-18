
local handsUpActive = false

local function ensureAnimDict()
	if HasAnimDictLoaded("script_proc@robberies@homestead@lonnies_shack@deception") then return end
	RequestAnimDict("script_proc@robberies@homestead@lonnies_shack@deception")
	while not HasAnimDictLoaded("script_proc@robberies@homestead@lonnies_shack@deception") do
		Citizen.Wait(0)
	end
end

function RaiseHands()
	ensureAnimDict()
	local ped = PlayerPedId()
	GiveWeaponToPed_2(ped, `WEAPON_UNARMED`, 0, true, false, 0, false, 0.5, 1.0, 0, false, 0.0, false)
	TaskPlayAnim(ped, "script_proc@robberies@homestead@lonnies_shack@deception", "hands_up_loop", 4.0, 4.0, -1, 25, 0.0, false, false, false, '', false)
	SetPedKeepTask(ped, true)
	handsUpActive = true
end

function LowerHands()
	local ped = PlayerPedId()
	if IsEntityPlayingAnim(ped, "script_proc@robberies@homestead@lonnies_shack@deception", "hands_up_loop", 3) then
		StopAnimTask(ped, "script_proc@robberies@homestead@lonnies_shack@deception", "hands_up_loop", 2.0)
	end
	handsUpActive = false
end

function ToggleRaiseHands()
	if handsUpActive then
		LowerHands()
	else
		RaiseHands()
	end
end

function IsHandsUpActive()
	return handsUpActive
end

RegisterNetEvent('handsup:toggle')
AddEventHandler('handsup:toggle', ToggleRaiseHands)

RegisterCommand('handsup', function()
	ToggleRaiseHands()
end, false)

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() ~= resource then return end
    LowerHands()
end)
