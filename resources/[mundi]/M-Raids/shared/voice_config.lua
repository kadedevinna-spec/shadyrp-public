--[[
    VOICE CONFIGURATION
    
    This file allows you to configure voice/speech data for different ped models.
    
    HOW TO ADD NEW PED MODELS:
    
    1. Find your ped model in the audio_banks.lua file (found in rdr3_discoveries)
       - Search for your ped model name (e.g., 'u_m_o_blwgeneralstoreowner_01')
    
    2. Locate the voice reference ID
       - It will be in the format: ["XXXX_PED_MODEL_NAME"] = { ... }
       - Example: ["0083_U_M_O_BlWGeneralStoreOwner_01"]
       - The format is usually: NumberPrefix_ModelName with proper capitalization
    
    3. Find available speech lines
       - Inside the voice reference block, you'll see quoted strings like "GREET_MALE_01"
       - These are the speech lines that ped model can say
       - Copy the ones you want to use (ignore the hex codes like 0x00063FB5)
    
    4. Add an entry below following this format:
       
       ['your_ped_model_here'] = {
           ref = 'XXXX_Your_Ped_Model_Name',  -- Voice reference from audio_banks
           lines = {                           -- Speech lines available for this ped
               'GREET_MALE_01',
               'WELCOME_01', 
               'GENERIC_THANKS_01',
               'FAREWELL_01'
           }
       },
    
    EXAMPLE FROM AUDIO_BANKS.LUA:
    
    If you see this in audio_banks.lua:
    
    ["0083_U_M_O_BLWGENERALSTOREOWNER_01"] = {
        0x00063FB5,
        "GREET_MALE_01",
        "GREET_MALE_02",
        "WELCOME_01",
        "TAKE_YOUR_TIME_01",
        ...
    }
    
    Then your entry would be:
    
    ['u_m_o_blwgeneralstoreowner_01'] = {
        ref = '0083_U_M_O_BlWGeneralStoreOwner_01',
        lines = {'GREET_MALE_01', 'GREET_MALE_02', 'WELCOME_01', 'TAKE_YOUR_TIME_01'}
    }
    
    TIPS:
    - Model name key should be LOWERCASE
    - Voice reference should match the EXACT capitalization from audio_banks
    - Common speech lines: GREET_MALE_01, WELCOME_01, GENERIC_THANKS, FAREWELL_01, TAKE_YOUR_TIME
    - Test in-game to verify speech works for your ped model
]]

VoiceConfig = {}

VoiceConfig.VoiceData = {
    -- Store Owners
    ['u_m_o_blwgeneralstoreowner_01'] = {
        ref = '0083_U_M_O_BlWGeneralStoreOwner_01',
        lines = {
            -- Base speech names without number suffixes (native picks random variant)
            'GREET_MALE',
            'GREET_FEMALE',
            'WELCOME',
            'WELCOME_MALE',
            'WELCOME_BACK',
            'TAKE_YOUR_TIME',
            'GENERIC_THANKS',
            'FAREWELL',
            'SALES_PITCH',
            'CHAT_SHOPKEEPER_GOSSIP',
            'RESPONSE_GENERIC'
        }
    },
    
    -- Guards / Henchmen
    ['s_m_m_fussarhenchman_01'] = {
        ref = '0760_S_M_M_FussarHenchman_01_Hispanic_01',
        lines = {
            -- Reactions
            'GREET_GENERAL_STRANGER', 'GREET_PLAYER_MASK',
            'WHAT_WAS_THAT', 'WHO_GOES_THERE',
            -- Victory/Melee
            'MELEE_BRING_IT_ON', 'MELEE_THAT_ALL_YOU_GOT',
            'WON_FIGHT', 'PEDTYPE_WON_FIGHT'
        }
    },
    
    -- Add your custom ped models below this line:
    -- ============================================
    
    -- Coach/Taxi Drivers
    ['s_m_m_coachtaxidriver_01'] = {
        ref = '1029_S_M_M_COACHTAXIDRIVER_01_WHITE_01',
        lines = {
            'GREET_MALE',
            'WELCOME',
            'GENERIC_THANKS',
            'FAREWELL',
            'GENERIC_GOODBYE',
            'TAKE_YOUR_TIME'
        }
    },
    
    -- Lemoyne Raiders / Confederate Veterans (Civil War Field Raid NPCs)
    ['g_m_y_uniexconfeds_01'] = {
        ref = '0177_G_M_Y_UNIEXCONFEDS_01_WHITE_01',
        lines = {
            'GREET_MALE',
            'GENERIC_HI',
            'WHAT_WAS_THAT',
            'WHO_GOES_THERE',
            'MELEE_BRING_IT_ON',
            'WON_FIGHT'
        }
    },
    
    -- Military Guards (Fort Wallace Raid NPC)
    ['s_m_m_micguard_01'] = {
        ref = '0030_MICGUARD_01',
        lines = {
            'GREET_MALE',
            'GENERIC_HI',
            'TAKE_YOUR_TIME',
            'GENERIC_THANKS',
            'WHAT_WAS_THAT',
            'WHO_GOES_THERE'
        }
    },
    
    -- Example template:
    --[[ 
    ['your_ped_model'] = {
        ref = 'XXXX_Your_Ped_Model_Name',
        lines = {
            'GREET_MALE',
            'WELCOME',
            'GENERIC_THANKS',
            'FAREWELL'
        }
    },
    ]]
}

-- Common fallback speech lines that work for most peds (if model not found above)
VoiceConfig.FallbackSpeech = {
    'GREET_MALE',
    'GENERIC_HI',
    'GENERIC_THANKS',
    'GENERIC_GOODBYE',
    'TAKE_YOUR_TIME'
}

-- Debug: Confirm voice_config.lua is loaded
if Config and Config.Debug then
    print('[M-Raids][VOICE_CONFIG] Loaded voice configuration for ' .. (VoiceConfig.VoiceData and 'multiple models' or 'no models'))
    if VoiceConfig.VoiceData then
        for model, data in pairs(VoiceConfig.VoiceData) do
            print('[M-Raids][VOICE_CONFIG] - Model:', model, '| Voice Ref:', data.ref)
        end
    end
end
