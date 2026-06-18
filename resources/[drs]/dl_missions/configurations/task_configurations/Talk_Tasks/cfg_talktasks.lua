-- TASK KONFIGURATION FOR TALK TASKS (Type 6)
----------------------------------------------------------------
-- Here we define all the talk tasks that can be used in the missions. You can create as many tasks as you want and use them in different missions. Just make sure to give them a unique name and configure them according to your needs.
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
-- TALK TASKS (Typ 6)
----------------------------------------------------------------

Config.Tasks["speak_medic"] = {
    type = 6, -- Task Type 
    title = "Consult the Doctor", -- Task Title
    description = "Find the doctor in Valentine and speak with him", -- Task Description
    
    targetAmount = 1, -- Target Amount 
    
    targetPosition = { x = -288.84, y = 808.47, z = 118.39}, -- NPC Spawn Position
    
    targetNPCModel = "cs_creoledoctor", -- NPC Model
    targetNPCName = "Dr. Miller", -- NPC Name
    targetNPCAnimation = {
        useanim = true,
        dict = "amb_rest_lean@world_human_lean@wall@smoking@male_a@base",
        name = "base",
        flag = 1,
        isScenario = false, -- If true, the animation will be played as a scenario, if false, the animation will be played as a normal animation
        scenario = "",
        scenarioProp = "",
        scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0), -- Only relevant if isScenario is true, defines the offset for the scenario position, so the position where the scenario will be played is coords + scenarioPosOffset
    },
    targetNPCDialogue = {
        {text="Ah, Sie sind es! Ich habe auf Sie gewartet.", time=2000},
        {text="I have an important task for you.", time=2000},
        {text="Come closer. We need to talk.", time=2000}
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Doctor Miller",
        zoneradius = 10.0, -- Wenn dieser Wert größer als 0 ist, wird ein Area Blip erstellt anstatt ein normaler
    },

    restartable = false
}

Config.Tasks["speak_mayjor"] = {
    type = 6,
    title = "Speak with the Mayor",
    description = "Find the mayor in Valentine and speak with him",
    
    targetAmount = 1,
    
    targetPosition = { x = -288.84, y = 808.47, z = 118.39},
    
    targetNPCModel = "cs_mayor",
    targetNPCName = "Mr. Miller",
    targetNPCDialogue = {
        {text="Ah, Sie sind es! Ich habe auf Sie gewartet.", time=2000},
        {text="I have an important task for you.", time=2000},
        {text="Come closer. We need to talk.", time=2000}
    },
    
    restartable = false
}

----------------------------------------------------------------
-- SHADYRP CUSTOM TALK TASKS
----------------------------------------------------------------

Config.Tasks["shadyrp_question_martha"] = {
    type = 6,
    title = "Question the Witness",
    description = "Find Martha Whitlock near the Valentine saloon and ask what she saw.",

    targetAmount = 1,

    targetPosition = { x = -317.38, y = 806.89, z = 117.98 },

    targetNPCModel = "a_f_m_valtownfolk_01",
    targetNPCName = "Martha Whitlock",
    targetNPCAnimation = {
        useanim = true,
        dict = "amb_rest_lean@world_human_lean@wall@smoking@male_a@base",
        name = "base",
        flag = 1,
        isScenario = false,
        scenario = "",
        scenarioProp = "",
        scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0),
    },
    targetNPCDialogue = {
        {text="Keep your voice down. Men were asking about that ledger before dawn.", time=5000, audio=""},
        {text="One wore a badge. One had blood on his cuffs. I do not know which scared me more.", time=7000, audio=""},
        {text="If the numbers in that book match the bank records, somebody powerful is going to sweat.", time=8000, audio=""},
    },

    blip = {
        coords = {},
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Martha Whitlock",
        zoneradius = 5.0,
    },

    restartable = false
}

Config.Tasks["shadyrp_law_speak_deputy_clara"] = {
    type = 6,
    title = "Brief the Deputy",
    description = "Speak with Deputy Clara Bell outside the Valentine sheriff's office.",

    targetAmount = 1,

    targetPosition = { x = -272.20, y = 805.62, z = 119.39 },

    targetNPCModel = "a_f_m_valtownfolk_01",
    targetNPCName = "Deputy Clara Bell",
    targetNPCAnimation = {
        useanim = false,
        dict = "",
        name = "",
        flag = 1,
        isScenario = false,
        scenario = "",
        scenarioProp = "",
        scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0),
    },
    targetNPCDialogue = {
        {text="You filed it? Good. Now we need the witness alive long enough for a judge to hear her.", time=8000, audio=""},
        {text="Warn Martha, then post the notice at the jail board. If anybody asks, this is routine county business.", time=9000, audio=""},
    },

    blip = {
        coords = {},
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Deputy Clara Bell",
        zoneradius = 5.0,
    },

    restartable = false
}

