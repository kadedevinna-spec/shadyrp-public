Config = {}

-- Wire Sabotage Minigame Configuration
Config.WireSabotage = {
    -- Command settings
    command = "sabotage",
    
    -- UI settings
    enableEscapeKey = true,
    
    -- Image settings
    wireBoxImage = "images/wire_box.png",
    
    -- Audio settings
    sounds = {
        enabled = true,
        volume = 0.7,
        effects = {
            leverClank = {
                file = "lever_clank.mp3",
                volume = 0.5
            },
            wireCut = {
                file = "wire_cut.mp3",
                volume = 0.8
            },
            electricShock = {
                file = "electric_shock.mp3",
                volume = 0.9
            },
            fusesSpark = {
                file = "electric_shock2.mp3",
                volume = 0.5,
                duration = 2500  -- Duração em milissegundos (2 segundos)
            }
        }
    },
    
    -- Minigame settings
    wireCutting = {
        enabled = true,
        barSpeed = 1000,        -- Velocidade da barra (ms para completar) - mais rápido
        hitZoneSize = 12,       -- Tamanho da zona de acerto (%) - menor
        hitZonePosition = 50,   -- Posição da zona de acerto (%)
        maxAttempts = 3,        -- Tentativas máximas por fio
        shockCloseDelay = 2000  -- Delay antes de fechar UI após choque (ms)
    }
}


-- ========================================
-- CONFIGURAÇÕES DO TIMER DE ROUBO
-- ========================================
Config.RobberyTimer = {
    enabled = true,
    defaultDuration = 300000, -- 5 minutos em ms
    
    -- Posição na tela (0.0 a 1.0)
    position = {
        x = 0.5, -- Centro horizontal
        y = 0.1  -- Parte superior
    },
    
    -- Configurações visuais
    background = {
        dict = "hud_textures",
        texture = "hud_wanted_bg",
        width = 0.15,
        height = 0.08,
        r = 0, g = 0, b = 0, a = 200 -- Fundo preto semi-transparente
    },
    
    text = {
        font = 0,
        scale = 0.6,
        r = 255, g = 255, b = 255, a = 255,
        outline = true
    },
    
    -- Cores baseadas no tempo restante
    colors = {
        normal = {r = 255, g = 255, b = 255}, -- Branco
        warning = {r = 255, g = 255, b = 100}, -- Amarelo (< 2 min)
        critical = {r = 255, g = 100, b = 100} -- Vermelho (< 1 min)
    },
    
    -- Tempos para mudança de cor (em ms)
    warningTime = 120000, -- 2 minutos
    criticalTime = 60000   -- 1 minuto
}

-- ========================================
-- CONFIGURAÇÕES DE DISTÂNCIA DOS HOSTAGES
-- ========================================
Config.HostageDistance = {
    capture = 1.0,        -- Distância para capturar reféns
    detection = 4.0,      -- Distância padrão para detectar hostages próximos
    threat = 10.0,        -- Distância para ameaçar com arma
    banker = 10.0         -- Distância para detectar banker
}

-- ========================================
-- CONFIGURAÇÕES DO TIMER DE HOSTAGE
-- ========================================
Config.HostageTimer = {
    enabled = true,
    
    -- Configurações de posicionamento
    positioning = {
        mode = "world", -- "screen" (fixo na tela) ou "world" (acima do NPC)
        
        -- Para modo "screen" (fixo na tela)
        screenPosition = {
            x = 0.85, -- Lado direito
            y = 0.5   -- Centro vertical
        },
        
        -- Para modo "world" (acima do NPC)
        worldOffset = {
            x = 0.0,   -- Offset horizontal em relação ao NPC
            y = 0.0,   -- Offset lateral
            z = 0.2    -- Altura acima da cabeça do NPC
        },
        
        -- Offset para ajustar posição do background em relação ao ícone
        backgroundOffset = {
            x = 0.0,   -- Offset horizontal do background
            y = -0.003 -- Offset vertical do background (negativo = para baixo)
        }
    },
    
    -- Tamanhos separados para background e ícone
    size = {
        background = {
            -- width = 0.043,
            -- height = 0.041
            width = 0.042,
            height = 0.071
        },
        icon = {
            -- width = 0.08,
            -- height = 0.08
            width = 0.026,
            height = 0.049
        }
    },
    
    -- Configurações das texturas
    textures = {
        -- Ícone central
        icon = {
            dict = "itemtype_textures",
            texture = "transaction_honor_bad"
        },
        
        -- Fundos baseados no tempo decorrido (1 = vazio/início, 10 = cheio/fim)
        -- Conforme o tempo passa, a barra enche: tank_1 → tank_10
        backgrounds = {
            [1] = { dict = "rpg_menu_item_effects", texture = "rpg_tank_1" },   -- Vazio (início)
            [2] = { dict = "rpg_menu_item_effects", texture = "rpg_tank_2" },
            [3] = { dict = "rpg_menu_item_effects", texture = "rpg_tank_3" },
            [4] = { dict = "rpg_menu_item_effects", texture = "rpg_tank_4" },
            [5] = { dict = "rpg_menu_item_effects", texture = "rpg_tank_5" },
            [6] = { dict = "rpg_menu_item_effects", texture = "rpg_tank_6" },
            [7] = { dict = "rpg_menu_item_effects", texture = "rpg_tank_7" },
            [8] = { dict = "rpg_menu_item_effects", texture = "rpg_tank_8" },
            [9] = { dict = "rpg_menu_item_effects", texture = "rpg_tank_9" },
            [10] = { dict = "rpg_menu_item_effects", texture = "rpg_tank_10" } -- Cheio (fim)
        }
    },
    
    -- Cores baseadas no tempo restante
    colors = {
        normal = {r = 255, g = 255, b = 255, a = 255}, -- Branco
        warning = {r = 255, g = 200, b = 100, a = 255}, -- Amarelo (< 50%)
        critical = {r = 255, g = 100, b = 100, a = 255} -- Vermelho (< 25%)
    },
    
    -- Configurações de animação
    animation = {
        pulseSpeed = 1000, -- ms para um ciclo completo
        fadeSpeed = 500    -- ms para fade in/out
    }
}

-- Configurações de notificação
Config.Notifications = {
    dialOpened = "Open Dial Minigame",
    dialClosed = "Minigame Closed",
    dialCompleted = "Safe unlocked successfully!",
    dialFailed = "Failed to unlock safe",
    alreadyActive = "Minigame already active!",
}

-- ================================== SISTEMA DE RONDAS ==================================

