Config = {}
Config.PortLocations = {}

-----------------------------------------------------------
-- settings
-----------------------------------------------------------
Config.TicketCost = 10
Config.DistanceSpawn = 20.0
Config.FadeIn = true
Config.TravelCooldown = 30
Config.BuyCooldown = 5
Config.MaxTickets = 10

-----------------------------------------------------------
-- blip settings
-----------------------------------------------------------
Config.Blip = {
    blipName   = 'Port', -- Config.Blip.blipName
    blipSprite = 'blip_ambient_riverboat', -- Config.Blip.blipSprite
    blipScale  = 0.2 -- Config.Blip.blipScale
}

-----------------------------------------------------------
-- port settings
-----------------------------------------------------------
--Config.PortLocations = {
--
--    {
--        name          = 'Saint Denis Port',
--        ticketprompt  = 'port-stdenis-ticket',
--		ticketlable   = 'Buy a Ticket',
--		travellable   = 'Travel to Guarma',
--		travelprompt  = 'port-stdenis-travel',
--        coords        = vector3(2663.5056, -1543.155, 45.969764),
--		ticketkeybind = 'ENTER',
--		travelkeybind = 'J',
--        npcmodel      = `u_m_o_rigtrainstationworker_01`,
--        npccoords     = vector4(2662.3156, -1541.951, 45.969783, 265.44274),
--        currentport   = 'stdenis',
--        traveldest    = 'guarma',
--        showblip      = true
--    },
--	
--    {
--        name          = 'Guarma Port',
--        ticketprompt  = 'port-guarma-ticket',
--		ticketlable   = 'Buy a Ticket',
--		travellable   = 'Travel to Saint Denis',
--		travelprompt  = 'port-guarma-travel',
--        coords        = vector3(1268.6583, -6851.772, 43.318504),
--		ticketkeybind = 'ENTER',
--		travelkeybind = 'J',
--        npcmodel      = `u_m_o_rigtrainstationworker_01`,
--        npccoords     = vector4(1268.4835, -6850.459, 43.318496, 212.38269),
--        currentport   = 'guarma',
--        traveldest    = 'stdenis',
--        showblip      = true
--    },
--    
--}
