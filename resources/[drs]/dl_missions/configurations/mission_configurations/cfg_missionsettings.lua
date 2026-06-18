----------------------------------------------------------------
-- MISSION KONFIGURATION
----------------------------------------------------------------
-- Missionen sind nach Typ unterteilt für bessere Übersicht
----------------------------------------------------------------
Config = Config or {}
Config.Missions = {}

----------------------------------------------------------------

Config.MissionTypeSettings = {

    ["Doctor"] = {
        timeLimit = -1, -- In Hours
        max_missions = 1, -- Max Anzahl an Daily Missionen, die ein Spieler gleichzeitig haben kann
        allowedJobs = {"doctor"}, -- ONLY USED IF Config.NextQuestWithNPCs = false
    },

    ["Daily"] = {
        timeLimit = 24, -- In Hours
        max_missions = 3, -- Max Anzahl an Daily Missionen, die ein Spieler gleichzeitig haben kann
        allowedJobs = {}, -- ONLY USED IF Config.NextQuestWithNPCs = false
    },
    ["Weekly"] = {
        timeLimit = 7 * 24, -- 7 Tage in Stunden
        max_missions = 1, -- Max Anzahl an Weekly Missionen, die ein Spieler gleichzeitig haben kann
        allowedJobs = {}, -- ONLY USED IF Config.NextQuestWithNPCs = false
    },
    ["Monthly"] = {
        timeLimit = 30 * 24, -- 30 Tage in Stunden
        max_missions = 1, -- Max Anzahl an Monthly Missionen, die ein Spieler gleichzeitig haben kann
        allowedJobs = {}, -- ONLY USED IF Config.NextQuestWithNPCs = false
    },
}