Config.Rounds = {
    Settings = {
        enabled = true,
        checkInterval = 500, -- Intervalo de verificação em ms
        defaultDetectionRadius = 8.0, -- Raio padrão de detecção
        defaultHealth = 200, -- Vida padrão dos guardas
        defaultAccuracy = 50, -- Precisão padrão das armas
        spawnDelay = 100, -- Delay entre spawns em ms
        cleanupDelay = 5000, -- Delay para remover corpos em ms
        
        -- Configurações de Stealth
        stealthEnabled = true, -- Habilitar sistema stealth
        lineOfSightEnabled = true, -- Verificar linha de visão
        crouchStealthBonus = 0.5, -- Redução de detecção agachado (50%)
        walkingStealthBonus = 0.7, -- Redução de detecção andando (30%)
        runningStealthPenalty = 1.5, -- Aumento de detecção correndo (50%)
        
        -- Estados de alerta
        suspiciousTime = 3000, -- Tempo em ms para ficar suspeito
        alertTime = 5000, -- Tempo em ms para ficar alerta
        returnToIdleTime = 8000, -- Tempo para voltar ao idle
        
        -- Configurações de reset para guardas em combate
        combatResetDistance = 25.0, -- Distância extra para resetar guardas em combate
        combatPlayerCheckRadius = 20.0, -- Raio extra para verificar players próximos em combate
        
        -- Detecção por toque
        touchDetectionEnabled = true, -- Detecção por toque
        touchAlertRadius = 15.0, -- Raio para alertar outros guardas quando tocado
        
        -- Sistema de arma apontada
        weaponPointingEnabled = true, -- Habilitar sistema de apontar arma
        weaponPointingDistance = 8.0, -- Distância para apontar arma quando player está armado
        weaponWarningTime = 5000, -- Tempo em ms para guardar arma antes de atirar
        weaponPointingMessage = "Keep your gun or will be considered a threat!"
    },
    
    -- Configurações de relationship groups
    RelationshipGroups = {
        guard = "ROUND_GUARD",
        enemy = "ROUND_ENEMY",
        player = "PLAYER"
    },
    
    -- Localizações das rondas
    Locations = {
        ["valentine_ronda"] = {
            displayName = "Valentine",
            description = "Ronda do Banco de Valentine",
            enabled = true,
            
            -- Localização do banco para monitoramento automático de reset
            bankLocation = vector3(-308.3, 776.0, 118.7),
            
            -- Configurações específicas da localização
            settings = {
                autoCleanup = true, -- Auto-remover corpos
                notifyCompletion = true, -- Notificar quando limpar
                lockDoors = false -- Trancar portas ao completar
            },
            
            -- Sistema de hostages para esta ronda
            hostageSystem = {
                enabled = true,
                systemName = "valentine_hostages", -- Nome do sistema no Config.Hostages
                autoSpawn = true, -- Spawnar automaticamente quando ronda iniciar
                autoCleanup = true -- Limpar quando ronda parar
            },
            
            -- Sistema de cofres para esta ronda
            vaultSystem = {
                enabled = true,
                systemName = "valentine_vaults", -- Nome do sistema no Config.BankVaults
                autoActivate = true, -- Ativar automaticamente quando ronda iniciar
                lobbyRestricted = true -- Só membros da lobby podem usar
            },
            
            -- Sistema de notas para esta ronda
            notesSystem = {
                enabled = true,
                locationName = "valentine_notes", -- Nome da localização no Config.NotesSpawns
                autoActivate = true -- Ativar automaticamente quando ronda iniciar
            },
            
            -- Configurações do timer da ronda
            timer = {
                enabled = true,
                duration = 600000, -- 10 minutos em ms (600 segundos)
                autoStart = true -- Iniciar automaticamente quando a ronda começar
            },
            
            -- Configurações do gas explosivo
            explosiveGas = {
                enabled = true,
                triggerOnTimerExpired = true, -- Se deve ativar gas quando timer expira
                explosionCoords = vector3(-305.245, 764.52, 120.346), -- Coordenadas da explosão (mesma da carroça)
                explosionTag = 35, -- ID do tipo de explosão
                damageScale = 1.0,
                isAudible = true,
                isInvisible = false,
                cameraShake = 0.1,
                warning = {
                    enabled = false, -- Desabilitado = gas sai imediatamente
                    timeBeforeExplosion = 5000, -- 5 segundos de aviso antes da explosão
                    message = "GAS TÓXICO DETECTADO! Evacuem a área em 5 segundos!"
                }
            },
            
            -- Configuração da carroça com cofres
            supplyWagon = {
                enabled = true,
                model = "ArmySupplyWagon",
                spawnLocation = {
                    coords = vector3(-304.353, 756.072, 118.291), -- Localização da carroça
                    heading = -175.315
                },
                -- Cofres attachados na carroça
                attachedVaults = {
                    {
                        model = "s_vault_sml_r_val01x_high",
                        position = vector3(0.03, -1.61, 0.39),
                        rotation = vector3(0.0, 0.0, 0.0)
                    },
                    {
                        model = "s_vault_med_r_val01x_high", 
                        position = vector3(-0.53, 0.23, 0.38),
                        rotation = vector3(-1.0, -2.0, 0.0)
                    },
                    {
                        model = "s_vault_lrg_r_val01x_high",
                        position = vector3(0.16, 0.16, 0.38),
                        rotation = vector3(0.0, 0.0, -86.0)
                    }
                },

            },
            
            -- Zonas restritas onde guardas ficam alertas automaticamente
            restrictedZones = {
                {
                    coords = vector3(-304.378, 756.069, 118.29), -- Zona próxima aos guardas
                    radius = 3.0,
                    alertLevel = "combat", -- suspicious, alert, combat
                    message = "ÁREA RESTRITA! Saia imediatamente!"
                },
                {
                    coords = vector3(-301.407, 764.531, 121.877), -- Zona próxima aos guardas
                    radius = 3.0,
                    alertLevel = "combat", -- suspicious, alert, combat
                    message = "ÁREA RESTRITA! Saia imediatamente!"
                },

            },
            
            guards = {
                ["guard1"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(-308.448, 758.859, 118.748), -- Valentine área
                    heading = 180.0,
                    weapon = "weapon_revolver_cattleman",
                    health = 200,
                    accuracy = 50,
                    detectionRadius = 8.0,
                    
                    -- Configurações de stealth específicas do guarda
                    stealthSettings = {
                        fieldOfView = 120.0, -- Campo de visão em graus (mais amplo)
                        maxSightDistance = 15.0, -- Distância máxima de visão
                        hearingRadius = 8.0, -- Raio de audição para ruídos (maior)
                        drawWeaponOnTouch = true, -- Sacar arma quando tocado
                        drawWeaponInRestrictedZone = false -- Sacar arma em zona restrita
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_a@idle_b",
                        anim = "idle_d",
                        flag = 1
                    }
                },
                
                ["guard2"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(-307.967, 778.739, 123.615), -- Próximo ao guard1
                    heading = 270.0,
                    weapon = "weapon_repeater_henry",
                    health = 220,
                    accuracy = 55,
                    detectionRadius = 10.0,
                    
                    stealthSettings = {
                        fieldOfView = 140.0, -- Campo de visão maior
                        maxSightDistance = 18.0,
                        hearingRadius = 10.0, -- Maior raio de audição
                        drawWeaponOnTouch = true,
                        drawWeaponInRestrictedZone = true -- Mais agressivo
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                        anim = "idle_f",
                        flag = 1
                    }
                },
                
                ["guard3"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(-305.211, 778.341, 118.716), -- Formando triângulo
                    heading = 45.0,
                    weapon = "weapon_rifle_boltaction",
                    health = 250,
                    accuracy = 60,
                    detectionRadius = 12.0,
                    
                    stealthSettings = {
                        fieldOfView = 130.0, -- Campo de visão amplo
                        maxSightDistance = 20.0, -- Sniper tem visão longa
                        hearingRadius = 12.0, -- Maior raio de audição
                        drawWeaponOnTouch = true,
                        drawWeaponInRestrictedZone = true
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                        anim = "idle_f",
                        flag = 1
                    }
                },

                ["guard4"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(-299.046, 761.248, 118.75), -- Formando triângulo
                    heading = -133.256,
                    weapon = "weapon_rifle_boltaction",
                    health = 250,
                    accuracy = 60,
                    detectionRadius = 12.0,
                    
                    stealthSettings = {
                        fieldOfView = 130.0, -- Campo de visão amplo
                        maxSightDistance = 20.0, -- Sniper tem visão longa
                        hearingRadius = 12.0, -- Maior raio de audição
                        drawWeaponOnTouch = true,
                        drawWeaponInRestrictedZone = true
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                        anim = "idle_f",
                        flag = 1
                    }
                },

                ["guard5"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(-306.743, 780.76, 118.765), -- Formando triângulo
                    heading = 22.012,
                    weapon = "weapon_rifle_boltaction",
                    health = 250,
                    accuracy = 60,
                    detectionRadius = 12.0,
                    
                    stealthSettings = {
                        fieldOfView = 130.0, -- Campo de visão amplo
                        maxSightDistance = 20.0, -- Sniper tem visão longa
                        hearingRadius = 12.0, -- Maior raio de audição
                        drawWeaponOnTouch = true,
                        drawWeaponInRestrictedZone = true
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                        anim = "idle_f",
                        flag = 1
                    }
                },

                ["guard6"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(-309.513, 780.298, 118.761), -- Formando triângulo
                    heading = 22.012, -- Formando triângulo
                    weapon = "weapon_rifle_boltaction",
                    health = 250,
                    accuracy = 60,
                    detectionRadius = 12.0,
                    
                    stealthSettings = {
                        fieldOfView = 130.0, -- Campo de visão amplo
                        maxSightDistance = 20.0, -- Sniper tem visão longa
                        hearingRadius = 12.0, -- Maior raio de audição
                        drawWeaponOnTouch = true,
                        drawWeaponInRestrictedZone = true
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                        anim = "idle_f",
                        flag = 1
                    }
                },

                
            }
        },
        
        ["saint_denis_ronda"] = {
            displayName = "Saint Denis",
            description = "Ronda do Banco de Saint Denis",
            enabled = true,
            
            -- Localização do banco para monitoramento automático de reset
            bankLocation = vector3(2644.5, -1292.8, 52.2),
            
            -- Configurações específicas da localização
            settings = {
                autoCleanup = true, -- Auto-remover corpos
                notifyCompletion = true, -- Notificar quando limpar
                lockDoors = false -- Trancar portas ao completar
            },
            
            -- Sistema de hostages para esta ronda
            hostageSystem = {
                enabled = true,
                systemName = "saint_denis_hostages", -- Nome do sistema no Config.Hostages
                autoSpawn = true, -- Spawnar automaticamente quando ronda iniciar
                autoCleanup = true -- Limpar quando ronda parar
            },
            
            -- Sistema de cofres para esta ronda
            vaultSystem = {
                enabled = true,
                systemName = "saint_denis_vaults", -- Nome do sistema no Config.BankVaults
                autoActivate = true, -- Ativar automaticamente quando ronda iniciar
                lobbyRestricted = true -- Só membros da lobby podem usar
            },
            
            -- Sistema de notas para esta ronda
            notesSystem = {
                enabled = true,
                locationName = "saint_denis_notes", -- Nome da localização no Config.NotesSpawns
                autoActivate = true -- Ativar automaticamente quando ronda iniciar
            },
            
            -- Configurações do timer da ronda
            timer = {
                enabled = true,
                duration = 600000, -- 10 minutos em ms (600 segundos)
                autoStart = true -- Iniciar automaticamente quando a ronda começar
            },
            
            -- Configurações do gas explosivo
            explosiveGas = {
                enabled = true,
                triggerOnTimerExpired = true, -- Se deve ativar gas quando timer expira
                explosionCoords = vector3(2644.111, -1305.662, 55.171), -- Coordenadas da explosão (mesma da carroça)
                explosionTag = 35, -- ID do tipo de explosão
                damageScale = 1.0,
                isAudible = true,
                isInvisible = false,
                cameraShake = 0.1,
                warning = {
                    enabled = false, -- Desabilitado = gas sai imediatamente
                    timeBeforeExplosion = 5000, -- 5 segundos de aviso antes da explosão
                    message = "GAS TÓXICO DETECTADO! Evacuem a área em 5 segundos!"
                }
            },
            
            -- Configuração da carroça com cofres
            supplyWagon = {
                enabled = true,
                model = "ArmySupplyWagon",
                spawnLocation = {
                    coords = vector3(2630.417, -1293.778, 52.205), -- Localização da carroça
                    heading = 26.084
                },
                -- Cofres attachados na carroça
                attachedVaults = {
                    {
                        model = "s_vault_sml_r_val01x_high",
                        position = vector3(0.03, -1.61, 0.39),
                        rotation = vector3(0.0, 0.0, 0.0)
                    },
                    {
                        model = "s_vault_med_r_val01x_high", 
                        position = vector3(-0.53, 0.23, 0.38),
                        rotation = vector3(-1.0, -2.0, 0.0)
                    },
                    {
                        model = "s_vault_lrg_r_val01x_high",
                        position = vector3(0.16, 0.16, 0.38),
                        rotation = vector3(0.0, 0.0, -86.0)
                    }
                },

            },
            
            -- Zonas restritas onde guardas ficam alertas automaticamente
            restrictedZones = {
                {
                    coords = vector3(2649.986, -1306.14, 62.288), -- Zona próxima aos guardas
                    radius = 3.0,
                    alertLevel = "combat", -- suspicious, alert, combat
                    message = "ÁREA RESTRITA! Saia imediatamente!"
                },


            },
            
            guards = {
                ["guard1"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(2631.318, -1288.825, 52.271), -- Valentine área
                    heading = 81.683,
                    weapon = "weapon_revolver_cattleman",
                    health = 200,
                    accuracy = 50,
                    detectionRadius = 8.0,
                    
                    -- Configurações de stealth específicas do guarda
                    stealthSettings = {
                        fieldOfView = 120.0, -- Campo de visão em graus (mais amplo)
                        maxSightDistance = 15.0, -- Distância máxima de visão
                        hearingRadius = 8.0, -- Raio de audição para ruídos (maior)
                        drawWeaponOnTouch = true, -- Sacar arma quando tocado
                        drawWeaponInRestrictedZone = false -- Sacar arma em zona restrita
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_a@idle_b",
                        anim = "idle_d",
                        flag = 1
                    }
                },
                
                ["guard2"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(2642.899, -1284.063, 52.273), -- Próximo ao guard1
                    heading = 28.266,
                    weapon = "weapon_repeater_henry",
                    health = 220,
                    accuracy = 55,
                    detectionRadius = 10.0,
                    
                    stealthSettings = {
                        fieldOfView = 140.0, -- Campo de visão maior
                        maxSightDistance = 18.0,
                        hearingRadius = 10.0, -- Maior raio de audição
                        drawWeaponOnTouch = true,
                        drawWeaponInRestrictedZone = true -- Mais agressivo
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                        anim = "idle_f",
                        flag = 1
                    }
                },
                
                ["guard3"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(2638.642, -1285.934, 52.262), -- Formando triângulo
                    heading = 28.266,
                    weapon = "weapon_rifle_boltaction",
                    health = 250,
                    accuracy = 60,
                    detectionRadius = 12.0,
                    
                    stealthSettings = {
                        fieldOfView = 130.0, -- Campo de visão amplo
                        maxSightDistance = 20.0, -- Sniper tem visão longa
                        hearingRadius = 12.0, -- Maior raio de audição
                        drawWeaponOnTouch = true,
                        drawWeaponInRestrictedZone = true
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                        anim = "idle_f",
                        flag = 1
                    }
                },

                ["guard4"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(2643.923, -1288.936, 52.25), -- Formando triângulo
                    heading = 140.783,
                    weapon = "weapon_rifle_boltaction",
                    health = 250,
                    accuracy = 60,
                    detectionRadius = 12.0,
                    
                    stealthSettings = {
                        fieldOfView = 130.0, -- Campo de visão amplo
                        maxSightDistance = 20.0, -- Sniper tem visão longa
                        hearingRadius = 12.0, -- Maior raio de audição
                        drawWeaponOnTouch = true,
                        drawWeaponInRestrictedZone = true
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                        anim = "idle_f",
                        flag = 1
                    }
                },

                ["guard5"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(2637.125, -1298.067, 52.226), -- Formando triângulo
                    heading = 120.178,
                    weapon = "weapon_rifle_boltaction",
                    health = 250,
                    accuracy = 60,
                    detectionRadius = 12.0,
                    
                    stealthSettings = {
                        fieldOfView = 130.0, -- Campo de visão amplo
                        maxSightDistance = 20.0, -- Sniper tem visão longa
                        hearingRadius = 12.0, -- Maior raio de audição
                        drawWeaponOnTouch = true,
                        drawWeaponInRestrictedZone = true
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                        anim = "idle_f",
                        flag = 1
                    }
                },

                ["guard6"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(2638.185, -1300.597, 52.254), -- Formando triângulo
                    heading = 120.178, -- Formando triângulo
                    weapon = "weapon_rifle_boltaction",
                    health = 250,
                    accuracy = 60,
                    detectionRadius = 12.0,
                    
                    stealthSettings = {
                        fieldOfView = 130.0, -- Campo de visão amplo
                        maxSightDistance = 20.0, -- Sniper tem visão longa
                        hearingRadius = 12.0, -- Maior raio de audição
                        drawWeaponOnTouch = true,
                        drawWeaponInRestrictedZone = true
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                        anim = "idle_f",
                        flag = 1
                    }
                },

                
            }
        },
        
        ["rhodes_ronda"] = {
            displayName = "Rhodes",
            description = "Ronda do Banco de Rhodes",
            enabled = true,
            
            -- Localização do banco para monitoramento automático de reset
            bankLocation = vector3(1294.1, -1303.5, 77.0),
            
            -- Configurações específicas da localização
            settings = {
                autoCleanup = true, -- Auto-remover corpos
                notifyCompletion = true, -- Notificar quando limpar
                lockDoors = false -- Trancar portas ao completar
            },
            
            -- Sistema de hostages para esta ronda
            hostageSystem = {
                enabled = true,
                systemName = "rhodes_hostages", -- Nome do sistema no Config.Hostages
                autoSpawn = true, -- Spawnar automaticamente quando ronda iniciar
                autoCleanup = true -- Limpar quando ronda parar
            },
            
            -- Sistema de cofres para esta ronda
            vaultSystem = {
                enabled = true,
                systemName = "rhodes_vaults", -- Nome do sistema no Config.BankVaults
                autoActivate = true, -- Ativar automaticamente quando ronda iniciar
                lobbyRestricted = true -- Só membros da lobby podem usar
            },
            
            -- Sistema de notas para esta ronda
            notesSystem = {
                enabled = true,
                locationName = "rhodes_notes", -- Nome da localização no Config.NotesSpawns
                autoActivate = true -- Ativar automaticamente quando ronda iniciar
            },
            
            -- Configurações do timer da ronda
            timer = {
                enabled = true,
                duration = 600000, -- 10 minutos em ms (600 segundos)
                autoStart = true -- Iniciar automaticamente quando a ronda começar
            },
            
            -- Configurações do gas explosivo
            explosiveGas = {
                enabled = true,
                triggerOnTimerExpired = true, -- Se deve ativar gas quando timer expira
                explosionCoords = vector3(1286.708, -1313.94, 79.979), -- Coordenadas da explosão (mesma da carroça)
                explosionTag = 35, -- ID do tipo de explosão
                damageScale = 1.0,
                isAudible = true,
                isInvisible = false,
                cameraShake = 0.1,
                warning = {
                    enabled = false, -- Desabilitado = gas sai imediatamente
                    timeBeforeExplosion = 5000, -- 5 segundos de aviso antes da explosão
                    message = "GAS TÓXICO DETECTADO! Evacuem a área em 5 segundos!"
                }
            },
            
            -- Configuração da carroça com cofres
            supplyWagon = {
                    enabled = true,
                model = "ArmySupplyWagon",
                spawnLocation = {
                    coords = vector3(1297.289, -1292.272, 76.394), -- Localização da carroça
                    heading = -127.997
                },
                -- Cofres attachados na carroça
                attachedVaults = {
                    {
                        model = "s_vault_sml_r_val01x_high",
                        position = vector3(0.03, -1.61, 0.39),
                        rotation = vector3(0.0, 0.0, 0.0)
                    },
                    {
                        model = "s_vault_med_r_val01x_high", 
                        position = vector3(-0.53, 0.23, 0.38),
                        rotation = vector3(-1.0, -2.0, 0.0)
                    },
                    {
                        model = "s_vault_lrg_r_val01x_high",
                        position = vector3(0.16, 0.16, 0.38),
                        rotation = vector3(0.0, 0.0, -86.0)
                    }
                },

            },
            
            -- Zonas restritas onde guardas ficam alertas automaticamente
            restrictedZones = {
                {
                    coords = vector3(1297.289, -1292.272, 76.394), -- Zona próxima aos guardas
                    radius = 3.0,
                    alertLevel = "combat", -- suspicious, alert, combat
                    message = "ÁREA RESTRITA! Saia imediatamente!"
                },


            },
            
            guards = {
                ["guard1"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(1297.903, -1297.868, 77.036), -- Valentine área
                    heading = -39.688,
                    weapon = "weapon_revolver_cattleman",
                    health = 200,
                    accuracy = 50,
                    detectionRadius = 8.0,
                    
                    -- Configurações de stealth específicas do guarda
                    stealthSettings = {
                        fieldOfView = 120.0, -- Campo de visão em graus (mais amplo)
                        maxSightDistance = 15.0, -- Distância máxima de visão
                        hearingRadius = 8.0, -- Raio de audição para ruídos (maior)
                        drawWeaponOnTouch = true, -- Sacar arma quando tocado
                        drawWeaponInRestrictedZone = false -- Sacar arma em zona restrita
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_a@idle_b",
                        anim = "idle_d",
                        flag = 1
                    }
                },
                
                ["guard2"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(1295.332, -1295.812, 77.036), -- Próximo ao guard1
                    heading = -39.688,
                    weapon = "weapon_repeater_henry",
                    health = 220,
                    accuracy = 55,
                    detectionRadius = 10.0,
                    
                    stealthSettings = {
                        fieldOfView = 140.0, -- Campo de visão maior
                        maxSightDistance = 18.0,
                        hearingRadius = 10.0, -- Maior raio de audição
                        drawWeaponOnTouch = true,
                        drawWeaponInRestrictedZone = true -- Mais agressivo
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                        anim = "idle_f",
                        flag = 1
                    }
                },
                
                ["guard3"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(1284.394, -1319.573, 76.817), -- Formando triângulo
                    heading = 150.987,
                    weapon = "weapon_rifle_boltaction",
                    health = 250,
                    accuracy = 60,
                    detectionRadius = 12.0,
                    
                    stealthSettings = {
                        fieldOfView = 130.0, -- Campo de visão amplo
                        maxSightDistance = 20.0, -- Sniper tem visão longa
                        hearingRadius = 12.0, -- Maior raio de audição
                        drawWeaponOnTouch = true,
                        drawWeaponInRestrictedZone = true
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                        anim = "idle_f",
                        flag = 1
                    }
                },

                ["guard4"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(1276.324, -1312.859, 76.732), -- Formando triângulo
                    heading = 131.648,
                    weapon = "weapon_rifle_boltaction",
                    health = 250,
                    accuracy = 60,
                    detectionRadius = 12.0,
                    
                    stealthSettings = {
                        fieldOfView = 130.0, -- Campo de visão amplo
                        maxSightDistance = 20.0, -- Sniper tem visão longa
                        hearingRadius = 12.0, -- Maior raio de audição
                        drawWeaponOnTouch = true,
                        drawWeaponInRestrictedZone = true
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                        anim = "idle_f",
                        flag = 1
                    }
                },
                
                ["guard5"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(1287.884, -1303.26, 81.971), -- Formando triângulo
                    heading = 138.326,
                    weapon = "weapon_rifle_boltaction",
                    health = 250,
                    accuracy = 60,
                    detectionRadius = 12.0,
                    
                    stealthSettings = {
                        fieldOfView = 130.0, -- Campo de visão amplo
                        maxSightDistance = 20.0, -- Sniper tem visão longa
                        hearingRadius = 12.0, -- Maior raio de audição
                        drawWeaponOnTouch = true,
                        drawWeaponInRestrictedZone = true
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                        anim = "idle_f",
                        flag = 1
                    }
                },

                ["guard6"] = {
                    model = "s_m_m_dispatchpolice_01",
                    coords = vector3(1291.972, -1306.951, 81.972), -- Formando triângulo
                    heading = 140.848, -- Formando triângulo
                    weapon = "weapon_rifle_boltaction",
                    health = 250,
                    accuracy = 60,
                    detectionRadius = 12.0,
                    
                    stealthSettings = {
                        fieldOfView = 130.0, -- Campo de visão amplo
                        maxSightDistance = 20.0, -- Sniper tem visão longa
                        hearingRadius = 12.0, -- Maior raio de audição
                        drawWeaponOnTouch = true,
                        drawWeaponInRestrictedZone = true
                    },
                    
                    animation = {
                        dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                        anim = "idle_f",
                        flag = 1
                    }
                },

                
            }
        },
    }
}

