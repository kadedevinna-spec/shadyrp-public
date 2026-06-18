# DL Missions - Configuration Documentation

This documentation explains how to configure the script completely:

- Base configuration
- Task types and when to use them
- Creating full missions from A to Z
- Assigning tasks correctly to a mission

The examples are based on the current structure in this resource.

## 1. Requirements

1. OxMySQL is installed and running.
2. SQL tables from db_installation.sql are imported.
3. Framework Core and Inventory are active (see server_framework.lua).
4. The resource is started in server.cfg.

## 2. Important Files and Recommended Order

Recommended setup order:

1. configurations/config.lua
2. configurations/mission_configurations/cfg_missionsettings.lua
3. configurations/task_configurations/cfg_task_items.lua &
3. configurations/task_configurations/... (all task definitions)
4. configurations/mission_configurations/... (Daily/Weekly/Monthly/Doctor/Story)

Why this order:

- First global rules and mission limits
- then building blocks (tasks)
- finally missions that reference those tasks

## 3. Base Configuration

In configurations/config.lua you control global behavior:

- Locale and debug
- Mission UI command (for example /myMissions)
- Dialog audio volume
- RandomMissionGivers Npcs
- SpecificMissionGivers Npcs

### RandomMissionGivers

Purpose:

- NPC gives a random mission of one mission category
- respects max_missions from MissionTypeSettings

Good for:

- Daily/Weekly routine content
- repeatable content without a fixed story order

### SpecificMissionGivers

Purpose:

- NPC gives one specific mission by missionName
- ignores max_missions limit of the MissionTypeSettings

Good for:

- important special missions
- event missions
- targeted testing of one mission

## 4. Mission Types and Limits

In configurations/mission_configurations/cfg_missionsettings.lua you define per type:

- timeLimit in hours
- max_missions at the same time
- allowedJobs (only relevant if NextQuestWithNPCs = false, otherwise the missionGiver NPCs are giving the Missions (and they can be joblocked individually) )

Types in current setup:

- Doctor
- Daily
- Weekly
- Monthly

Story missions are handled separately via Config.StoryMissions.





## 5. Task Types: When to Use Which Type

All tasks are stored in configurations/task_configurations.

### Type 1: Travel

Use when:

- player should travel a certain distance
- movement gameplay is the focus

Typical fields:

- targetAmount: meters
- vehicleRequirement: optional, for example horse or boat

Good for:

- travel missions
- scouting tasks

### Type 2: Collection

Use when:

- items must be collected
- either quest items or normal inventory items

Typical fields:

- isQuestItem
- itemName
- targetAmount
- collectionType: position or vehicle
- targetPosition

Good for:

- gathering quests
- supply and loot objectives

### Type 3: Delivery

Use when:

- items must be delivered or placed

deliveryType options:

- npc
- position
- vehicle

Typical fields:

- itemName
- isQuestItem
- targetAmount
- targetPosition
- deliveryTime
- npcDelivery or vehicleDelivery

Good for:

- courier missions
- construction or supply jobs
- multi-step missions after collection

### Type 4: Elimination

Use when:

- specific entities must be killed

Typical fields:

- targetNames
- targetAmount
- weaponRequirement optional

Good for:

- hunting
- combat tasks
- pvp (kill 10 players)

### Type 5: Patrol

Use when:

- locations must be visited
- or a specific player must be found

patrolType:

- position
- player

Typical fields:

- targetPosition with radius
- targetCharacterIDs when patrolType = player

Good for:

- rounds and patrol routes
- checkpoints
- search objectives

### Type 6: Talk

Use when:

- player interaction/dialog with NPC is required

Typical fields:

- targetPosition
- targetNPCModel
- targetNPCName
- targetNPCDialogue

Good for:

- story progression
- info and handover dialogs

### Type 7: Use

Use when:

- an inventory item must be used

Typical fields:

- itemNames
- targetAmount

Good for:

- consumable quests
- medicine and utility item tasks

### Type 8: Interaction

Use when:

- player must perform actions at coordinates
- optionally with animation, prop, marker, and required equipment

Typical fields:

