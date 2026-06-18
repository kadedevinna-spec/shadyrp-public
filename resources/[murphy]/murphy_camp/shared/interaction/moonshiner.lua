local interaction = "moonshiner"

RegisterNetEvent("murphy_camp:PropInteraction:"..interaction, function (data)
    TriggerEvent("murphy_craft:OpenCraftingMenu", "camp_moonshiner", data.id)
end)