-------------------------------------------------------
---- CONFIGURAÇÃO DOS GERADORES ----
-------------------------------------------------------

Config.Generators = {
    Settings = {
        model = "p_generator", -- Modelo do gerador
        spawnDistance = 50.0, -- Distância para spawnar (metros)
        despawnDistance = 75.0, -- Distância para despawnar (metros)
        checkInterval = 2000, -- Intervalo de verificação (ms)
        maxGenerators = 10, -- Máximo de geradores simultâneos
        
        -- Configurações de sabotagem
        sabotage = {
            requireActiveRobbery = true, -- Só pode sabotar durante assalto ativo
            oncePerRobbery = true, -- Só pode sabotar uma vez por assalto
            timeBonus = 120000, -- Tempo adicionado ao completar sabotagem (2 minutos em ms)
            notifySuccess = true, -- Notificar sucesso da sabotagem
            electricShockPenalty = 30000 -- Tempo descontado quando leva choque (30 segundos em ms)
        },
        
        -- Configurações dos efeitos de fumaça
        smokeEffects = {
            enabled = true,
            dictionary = "scr_std1",
            effectName = "scr_nbd1_smoke_chimney_split",
            scale1 = 0.8, -- Escala da fumaça principal
            scale2 = 1.0, -- Escala da fumaça secundária
            scale3 = 0.8, -- Escala da fumaça adicional
            scale4 = 1.0, -- Escala da fumaça adicional
            
            -- Posições dos efeitos (offset do centro do objeto)
            smoke1Position = vector3(-1.0, 0.32, 1.5), -- Fumaça principal (topo)
            smoke2Position = vector3(-1.0, 0.33, 0.8), -- Fumaça secundária (lateral)
            smoke3Position = vector3(-1.0, -0.32, 1.2),  -- Fumaça adicional (topo oposto)
            smoke4Position = vector3(-1.0, -0.33, 0.6),  -- Fumaça adicional (lateral oposta)

        },
        
        -- Configurações de áudio
        audio = {
            enabled = true,
            defaultMinDistance = 3.0,  -- Distância mínima padrão (volume máximo)
            defaultMaxDistance = 3.8, -- Distância máxima padrão (volume zero)
            fadeSpeed = 0.02,          -- Velocidade do fade
            updateInterval = 200       -- Intervalo de atualização em ms (reduzido para evitar pipoco)
        }
    },
    
    -- Localizações dos geradores
    Locations = {
        ["valentine_generator"] = {
            coords = vector3(-301.406, 764.531, 121.877),
            rotation = vector3(0.0, 6.125, 10.092), -- pitch, roll, yaw
            enabled = true,
            -- Configurações de áudio específicas (opcional)
            audio = {
                minDistance = 2.0,  -- Volume máximo a 2m
                maxDistance = 3.0  -- Volume zero a 12m
            },
            -- Configurações específicas de sabotagem
            sabotage = {
                timeBonus = 180000, -- 3 minutos de bônus para este gerador específico
                associatedRobbery = "valentine_ronda" -- Ronda associada (só pode sabotar durante esta ronda)
            },
            -- Configurações do prompt de sabotagem
            sabotagePrompt = {
                enabled = true,
                position = vector3(-301.477, 765.762, 123.101), -- Posição do prompt (pode ser diferente do gerador)
                distance = 1.2, -- Distância para mostrar o prompt
                text = "Sabotage Generator", -- Texto do prompt
                key = 0x760A9C6F -- Tecla G
            },
            -- Configurações da animação de sabotagem
            sabotageAnimation = {
                playerPosition = vector3(-301.53, 765.918, 122.103), -- Posição exata do player
                playerHeading = -170.698, -- Direção que o player fica virado
                animation = {
                    dict = "script_common@other@unapproved",
                    anim = "medic_kneel_enter",
                    flag = 2,
                    duration = 10000 -- Duração da animação em ms
                }
            }
        },
        ["saint_denis_generator"] = {
            coords = vector3(2649.986, -1306.139, 62.288),
            rotation = vector3(0.0, 0.0, -85.712), -- pitch, roll, yaw
            enabled = true,
            -- Configurações de áudio específicas (opcional)
            audio = {
                minDistance = 2.0,  -- Volume máximo a 2m
                maxDistance = 3.0  -- Volume zero a 12m
            },
            -- Configurações específicas de sabotagem
            sabotage = {
                timeBonus = 180000, -- 3 minutos de bônus para este gerador específico
                associatedRobbery = "saint_denis_ronda" -- Ronda associada (só pode sabotar durante esta ronda)
            },
            -- Configurações do prompt de sabotagem
            sabotagePrompt = {
                enabled = true,
                position = vector3(2651.22, -1305.84, 63.532), -- Posição do prompt (pode ser diferente do gerador)
                distance = 1.2, -- Distância para mostrar o prompt
                text = "Sabotage Generator", -- Texto do prompt
                key = 0x760A9C6F -- Tecla G
            },
            -- Configurações da animação de sabotagem
            sabotageAnimation = {
                playerPosition = vector3(2651.22, -1305.84, 62.532), -- Posição exata do player
                playerHeading = 111.626, -- Direção que o player fica virado
                animation = {
                    dict = "script_common@other@unapproved",
                    anim = "medic_kneel_enter",
                    flag = 2,
                    duration = 10000 -- Duração da animação em ms
                }
            }
        },
        ["rhodes_generator"] = {
            coords = vector3(1289.84, -1304.825, 80.728),
            rotation = vector3(0.0, 0.0, 48.992), -- pitch, roll, yaw
            enabled = true,
            -- Configurações de áudio específicas (opcional)
            audio = {
                minDistance = 2.0,  -- Volume máximo a 2m
                maxDistance = 3.0  -- Volume zero a 12m
            },
            -- Configurações específicas de sabotagem
            sabotage = {
                timeBonus = 180000, -- 3 minutos de bônus para este gerador específico
                associatedRobbery = "rhodes_ronda" -- Ronda associada (só pode sabotar durante esta ronda)
            },
            -- Configurações do prompt de sabotagem
            sabotagePrompt = {
                enabled = true,
                position = vector3(1288.612, -1303.81, 81.971), -- Posição do prompt (pode ser diferente do gerador)
                distance = 1.2, -- Distância para mostrar o prompt
                text = "Sabotage Generator", -- Texto do prompt
                key = 0x760A9C6F -- Tecla G
            },
            -- Configurações da animação de sabotagem
            sabotageAnimation = {
                playerPosition = vector3(1288.612, -1303.81, 80.971), -- Posição exata do player
                playerHeading = -130.4, -- Direção que o player fica virado
                animation = {
                    dict = "script_common@other@unapproved",
                    anim = "medic_kneel_enter",
                    flag = 2,
                    duration = 10000 -- Duração da animação em ms
                }
            }
        },

        -- Adicione mais geradores conforme necessário
    }
}

-------------------------------------------------------
---- CONFIGURAÇÃO DOS HOSTAGES/TRABALHADORES ----
-------------------------------------------------------

Config.Hostages = {
    -- Configurações padrão para ameaça com arma (aplicadas a hostages sem config específica)
    DefaultWeaponThreat = {
        minHandsUpTime = 3, -- Tempo mínimo de mãos para cima (segundos)
        maxHandsUpTime = 60, -- Tempo máximo de mãos para cima (segundos)
        multiplier = 1.0, -- Multiplicador do tempo de mira (1.0 = 100% do tempo)
        scaredRecoveryTime = 4 -- Tempo de scared idle após hands up (segundos)
    },
    
    ["valentine_hostages"] = {
        enabled = true,
        
        hostages = {
            ["banker"] = {
                coords = vector3(-306.103, 773.639, 118.703),
                heading = -31.001,
                model = "s_m_m_bankclerk_01", -- Modelo do caixa masculino
                enabled = true,
                outfit = 2, -- Preset do outfit (0-15)
                animation = {
                    dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                    anim = "idle_f",
                    flags = 1
                },
                -- Configurações de tempo de ameaça com arma
                weaponThreat = {
                    minHandsUpTime = 3, -- Tempo mínimo de mãos para cima (segundos)
                    maxHandsUpTime = 60, -- Tempo máximo de mãos para cima (segundos)
                    multiplier = 1.0, -- Multiplicador do tempo de mira (1.0 = 100% do tempo)
                    shotDetection = {
                        enabled = true, -- Ativar detecção de tiros próximos
                        radius = 3.0, -- Raio em metros para detectar tiros
                        minShots = 2 -- Número mínimo de tiros para ativar
                    },
                                    -- Configuração de movimento após hands up
                moveAfterHandsUp = {
                    enabled = true,
                    forceTimeout = 30000, -- Tempo em ms para forçar movimento mesmo sem todos em hands up (30s)
                    -- Lista de portas para abrir em sequência
                    doorSequence = {
                        [1] = {
                            targetPosition = vector3(-310.914, 774.522, 118.703), -- Posição da primeira porta
                            targetHeading = -0.038, -- Direção que fica virado na porta
                            walkSpeed = 1.0, -- Velocidade de caminhada (1.0 = normal)
                            waitAtTarget = 3000, -- Tempo que espera na porta (ms)
                            actionText = "Opening the main vault door...", -- Texto que aparece
                            doorId = 1 -- ID da porta no sistema
                        },
                        [2] = {
                            targetPosition = vector3(-310.487, 770.963, 118.703), -- Posição da segunda porta
                            targetHeading = -169.946, -- Direção que fica virado na porta
                            walkSpeed = 1.0, -- Velocidade de caminhada
                            waitAtTarget = 3000, -- Tempo que espera na porta (ms)
                            actionText = "Opening the secondary vault door...", -- Texto que aparece
                            doorId = 2 -- ID da porta no sistema
                        },

                    },
                    -- Configurações gerais
                    maxDoors = 2, -- Máximo de portas que pode abrir
                    timeBetweenDoors = 2000, -- Tempo entre abrir uma porta e ir para a próxima (ms)
                    resetAfterComplete = true -- Se deve voltar à animação de medo após abrir todas
                }
                }
             },
            ["manager"] = {
                coords = vector3(-310.712, 777.634, 117.716),
                heading = -78.236,
                model = "cs_hobartcrawley", -- Modelo do caixa masculino
                enabled = true,
                outfit = 0, -- Preset do outfit (0-15)
                animation = {
                    dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                    anim = "idle_f",
                    flags = 1
                },
                -- Configurações de tempo de ameaça com arma
                weaponThreat = {
                    minHandsUpTime = 3, -- Tempo mínimo de mãos para cima (segundos)
                    maxHandsUpTime = 60, -- Tempo máximo de mãos para cima (segundos)
                    multiplier = 1.0 -- Multiplicador do tempo de mira (1.0 = 100% do tempo)
                }
            },
            ["client1"] = {
                coords = vector3(-303.507, 777.216, 117.716),
                heading = -100.42,
                model = "a_m_m_valtownfolk_01", -- Modelo do caixa masculino
                enabled = true,
                outfit = 0, -- Preset do outfit (0-15)
                animation = {
                    dict = "script_story@ind1@ig@ig12_hosea_bankers",
                    anim = "ig12_hoseabankers_bankeridle_a_m_m_gamhighsociety_01",
                    flags = 2
                },
                -- Configurações de tempo de ameaça com arma
                weaponThreat = {
                    minHandsUpTime = 3, -- Tempo mínimo de mãos para cima (segundos)
                    maxHandsUpTime = 60, -- Tempo máximo de mãos para cima (segundos)
                    multiplier = 1.0 -- Multiplicador do tempo de mira (1.0 = 100% do tempo)
                }
            },

         
        }
    },
    ["saint_denis_hostages"] = {
        enabled = true,
        
        hostages = {
            ["banker"] = {
                coords = vector3(2644.422, -1295.995, 52.246),
                heading = 115.53,
                model = "s_m_m_bankclerk_01", -- Modelo do caixa masculino
                enabled = true,
                outfit = 2, -- Preset do outfit (0-15)
                animation = {
                    dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                    anim = "idle_f",
                    flags = 1
                },
                -- Configurações de tempo de ameaça com arma
                weaponThreat = {
                    minHandsUpTime = 3, -- Tempo mínimo de mãos para cima (segundos)
                    maxHandsUpTime = 60, -- Tempo máximo de mãos para cima (segundos)
                    multiplier = 1.0, -- Multiplicador do tempo de mira (1.0 = 100% do tempo)
                    shotDetection = {
                        enabled = true, -- Ativar detecção de tiros próximos
                        radius = 3.0, -- Raio em metros para detectar tiros
                        minShots = 2 -- Número mínimo de tiros para ativar
                    },
                                    -- Configuração de movimento após hands up
                moveAfterHandsUp = {
                    enabled = true,
                    forceTimeout = 30000, -- Tempo em ms para forçar movimento mesmo sem todos em hands up (30s)
                    -- Lista de portas para abrir em sequência
                    doorSequence = {
                        [1] = {
                            targetPosition = vector3(2648.98, -1300.05, 51.245), -- Posição da primeira porta (porta 4)
                            targetHeading = -151.669, -- Direção que fica virado na porta
                            walkSpeed = 1.0, -- Velocidade de caminhada (1.0 = normal)
                            waitAtTarget = 3000, -- Tempo que espera na porta (ms)
                            actionText = "Opening the main vault door...", -- Texto que aparece
                            doorId = 4 -- ID da porta no sistema
                        },
                        [2] = {
                            targetPosition = vector3(2643.3, -1300.427, 51.255), -- Posição da segunda porta (porta 5)
                            targetHeading = -169.946, -- Direção que fica virado na porta
                            walkSpeed = 1.0, -- Velocidade de caminhada
                            waitAtTarget = 3000, -- Tempo que espera na porta (ms)
                            actionText = "Opening the secondary vault door...", -- Texto que aparece
                            doorId = 5 -- ID da porta no sistema
                        },

                    },
                    -- Configurações gerais
                    maxDoors = 2, -- Máximo de portas que pode abrir
                    timeBetweenDoors = 2000, -- Tempo entre abrir uma porta e ir para a próxima (ms)
                    resetAfterComplete = false -- Se deve voltar à animação de medo após abrir todas
                }
                }
             },
            ["manager"] = {
                coords = vector3(2648.905, -1291.695, 52.246),
                heading = 138.16,
                model = "cs_hobartcrawley", -- Modelo do caixa masculino
                enabled = true,
                outfit = 0, -- Preset do outfit (0-15)
                animation = {
                    dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                    anim = "idle_f",
                    flags = 1
                },
                -- Configurações de tempo de ameaça com arma
                weaponThreat = {
                    minHandsUpTime = 3, -- Tempo mínimo de mãos para cima (segundos)
                    maxHandsUpTime = 60, -- Tempo máximo de mãos para cima (segundos)
                    multiplier = 1.0 -- Multiplicador do tempo de mira (1.0 = 100% do tempo)
                }
            },
            ["client1"] = {
                coords = vector3(2648.873, -1294.025, 52.246),
                heading = -100.42,
                model = "a_m_m_middlesdtownfolk_03", -- Modelo do caixa masculino
                enabled = true,
                outfit = 0, -- Preset do outfit (0-15)
                animation = {
                    dict = "script_story@ind1@ig@ig12_hosea_bankers",
                    anim = "ig12_hoseabankers_bankeridle_a_m_m_gamhighsociety_01",
                    flags = 2
                },
                -- Configurações de tempo de ameaça com arma
                weaponThreat = {
                    minHandsUpTime = 3, -- Tempo mínimo de mãos para cima (segundos)
                    maxHandsUpTime = 60, -- Tempo máximo de mãos para cima (segundos)
                    multiplier = 1.0 -- Multiplicador do tempo de mira (1.0 = 100% do tempo)
                }
            },

         
        }
    },
    ["rhodes_hostages"] = {
        enabled = true,
        
        hostages = {
            ["banker"] = {
                coords = vector3(1292.773, -1304.733, 76.042),
                heading = -37.747,
                model = "s_m_m_bankclerk_01", -- Modelo do caixa masculino
                enabled = true,
                outfit = 2, -- Preset do outfit (0-15)
                animation = {
                    dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                    anim = "idle_f",
                    flags = 1
                },
                -- Configurações de tempo de ameaça com arma
                weaponThreat = {
                    minHandsUpTime = 3, -- Tempo mínimo de mãos para cima (segundos)
                    maxHandsUpTime = 60, -- Tempo máximo de mãos para cima (segundos)
                    multiplier = 1.0, -- Multiplicador do tempo de mira (1.0 = 100% do tempo)
                    shotDetection = {
                        enabled = true, -- Ativar detecção de tiros próximos
                        radius = 4.0, -- Raio em metros para detectar tiros (Rhodes precisa de mais alcance)
                        minShots = 3 -- Número mínimo de tiros para ativar
                    },
                    -- Configuração de movimento após hands up
                    moveAfterHandsUp = {
                    enabled = true,
                    forceTimeout = 30000, -- Tempo em ms para forçar movimento mesmo sem todos em hands up (30s)
                    -- Lista de portas para abrir em sequência
                    doorSequence = {
                        [1] = {
                            targetPosition = vector3(1295.734, -1305.475, 76.033), -- Posição da primeira porta (porta 4)
                            targetHeading = -37.747, -- Direção que fica virado na porta
                            walkSpeed = 1.0, -- Velocidade de caminhada (1.0 = normal)
                            waitAtTarget = 3000, -- Tempo que espera na porta (ms)
                            actionText = "Opening the main vault door...", -- Texto que aparece
                            doorId = 6 -- ID da porta no sistema
                        },


                    },
                    -- Configurações gerais
                    maxDoors = 1, -- Máximo de portas que pode abrir
                    timeBetweenDoors = 2000, -- Tempo entre abrir uma porta e ir para a próxima (ms)
                    resetAfterComplete = false -- Se deve voltar à animação de medo após abrir todas
                }
                }
             },
            ["manager"] = {
                coords = vector3(1297.384, -1303.219, 76.041),
                heading = 48.407,
                model = "cs_hobartcrawley", -- Modelo do caixa masculino
                enabled = true,
                outfit = 0, -- Preset do outfit (0-15)
                animation = {
                    dict = "amb_misc@world_human_stand_waiting@male_b@idle_b",
                    anim = "idle_f",
                    flags = 1
                },
                -- Configurações de tempo de ameaça com arma
                weaponThreat = {
                    minHandsUpTime = 3, -- Tempo mínimo de mãos para cima (segundos)
                    maxHandsUpTime = 60, -- Tempo máximo de mãos para cima (segundos)
                    multiplier = 1.0 -- Multiplicador do tempo de mira (1.0 = 100% do tempo)
                }
            },
            ["client1"] = {
                coords = vector3(1291.505, -1298.499, 76.061),
                heading = 51.18,
                model = "a_m_m_middlesdtownfolk_03", -- Modelo do caixa masculino
                enabled = true,
                outfit = 0, -- Preset do outfit (0-15)
                animation = {
                    dict = "script_story@ind1@ig@ig12_hosea_bankers",
                    anim = "ig12_hoseabankers_bankeridle_a_m_m_gamhighsociety_01",
                    flags = 2
                },
                -- Configurações de tempo de ameaça com arma
                weaponThreat = {
                    minHandsUpTime = 3, -- Tempo mínimo de mãos para cima (segundos)
                    maxHandsUpTime = 60, -- Tempo máximo de mãos para cima (segundos)
                    multiplier = 1.0 -- Multiplicador do tempo de mira (1.0 = 100% do tempo)
                }
            },

         
        }
    },
    
}


