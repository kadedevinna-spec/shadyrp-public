Config = {}

Config.DistanceSpawn = 20.0 -- Distance before spawning/despawning the ped. (GTA Units.)
Config.FadeIn = true

Config.Key = 'J'
Config.UseTarget = true
Config.BarberCost = 5

Config.BarberLocations =
{
    {
        name = "Valentine",
        barberid = "val-barber",
        npcmodel = `s_m_m_barber_01`,
        npccoords = vector4(-307.96, 814.16, 118.99, 190.93),
        coords = vector3(-307.96, 814.16, 118.99),
        seat = vector4(-306.62, 813.56, 118.75, 90.60),
        camPos = vector3(-307.35, 813.45, 119.61),
        camRot = vector3(-18.29, 0.0, -79.42),
        lighting = vector3(-307.39, 813.43, 119.51),
        showblip = true
    },
    {
        name = "Blackwater",
        barberid = "blk-barber",
        npcmodel = `s_m_m_barber_01`,
        npccoords = vector4(-815.88, -1364.72, 43.75, 268.01),
        coords = vector3(-815.88, -1364.72, 43.75),
        seat = vector4(-815.17, -1368.75, 43.50, 95.5),
        camPos = vector3(-816.06, -1368.76, 44.26),
        camRot = vector3(-10.98, 0.0, -88.66),
        lighting = vector3(-816.46, -1368.77, 44.26),
        showblip = true
    }
}
