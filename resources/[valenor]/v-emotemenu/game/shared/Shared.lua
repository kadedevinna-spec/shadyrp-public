Config = {}

Config.Debug = true
Config.OpenCommand = "emotemenu"
Config.AnimPosCommand = "animpos" 
Config.MaxDistance = 4.50
Config.HandsUp = true
Config.Ragdoll = true
Config.Crawling = true

Config.Keybinds = {
    ["W"] = 0x8FD015D8,         
    ["S"] = 0x091178D0,         
    ["A"] = 0x7065027D,         
    ["D"] = 0x4D8FB4C1,         
    ["Q"] = 0x06052D11,         
    ["E"] = 0x43F2959C,         
    ["LEFT"] = 0xA65EBAB4,      
    ["RIGHT"] = 0x65F9EC5B,     
    ["ENTER"] = 0x2CD5343E,     
    ["BACKSPACE"] = 0x156F7119,
    ["RAGDOLL"] = 0xD8F73058,
    ["LEFT_CONTROL"] = 0xDB096B85,
    ["CRAWLING"] = 0x26E9DC00,
    ["REQUEST_ACCEPT"] = 0x26E9DC00,
    ["REQUEST_ACCEPT_NAME"] = "Z",
    ["HANDSUP_CANCEL_ANIM"] = 0x7DA48D2A
}

Config.KeyBinds = Config.Keybinds

Config.PropOffsets = {
    ["p_pianochair01x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_stool06x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_benchpiano02x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_stool08x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_chaircomfy04x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_chair14x"] = { position = vector3(0.0, 0.0, 0.55), heading = 0.0 },
    ["p_sit_chairwicker01b"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_sit_chairwicker01a"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["s_crateseat03x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_chairwicker01x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_chairrocking06x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_windsorchair03x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_chair13x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_chair12x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_bistrochair01x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_bistrochair02x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_chairfolding02x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_chair06x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_chair22x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_woodenchair01x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_diningchairs01x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_windsorchair02x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_loveseat01x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_bench06x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_bench17x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_couch05x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_couch08x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_bench_log07x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_windsorbench01x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_bench15x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_seatbench01x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_chairdesk01x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_chairdesk02x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_woodendeskchair01x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_chairoffice02x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_medwheelchair01x"] = { position = vector3(0.0, 0.0, 0.45), heading = 180.0 },
    ["p_chairdoctor01x"] = { position = vector3(0.0, 0.0, 0.55), heading = 180.0 },
    ["p_cs_electricchair01x"] = { position = vector3(0.0, 0.0, 0.65), heading = 180.0 },
    ["s_electricchair01x"] = { position = vector3(0.0, 0.0, 0.65), heading = 180.0 },
}

Config.DefaultPropOffset = {
    position = vector3(0.0, 0.0, 0.55),
    heading = 180.0
}

Config.Interactions = {

 
}

function Notify(text, type, duration)
    print("[" .. type .. "] " .. text, duration)
    TriggerEvent('vorp:TipBottom', text, duration)
end