-- Door Types Configuration
Config.DoorTypes = {
    -- Regular Door (original)
    door = {
        command = 'doortorch',
        phases = {
            {
                name = 'top',
                backgroundImage = 'top_door.png',
                doorHinge = {
                    image = 'door_hinge.png',
                    xPosition = -120,
                    yPosition = 0,
                    size = 200
                },
                cuttingGame = {
                    progressTitle = 'Cutting Top Section...',
                    progressSubtitle = 'Cut through the top hinge',
                    cutLineOffsetX = -130,
                    cutLineOffsetY = 0,
                    cutLineLength = 150
                }
            },
            {
                name = 'middle',
                backgroundImage = 'midle_door.png',
                doorHinge = {
                    image = 'door_hinge.png',
                    xPosition = -140,
                    yPosition = 125,
                    size = 200
                },
                cuttingGame = {
                    progressTitle = 'Cutting Middle Section...',
                    progressSubtitle = 'Cut through the middle hinge',
                    cutLineOffsetX = -150,
                    cutLineOffsetY = 125,
                    cutLineLength = 150
                }
            },
            {
                name = 'end',
                backgroundImage = 'end_door.png',
                doorHinge = {
                    image = 'door_hinge.png',
                    xPosition = -150,
                    yPosition = 130,
                    size = 200
                },
                cuttingGame = {
                    progressTitle = 'Cutting Bottom Section...',
                    progressSubtitle = 'Cut through the bottom hinge',
                    cutLineOffsetX = -160,
                    cutLineOffsetY = 130,
                    cutLineLength = 150
                }
            }
        }
    },
    
    -- Vault Door
    vault = {
        command = 'vaulttorch',
        phases = {
            {
                name = 'top',
                backgroundImage = 'vault_top.png',
                doorHinge = {
                    image = 'vault_hinge.png',
                    xPosition = 240,   -- Moved to the right (was -100)
                    yPosition = -20,
                    size = 180
                },
                cuttingGame = {
                    progressTitle = 'Cutting Vault Top Section...',
                    progressSubtitle = 'Cut through the vault top hinge',
                    cutLineOffsetX = 220,   -- Moved to match hinge position
                    cutLineOffsetY = -20,
                    cutLineLength = 140
                }
            },
            {
                name = 'middle',
                backgroundImage = 'vault_midle.png',
                doorHinge = {
                    image = 'vault_hinge.png',
                    xPosition = 220,
                    yPosition = 100,
                    size = 180
                },
                cuttingGame = {
                    progressTitle = 'Cutting Vault Middle Section...',
                    progressSubtitle = 'Cut through the vault middle hinge',
                    cutLineOffsetX = 200,
                    cutLineOffsetY = 100,
                    cutLineLength = 140
                }
            },
            {
                name = 'end',
                backgroundImage = 'vault_end.png',
                doorHinge = {
                    image = 'vault_hinge.png',
                    xPosition = 215,
                    yPosition = 120,
                    size = 180
                },
                cuttingGame = {
                    progressTitle = 'Cutting Vault Bottom Section...',
                    progressSubtitle = 'Cut through the vault bottom hinge',
                    cutLineOffsetX = 195,
                    cutLineOffsetY = 120,
                    cutLineLength = 140
                }
            }
        }
    }
}

-- TORCH Minigame Configuration (shared settings for all door types)
Config.Minigame = {
    -- Current phase (starts at 1)
    currentPhase = 1,
    
    -- UI Settings
    allowEscapeToClose = true,
    
    -- Debug mode
    debug = false,
    
    -- Global Cutting Settings (applied to all phases)
    globalCuttingSettings = {
        pathTolerance = 15,    -- Closer tolerance - must be more precise
        minSpeed = 0.5,        -- Very slow minimum speed (very realistic)
        maxSpeed = 4,          -- Very slow maximum speed (very realistic)
        particleCount = 15,    -- Number of particles per spark
        autoCloseOnSuccess = false, -- Don't auto close - go to next phase
        successDelay = 1700,   -- Delay before next phase (ms)
        progressRate = 0.3,    -- How fast progress increases (slower = more realistic)
        
        -- Progress Bar Settings
        progressIcon = 'images/cutting_line.png' -- Icon for progress bar
    },
    
    -- Phase Transition Settings
    phaseTransition = {
        loadingText = 'Loading next hinge...',  -- Text shown during loading
        backgroundOpacity = 1.0,                     -- Loading overlay opacity (completely black)
        transitionDuration = 400,                    -- Animation duration in ms
        loadingDuration = 300                        -- How long to show loading
    },
    
    -- Torch Audio Settings
    torchAudio = {
        igniteVolume = 1.0,     -- Volume for ignite sound (0.0 to 1.0)
        fireVolume = 1.0,       -- Volume for continuous fire sound (0.0 to 1.0)
        cuttingVolume = 1.0,    -- Volume for cutting sound (0.0 to 1.0)
        fadeTime = 500,         -- Fade out time in milliseconds
        enabled = true          -- Enable/disable all torch sounds
    }
}

-- Robbery Progress Bar Configuration (Simple)
Config.RobberyProgress = {
    command = 'robbery',        -- Command to start progress bar
    title = 'Robbing...',      -- Progress bar title
    subtitle = 'Stay still',   -- Progress bar subtitle  
    duration = 8000,           -- Duration in milliseconds (8 seconds)
    icon = 'images/robbery.png'  -- Icon image
}

-------------------------------------------------------
---- CONFIGURAÇÃO DAS NOTAS SPAWNS ----
-------------------------------------------------------

