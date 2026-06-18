# Murphy Job Panel Configuration Guide

## Introduction
This guide will help you configure the job system for the Murphy Job Panel. The job system allows you to create various types of jobs with different tasks and rewards.

## Dependencies

### Oxmysql

Oxmysql is required for database interactions. Ensure you have Oxmysql installed and configured. Refer to the [Oxmysql documentation](https://overextended.github.io/docs/oxmysql/) for installation and setup instructions.

### murphy_notify

Murphy Notify is used for displaying notifications to the player. Ensure you have murphy_notify installed and configured.

## Configuration Files

### config.lua

The `config.lua` file contains the main configuration settings for the job panel. You need to specify the framework you are using and the locations of the job panels.

#### Parameters

- `Config.framework`: Specifies the framework you are using. Options include `qbr-core`, `REDEMRP2k23`, `redemrp2022`, `rsg-core`, and `vorp`.
- `Config.Panel`: A table containing the job panel locations. Each entry specifies the model, coordinates, and rotation of a job panel. The key in this table is important as it corresponds to the `board` field in the job data.

Example:
```lua
Config.Panel = {
    ["armadillo"] = {
        model = "mp005_p_mp_bountyboard01x",
        coords = vector3(-3727.36, -2598.500244140625, -14.46000003814697),
        rotation = vector3(0.0, 0.0, 89)
    },
    ["vanhorn"] = {
        model = "mp005_p_mp_bountyboard01x",
        coords = vector3(2983.57666015625, 571.44970703125, 43.5),
        rotation = vector3(0.0, 0.0, -99.99999237060547)
    },
    ["oil"] = {
        model = "mp005_p_mp_bountyboard01x",
        coords = vector3(489.75, 667.530029296875, 116.29000091552734),
        rotation = vector3(0.0, 0.0, -95.0)
    },
}
```

### translate.lua

The `translate.lua` file contains translations for various text strings used in the job panel. You can customize these translations to fit your needs.

### SQL Setup

You need to execute the `murphy_jobpanel.sql` file to create the necessary database table for storing job progression.

## Job Configuration

Each job is defined in a separate Lua file within the `config/jobs` directory. Below is a description of the key components of a job configuration file.

### Job Data Structure

```lua
local JobData = {
    name = "job_name", -- Unique identifier for the job
    board = {"board_name"}, -- Job board(s) where the job will be listed, nil if you want it to be on every job board
    --- Poster generator ---
    label = "Job Label", -- Display name for the job
    description = "Job Description", -- Description of the job
    image = "./img/Poster_art/image.png", -- Path to the job image
    reward = "Reward", -- Reward text

    --- Steps ---
    steps = { -- Steps involved in the job
        { action = "ActionName", label = "Step Label", description = "Step Description", ... },
        -- Add more steps as needed
    },
}
```

### Example Job Configuration

Here is an example of a job configuration file:

```lua
local JobData = {
    name = "delivery_ordered",
    board = {"armadillo"},
    image = "./img/Poster_art/beef.png",
    reward = "$25",
    label = "Livraison",
    description = "Livrez des colis dans un ordre spécifique",
    steps = {
        { action = "Initialisation", label = "Initialisation", description = "Initialiser la livraison", vehicle = GetHashKey("chuckwagon002x"), bliplabel = "Work Carriage",
            coords = vector3(-3731.456, -2549.489, -14.83865), heading = 274.0, packagemodel = GetHashKey("p_crate01x"), packagesSettings = {0.0, -2.1, 0.1, 0.0, 0.0, 90.01} },
        { action = "DeliverPackage", label = "Livrer le colis", description = "Livrer le colis à l'emplacement spécifié" },
        -- Add more steps as needed
        { action = "ReturnCarriage", reward = 25, label = "Retourner la charrette", description = "Retourner la charrette au point de départ" },
    },
}
```

### Actions

Each step in the job configuration has an `action` field that specifies what action to perform. Actions are defined as functions in the job configuration file. These functions are executed at a given step of the job. You can create as many functions as needed to handle different actions. Here are some common actions:

- `Initialisation`: Initializes the job, spawns necessary entities, and sets up interactions.
- `DeliverPackage`: Handles the delivery of a package to a specified location.
- `ReturnCarriage`: Completes the job by returning the carriage to the starting point.
- `CompleteJob`: Finalizes the job and gives the reward.

### Adding a New Job

1. Create a new Lua file in the `config/jobs` directory.
2. Define the `JobData` table with the necessary fields.
3. Implement the actions required for the job.
4. Register the job in the `JobsConfig` table if running on the server side.

### Example of Adding a New Job

```lua
local JobData = {
    name = "new_job",
    label = "New Job",
    description = "Description of the new job",
    steps = {
        { action = "Initialisation", label = "Start", description = "Start the job" },
        { action = "PerformTask", label = "Task", description = "Perform the task" },
        { action = "CompleteJob", reward = 100, label = "Finish", description = "Complete the job" },
    },
    board = {"armadillo"},
    image = "./img/Poster_art/new_job.png",
    reward = "$100",
}

if IsDuplicityVersion() then
    JobsConfig["new_job"] = JobData
else
    -- Define client-side actions and job creation logic here
end
```

## Callbacks

The Murphy Job Panel uses callbacks to interact with the server. Below are the available callbacks and their descriptions:

### Available Callbacks

- `GetItemAmount`: Retrieves the amount of a specific item the player has.
- `RemoveItem`: Removes a specified amount of an item from the player's inventory.
- `GiveItem`: Gives a specified amount of an item to the player.
- `AddCurrency`: Adds currency to the player's account.
- `RemoveCurrency`: Removes currency from the player's account.
- `GetCharMoney`: Retrieves the amount of money the player has.
- `GetCharJob`: Retrieves the player's current job and job grade.
- `GetCharIdentifier`: Retrieves the player's character identifier.
- `GetProgression`: Retrieves the player's job progression.
- `RequestJobPosters`: Requests the job posters for a specific job board location.

### Example Callback Registration

Callbacks are registered in the `server/callbacks.lua` file. Here is an example:

```lua
Callback.register('GetItemAmount', function(source, item)
    local result = GetItemAmount(source, item)
    return result
end)

Callback.register('RemoveItem', function(source, item, amount, meta)
    local result = RemoveItem(source, item, amount, meta)
    return result
end)

Callback.register('AddCurrency', function(source, amount)
    AddCurrency(source, amount)
    return
end)

// ...existing code...
```

### Example Callback Usage

To trigger a callback from the client side, you can use the `Callback.triggerServer` function. Here is an example:

```lua
Callback.triggerServer('GetItemAmount', function(amount)
    print("Player has " .. amount .. " of the specified item.")
end, 'item_name')

Callback.triggerServer('AddCurrency', function()
    print("Currency added to the player.")
end, 100)
```

## Conclusion

This guide provides a basic overview of how to configure jobs for the Murphy Job Panel and understand the available callbacks. You can create various types of jobs by defining different steps and actions. Customize the job configurations to fit your needs and enhance the gameplay experience.

