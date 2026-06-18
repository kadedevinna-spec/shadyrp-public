local interaction = "butcher"

RegisterNetEvent("murphy_camp:PropInteraction:" .. interaction, function(data)
    TriggerEvent("dust_chasse:depviande")
end)

