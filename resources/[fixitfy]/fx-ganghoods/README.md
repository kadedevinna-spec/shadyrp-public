## SETUP
- Put the file into resource
- Start the script in server.cfg file

### For developers

| Doors                     | Doorhashes
|---------------------------|----------------------------------------------------------------------------------|
--- Hood 1
| bkgangdoor1              | [1610288065] = {1610288065,-798350419,"p_door_val_jail_cell01x",-1532.728759765625,-298.62115478515625,125.10967254638672}
| bkgangdoor2              | [643242106] = {643242106,-798350419,"p_door_val_jail_cell01x",-1531.1500244140625,-302.2300109863281,125.10967254638672}
--- Hood 2
| bkgangdoor3              | [947698885] = {947698885,-798350419,"p_door_val_jail_cell01x",-2204.989013671875,-917.3441772460938,114.26567077636719}
| bkgangdoor4              | [3571185029] = {3571185029,-798350419,"p_door_val_jail_cell01x",-2203.410400390625,-920.9525756835938,114.26567077636719}
--- Hood 3
| bkgangdoor5              | [2789775455] = {2789775455,-798350419,"p_door_val_jail_cell01x",-2741.239013671875,-2656.582275390625,65.50337219238281}
| bkgangdoor6              | [1900195408] = {1900195408,-798350419,"p_door_val_jail_cell01x",-2739.659912109375,-2660.191162109375,65.50337219238281}
--- Hood 4
| bkgangdoor7              | [3267055940] = {3267055940,-798350419,"p_door_val_jail_cell01x",-5909.9091796875,-2754.327880859375,-8.06146240234375}
| bkgangdoor8              | [3755772806] = {3755772806,-798350419,"p_door_val_jail_cell01x",-5908.330078125,-2757.93701171875,-8.06146335601806}
--- Hood 5
| bkgangdoor9              | [4048563821] = {4048563821,-798350419,"p_door_val_jail_cell01x",-199.7098846435547,1364.4178466796875,164.60267639160156}
| bkgangdoor10             | [3659084077] = {3659084077,-798350419,"p_door_val_jail_cell01x",-198.1310272216797,1360.8089599609375,164.60267639160156}



### LOCATİON
Hood1
-1505.6783, -306.8435, 127.9488, 260.5080
Hood2
-2178.9587, -924.0596, 116.6982, 129.1055
Hood3
 -2714.2134, -2664.5239, 68.6833, 116.4121
Hood4
-5883.3540, -2759.6484, -4.3372, 17.2003 
Hood5
-171.3043, 1354.5363, 168.0547, 96.5605

### DOORLOCKS SCRIPT
```lua
	--- ############## FIXITFY UNDER GANG HOOD ##################################
	----------##################-----------------------------
	--- Hood 1 Jail doors
	{
		authorizedJobs = {'sheriff', 'offsheriff', 'police', 'offpolice'},
		authorizedItem = 'lockpick',
		canlockbreak = false,
		object = 1610288065
		objCoords  = vector3(-1532.728759765625,-298.62115478515625,125.10967254638672),
		textCoords  = vector3(-1532.398, -299.579, 126.28),
		objYaw = -65.62,
		locked = true,
		distance = 1.2
	},
	
	{
		authorizedJobs = {'sheriff', 'offsheriff', 'police', 'offpolice'},
		authorizedItem = 'lockpick',
		canlockbreak = true,
		object = 643242106,
		objCoords  = vector3(-1531.1500244140625,-302.2300109863281,125.10967254638672),
		textCoords  = vector3(-1530.824,-303.23,126.22),
		objYaw = -65.99,
		locked = true,
		distance = 1.3
	},
	
	--- Hood 2 Jail doors
	{
		authorizedJobs = {'sheriff', 'offsheriff', 'police', 'offpolice'},
		authorizedItem = 'lockpick',
		canlockbreak = false,
		object = 947698885,
		objCoords  = vector3(-2204.989013671875,-917.3441772460938,114.26567077636719),
		textCoords  = vector3(-2204.600, -918.303, 115.49),
		objYaw = -65.9,
		locked = true,
		distance = 1.2
	},
	
	{
		authorizedJobs = {'sheriff', 'offsheriff', 'police', 'offpolice'},
		authorizedItem = 'lockpick',
		canlockbreak = true,
		object = 3571185029	,
		objCoords  = vector3(-2203.410400390625,-920.9525756835938,114.26567077636719),
		textCoords  = vector3(-2203.068,-921.90,115.49),
		objYaw = -66.3,
		locked = true,
		distance = 1.3
	},
	
	--- Hood 3 Jail doors
	{
		authorizedJobs = {'sheriff', 'offsheriff', 'police', 'offpolice'},
		authorizedItem = 'lockpick',
		canlockbreak = false,
		object = 2789775455,
		objCoords  = vector3(-2741.239013671875,-2656.582275390625,65.50337219238281),
		textCoords  = vector3(-2740.873, -2657.552, 66.67),
		objYaw = -65.9,
		locked = true,
		distance = 1.2
	},
	
	{
		authorizedJobs = {'sheriff', 'offsheriff', 'police', 'offpolice'},
		authorizedItem = 'lockpick',
		canlockbreak = true,
		object = 1900195408,
		objCoords  = vector3(-2739.659912109375,-2660.191162109375,65.50337219238281),
		textCoords  = vector3(-2739.306,-2661.156,66.67),
		objYaw = -66.01,
		locked = true,
		distance = 1.3
	},
	--- Hood 4 Jail doors
	{
		authorizedJobs = {'sheriff', 'offsheriff', 'police', 'offpolice'},
		authorizedItem = 'lockpick',
		canlockbreak = false,
		object = 3267055940,
		objCoords  = vector3(-5909.9091796875,-2754.327880859375,-8.06146240234375),
		textCoords  = vector3(-5909.562,-2755.303, -6.86),
		objYaw = -65.9,
		locked = true,
		distance = 1.2
	},
	
	{
		authorizedJobs = {'sheriff', 'offsheriff', 'police', 'offpolice'},
		authorizedItem = 'lockpick',
		canlockbreak = true,
		object = 3755772806,
		objCoords  = vector3(-5908.330078125,-2757.93701171875,-8.06146335601806),
		textCoords  = vector3(-5908.001,-2758.906,-6.86),
		objYaw = -65.7,
		locked = true,
		distance = 1.3
	},
	--- Hood 5 Jail doors
	{
		authorizedJobs = {'sheriff', 'offsheriff', 'police', 'offpolice'},
		authorizedItem = 'lockpick',
		canlockbreak = false,
		object = 4048563821,
		objCoords  = vector3(-199.7098846435547,1364.4178466796875,164.60267639160156),
		textCoords  = vector3(-199.351,1363.470,165.78),
		objYaw = -65.9,
		locked = true,
		distance = 1.2
	},
	
	{
		authorizedJobs = {'sheriff', 'offsheriff', 'police', 'offpolice'},
		authorizedItem = 'lockpick',
		canlockbreak = true,
		object = 3659084077,
		objCoords  = vector3(-198.1310272216797,1360.8089599609375,164.60267639160156),
		textCoords  = vector3(-197.770,1359.849,165.83),
		objYaw = -65.9,
		locked = true,
		distance = 1.3
	},
	

```