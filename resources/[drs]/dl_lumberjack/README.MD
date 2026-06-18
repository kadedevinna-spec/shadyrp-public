# Installation Guide
Installation Guide for the Frameworks

### VORPCORE
import vorp_redem.sql into your database
edit config.lua ->  change Config.Framework to "vorpcore"
edit Config as you like
add Items you wanna use in your 'items' table in your database (for example: axe, wood_log, wood, wood_plank, wood_small, tree_seed)
ensure dl_lumberjack after all dependencies in your ressource/server.cfg


### RedEM:RP
import vorp_redem.sql into your database
edit config.lua ->  change Config.Framework to "redemrp"
edit Config as you like
add Items you wanna use in the config.lua of the redemrp_inventory script
ensure dl_lumberjack after all dependencies in your ressource/server.cfg


### RSGCore
import rsg.sql into your database
edit config.lua ->  change Config.Framework to "rsgcore"
edit Config as you like
add Items you wanna use in the shared/items.lua file in the rsg-core script
ensure dl_lumberjack after all dependencies in your ressource/server.cfg





# Config Guide
Guide for the config.lua

### Cutting Times
The Time you need to Fell a Tree can be determined by multiple factors. The Base Time you setup in the Config.TimetoCut, the timeScale on the Item your using to Fell the Tree, The Timescale on the Tree itself and the XP of the Player who is cutting the Tree

Example:
Config.TimetoCut = 15
timeScale of the Item your using: 1.0
timeScale of the Tree your Felling: 1.2
Time 15*1.0*1.2 = 18
PlayerXP = 2.3
for every 1.0XP the time gets multiplied by Config.XPTimeMultiplier (example: 0.8)
18*0.8*0.8 = 11.52


### XP Guide
Config.MaxXPGainable is the max xp that is gainable by any player
Config.MaxXPGainableByNonJobsForMultiplier is the max xp for players that are not listed in the Config.JobsForMultiplier
this makes it possible to have players with a certain job have a higher max xp value
Config.JobMultiplier is the xp multiplier players with a job listed in the Config.JobsForMultiplier will have.



JOIN MY DISCORD SERVER FOR NEWS, PATCHES AND SUPPORT
https://discord.gg/sM6aCXp5xu