Config.NotesSpawns = {
    Settings = {
        model = "p_cs_note01x", -- Modelo da nota
        spawnDistance = 50.0, -- Distância para spawnar (metros)
        despawnDistance = 75.0, -- Distância para despawnar (metros)
        checkInterval = 2000, -- Intervalo de verificação (ms)
        maxNotes = 20, -- Máximo de notas simultâneas
        
        -- Configurações de coleta
        collection = {
            distance = 1.5, -- Distância para coletar
            command = "collectnote", -- Comando para coletar
            promptText = "Collect Note", -- Texto do prompt
            promptKey = 0x760A9C6F, -- Tecla G
            removeAfterCollection = true, -- Remove a nota após coletar
            notifyCollection = true, -- Notificar quando coletar
            
            -- Configurações de animação
            animations = {
                -- Animação de procurar
                search = {
                    dict = "mech_loco_m@generic@searching@poi@look_down@unarmed@idle@_variations@d",
                    anim = "idle_variation_d",
                    flag = 0,
                    duration = 3000 -- 3 segundos
                },
                -- Animação de pegar
                pickup = {
                    dict = "mech_loco_m@generic@robbing@non_aiming@unarmed@catch_rh",
                    anim = "catch_object",
                    flag = 27,
                    duration = 2000 -- 2 segundos
                },
                -- Configurações de anexo na mão
                attachment = {
                    boneIndex = 302, -- SKEL_R_Finger02
                    offset = {
                        x = 0.05,
                        y = 0.02,
                        z = 0.0
                    },
                    rotation = {
                        x = 0.0,
                        y = 0.0,
                        z = 0.0
                    },
                    attachDelay = 500, -- Delay antes de anexar (ms)
                    holdDuration = 1500 -- Tempo segurando na mão (ms)
                },
                -- Configurações gerais
                rotationSpeed = 500, -- Tempo para virar para a nota (ms)
                enableRotation = true, -- Se deve virar o player
                enableSearchAnim = true, -- Se deve fazer animação de procurar
                enablePickupAnim = true, -- Se deve fazer animação de pegar
                enableAttachment = true -- Se deve anexar na mão
            }
        }
    },
    
    -- Todas as 19 combinações de notas disponíveis
    AvailableNotes = {
        "02_99_41_note",
        "49_10_32_note", 
        "07_45_92_note",
        "38_11_64_note",
        "56_03_87_note",
        "21_74_09_note",
        "95_62_48_note",
        "13_80_27_note",
        "44_19_53_note",
        "68_07_36_note",
        "90_24_15_note",
        "72_33_08_note",
        "59_14_67_note",
        "81_06_25_note",
        "34_58_12_note",
        "17_83_40_note",
        "26_91_05_note",
        "63_39_78_note",
        "85_28_60_note"
    },
    
    -- Localizações dos spawns
    Locations = {
        ["valentine_notes"] = {
            displayName = "Valentine Bank Notes",
            description = "Notas espalhadas pelo banco de Valentine",
            enabled = true,
            maxActiveNotes = 6, -- Máximo de 6 notas ativas simultaneamente
            
            -- Spawns específicos para Valentine
            spawns = {
                {
                    id = "valentine_note_1",
                    coords = vector3(-305.148, 769.645, 118.171),
                    rotation = vector3(0.0, 0.0, 55.722), -- pitch, roll, yaw
                    enabled = true
                },
                {
                    id = "valentine_note_2", 
                    coords = vector3(-304.933, 770.541, 118.169),
                    rotation = vector3(0.0, 0.0, 55.722),
                    enabled = true
                },
                {
                    id = "valentine_note_3",
                    coords = vector3(-309.101, 767.94, 118.5),
                    rotation = vector3(0.0, 0.0, 55.721),
                    enabled = true
                },
                {
                    id = "valentine_note_4",
                    coords = vector3(-303.616, 768.769, 117.711),
                    rotation = vector3(0.0, 0.0, 102.0),
                    enabled = true
                },
                {
                    id = "valentine_note_5",
                    coords = vector3(-306.915, 766.874, 117.712),
                    rotation = vector3(0.0, 0.0, 24.999),
                    enabled = true
                },
                {
                    id = "valentine_note_6",
                    coords = vector3(-307.598, 774.595, 118.762),
                    rotation = vector3(0.0, 0.0, 135.0),
                    enabled = true
                },
                {
                    id = "valentine_note_7",
                    coords = vector3(-308.06, 770.158, 118.5),
                    rotation = vector3(0.0, 0.0, 5.396),
                    enabled = true
                },
                {
                    id = "valentine_note_8",
                    coords = vector3(-306.018, 763.968, 117.713),
                    rotation = vector3(0.0, 0.0, 5.396),
                    enabled = true
                },
                {
                    id = "valentine_note_9",
                    coords = vector3(-303.481, 765.82, 118.319),
                    rotation = vector3(0.0, 0.0, 5.396),
                    enabled = true
                },
                {
                    id = "valentine_note_10",
                    coords = vector3(-305.481, 762.539, 118.515),
                    rotation = vector3(0.0, 0.0, -17.0),
                    enabled = true
                }
            },
        },
        
        ["saint_denis_notes"] = {
            displayName = "Saint Denis Bank Notes",
            description = "Notas espalhadas pelo banco de Saint Denis",
            enabled = true,
            maxActiveNotes = 3, -- Máximo de 3 notas ativas simultaneamente
            
            -- Spawns específicos para Saint Denis (coordenadas de exemplo)
            spawns = {
                {
                    id = "saint_denis_note_1",
                    coords = vector3(2645.677, -1293.225, 52.305),
                    rotation = vector3(0.0, 0.0, 45.0),
                    enabled = true
                },
                {
                    id = "saint_denis_note_2", 
                    coords = vector3(2647.252, -1294.008, 52.305),
                    rotation = vector3(0.0, 0.0, -30.0),
                    enabled = true
                },
                {
                    id = "saint_denis_note_3",
                    coords = vector3(2647.71, -1295.873, 52.306),
                    rotation = vector3(0.0, 0.0, 90.0),
                    enabled = true
                },
                {
                    id = "saint_denis_note_4",
                    coords = vector3(2645.081, -1297.528, 52.306),
                    rotation = vector3(0.0, 0.0, 180.0),
                    enabled = true
                },
                {
                    id = "saint_denis_note_5",
                    coords = vector3(2644.194, -1295.042, 51.256),
                    rotation = vector3(0.0, 0.0, -45.0),
                    enabled = true
                },
                {
                    id = "saint_denis_note_6",
                    coords = vector3(2640.454, -1300.814, 52.306),
                    rotation = vector3(0.0, 0.0, 135.0),
                    enabled = true
                },
                {
                    id = "saint_denis_note_7",
                    coords = vector3(2641.445, -1300.292, 52.306),
                    rotation = vector3(0.0, 0.0, 60.0),
                    enabled = true
                },
                {
                    id = "saint_denis_note_8",
                    coords = vector3(2640.724, -1301.069, 51.256),
                    rotation = vector3(0.0, 0.0, -90.0),
                    enabled = true
                },
                {
                    id = "saint_denis_note_9",
                    coords = vector3(2644.62, -1306.09, 51.256),
                    rotation = vector3(0.0, 0.0, 15.0),
                    enabled = true
                },
                {
                    id = "saint_denis_note_10",
                    coords = vector3(2645.203, -1302.423, 52.306),
                    rotation = vector3(0.0, 0.0, -60.0),
                    enabled = true
                },
                {
                    id = "saint_denis_note_11",
                    coords = vector3(2651.802, -1302.276, 52.305),
                    rotation = vector3(0.0, 0.0, -93.735),
                    enabled = true
                },
                {
                    id = "saint_denis_note_12",
                    coords = vector3(2647.023, -1304.849, 52.305),
                    rotation = vector3(0.0, 0.0, 119.745),
                    enabled = true
                },
            }
        },
        
        ["rhodes_notes"] = {
            displayName = "Rhodes Bank Notes", 
            description = "Notas espalhadas pelo banco de Rhodes",
            enabled = true,
            maxActiveNotes = 6, 
            
            -- Spawns específicos para Rhodes (coordenadas de exemplo)
            spawns = {
                {
                    id = "rhodes_note_1",
                    coords = vector3(1290.426, -1312.25, 76.049),
                    rotation = vector3(0.0, 0.0, 45.0),
                    enabled = true
                },
                {
                    id = "rhodes_note_2",
                    coords = vector3(1291.916, -1309.568, 76.05),
                    rotation = vector3(0.0, 0.0, -30.0),
                    enabled = true
                },
                {
                    id = "rhodes_note_3",
                    coords = vector3(1295.258, -1307.179, 76.049),
                    rotation = vector3(0.0, 0.0, 90.0),
                    enabled = true
                },
                {
                    id = "rhodes_note_4",
                    coords = vector3(1288.301, -1303.773, 77.101),
                    rotation = vector3(0.0, 0.0, 180.0),
                    enabled = true
                },
                {
                    id = "rhodes_note_5",
                    coords = vector3(1290.514, -1302.344, 77.10),
                    rotation = vector3(0.0, 0.0, -45.0),
                    enabled = true
                },
                {
                    id = "rhodes_note_6",
                    coords = vector3(1293.291, -1304.291, 77.096),
                    rotation = vector3(0.0, 0.0, 135.0),
                    enabled = true
                },
                {
                    id = "rhodes_note_7",
                    coords = vector3(1293.379, -1308.043, 76.05),
                    rotation = vector3(0.0, 0.0, 60.0),
                    enabled = true
                },  
                {
                    id = "rhodes_note_8",
                    coords = vector3(1284.519, -1305.933, 76.049),
                    rotation = vector3(0.0, 0.0, -90.0),
                    enabled = true
                },
                {
                    id = "rhodes_note_9",
                    coords = vector3(1282.052, -1311.059, 76.049),
                    rotation = vector3(0.0, 0.0, -90.0),
                    enabled = true
                },
                {
                    id = "rhodes_note_10",
                    coords = vector3(1284.828, -1314.909, 76.049),
                    rotation = vector3(0.0, 0.0, -90.0),
                    enabled = true
                },
                {
                    id = "rhodes_note_11",
                    coords = vector3(1288.217, -1313.488, 76.049),
                    rotation = vector3(0.0, 0.0, -90.0),
                    enabled = true
                },
                {
                    id = "rhodes_note_12",
                    coords = vector3(1286.707, -1315.139, 76.049),
                    rotation = vector3(0.0, 0.0, -90.0),
                    enabled = true
                },
                {
                    id = "rhodes_note_13",
                    coords = vector3(1283.79, -1312.911, 76.049),
                    rotation = vector3(0.0, 0.0, -90.0),
                    enabled = true
                }

            }
        }
    }
}

-------------------------------------------------------
---- CONFIGURAÇÃO DOS COFRES POR BANCO ----
-------------------------------------------------------

Config.BankVaults = {
    Settings = {
        interactionDistance = 1.1, -- Distância para mostrar prompt
        promptText = "Open Safe", -- Texto do prompt
        promptKey = 0x760A9C6F, -- Tecla G
        requireActiveRound = true, -- Só funciona durante ronda ativa
        resetAfterRound = true, -- Reseta cofres quando ronda termina
        
        -- Configurações de animação por modelo específico
        animations = {
            -- Cofre pequeno esquerdo
            ["s_vault_sml_l_val01x"] = {
                openDict = "mini_games@safecrack@sm",
                openAnim = "open_lt_safe",
                closeDict = "mini_games@safecrack@sm", 
                closeAnim = "dial_reset_safe",
                openDuration = 2000,
                closeDuration = 5000
            },
            -- Cofre pequeno direito
            ["s_vault_sml_r_val01x"] = {
                openDict = "script_story@nbd1@ig@ig_29_billforcemanager",
                openAnim = "t10_arthur_safe_idle_sm_s_vault_sml_r_val01x",
                closeDict = "script_story@nbd1@ig@ig_29_billforcemanager", 
                closeAnim = "t10_bill_mngr_enter_sm_s_vault_sml_r_val01x",
                openDuration = 2000,
                closeDuration = 5000
            },
            -- Cofre médio direito
            ["s_vault_med_r_val01x"] = {
                openDict = "script_story@nbd1@ig@ig_29_billforcemanager",
                openAnim = "ig29_mudidle_md_s_vault_med_r_val01x",
                closeDict = "script_story@nbd1@ig@ig_29_billforcemanager",
                closeAnim = "ig29_mudidle_sm_s_vault_med_r_val01x", 
                openDuration = 2000,
                closeDuration = 5000
            },
            -- Cofre médio direito alto
            ["s_vault_med_r_val01x_high"] = {
                openDict = "script_ca@cachr@ig@ig4_vaultloot",
                openAnim = "open_small_vault_s_vault_med_r_val01x",
                closeDict = "script_ca@cachr@ig@ig4_vaultloot",
                closeAnim = "open_small_vault_s_vault_sml_r_val01x", 
                openDuration = 2000,
                closeDuration = 5000
            },
            -- Cofre grande direito alto
            ["s_vault_lrg_r_val01x_high"] = {
                openDict = "script_story@nbd1@ig@ig_29_billforcemanager",
                openAnim = "ig29_mudidle_lg_s_vault_lrg_r_val01x",
                closeDict = "script_story@nbd1@ig@ig_29_billforcemanager",
                closeAnim = "ig29_mudenter_sm_s_vault_lrg_r_val01x", 
                openDuration = 3000,
                closeDuration = 6000
            },

            -- rhodes
            ["s_vault_med_r_val_bent02x"] = {
                openDict = "script_ca@cachr@ig@ig4_vaultloot",
                openAnim = "open_small_vault_s_vault_med_r_val01x",
                closeDict = "script_ca@cachr@ig@ig4_vaultloot",
                closeAnim = "open_small_vault_s_vault_sml_r_val01x", 
                openDuration = 2000,
                closeDuration = 5000
            },
            ["s_vault_med_r_val_bent01x"] = {
                openDict = "script_ca@cachr@ig@ig4_vaultloot",
                openAnim = "open_small_vault_s_vault_med_r_val01x",
                closeDict = "script_ca@cachr@ig@ig4_vaultloot",
                closeAnim = "open_small_vault_s_vault_sml_r_val01x", 
                openDuration = 2000,
                closeDuration = 5000
            },
            --small
            ["s_vault_sml_r_val_bent01x"] = {
                openDict = "script_story@nbd1@ig@ig_29_billforcemanager",
                openAnim = "ig29_mudloot_sm_s_vault_sml_r_val01x",
                closeDict = "script_story@nbd1@ig@ig_29_billforcemanager",
                closeAnim = "ig29_mudloot_md_s_vault_sml_r_val01x", 
                openDuration = 2000,
                closeDuration = 5000
            },
            ["s_vault_sml_l_val_bent01x"] = {
                openDict = "script_ca@cachr@ig@ig4_vaultloot",
                openAnim = "open_small_vault_right_s_vault_sml_r_val_bent01x",
                closeDict = "script_story@nbd1@ig@ig_29_billforcemanager",
                closeAnim = "ig29_mudloot_md_s_vault_sml_r_val01x", 
                openDuration = 2000,
                closeDuration = 5000
            },

            -- Saint Denis
            ["s_vault_sml_r_val01x_high"] = {
                openDict = "script_story@nbd1@ig@ig_29_billforcemanager",
                openAnim = "ig29_mudidle_sm_s_vault_sml_r_val01x",
                closeDict = "script_story@nbd1@ig@ig_29_billforcemanager",
                closeAnim = "ig29_mudloot_md_s_vault_sml_r_val01x", 
                openDuration = 2000,
                closeDuration = 5000
            },


        }
    },
    
    -- Configurações por banco
    Banks = {
        ["valentine_vaults"] = {
            displayName = "Valentine Bank Vaults",
            description = "Cofres do banco de Valentine",
            enabled = true,
            associatedRound = "valentine_ronda", -- Ronda que deve estar ativa
            
            vaults = {
                {
                    id = "valentine_vault_1",
                    coords = vector3(-308.4885559082031, 762.2102050781, 118.503166198),
                    heading = -170.0,
                    model = "s_vault_sml_r_val01x",
                    type = "small_vault",
                    items = {"clothe3", "clothe2"},
                    money = {
                        min = 50,  -- Dinheiro mínimo
                        max = 150  -- Dinheiro máximo
                    },
                    enabled = true,
                    spawned = false,
                    -- Posição e heading específicos para animação do player neste cofre
                    playerAnim = {
                        dict = "mini_games@safecrack@sm",
                        anim = "dial_turn_left_stage_00",
                        flag = 1,
                        coords = vector3(-308.416, 762.802, 117.703), -- Posição exata do player
                        heading = -152.996 -- Heading exato do player
                    }
                },
                {
                    id = "valentine_vault_2", 
                    coords = vector3(-308.4800109863281, 765.73, 118.51000213623047),
                    heading = 10.99,
                    model = "s_vault_sml_r_val01x",
                    type = "small_vault",
                    items = {"gold"},
                    money = {
                        min = 75,  -- Dinheiro mínimo
                        max = 200  -- Dinheiro máximo
                    },
                    enabled = true,
                    spawned = false,
                    -- Posição e heading específicos para animação do player neste cofre
                    playerAnim = {
                        dict = "mini_games@safecrack@sm",
                        anim = "dial_turn_left_stage_00",
                        flag = 1,
                        coords = vector3(-308.589, 765.101, 117.703), -- Posição exata do player
                        heading = 25.062 -- Heading exato do player
                    }
                },
                {
                    id = "valentine_vault_3",
                    coords = vector3(-309.2186584472656, 762.4449462890625, 117.79785156),
                    heading = 99.0,
                    model = "s_vault_med_r_val01x",
                    type = "medium_vault",
                    items = {"bread"},
                    money = {
                        min = 100,  -- Dinheiro mínimo
                        max = 300   -- Dinheiro máximo
                    },
                    enabled = true,
                    spawned = false,
                    -- Posição e heading específicos para animação do player neste cofre
                    playerAnim = {
                        dict = "mini_games@safecrack@med",
                        anim = "dial_turn_left_stage_01",
                        flag = 1,
                        coords = vector3(-308.744, 762.854, 117.703), -- Posição exata do player
                        heading = 110.138 -- Heading exato do player
                    }
                },
                {
                    id = "valentine_vault_4",
                    coords = vector3(-309.4244689941, 763.491577148437, 117.79785156),
                    heading = 100.0,
                    model = "s_vault_med_r_val01x", 
                    type = "medium_vault",
                    items = {"water", "gold"},
                    money = {
                        min = 150,  -- Dinheiro mínimo
                        max = 400   -- Dinheiro máximo
                    },
                    enabled = true,
                    spawned = false,
                    -- Posição e heading específicos para animação do player neste cofre
                    playerAnim = {
                        dict = "mini_games@safecrack@med",
                        anim = "dial_turn_left_stage_01",
                        flag = 1,
                        coords = vector3(-308.921, 763.909, 117.703), -- Posição exata do player
                        heading = 108.021 -- Heading exato do player
                    }
                },
                {
                    id = "valentine_vault_5",
                    coords = vector3(-309.595703125, 764.556518554687, 117.7978515625),
                    heading = 100.0,
                    model = "s_vault_med_r_val01x",
                    type = "medium_vault", 
                    items = {"clothe3", "clothe3"},
                    money = {
                        min = 200,  -- Dinheiro mínimo
                        max = 500   -- Dinheiro máximo
                    },
                    enabled = true,
                    spawned = false,
                    -- Posição e heading específicos para animação do player neste cofre
                    playerAnim = {
                        dict = "mini_games@safecrack@med",
                        anim = "dial_turn_left_stage_01",
                        flag = 1,
                        coords = vector3(-309.081, 764.889, 117.703), -- Posição exata do player
                        heading = 103.041 -- Heading exato do player
                    }
                }
            }
        },
        
        ["saint_denis_vaults"] = {
            displayName = "Saint Denis Bank Vaults",
            description = "Cofres do banco de Saint Denis",
            enabled = true,
            associatedRound = "saint_denis_ronda",
            
            vaults = {
                {
                    id = "saint_denis_vault_1",
                    coords = vector3(2645.168, -1306.612, 51.379),
                    heading = -155.0,
                    model = "s_vault_lrg_r_val01x_high",
                    type = "large_vault",
                    items = {"gold", "clothe2"},
                    money = {
                        min = 300,  -- Dinheiro mínimo (cofre grande)
                        max = 800   -- Dinheiro máximo
                    },
                    enabled = true,
                    spawned = false,
                    playerAnim = {
                        dict = "mini_games@safecrack@base",
                        anim = "dial_turn_left_stage_00",
                        flag = 1,
                        coords = vector3(2644.259, -1306.402, 51.246), -- Posição exata do player
                        heading = -138.287 -- Heading exato do player
                    }
                },
                {
                    id = "saint_denis_vault_2",
                    coords = vector3(2644.766, -1303.275, 52.063),
                    heading = -65.001,
                    model = "s_vault_sml_r_val01x_high",
                    type = "small_vault",
                    items = {"water", "bread", "gold"},
                    money = {
                        min = 100,  -- Dinheiro mínimo (cofre pequeno)
                        max = 250   -- Dinheiro máximo
                    },
                    enabled = true,
                    spawned = false,
                    playerAnim = {
                        dict = "mini_games@safecrack@base",
                        anim = "dial_turn_left_stage_00",
                        flag = 1,
                        coords = vector3(2644.428, -1303.9, 51.245), -- Posição exata do player
                        heading = -47.872 -- Heading exato do player
                    }
                },
                {
                    id = "saint_denis_vault_3",
                    coords = vector3(2641.291, -1303.771, 51.353),
                    heading = 114.999,
                    model = "s_vault_med_r_val01x_high",
                    type = "medium_vault",
                    items = {"water", "bread", "gold"},
                    money = {
                        min = 150,  -- Dinheiro mínimo (cofre médio)
                        max = 400   -- Dinheiro máximo
                    },
                    enabled = true,
                    spawned = false,
                    playerAnim = {
                        dict = "mini_games@safecrack@med",
                        anim = "dial_turn_left_stage_01",
                        flag = 1,
                        coords = vector3(2641.73, -1303.29, 51.245), -- Posição exata do player
                        heading = 115.033 -- Heading exato do player
                    }
                },
            }
        },
        
        ["rhodes_vaults"] = {
            displayName = "Rhodes Bank Vaults", 
            description = "Cofres do banco de Rhodes",
            enabled = true,
            associatedRound = "rhodes_ronda",
            
            vaults = {
                {
                    id = "rhodes_vault_1",
                    coords = vector3(1288.199, -1312.922, 76.852),
                    heading = -39.827,
                    model = "s_vault_sml_r_val_bent01x",
                    type = "small_vault",
                    items = {"clothe3", "clothe2"},
                    money = {
                        min = 80,   -- Dinheiro mínimo (cofre pequeno)
                        max = 180   -- Dinheiro máximo
                    },
                    enabled = true,
                    spawned = false,
                    -- Posição e heading específicos para animação do player neste cofre
                    playerAnim = {
                        dict = "mini_games@safecrack@sm",
                        anim = "dial_turn_left_stage_00",
                        flag = 1,
                        coords = vector3(1288.111, -1313.584, 76.039), -- Posição exata do player
                        heading = -29.727 -- Heading exato do player
                    }
                },
                {
                    id = "rhodes_vault_2", 
                    coords = vector3(1288.968, -1314.062, 76.145),
                    heading = -130.141,
                    model = "s_vault_med_r_val_bent01x",
                    type = "medium_vault",
                    items = {"gold"},
                    money = {
                        min = 120,  -- Dinheiro mínimo (cofre médio)
                        max = 350   -- Dinheiro máximo
                    },
                    enabled = true,
                    spawned = false,
                    -- Posição e heading específicos para animação do player neste cofre
                    playerAnim = {
                        dict = "mini_games@safecrack@med",
                        anim = "dial_turn_left_stage_01",
                        flag = 1,
                        coords = vector3(1288.254, -1314.041, 76.039), -- Posição exata do player
                        heading = -108.654 -- Heading exato do player
                    }
                },
                {
                    id = "rhodes_vault_3",
                    coords = vector3(1288.278, -1314.884, 76.145),
                    heading = -130.141,
                    model = "s_vault_med_r_val_bent02x",
                    type = "medium_vault",
                    items = {"bread"},
                    money = {
                        min = 100,  -- Dinheiro mínimo (cofre médio)
                        max = 300   -- Dinheiro máximo
                    },
                    enabled = true,
                    spawned = false,
                    -- Posição e heading específicos para animação do player neste cofre
                    playerAnim = {
                        dict = "mini_games@safecrack@med",
                        anim = "dial_turn_left_stage_01",
                        flag = 1,
                        coords = vector3(1287.584, -1314.752, 76.039), -- Posição exata do player
                        heading = -120.089 -- Heading exato do player
                    }
                },
                {
                    id = "rhodes_vault_4",
                    coords = vector3(1287.591, -1315.703, 76.145),
                    heading = -130.141,
                    model = "s_vault_med_r_val_bent01x", 
                    type = "medium_vault",
                    items = {"water", "gold"},
                    enabled = true,
                    spawned = false,
                    -- Posição e heading específicos para animação do player neste cofre
                    playerAnim = {
                        dict = "mini_games@safecrack@med",
                        anim = "dial_turn_left_stage_01",
                        flag = 1,
                        coords = vector3(1286.999, -1315.522, 76.039), -- Posição exata do player
                        heading = -129.21 -- Heading exato do player
                    }
                },
                {
                    id = "rhodes_vault_5",
                    coords = vector3(1285.958, -1315.588, 76.852),
                    heading = 140.103,
                    model = "s_vault_sml_l_val_bent01x",
                    type = "small_vault", 
                    items = {"clothe3", "clothe3"},
                    enabled = true,
                    spawned = false,
                    -- Posição e heading específicos para animação do player neste cofre
                    playerAnim = {
                        dict = "mini_games@safecrack@sm",
                        anim = "dial_turn_left_stage_00",
                        flag = 1,
                        coords = vector3(1286.478, -1315.261, 76.038), -- Posição exata do player
                        heading = 160.538 -- Heading exato do player
                    }
                }
            }
        }
    }
}

