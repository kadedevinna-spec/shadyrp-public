-- TASK KONFIGURATION FOR INTEGRATION TASKS (Type 9)
----------------------------------------------------------------
-- Here we define all the integration tasks that can be used in the missions. Integration Tasks are special tasks that can only be completed through an export function. This allows you to integrate any custom task that is not covered by the other task types. And combine it with other Scripts
----------------------------------------------------------------

Config = Config or {}
Config.Tasks = Config.Tasks or {}

----------------------------------------------------------------
-- TASK TYPES:
-- 1 = Travel      (Cover distance)
-- 2 = Collection  (Collect items, quest or inventory items)
-- 3 = Delivery    (Deliver/place items at NPC, position or vehicle (quest or inventory items))
-- 4 = Elimination (Kill enemies)
-- 5 = Patrol      (Reach specific points)
-- 6 = Talk        (Talk to NPC)
-- 7 = Use         (Use/consume inventory item)
-- 8 = Interaction (Interact at coords e.g. repair fence, clean windows, mine stone, etc.)
-- 9 = Integration (Integrate with other scripts, this task can only be completed through an export function)


----------------------------------------------------------------

----------------------------------------------------------------
-- INTEGRATION TASKS (Typ 9)
----------------------------------------------------------------

Config.Tasks["open_admin_menu"] = {
    type = 9,
    title = "Open Admin Menu", -- Task Title
    description = "Open the Admin Menu 5 Times", -- Task Description
    targetAmount = 5, -- How many times the task has to be completed, in this case the admin menu has to be opened 5 times to complete the task
    restartable = false
}