-- ╔═══════════════════════════════════════════════════════════════╗
-- ║         M-RAIDS - BANK WAGON DISCORD LOGGING CONFIG          ║
-- ╚═══════════════════════════════════════════════════════════════╝

BankWagonDiscordConfig = {}

BankWagonDiscordConfig.enabled = true

BankWagonDiscordConfig.webhookURL = ""

BankWagonDiscordConfig.webhooks = {
    heists  = "",   -- Robbery started, wagon reached destination, wagon destroyed
    combat  = "",   -- Convoy attacked, all guards dead, dynamite planted
    loot    = "",   -- Loot collected, chest opened
    admin   = "",   -- Admin force-end commands
}

BankWagonDiscordConfig.botName   = "Wagon Dispatch"
BankWagonDiscordConfig.botAvatar = ""

BankWagonDiscordConfig.colors = {
    started     = 3447003,  -- Blue   (#3498DB) - Robbery initiated
    attacked    = 15844367, -- Gold   (#F1C40F) - Convoy under attack
    exploded    = 15158332, -- Red    (#E74C3C) - Dynamite / explosion
    success     = 3066993,  -- Green  (#2ECC71) - Criminals succeeded
    lawWin      = 1752220,  -- Teal   (#1ABC9C) - Law delivered wagon
    npcWin      = 9807270,  -- Grey   (#95A5A6) - NPC convoy delivered (criminals lost)
    loot        = 10181046, -- Purple (#9B59B6) - Loot collected / chest opened
    admin       = 15277667, -- Coral  (#E91E63) - Admin actions
    info        = 16777215, -- White  (#FFFFFF) - Misc
}

BankWagonDiscordConfig.events = {
    robberyStarted      = true,
    convoyAttacked      = true,
    dynamitePlanted     = true,
    allGuardsDead       = false,    -- High volume if guards are large, disabled by default
    lootCollected       = true,
    chestOpened         = true,
    wagonDelivered      = true,     -- Outcome: criminals won / law won / NPC won
    wagonDestroyed      = true,     -- Wagon destroyed before explosion
    adminCommands       = true,
}

BankWagonDiscordConfig.footer        = "M-Raids | Bank Wagon"
BankWagonDiscordConfig.showTimestamp = true