-- ========================================
-- CONFIGURAÇÕES DAS PORTAS DO BANCO
-- ========================================
Config.BankDoors = {
    -- Valentine Bank
    [1] = {
        hash = 1340831050, 
        hash2 = nil, -- Porta simples
        model = "p_gate_valbankvlt", 
        coords = vector3(-311.741, 774.675, 117.729),
        description = "Porta do Cofre Principal",
        closedHeading = 10.055,
        openHeading = 112.055,
        kickPitch = 90.0  -- Pitch positivo (cai para frente)
    },
    [2] = {
        hash = 3718620420, 
        hash2 = nil,
        model = "p_door_val_bank01", 
        coords = vector3(-311.06, 770.124, 117.702),
        description = "Porta Principal 1",
        closedHeading = 10.055,
        openHeading = -74.945,
        kickPitch = 90.0  -- Pitch positivo (cai para frente)
    },
    [3] = {
        hash = 576950805, 
        hash2 = nil,
        model = "p_door_val_bankvault", 
        coords = vector3(-307.75375366211, 766.34899902344, 117.7015914917),
        description = "Porta Da Entrada do Cofre",
        closedHeading = -169.945,
        openHeading = -255.0,
        kickPitch = -90.0  -- Pitch negativo (cai para trás) - original
    },
    -- Saint Denis Bank
    [4] = {
        hash = 965922748, 
        hash2 = nil,
        model = "p_door_nbxbank02x_l", 
        coords = vector3(2648.98, -1300.05, 51.245),
        description = "Porta Da Entrada do Cofre",
        closedHeading = -155.000,
        openHeading = -75.0,
        kickPitch = 90.0  -- Pitch positivo (cai para frente)
    },
    [5] = {
        hash = 1751238140, 
        hash2 = nil,
        model = "p_door_val_bankvault02x", 
        coords = vector3(2643.3, -1300.427, 51.255),
        description = "Porta Da Entrada do Cofre",
        closedHeading = 160.055,
        openHeading = -255.0,
        kickPitch = -90.0  -- Pitch negativo (cai para trás)
    },
    -- Rhodes Bank
    [6] = {
        hash = 1634148892, 
        hash2 = nil, -- Porta simples
        model = "p_gateundrtkr01x", 
        coords = vector3(1295.7341308594, -1305.4748535156, 76.033004760742),
        description = "Porta do Cofre Principal",
        closedHeading = 139.999,
        openHeading = 49.999,
        kickPitch = -90.0  -- Pitch positivo (cai para trás)
    },
    [7] = {
        hash = 3483244267, 
        hash2 = nil, -- Porta simples
        model = "p_door_val_bankvault", 
        coords = vector3(1282.5363769531,-1309.3159179688,76.036422729492),
        description = "Porta do Cofre Principal",
        closedHeading = -130.999,
        openHeading = 136.999,
        kickPitch = -90.0  -- Pitch positivo (cai para trás)
    },
}

-- ========================================
-- CONFIGURAÇÕES DOS ALVOS DE DINAMITE
-- ========================================
Config.DynamiteTargets = {
    -- Portas do banco
    {
        type = "door",
        doorId = 1,
        coords = vector3(-311.741, 774.675, 117.729),
        description = "Porta do Cofre Principal",
        distance = 3.0
    },
    {
        type = "door", 
        doorId = 2,
        coords = vector3(-311.06, 770.124, 117.702),
        description = "Porta Principal 1",
        distance = 3.0
    },
    {
        type = "door",
        doorId = 3, 
        coords = vector3(-307.75375366211, 766.34899902344, 117.7015914917),
        description = "Porta Da Entrada do Cofre",
        distance = 3.0
    },
    -- Saint Denis doors
    {
        type = "door",
        doorId = 4,
        coords = vector3(2648.98, -1300.05, 51.245),
        description = "Porta Da Entrada do Cofre (Saint Denis)", 
        distance = 3.0
    },
    {
        type = "door",
        doorId = 5,
        coords = vector3(2643.3, -1300.427, 51.255),
        description = "Porta Da Entrada do Cofre (Saint Denis)",
        distance = 3.0
    },
    -- Rhodes Bank
    {
        type = "door",
        doorId = 6,
        coords = vector3(1295.7341308594, -1305.4748535156, 76.033004760742),
        description = "Porta Da Entrada do Cofre (Rhodes)",
        distance = 3.0
    },
    {
        type = "door",
        doorId = 7,
        coords = vector3(1282.5363769531,-1309.3159179688,76.036422729492),
        description = "Porta do Cofre Principal",
        distance = 3.0
    },
    
    -- Paredes dos bancos
    {
        type = "wall",
        bankName = "Saint Denis Bank",
        coords = vector3(2653.033, -1291.999, 52.246),
        description = "Parede do Saint Denis Bank",
        distance = 4.0,
        rayfireObjects = {"des_nbd1_bankwall", "des_nbd1_bankwall_int"},
        imapId = 1017355491
    },
    {
        type = "wall", 
        bankName = "Rhodes Bank",
        coords = vector3(1288.11, -1315.277, 78.399),
        description = "Parede do Rhodes Bank",
        distance = 4.0,
        rayfireObjects = {"des_rho_bankwall"},
        interiorId = 29442
    }
}

-- ========================================
-- CONFIGURAÇÕES DA TOCHA (TORCH TOOL)
-- ========================================
Config.TorchTargets = {
    -- Valentine Bank
    valentine = {
        {
            coords = vector3(-311.741, 774.675, 117.729),
            doorType = "vault",
            minigameType = "door", -- Tipo: door ou vault
            distance = 3.0,
            description = "Porta do Cofre Principal",
            kickDoorId = 1, -- ID da porta no sistema de KickDoor
            -- Posição e heading do player para corte
            playerPos = vector3(-311.184, 775.822, 117.703),
            playerHeading = 165.044
        },
        {
            coords = vector3(-307.75375366211, 766.34899902344, 117.7015914917),
            doorType = "vault", 
            minigameType = "vault", -- Tipo: door ou vault
            distance = 3.0,
            description = "Cofre Principal",
            kickDoorId = 3, -- ID da porta no sistema de KickDoor
            -- Posição e heading do player para corte
            playerPos = vector3(-307.786, 767.687, 117.703),
            playerHeading = -167.328
        }
    },
    -- Saint Denis Bank
    saint_denis = {
        {
            coords = vector3(2644.012, -1299.424, 52.246),
            doorType = "vault", 
            minigameType = "vault",
            distance = 1.0,
            description = "Cofre Principal",
            kickDoorId = 5,
            playerPos = vector3(2644.012, -1299.424, 51.246),
            playerHeading = 163.293
        }
    },
    rhodes = {
        {
            coords = vector3(1295.7341308594, -1305.4748535156, 76.033004760742),
            doorType = "vault",
            minigameType = "door",
            distance = 3.0,
            description = "Porta do Cofre Principal",
            kickDoorId = 6,
            playerPos = vector3(1296.51, -1304.741, 76.043),
            playerHeading = 143.939
        },
        {
            coords = vector3(1282.5363769531,-1309.3159179688,76.036422729492),
            doorType = "vault",
            minigameType = "vault",
            distance = 1.5,
            description = "Porta do Cofre Principal",
            kickDoorId = 7,
            playerPos = vector3(1281.927, -1308.12, 76.039),
            playerHeading = -139.969
        }
    }
    
    -- Adicionar outras localizações aqui conforme necessário
    -- strawberry = { ... },
    -- rhodes = { ... }
}

-- ========================================
-- CONFIGURAÇÕES DE DETECÇÃO DE LOCALIZAÇÃO
-- ========================================
Config.BankLocations = {
    valentine = {
        center = vector3(-308.0, 775.0, 117.7),
        radius = 50.0,
        displayName = "Valentine Bank"
    },
    saint_denis = {
        center = vector3(2646.0, -1300.0, 51.2),
        radius = 50.0,
        displayName = "Saint Denis Bank"
    },
    rhodes = {
        center = vector3(1295.0, -1305.0, 76.0),
        radius = 50.0,
        displayName = "Rhodes Bank"
    }
    -- strawberry = {
    --     center = vector3(x, y, z),
    --     radius = 50.0,
    --     displayName = "Strawberry Bank"
    -- },
    -- rhodes = {
    --     center = vector3(x, y, z),
    --     radius = 50.0,
    --     displayName = "Rhodes Bank"
    -- }
}

