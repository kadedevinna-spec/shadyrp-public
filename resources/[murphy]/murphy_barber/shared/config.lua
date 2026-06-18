Config = {}


Config.framework = "rsg-core" --- "vorp" or "REDEMRP2k23" or "rsg-core"
Config.murphy_creator = true --- true if you use murphy_creator
Config.MenuCommand = "barbermenu" --- nil if you don't want a command to open the menu

Config.NativePrompt = true --- if you want to use a prompt to open the menu

Config.OverlayItem = "toilet" ---- Outfit item
Config.Overlayitems = {
    ["eyeliners"] = true,
    ["shadows"] = true,
    ["paintedmasks"] = true,
    ["blush"] = true,
    ["blush2"] = true,
    ["foundation"] = true,
    ["lipsticks"] = true,

    ["eyebrows"] = false,
    ["scars"] = false,
    ["scars2"] = false,
    ["scars3"] = false,
    ["acne"] = false,
    ["beardstabble"] = false,
    ["ageing"] = false,
    ["complex"] = false,
    ["disc"] = false,
    ["freckles"] = false,
    ["grime"] = false,
    ["hairstabble"] = false,
    ["moles"] = false,
    ["spots"] = false,

}


---- props to nil for Saint-Denis, Blackwater and Valentine Saloon, else please insert props information in order to make the menu works
--- three model possible: p_barberchair01x, p_barberchair02x, p_barberchair03x
Config.Shops = { 
    ["Saint-Denis Barber"] = {npcmodel = `s_m_m_barber_01`, npccoords = vector4(2656.16, -1180.87, 53.28, 176.33), coords = vector3(2656.16, -1180.87, 53.28), props = nil},
    ["Blackwater Barber"] = {coords = vector3(-815.4733, -1367.094, 42.75088), props = nil},

    ["Rhodes Barber"] = {coords = vector3(1350.788, -1381.203, 83.28922), props = {model = "p_barberchair01x", rotation = {vector3(0.0, 0.0, 169.46511840820312)}}},
    ["Mountain Barber"] = {coords =  vector3(-2014.7191162109375, 56.47406768798828, 330.779296875), props = {model = "p_barberchair03x", rotation = {vector3(-13.99607181549072, 0.93200272321701, -0.12837082147598)}}},
}


Config.Price = {
    -- Male Head Categories
    ["hair"] = 1,
    ["hair_bonnet"] = 1,
    ["beard"] = 1,
    ["beards_complete"] = 1,
    ["beards_chin"] = 1,
    ["beards_mustache"] = 1,
    ["beards_chops"] = 1,

    ["eyeliners"] = 0.5,
    ["shadows"] = 0.5,
    ["paintedmasks"] = 0.5,
    ["blush"] = 0.5,
    ["blush2"] = 0.5,
    ["foundation"] = 0.5,
    ["lipsticks"] = 0.5,

    ["eyebrows"] = 0.5,
    ["scars"] = 0.5,
    ["scars2"] = 0.5,
    ["scars3"] = 0.5,
    ["acne"] = 0.5,
    ["beardstabble"] = 0.5,
    ["ageing"] = 0.5,
    ["complex"] = 0.5,
    ["disc"] = 0.5,
    ["freckles"] = 0.5,
    ["grime"] = 0.5,
    ["hairstabble"] = 0.5,
    ["moles"] = 0.5,
    ["spots"] = 0.5,
    
  
}