- targetPosition
- interactionEquipment
- interactionOptions.animation
- interactionOptions.prop
- drawMarker and markerSettings

Good for:

- repairs
- work and crafting jobs
- immersive world interactions (repair fence, mob the floor, clean the chimney, clean the tables, etc)

### Type 9: Integration

Use when:

- progress is not detected by this script directly
- another script must report progress

Typical fields:

- targetAmount

Good for:

- cross-script missions
- complex systems like heists, events, minigames

Set progress via exports in other Scripts Server files:

```lua
-- Example: increase progress by task name
exports.dl_missions:addTaskProgressByTaskName(playerSource, "complete_trainrobbery", 1) -- source, taskName, addProgressAmount

-- Alternative by task ID
exports.dl_missions:addTaskProgressById(taskId, 1) -- taskID, addProgressAmount
```

More about existing exports events can be found in section 12.



## 6. Configure Quest Items

If type 2 or type 3 is used with isQuestItem = true, the item must exist in
configurations/task_configurations/cfg_task_items.lua.

Per quest item define:

- label
- model
- carryAnimation optional

Without a valid quest item config, collection/delivery with quest items will not work correctly.



## 7. Create a Complete Mission: Step by Step

This is the standard workflow from creating to assigning tasks.


### Step 1: Choose mission type

Choose one first:

- Daily, Weekly, Monthly, Doctor, or add a new one
- or StoryMission

If Daily/Weekly/Monthly/Doctor/Custom:

- check timeLimit and max_missions in cfg_missionsettings.lua.


### Step 2: Create all required tasks

Create each task definition in the matching file under task_configurations.

Rule:

- every task needs a unique key, for example collect_wood_3
- this key is referenced 1:1 in mission tasks list


### Step 3: Create quest items (if needed)

If a task uses quest items:

- itemName in task must exist in cfg_task_items.lua.


### Step 4: Create mission entry

For time-based mission types:

- open file under mission_configurations/...
- for example cfg_dailymissions.lua
- add new entry under Config.Missions["Daily"]["your_key"]

For Story:

- cfg_storymissions.lua
- add new entry under Config.StoryMissions["your_key"]


IMPORTANT:
- Each Key has to be unique !

Required mission fields:

- title
- description
- missionImage
- tasks
- reward

Important for tasks:

- tasks is an array of task keys
- all referenced task keys must exist in Config.Tasks
- all tasks of that mission are handled together as active tasks


### Step 5: Configure rewards

In reward:

- currency: money, gold, xp, etc.
- items: inventory rewards
- events: optional event/export calls on mission turn-in


### Step 6: Make mission startable (assignment)

You have multiple ways to assign/start a mission:

1. Via RandomMissionGivers in config.lua
2. Via SpecificMissionGivers in config.lua
3. Via Story NPC in cfg_storymissions.lua (if requirements of the mission are met)
4. Via Story follow-up chain (followUpMissions)
5. Via export from another script:

```lua
exports.dl_missions:addMissionByNameToPlayerId("your_mission_key", playerSource)
```

### Step 7: Test

Checklist:

1. Mission appears in UI
2. All task titles and descriptions are correct
3. Every task gets progress
4. Mission completes when all tasks are done
5. Turn-in works
6. Rewards are fully granted


## 8. Full Example: Non Story Mission with Multiple Task Types

### 8.1 Define tasks