-- ========================================
-- CONFIGURAÇÕES DE LINGUAGENS
-- ========================================
Config.Languages = {
    currentLanguage = "en-us", -- Idioma padrão
    
    ["en-us"] = {
        -- Client Bank Robbery Messages
        bankStatus = {
            open = "OPEN",
            closed = "CLOSED",
            statusMessage = " is " -- bankName + statusMessage + status
        },
        
        bankOperations = {
            rhodesClosing = "Closing bank via server...",
            rhodesOpening = "Opening bank via server...",
            saintDenisOpening = "Opening bank via server...",
            saintDenisClosing = "Closing bank via server...",
            rhodesInitializing = "Initializing bank - closing walls",
            saintDenisInitializing = "Initializing bank - closing walls"
        },
        
        rayfire = {
            noObjectsFound = "No Rayfire objects found nearby",
            wallsClosed = "Walls Closed",
            bankInitialized = " initialized - walls closed"
        },
        
        bankNames = {
            rhodes = "Rhodes Bank",
            saintDenis = "Saint Denis Bank",
            valentine = "Valentine Bank"
        },
        
        -- Client Dial Game Messages
        dialGame = {
            vaultsInactive = "Vaults Inactive",
            noActiveRound = "No active round with vault system",
            success = "Success!",
            wrongCombination = "Wrong Combination!",
            wrongCombinationMessage = "The entered combination is wrong!",
            failed = "Failed!",
            toxicGas = "Toxic Gas!",
            minigameInterrupted = "Safe minigame interrupted by toxic gas!",
            roundFinished = "Round Finished",
            systemDeactivated = "Vault system deactivated by lobby",
            vaultOccupied = "Vault Occupied",
            someoneUsing = "Someone is already using a vault",
            vaultAlreadyOpened = "Vault Already Opened",
            alreadyOpenedMessage = "This vault has already been opened",
            accessDenied = "Access Denied",
            notInLobby = "You are not in the correct lobby",
            wrongCombinationProvided = "The provided combination is wrong",
            unknownReason = "Unknown reason"
        },
        
        -- Client Door Locks Messages
        doorLocks = {
            doorChanged = "Door Changed",
            locked = "locked",
            unlocked = "unlocked",
            doorKicked = "Door Kicked",
            doorKickedMessage = " was kicked and opened!",
            explosion = "Explosion!",
            doorExploded = " was exploded with dynamite!",
            massiveExplosion = "Massive Explosion!",
            wallDestroyed = " was destroyed with dynamite!",
            tooFar = "Too Far",
            needToBeClose = "You need to be close to a door or wall to use dynamite",
            bombActivated = "BOMB ACTIVATED! EXPLOSION IN ",
            seconds = " SECONDS!",
            explosionText = "EXPLOSION!",
            dynamiteCancelled = "Dynamite Cancelled",
            bombCancelled = "You cancelled the bomb setup",
            dynamiteFailed = "Dynamite Failed",
            bombError = "Something went wrong with the bomb",
            debugExecuted = "Debug executed - check console",
            closestDoor = "Closest Door",
            noDoor = "No Door",
            incorrectUsage = "Incorrect Usage",
            usageCloseDoor = "Use: /closedoor [1-5]",
            invalidId = "Invalid ID",
            doorIdRange = "Door ID must be between 1 and 5",
            usageKickDoor = "Use: /kickdoor_id [1-5]",
            nonExistentDoor = "Non-existent Door",
            doorNotExist = " does not exist",
            tooFarFromDoor = "You are too far from door ",
            usagePitch = "Use: /testpitch [doorId] [pitch] (ex: /testpitch 5 -90)",
            invalidPitch = "Invalid Pitch",
            pitchNumber = "Pitch value must be a number (ex: -90, 90)",
            pitchApplied = "Pitch Applied",
            pitchDegrees = "° pitch",
            error = "Error",
            doorObjectNotFound = " object not found",
            targetFound = "Target Found",
            noTarget = "No Target",
            noValidTarget = "No valid dynamite target nearby",
            completeReset = "Complete Reset",
            allDoorsLocked = "All doors have been locked",
            forcedReset = "Forced Reset",
            doorResetForced = " reset forcefully",
            tablesCleared = "Tables Cleared",
            controlTablesReset = "Door control tables have been reset",
            syncTest = "Sync Test",
            syncResetTested = "Reset synchronization tested",
            pitchForced = "Pitch Forced",
            pitchAppliedToDoor = "Pitch applied to door ",
            areaClean = "Area Clean",
            decalsRemoved = "Explosion and blood decals removed",
            cleanupTest = "Cleanup Test",
            decalCleanupRequested = "Decal cleanup requested via server",
            noNearbyKick = "No nearby door to kick (< 5m)",
            doorKickedSimple = " was kicked!",
            doorWith = "Door ",
            with = " with "
        },
        
        -- Client Generator Messages
        generators = {
            explosionGenerator = "💥 GENERATOR EXPLOSION! 💥",
            audioTest = "Audio Test",
            testingWith = "Testing ",
            audioStopped = "Audio Stopped",
            generatorAudioStopped = "Generator sound stopped and system reset",
            systemReset = "System Reset",
            generatorAudioReset = "Generator audio system reinitialized",
            gasTest = "Gas Test",
            testingDisabling = "Testing disabling for ",
            systemInactive = "System Inactive",
            generatorSystemInactive = "Generator system is not active",
            audioForced = "Audio Forced",
            generatorAudioReactivated = "Generator audio reactivated",
            noGenerator = "No Generator",
            noNearbyGenerator = "No nearby generator found",
            audioDebug = "Audio Debug",
            generatorBroken = "Generator Broken",
            generatorBrokenMessage = " with smoke + electric effects (reduced sound)",
            electricEffects = "Electric Effects",
            generatorWithShocks = " with electric shocks",
            generatorRestored = "Generator Restored",
            generatorRestoredMessage = " back to normal (sound restored)",
            effectsStopped = "Effects Stopped",
            allEffectsStopped = "All effects stopped (",
            removed = " removed)",
            generatorSabotaged = "Generator Sabotaged",
            anotherPlayerSabotaged = "Another player sabotaged generator ",
            testFailed = "Test Failed",
            needActiveLobby = "You need to be in an active lobby",
            syncTest = "Sync Test",
            activeRobberySynced = "Active robbery synchronized: ",
            sabotageTest = "Sabotage Test",
            sabotageSynced = "Sabotage state synchronized: ",
            sabotageStarted = "Sabotage Started",
            cuttingWires = "Cutting generator wires...",
            sabotageCompleted = "Sabotage Completed",
            generatorDisabled = "Generator disabled! Gas neutralized! +",
            secondsAdded = "s added",
            electricShock = "Electric Shock!",
            wrongWireCut = "You got shocked by cutting the wrong wire!",
            sabotageNegated = "Sabotage Denied",
            error = "Error",
            generatorNotFound = " not found",
            testSabotage = "Test Sabotage",
            sabotageSuccessful = " sabotaged and synchronized!",
            robberySet = "Robbery Set",
            activeRobbery = "Active robbery: ",
            robberyCleared = "Robbery Cleared",
            noActiveRobbery = "No active robbery",
            testShock = "Test Shock",
            electricShockApplied = "Electric shock applied for ",
            maskRemoved = "Mask Removed",
            gasMaskRemoved = "Gas mask removed",
            modelNotFound = "Mask model not found",
            maskEquipped = "Mask Equipped",
            gasMaskEquipped = "Gas mask equipped successfully",
            generatorsReset = "Generators Reset",
            generatorsResetMessage = " generators reset to original state",
            needLobbyToSabotage = "You need to be in an active lobby to sabotage generators"
        },
        
        -- Client Hostage Functions Messages
        hostages = {
            bankerArmed = "BANKER ARMED!",
            bankerArmedMessage = "The banker drew a weapon - all hostages must be in hands up!",
            bankerPacified = "Banker Pacified",
            allHostagesHandsUp = "All hostages in hands up - banker stopped attacking",
            hostageCaptured = "Hostage Captured",
            isHogtiedCannotEscape = " is hogtied and cannot escape!",
            isHogtiedCannotAttempt = " is hogtied and cannot attempt to escape!",
            hostageAttacking = "Hostage Attacking!",
            hostageAttackingMessage = " is trying to escape! Aim to stop!",
            hostageCapturedMessage = " was hogtied during escape attempt!",
            stoppedFromEscaping = " stopped from escaping! (1/1 chance used)",
            refemMorreu = "Hostage died",
            hostageLiberated = "Hostage died and you were released",
            refemCapturado = "Hostage Captured",
            capturedMessage = "You captured ",
            useWASD = ". Use WASD to move!",
            refemLiberado = "Hostage Released",
            releasedMessage = "You released ",
            refensLiberados = "Hostages Released",
            hostagesReleased = " hostages were released",
            lobbyNecessario = "Lobby Necessary",
            needActiveLobbyHostages = "You need to be in an active lobby to interact with hostages",
            erro = "Error",
            animationLoadFailed = "Animation load failed",
            systemNotInitialized = "Hostage system not initialized",
            nenhumHostage = "No Hostage",
            spawnHostagesFirst = "Spawn hostages first (/hostages_start valentine_hostages)",
            nenhumRefem = "No Hostage",
            noNearbyHostages = "No nearby hostages (max 3m)",
            refemOcupado = "Hostage Occupied",
            hostageAlreadyCaptured = "This hostage was already captured",
            noHostagesCaptured = "You don't have any hostages captured",
            naoPossivel = "Not possible",
            movementCancelled = "Movement Cancelled",
            hostageDeadCannotMove = " is dead and cannot move",
            movementStopped = "Movement Stopped",
            hostageDiedWhileMoving = " died while moving",
            bankerMoved = "Banker Moved",
            reachedDoorPosition = " reached door ",
            position = " position",
            doorOpenedByBanker = " OPENED BY BANKER 🔓",
            allDoorsOpenedByBanker = "🔓 ALL DOORS OPENED BY BANKER 🔓",
            activeThreats = "Active threats: ",
            config = "Config ",
            timerFlashTest = "Timer Flash Test",
            redFlashActivated = "Red flash effect activated!",
            testFailed = "Test Failed",
            robberyTimerNotActive = "Robbery timer is not active",
            hostageDeathTest = "Hostage Death Test",
            wasKilledForTesting = " was killed for testing",
            noHostagesNearby = "No hostages nearby",
            bankerCheckTest = "Banker Check Test",
            canMove = "Can move: ",
            yes = "YES",
            no = "NO",
            bankerNotFound = "Banker not found",
            bankerAttackTest = "Banker Attack Test",
            bankerIsAttacking = "Banker is now attacking!",
            testeIniciado = "Teste Iniciado",
            bankerMovingToTarget = "Banker moving to target position",
            timerMode = "Timer modo: ",
            aboveNPC = "Acima do NPC",
            fixedOnScreen = "Fixed on screen",
            timerHeight = "Timer height: ",
            timerOffset = "Timer offset: ",
            timerTestStarted = "Timer test started - ",
            timerStopped = "Timer stopped",
            noActiveTimer = "No active timer",
            testTimerStarted = "Test Timer Started",
            lobbyTimer = "Lobby timer: ",
            testTimerStopped = "Test Timer Stopped",
            lobbyTimerStopped = "Lobby timer stopped",
            hostagesThreatened = " threatened ",
            timeTimes = " time(s)",
            threatsReset = "Threats Reset",
            allCountersReset = "All hostage counters reset",
            hogtiedTest = "Hogtied Test",
            hogtied = " hogtied: ",
            navmeshFleeTest = "NAVMESH Flee Test",
            shouldRunNavmesh = " should RUN AWAY using navmesh!",
            isolatedFleeTest = "ISOLATED Flee Test",
            shouldRunNoInterference = " should RUN with NO interference!",
            yourFunctionTest = "YOUR Function Test",
            usingYourFunction = " using YOUR makePedFlee function!",
            pureFleeTest = "Pure Flee Test",
            shouldRunNoAnimations = " should RUN now (no animations blocking)!",
            cleanFleeTest = "Clean Flee Test",
            fleeingWithoutCombat = " fleeing WITHOUT combat!",
            attackFleeTest = "Attack→Flee Test",
            dontAimToSee = "DON'T aim to see the full sequence: Attack → Stop → Flee",
            testStarted = "Test Started",
            aimToStop = "Aim at ",
            toStopEscape = " to stop the escape!",
            testNotifications = "Test Notifications",
            debugInfo = "Debug info - check console",
            hostageMovementDebug = "Hostage movement debug - check console",
            movementSystemStopped = "Movement system with hostage was stopped",
            sistemaInativo = "System Inactive",
            movementSystemNotRunning = "Movement system not running",
            animacaoTestada = "Animation Tested",
            appliedAnimation = "Applied animation: ",
            animationNotFound = "Animation not found: ",
            jogadorDesfreezeado = "Player Unfrozen",
            playerUnfrozen = "You were manually unfrozen",
            statusOK = "Status OK",
            playerNotFrozen = "Player is not frozen",
            animacoesLimpas = "Animations Cleaned",
            playerAnimationsRemoved = "All player animations were removed",
            promptsDesativados = "Prompts Deactivated",
            promptSystemDeactivated = "Prompt system was deactivated",
            promptsAtivados = "Prompts Activated",
            promptSystemActivated = "Prompt system was activated",
            promptDebug = "Prompt debug - check console",
            testDetection = "Test detection - check console",
            teste = "Teste",
            hostageDeadSystemClean = "Hostage dead - system should clean automatically",
            diagonalPositionsTested = "Diagonal positions tested",
            hostageControlRequested = "Request control sent to all hostages",
            controleeSolicitado = "Control Requested",
            hostagesDied = " died! -",
            hostagesFled = " fled! -",
            debugTimerFlash = "Debug Timer Flash",
            checkConsoleDetails = "Check console for details",
            timerDebug = "Timer Debug",
            checkBothTimerStates = "Check console for both timer states",
            forceTimeDecrease = "Force Time Decrease",
            decreasedBy = "Decreased by ",
            hostageFunctionsReset = "Hostage Functions Reset",
            allControlVariablesReset = "All control variables reseted",
            registeredHostages = "Registered Hostages",
            hostagesRegisteredCheck = " hostages registrados - check console",
            thisHostageIsDead = "This hostage is dead",
            thisHostageCaptured = "This hostage is captured and cannot be threatened", 
            thisHostageFleeing = "This hostage is fleeing and cannot be threatened",
            controlDebug = "Control debug - check console",
            capturePrompt = "Capture Hostage",
            releasePrompt = "Release Hostage"

        },
        
        -- Client Notes Messages
        notes = {
            notaColetada = "Note Collected",
            collectedImportantNote = "You collected an important note!",
            sistemaDeNotas = "Notes system",
            notesSystemActivated = "Notes system activated!",
            notesSystemDeactivated = "Notes system deactivated!",
            notesRespawned = "Notes respawned!",
            systemActivatedValentine = "System activated in Valentine!",
            systemActivatedSaintDenis = "System activated in Saint Denis!",
            systemActivatedRhodes = "System activated in Rhodes!",
            usedNotesReset = "Used notes reseted!",
            infoNotas = "Info Notes",
            available = "Available: ",
            testeAnimacao = "Test Animation",
            alreadyCollecting = "You are already collecting a note!",
            animationTestCompleted = "Test animation completed!",
            allNotesCleared = "All notes were cleared!",
            testNotesReset = "Test Notes Reset",
            notesResetTested = "Reset notes tested - check console",
            testeSincronizacao = "Test synchronization",
            notesSyncRequested = "Notes synchronized requested for "
        },
        
        -- Client Hostages Messages  
        hostageSystem = {
            sistemaDeHostages = "Hostage system",
            systemActive = "System ",
            workers = " active (",
            workersCount = " workers)",
            sistemaPaado = "System Stopped",
            systemDeactivated = " deactivated",
            interacaoNegada = "Interaction Denied",
            outfitAplicado = "Outfit Applied",
            outfitApplied = "Outfit ",
            appliedTo = " applied to ",
            hostagesReset = "Hostages Reset",
            hostageSystemsReset = " hostages systems reseted",
            testeDeLimpeza = "Test cleaning",
            globalCleanupRequested = "Global cleanup requested via server"
        },
        
        -- Client Rounds Messages
        rounds = {
            detected = "Detected!",
            guardTouched = "Guard ",
            wasTouched = " was touched!",
            warning = "WARNING!",
            attention = "ATTENTION!",
            restrictedArea = "Restricted Area",
            roundCleared = "Round Cleaned",
            allGuardsEliminated = "All guards eliminated!",
            bankSelected = "Selected bank",
            approachBank = "Approach the ",
            toStart = " to start (",
            robberyStarted = "Robbery Started",
            arrivedAt = "Arrived at ",
            startingAssault = " - starting assault!",
            roundStarted = "Round Started",
            activated = " activated",
            roundStopped = "Round Stopped",
            deactivated = " deactivated",
            systemNeutralized = "System Neutralized",
            toxicGasDisabled = "Toxic gas disabled for ",
            statusRounds = "Status Rounds",
            rounds = " rounds, ",
            guards = " guards",
            warningsCleared = "Warnings Limpos",
            warningCacheReset = "Warning cache reset",
            testWeapon = "Test Weapon",
            armed = "Armed: ",
            yes = "YES",
            no = "NO",
            continuousGas = "CONTINUOUS GAS!",
            explosion = "Explosion #",
            gasNeutralized = "Gas Neutralized",
            toxicGasSystemDeactivated = "Toxic gas system has been deactivated",
            criticalAlert = "CRITICAL ALERT!",
            explosionText = "EXPLOSION!",
            toxicGasReleased = "Toxic gas released in ",
            roundCleaned = "Round Cleaned",
            roundCleanedByServer = "Ronda ",
            wasCleanedByServer = " was cleaned by server",
            globalCleanup = "Global Cleanup",
            pedsRemoved = " peds removed",
            roundsCleanup = "Rounds Cleanup",
            guardsRemoved = " guards removed",
            bruteForceTotalTitle = "Brute Force Total",
            pedsDeleted = " peds deleted",
            testStarted = "Test Started",
            timerFor = "Timer for ",
            forLocation = "s for ",
            testExplosion = "TEST EXPLOSION!",
            testFailed = "Test Failed",
            explosiveGasNotEnabled = "Explosive gas not enabled for ",
            roundNotFound = "Round ",
            notFound = " not found",
            timerExpiredTest = "Timer Expired Test",
            simulatingTimerExpiration = "Simulating timer expiration",
            roundsStateDebug = "Rounds State Debug",
            checkConsoleDetails = "Check console for details",
            testRoundStarted = "Test Round Started",
            roundWithHostages = "Round: ",
            withHostagesSystem = " with hostages system",
            testGasDisable = "Test Gas Disable",
            gasDisabledFor = "Gas disabled for ",
            bankReset = "Banco Resetado",
            bankStateReset = "Bank state was completely reseted",
            resetIn30s = "Reset em 30s",
            timerEndedAllLeft = "Timer ended - all left the area",
            autoResetDebug = "Auto Reset Debug",
            monitoring = "Monitoring: ",
            timer = " | Timer: ",
            gas = " | Gas: ",
            gasStateForced = "Gas State Forced",
            gasFinished = "Gas finished: ",
            autoResetForced = "Auto Reset Forced",
            monitoringStarted = "Monitoring started for ",
            timerForced = "Timer Forced",
            timerFinishedDistanceActive = "Timer marked as finished - distance monitoring active",
            forceGasFinished = "Force Gas Finished",
            gasMarkedFinished = "Gas marked as finished",
            proximityCancelled = "Proximity Cancelled",
            proximitySystemDeactivated = "Proximity system deactivated"
        },
        
        -- Client Torch Messages
        torch = {
            torchTitle = "Torch",
            torchEquippedSpark = "Torch equipped with electric spark!",
            torchRemoved = "Torch removed!",
            torchEquippedCutting = "Torch equipped for cutting!",
            workCompleted = "Work completed - torch removed!",
            phaseCompleted = "Phase ",
            completedStartingNext = " completed! Starting next ",
            phase = " phase...",
            allHingesCut = "All hinges cut! ",
            isNowOpen = " is now open!"
        },
        
        -- Client Torch Tool Messages
        torchTool = {
            torchToolTitle = "Torch Tool",
            notNearCompatibleDoor = "You are not near any compatible door",
            noDoorConfigFound = "No door configuration found for this area",
            doorConfigNotFound = "Error: Door configuration not found",
            startingCutOn = "Starting cut on: ",
            minigameConfigError = "Error in minigame configuration",
            needCloserToDoor = "You need to be closer to a door (maximum 3m)",
            kickingDoor = "Kicking door: ",
            doorOpenedSuccess = "Door opened successfully: ",
            doorOpened = "Door opened: "
        },
        
        -- Client Timer Robbery Messages
        timerRobbery = {
            robberyStarted = "Robbery Started",
            timer = "Timer: ",
            robberyCompleted = "Robbery Completed",
            time = "Timer: ",
            robberyCancelled = "Robbery Cancelled",
            timeRemaining = "Time remaining: ",
            timeExpired = "Time Expired",
            robberyFailedTime = "Robbery failed by time!",
            timerSynchronized = "Timer Synchronized",
            robberyStartedTimer = "Robbery started: ",
            robberyCompletedExclamation = "Robbery completed!",
            robberyCancelledExclamation = "Robbery cancelled!",
            timeAdded = "Time Added",
            timePenalty = "Time Penalty",
            adding = "Adding",
            subtracting = "Subtracting",
            testFailed = "Test Failed",
            needActiveLobby = "You need to be in an active lobby",
            syncTest = "Synchronization Test",
            timerSyncedWithLobby = "Timer synchronized with lobby: ",
            timerInactive = "Timer Inactive",
            timerTest = "Timer Test",
            decreasedBy = "Decreased by ",
            seconds = " seconds",
            timerNotActive = "Timer is not active",
            added = "Added ",
            couldNotAddTime = "Could not add time to timer",
            timerReset = "Timer Reset",
            timerSystemReset = "Timer system reset",
            timerMoved = "Timer moved: "
        },
        
        -- Client Vaults Messages
        vaults = {
            cofreInterrompido = "Vault Interrupted",
            vaultInterruptedByGas = "Vault interrupted by toxic gas!",
            erroCofre = "Error Vault",
            couldNotControlVault = "Could not control vault!",
            acessoNegado = "Access Denied",
            needLobbyForVaults = "You need to be in a lobby to use vaults",
            sistemaIndisponivel = "System Unavailable",
            lobbySystemNotActive = "Lobby system is not active",
            cofresInativos = "Cofres Inativos",
            noActiveRoundVaults = "No active round with vault system",
            cofre = "Vault",
            solvingCombination = "Solving combination...",
            combinacaoNecessaria = "Combination Necessary",
            needNoteWithCombination = "You need to find the note with the combination of this vault!",
            cofreAberto = "Vault Opened",
            itemsCollectedFromVault = "Items collected from vault!",
            falhaNoCofre = "Failure in Vault",
            couldNotOpenVault = "Could not open vault!",
            cofreBloqueado = "Vault Locked",
            roundNotActive = "Round is not active!",
            cofresResetados = "Vaults Reset",
            vaultsClosed = " vaults closed!",
            resetCofres = "Reset Vaults",
            noVaultWasOpen = "No vault was open",
            sistemaDeCofres = "Vault System",
            systemActivatedFor = "System activated for ",
            systemDeactivated = "System deactivated!",
            fechamentoForcado = "Forced Closing",
            posicaoResetada = "Position Reset",
            vaultsInClosedPosition = " vaults in closed position!",
            cofresValentine = "Vaults Valentine",
            systemActivated = "System activated!",
            cofresSaintDenis = "Vaults Saint Denis",
            cofresRhodes = "Vaults Rhodes",
            buscaCofres = "Search Vaults",
            foundNearbyVaults = "Found ",
            nearbyVaults = " vaults nearby",
            testeCofre = "Test Vault",
            vaultFound = " found!",
            vaultNotFound = " NOT found!",
            coordsAtualizadas = "Coords Updated",
            vaultCoordsInConsole = "Coordinates of ",
            vaultsInConsole = " vaults in console!",
            testeAnimacao = "Test Animation",
            animationTestedFor = "Animation tested for ",
            processoCancelado = "Process Canceled",
            vaultOpeningCancelled = "Vault opening canceled!",
            nadaParaCancelar = "Nothing to Cancel",
            noVaultInProcess = "No vault in process!",
            debug = "Debug",
            successEventTriggered = "Success event triggered!",
            failEventTriggered = "Failure event triggered!",
            camera = "Camera",
            cameraDeactivated = "Camera deactivated!",
            cameraActivatedShoulder = "Camera activated on shoulder!",
            erro = "Error",
            noNearbyVault = "No vault nearby!",
            cofresAtivados = "Vaults Activated",
            vaultSystemSyncedLobby = "Vault system synced with lobby",
            cofresDesativados = "Vaults Deactivated",
            vaultSystemDeactivatedLobby = "Vault system deactivated by lobby",
            cofresReset = "Vaults Reset",
            vaultSystemsReset = " vault systems reseted"
        },
        
        -- Server Messages (for TriggerClientEvent notifications)
        server = {
            -- Server Door Locks
            usoIncorreto = "Use Incorreto",
            useBankdoor = "Use: /bankdoor [1-5]",
            idInvalido = "Invalid ID",
            doorIdBetween = "ID of the door must be between 1 and ",
            portaAlterada = "Door Changed",
            doorWas = "Door ",
            was = " was ",
            locked = "locked",
            unlocked = "opened",
            portasTrancadas = "Doors Locked",
            allBankDoorsLocked = "All bank doors were locked",
            portasAbertas = "Portas Abertas",
            allBankDoorsOpened = "All bank doors were opened",
            erro = "Erro",
            doorSystemNotInitialized = "Door system not initialized",
            bankDoorStatus = "Status das portas do banco:",
            resetCompleto = "Reset Completo",
            doorsResetByServer = " doors reseted by server",
            bancoResetado = "Bank Reseted",
            doorsWereReset = " doors were reseted",
            resetServidor = "Reset Servidor",
            doorsResetServer = " doors reseted by server",
            testeGlobal = "Teste Global",
            globalDoorResetTested = "Reset global of doors tested",
            
            -- Server Usable Items
            bankNote = "Bank Note",
            examinedBankNote = "You examined a bank note",
            createBankNote = "Use: /createbanknote [note_id] [quantidade]",
            invalidNoteId = "Invalid note ID: ",
            notaCriada = "Note Created",
            addedToInventory = " added to inventory",
            torchTool = "Torch Tool",
            torchToolAdded = "Torch tool added to inventory",
            invalidNoteType = "Invalid note type!",
            notaColetada = "Note Collected",
            youCollected = "You collected: ",
            dynamite = "Dynamite",
            dynamiteAdded = "Dynamite added to inventory",
            cofreAberto = "Vault Opened",
            rewards = "Rewards: ",
            cofreVazio = "Vault Empty",
            vaultWasEmpty = "This vault was empty!",
            mascaraDeGas = "Gas Mask",
            gasMaskAdded = "Gas mask added to inventory",
            
            -- Server Vaults
            vaultsStatus = "Vaults Status",
            vaultsOpened = " vaults opened",
            vaultsReset = "Vaults Reset",
            roundReset = "Round ",
            resetText = " reseted",
            vaultsCleared = "Vaults Cleared",
            systemCompletelyReset = "System completely reseted",
            notInValidLobby = "You are not in a valid lobby",
            cofreJaAberto = "Vault Already Opened",
            vaultAlreadyOpenedByLobby = "This vault was already opened by someone from your lobby",
            
            -- Server Main
            combinacaoDescoberta = "Combination Discovered",
            vault = "Vault ",
            hostagesLimpos = "Hostages Cleaned",
            hostagesRemovedGlobally = "Hostages removed globally"
        }
    }
}