Config.Tasks["shadyrp_law_warn_martha"] = {
    type = 6,
    title = "Warn Martha",
    description = "Tell Martha Whitlock the ledger is in lawful hands and she should stay out of sight.",

    targetAmount = 1,

    targetPosition = { x = -319.15, y = 809.25, z = 117.98 },

    targetNPCModel = "a_f_m_valtownfolk_01",
    targetNPCName = "Martha Whitlock",
    targetNPCAnimation = {
        useanim = true,
        dict = "amb_rest_lean@world_human_lean@wall@smoking@male_a@base",
        name = "base",
        flag = 1,
        isScenario = false,
        scenario = "",
        scenarioProp = "",
        scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0),
    },
    targetNPCDialogue = {
        {text="The deputy has it? Then may God help us both.", time=6000, audio=""},
        {text="I will stay quiet and keep to the back rooms. Tell Clara I never wanted to be brave.", time=8000, audio=""},
    },

    blip = {
        coords = {},
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Martha Whitlock",
        zoneradius = 5.0,
    },

    restartable = false
}

Config.Tasks["shadyrp_law_report_elias"] = {
    type = 6,
    title = "Report to Elias",
    description = "Return to Elias Crowe and tell him the evidence has been protected.",

    targetAmount = 1,

    targetPosition = { x = -174.90, y = 627.75, z = 114.02 },

    targetNPCModel = "a_m_m_huntertravelers_cool_01",
    targetNPCName = "Elias Crowe",
    targetNPCAnimation = {
        useanim = false,
        dict = "",
        name = "",
        flag = 1,
        isScenario = false,
        scenario = "",
        scenarioProp = "",
        scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0),
    },
    targetNPCDialogue = {
        {text="You gave the town a fighting chance. That is more than most ever do.", time=7000, audio=""},
        {text="The people named in that book will push back. Let them push against the courthouse for once.", time=9000, audio=""},
    },

    blip = {
        coords = {},
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Elias Crowe",
        zoneradius = 5.0,
    },

    restartable = false
}

Config.Tasks["shadyrp_outlaw_speak_runner"] = {
    type = 6,
    title = "Meet the Runner",
    description = "Speak with Cade Mercer at the ridge camp after leaving the ledger in the dead drop.",

    targetAmount = 1,

    targetPosition = { x = -531.60, y = 392.25, z = 87.20 },

    targetNPCModel = "cs_oddfellowspinhead",
    targetNPCName = "Cade Mercer",
    targetNPCAnimation = {
        useanim = true,
        dict = "amb_rest_lean@world_human_lean@wall@smoking@male_a@base",
        name = "base",
        flag = 1,
        isScenario = false,
        scenario = "",
        scenarioProp = "",
        scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0),
    },
    targetNPCDialogue = {
        {text="Ledger is in the drop? Then nobody saw your hands. Good start.", time=7000, audio=""},
        {text="Plant these scraps near the western trail. Let the law think a rider ran for the hills.", time=9000, audio=""},
    },

    blip = {
        coords = {},
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Cade Mercer",
        zoneradius = 5.0,
    },

    restartable = false
}

Config.Tasks["shadyrp_outlaw_final_contact"] = {
    type = 6,
    title = "Collect the Payoff",
    description = "Meet Nettie Walsh west of the ridge and collect the outlaw payoff.",

    targetAmount = 1,

    targetPosition = { x = -606.35, y = 421.80, z = 88.20 },

    targetNPCModel = "a_f_m_valtownfolk_01",
    targetNPCName = "Nettie Walsh",
    targetNPCAnimation = {
        useanim = false,
        dict = "",
        name = "",
        flag = 1,
        isScenario = false,
        scenario = "",
        scenarioProp = "",
        scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0),
    },
    targetNPCDialogue = {
        {text="You made enough dust to hide a regiment. The law is looking west and the ledger is already gone.", time=9000, audio=""},
        {text="Take your money. If anybody asks, you were never here and neither was I.", time=8000, audio=""},
    },

    blip = {
        coords = {},
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Nettie Walsh",
        zoneradius = 5.0,
    },

    restartable = false
}