```lua
-- In task_configurations/Collection_Tasks/cfg_collectiontasks.lua
Config.Tasks["collect_crates"] = {
    type = 2,
    title = "Pick up the wooden crates",
    description = "Find and pick up the wooden crates",
    
    targetAmount = 3, -- 3 Crates have to be picked up

    isQuestItem = true, -- false = Inventory Item, true = Quest Item
    itemName = "wooden_crate", -- Item-Name of the Inventory Item or Item Name of the Quest Item
    saveQuestItem = true, -- Save the Quest Item in database to be used in future tasks ?

    collectionType = "position", -- position or vehicle

    -- OPTIONAL: Collection Positions (if its a Quest-Item)
    targetPosition = {
        {x = -193.07, y = 631.27, z = 112.40}, -- At this position a Crate will be spawned and can be picked up
        {x = -191.96, y = 633.60, z = 112.37}, -- At this position a Crate will be spawned and can be picked up
        {x = -194.87, y = 628.48, z = 112.40}, -- At this position a Crate will be spawned and can be picked up
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Create",
        zoneradius = 0, -- if this value is greater than 0, an Area Blip will be created instead of a normal one
    },

    -- OPTIONAL: Vehicle Collection Only relevant if collectionType = "vehicle"
    vehicleCollection = {
        useVehicleMissionRef = "", -- Reference to a vehicle that was spawned through the mission, e.g. does not despawn when the task is completed -> Other tasks can interact with this vehicle e.g. Collection Task (taking boxes out of vehicle)
    },
    
    restartable = false
}

-- In task_configurations/Delivery_Tasks/cfg_deliverytasks.lua
Config.Tasks["deliver_crates"] = {
    type = 3,
    title = "Deliver Crates",
    description = "Deliver the wooden crates to the wagon",
    targetAmount = 3, -- Target Amount of crates that should be delivered
    itemName = "wooden_crate", -- Task Item, not an inventory item because isQuestItem = true
    isQuestItem = true,
    
    deliveryType = "vehicle", -- creates will be delivered to a vehicle

    -- Delivery-Position
    targetPosition = {x = -278.41, y = 805.92, z = 118.38}, -- Will be ignored because we use deliveryType = vehicle
    deliveryTime = 2000,

    -- OPTIONAL: NPC Dialog 
    npcDelivery = {
        targetNPCModel = "CS_SheriffOwens", -- Optional, if the item has to be delivered to a npc (is this case not)
        targetNPCName = "Sheriff Anderson",
        targetNPCDialogue = {
        },
    },

    -- Here we assign the vehicle where the crates should be delivered too
    vehicleDelivery = {
        useVehicleMissionRef = "delivery_wagon",
    },

    restartable = false
}

-- In task_configurations/Integration_Tasks/cfg_integrationtasks.lua
Config.Tasks["complete_external_event"] = {
    type = 9,
    title = "Special Assignment",
    description = "Complete the external event",
    targetAmount = 1,
    restartable = false
}
```



### 8.2 Create a non Story mission

```lua
-- In mission_configurations/dailymissions/cfg_dailymissions.lua
Config.Missions["Daily"]["valentine_supply_run"] = {
    title = "Valentine Supply Run",
    description = "Collect crates, deliver them, and finish the special assignment.",
    missionImage = "mission_supply.png",
    
    tasks = {
        "collect_crates",
        "deliver_crates",
        "complete_external_event"
    },

    -- Optional: If a Mission Vehicle should be spawned
    missionVehicles = {
        delivery_wagon = { -- this name is referenced in the task
            model = "supplywagon",
            blip = {
                sprite = 564457427,
                color = "BLIP_MODIFIER_MP_COLOR_10",
                scale = 0.8,
                name = "Delivery Wagon"
            },
            spawnPositions = {
                {x = -229.20, y = 633.85, z = 113.11, h=234.34},
                {x = -219.67, y = 644.42, z = 113.13, h=225.57},
            },
            cargoPropset = "crates"
        },
    },

    reward = {
        currency = {
            money = 120,
            gold = 2,
            xp = 250
        },
        items = {
            {name = "bread", amount = 2}
        },
        events = {}
    },
    restartable = true
}
```

### 8.3 Assign non story mission

Option A: add a SpecificMissionGiver in config.lua.
Option B: the Mission is available with a RandomMissionGiver by the Daily category
Option C: assign directly from another script:

```lua
exports.dl_missions:addMissionByNameToPlayerId("valentine_supply_run", playerSource)
```


### 8.4 Progress integration task

When the external event is completed:

```lua
exports.dl_missions:addTaskProgressByTaskName(playerSource, "complete_external_event", 1)
```



## 9. Configure Story Missions Correctly

A story mission can include in addition to normal mission fields:

- npc: spawn, blip, dialog
- requiredMissions: unlock requirements
- followUpMissions: automatically activate next missions
- failMissionsOnComplete: lock/fail alternative branches
- missionVehicles: mission vehicles for task references