-- Função helper para buscar textos da linguagem atual
function GetLanguageText(category, key)
    local currentLang = Config.Languages.currentLanguage
    local langData = Config.Languages[currentLang]
    
    if not langData then
        print("^1[LANGUAGE ERROR] Linguagem não encontrada: " .. currentLang)
        return "MISSING_LANGUAGE"
    end
    
    if not langData[category] then
        print("^1[LANGUAGE ERROR] Categoria não encontrada: " .. category)
        return "MISSING_CATEGORY"
    end
    
    if not langData[category][key] then
        print("^1[LANGUAGE ERROR] Chave não encontrada: " .. category .. "." .. key)
        return "MISSING_KEY"
    end
    
    return langData[category][key]
end

-------------------------------------------------------
---- Police notifications configuration ----
-------------------------------------------------------

Config.PoliceNotifications = {
    enabled = true,
    
    -- Jobs who receive notifications (add the police jobs from your server)
    policeJobs = {
        "police",
        "sheriff",
        "marshal",
        "lawman",
        "deputy"
    },
    
    -- Marking configuration on the map
    mapBlip = {
        enabled = true,
        duration = 300000, -- 5 minutes in ms (300000ms = 5min)
        sprite = "blip_ambient_law", -- sprite Blip
        overlaySprite = "blip_overlay_ring", -- overlay Blip
        scale = 0.8,
        overlayScale = 2.0,
        modifier = "BLIP_MODIFIER_AREA_PULSE", -- Pulsating effect
        color = "COLOR_RED" -- Emergency Red Color
    },
    
    -- GPS route configuration
    gpsRoute = {
        enabled = true,
        color = "COLOR_RED", -- GPS route color
        autoRemove = true -- Remove GPS when blip expires
    },
    
    -- Mensagens de notificação
    messages = {
        title = "Bank Robbery",
        description = "Bank being robbed in ",
        mapBlipName = "Robbery in progress"
    }
}