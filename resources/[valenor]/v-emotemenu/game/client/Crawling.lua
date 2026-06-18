
if Config.Crawling then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(100)
            if IsControlPressed(0, Config.KeyBinds["CRAWLING"]) and IsControlPressed(0, Config.KeyBinds["LEFT_CONTROL"]) then
                RequestAnimDict("mech_crawl@base")
                local dictAttempts = 0
                while not HasAnimDictLoaded("mech_crawl@base") and dictAttempts < 100 do
                    Citizen.Wait(10)
                    dictAttempts = dictAttempts + 1
                end

                if HasAnimDictLoaded("mech_crawl@base") then
                    while true do
                        local ped = PlayerPedId()

                        if IsControlJustPressed(0, Config.KeyBinds["CRAWLING"]) and not IsControlPressed(0, Config.KeyBinds["LEFT_CONTROL"]) then
                            break
                        end

                        if IsControlPressed(0, Config.KeyBinds["W"]) then
                            if IsEntityPlayingAnim(ped, "mech_crawl@base", "idle", 3) and
                                not IsEntityPlayingAnim(ped, "mech_crawl@base", "walk_turn_r4", 3) and
                                not IsEntityPlayingAnim(ped, "mech_crawl@base", "walk_turn_l4", 3) then
                                TaskPlayAnim(ped, "mech_crawl@base", "walk", 1.0, 1.0, -1, 1, 0, false, false, false, '', false)
                            end
                        end

                        if IsControlPressed(0, Config.KeyBinds["A"]) then
                            if (IsEntityPlayingAnim(ped, "mech_crawl@base", "idle", 3) or
                                IsEntityPlayingAnim(ped, "mech_crawl@base", "walk", 3)) and
                                not IsEntityPlayingAnim(ped, "mech_crawl@base", "walk_turn_r4", 3) then
                                TaskPlayAnim(ped, "mech_crawl@base", "walk_turn_l4", 1.0, 1.0, 1500, 0, 0, false, false, false, '', false)
                            end
                        end

                        if IsControlPressed(0, Config.KeyBinds["D"]) then
                            if (IsEntityPlayingAnim(ped, "mech_crawl@base", "idle", 3) or
                                IsEntityPlayingAnim(ped, "mech_crawl@base", "walk", 3)) and
                                not IsEntityPlayingAnim(ped, "mech_crawl@base", "walk_turn_l4", 3) then
                                TaskPlayAnim(ped, "mech_crawl@base", "walk_turn_r4", 1.0, 1.0, 1500, 0, 0, false, false, false, '', false)
                            end
                        end

                        if IsControlPressed(0, Config.KeyBinds["S"]) then
                            if IsEntityPlayingAnim(ped, "mech_crawl@base", "idle", 3) then
                                TaskPlayAnim(ped, "mech_crawl@base", "onfront_bwd", 1.0, 1.0, -1, 1, 0, false, false, false, '', false)
                            end
                        end

                        if (not IsControlPressed(0, Config.KeyBinds["S"]) and not IsControlPressed(0, Config.KeyBinds["D"]) and
                            not IsControlPressed(0, Config.KeyBinds["A"]) and not IsControlPressed(0, Config.KeyBinds["W"])) or
                            (not IsEntityPlayingAnim(ped, "mech_crawl@base", "idle", 3) and
                            not IsEntityPlayingAnim(ped, "mech_crawl@base", "walk", 3) and
                            not IsEntityPlayingAnim(ped, "mech_crawl@base", "walk_turn_r4", 3) and
                            not IsEntityPlayingAnim(ped, "mech_crawl@base", "walk_turn_l4", 3) and
                            not IsEntityPlayingAnim(ped, "mech_crawl@base", "onfront_bwd", 3)) then
                            if not IsEntityPlayingAnim(ped, "mech_crawl@base", "idle", 3) then
                                TaskPlayAnim(ped, "mech_crawl@base", "idle", 1.0, 1.0, -1, 1, 0, false, false, false, '', false)
                            end
                        end

                        Citizen.Wait(1)
                    end

                    ClearPedTasks(PlayerPedId())
                    RemoveAnimDict("mech_crawl@base")
                end
            end
        end
    end)
end