Typical story flow:

1. Intro mission with NPC
2. requiredMissions for follow-up missions
3. optional branching through failMissionsOnComplete
4. optional auto-chain through followUpMissions

## 10. Common Issues

1. Task key in mission does not exist in Config.Tasks.
2. Quest itemName is missing in cfg_task_items.lua.
3. targetAmount does not match number of targetPosition entries.
4. deliveryType or collectionType set incorrectly.
5. Integration task is never progressed by export.
6. MissionTypeSettings entry missing for used mission type.

## 11. Quick Reference: New Mission in 60 Seconds

1. Create task keys.
2. Add quest items if required.
3. Create mission with tasks = {"task_a", "task_b"}.
4. Assign mission via giver, story NPC, or export.
5. Test in game, check turn-in, check rewards.



## 12. Export Functions
# Server Side

1. Open the Mission UI for a Player
```lua
exports.dl_missions:openMissionUI(playerSource)
```

2. Get Mission Object from missionID
```lua
exports.dl_missions:getMissionObjectById(missionID)
```

3. Get Task Object from taskID
```lua
exports.dl_missions:getTaskObjectById(taskID)
```

4. Get Active Mission ID´s from PlayerID
```lua
exports.dl_missions:getActiveMissionIDsByPlayerId(playerSource)
```

5. Get Task ID´s from missionID
```lua
exports.dl_missions:getTaskIDsByMissionId(missionID)
```

6. Add Mission by MissionName to Player
```lua
exports.dl_missions:addMissionByNameToPlayerId(missionName, playerSource)
```

7. Remove Mission by MissionName from Player
```lua
exports.dl_missions:removeMissionByNameFromPlayerId(missionName, playerSource)
```

8. Remove Mission by missionID
```lua
exports.dl_missions:removeMissionById(missionID)
```

9. Set Missionstatus Completed by missionID
```lua
exports.dl_missions:setMissionStatusCompletedById(missionID)
```

10. Set Missionstatus Failed by missionID
```lua
exports.dl_missions:setMissionStatusFailedById(missionID)
```

11. Set Missionstatus Active by missionID
```lua
exports.dl_missions:setMissionStatusActiveById(missionID)
```

12. Does Player has the Mission by MissionName
```lua
exports.dl_missions:doesPlayerHasMission(missionName, playerSource)
```

13. Set Task Status Active by taskID
```lua
exports.dl_missions:setTaskStatusActiveById(taskID)
```

14. Set Task Status Active by taskID
```lua
exports.dl_missions:setTaskStatusCompletedById(taskID)
```

15. Set Task Status Failed by taskID
```lua
exports.dl_missions:setTaskStatusFailedById(taskID)
```

16. Add Progress to Task by taskID
```lua
exports.dl_missions:addTaskProgressById(taskID, addAmount)
```

17. Add Progress to Task by taskName
```lua
exports.dl_missions:addTaskProgressByTaskName(playerSource, taskName, addAmount)
```

18. Remove Progress from Task by taskID
```lua
exports.dl_missions:removeTaskProgressById(taskID, removeAmount)
```

19. Remove Progress from Task by TaskName
```lua
exports.dl_missions:removeTaskProgressByTaskName(playerSource, taskName, removeAmount)
```

# Client Side
1. Open the Mission UI On Client Side
```lua
TriggerEvent('dl_missions:client:openMissionUI')
```

## 13. Admin Commands
1. Give Mission to Player by Mission Name
Usage: /giveMissionByName [source] [missionName] [type]

2. Remove Mission from Player by Mission Name
Usage: /removeMissionByName [source] [missionName] [type]

3. Set Mission Status by Mission Name
Usage: /setMissionStatusByName [source] [missionName] [status]
Possible Status:
1 = Active
2 = Completed
3 = Failed
4 = Turned In

4. Add Progress to Task by Task Name
Usage: /addTaskProgressByName [source] [TaskName] [addAmount]

5. Remove Progress from Task by Task Name
Usage: /removeTaskProgressByName [source] [TaskName] [removeAmount]

6. Get Active MissionID´s from Player
Usage: /getActiveMissionIDsFromPlayer [source]