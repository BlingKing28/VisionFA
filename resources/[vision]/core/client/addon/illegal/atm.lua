local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local inRobbery = false
function ATMRobbery(entity)
    local plyPed = PlayerPedId()
    local plyPos = GetEntityCoords(plyPed)
    local isPlayerAlrdyBraked = TriggerServerCallback("core:ATMAlreadyRob")

    local havePhone = false
    for _, value in pairs(p:getInventaire()) do
        if value.name == "phone" then
            havePhone = true
            break
        end
    end

    if havePhone then
        if (not isPlayerAlrdyBraked) and (p:getJob() ~= "lspd" and p:getJob() ~= "lssd") then
            local isInSouth = coordsIsInSouth(GetEntityCoords(entity))
            local policeMans = nil
            if isInSouth then
                policeMans = TriggerServerCallback("core:getNumberOfDuty", token,'lspd')
            else
                policeMans = TriggerServerCallback("core:getNumberOfDuty", token,'lssd')
            end
            
            if policeMans >= 4 then
                local robbed = TriggerServerCallback("core:EntityATMAlreadyRob", token, NetworkGetNetworkIdFromEntity(entity))

                if robbed then
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        content = "L'ATM semble hors service"
                    })
                else
                    if isInSouth then
                        TriggerServerEvent('core:makeCall', "lspd",
                            GetEntityCoords(entity), true,
                            "Braquage d'atm", false, "illegal")
                    else
                        TriggerServerEvent('core:makeCall', "lssd",
                            GetEntityCoords(entity), true,
                            "Braquage d'atm", false, "illegal")
                    end
                    TriggerServerEvent("core:BlackListATM", NetworkGetNetworkIdFromEntity(entity))
                    TaskStartScenarioAtPosition(plyPed, "WORLD_HUMAN_STAND_MOBILE", GetEntityCoords(plyPed), GetEntityHeading(plyPed), 0, 0, 5.0)
                    Wait(2500)
                    TriggerEvent("datacrack:start", 4, function(output)
                        if output == true then
                            Wait(2500)
                            ClearPedTasksImmediately(plyPed)

                            local heading = GetEntityHeading(atm)
                            RequestNamedPtfxAsset("scr_xs_celebration")
                            while not HasNamedPtfxAssetLoaded("scr_xs_celebration") do
                                Wait(10)
                            end
                            UseParticleFxAssetNextCall("scr_xs_celebration")
                            local pfx = StartParticleFxLoopedOnEntity("scr_xs_money_rain", entity, -0.1, -0.3, 0.75, -90.0, heading - 180.0, heading, 1.0, false, false, false)
                            exports['vNotif']:createNotification({
                                type = 'JAUNE',
                                content = "Vous avez réussie le piratage. Récuper l'argent."
                            })
                            RequestAnimDict('pickup_object')
                            while not HasAnimDictLoaded('pickup_object') do
                                Wait(10)
                            end
                            local count = 0
                            TriggerServerEvent("core:addCrewExp", p:getCrew(), 300, "ATM")

                            while count < 6 do
                                Wait(2500)
                                if #(GetEntityCoords(entity) - GetEntityCoords(plyPed)) >= 3.5 then
                                    break
                                end

                                count = count + 1
                                local money = math.random(300, 400)
                                TaskPlayAnim(plyPed, "pickup_object", "pickup_low", 2.0, 2.0, -1, 49, 2.0, 0, 0, 0)
                                Wait(500)
                                PlaySound(-1, 'ROBBERY_MONEY_TOTAL', 'HUD_FRONTEND_CUSTOM_SOUNDSET', 0, 0, 1)
                                TriggerSecurGiveEvent("core:addItemToInventory"
                                    , token, "money", money, {})
                                    TriggerServerEvent("core:setPlayerATMRobberyGood")
                                    exports['vNotif']:createNotification({
                                        type = 'DOLLAR',
                                        content = ("Vous avez récupéré ~s %s$"):format(money)
                                    })
                                    Wait(500)
                                    ClearPedTasks(plyPed)
                                end
                                RemoveAnimDict("pickup_object")
                                StopParticleFxLooped(pfx, 0)
                            if count >= 5 then
                                exports['vNotif']:createNotification({
                                    type = 'JAUNE',
                                    content = "L'ATM est vide"
                                })
                            else
                                exports['vNotif']:createNotification({
                                    type = 'ROUGE',
                                    content = "Tu es partie trops loin, la connexion à l'ATM a été perdue."
                                })
                            end
                        else
                            ClearPedTasksImmediately(plyPed)
                            exports['vNotif']:createNotification({
                                type = 'ROUGE',
                                content = "Vous n'avez pas réussie a pirater l'ATM"
                            })
                        end
                    end)
                end
            else
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    content = "Il n'y a pas assez de policier en ville"
                })
            end
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous ne pouvez pas braquer l'ATM"
            })
        end
    else
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            content = "Vous n'avez pas de téléphone"
        })
    end
end 
