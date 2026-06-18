local interaction = "stewpot"

RegisterNetEvent("murphy_camp:PropInteraction:"..interaction, function (data)
    TriggerEvent("murphy_craft:OpenCraftingMenu", "camp_stewpot", data.id)
end)