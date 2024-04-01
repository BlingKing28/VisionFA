local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local list = {
    north = {
        { start = vec4(2703.8308105469, 3453.1413574219, 54.704235076904, 169.90058898926), finish = vec3(-121.25982666016, 6481.7548828125, 30.413507461548) },
        { start = vec4(1202.5378417969, 2725.7817382813, 37.00415802002, 241.12022399902), finish = vec3(-123.36944580078, 6479.7827148438, 30.465406417847) },
        { start = vec4(181.35961914063, 6632.6352539063, 30.572723388672, 177.89540100098), finish = vec3(1210.2327880859, 2721.9318847656, 37.00505065918) }
    },
    south = {
        { start = vec4(-454.91506958008, -2799.6799316406, 4.6070213317871, 45.071636199951), finish = vec3(-2942.8996582031, 477.61706542969, 13.85596370697) },
        { start = vec4(-611.90478515625, -1029.9036865234, 20.787540435791, 95.631134033203), finish = vec3(257.25289916992, 277.60943603516, 104.61624145508) },
        { start = vec4(976.61071777344, 7.822597026825, 80.041000366211, 146.50180053711), finish = vec3(163.34762573242, -3041.7004394531, 4.9346089363098) },
        { start = vec4(-377.68240356445, -1876.3901367188, 19.527839660645, 10.261813163757), finish = vec3(254.5302734375, 278.74893188477, 104.5799331665) },
        { start = vec4(256.15197753906, 278.44445800781, 104.59992980957, 71.661918640137), finish = vec3(-1002.194152832, -2413.8823242188, 12.944536209106) }
    }
}

function startHackingBrinks()
    local plyPed = PlayerPedId()
    local plyPos = GetEntityCoords(plyPed)
    local animDict = "anim@heists@ornate_bank@hack"
    local props = "hei_prop_hst_laptop"

    RequestAnimDict(animDict)
    RequestModel(props)

    while not HasAnimDictLoaded(animDict) or not HasModelLoaded(props) do
        Citizen.Wait(10)
    end

    local targetPosition, targetRotation = vec3(plyPos.x, plyPos.y, plyPos.z+0.8), GetEntityRotation(plyPed)
    
    local animPos = GetAnimInitialOffsetPosition(animDict, "hack_loop", targetPosition, targetRotation, 0, 2)
    
    FreezeEntityPosition(plyPed, true)

    local laptop = CreateObject(GetHashKey(props), targetPosition, 1, 1, 0)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
    
    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(plyPed, netScene, animDict, "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_loop_laptop", 4.0, -8.0, 1)

    NetworkStartSynchronisedScene(netScene)
    Citizen.Wait(5000)
    
    TriggerEvent("datacrack:start", 4.5, function(output)
        if output == true then
            startBrinksTracking()
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous n'avez pas réussie a pirater le terminal"
            })
        end
        setUsingComputer(false)
        Citizen.Wait(7500)
        NetworkStopSynchronisedScene(netScene)
        FreezeEntityPosition(plyPed, false)
    end)
end

function startBrinksTracking()
    TriggerServerEvent("TREFSDFD5156FD", "ADSFDF", 5000)
    TriggerServerEvent("TREFSDFD5156FD", "AESDAZDS", 5000)
    TriggerServerEvent("TREFSDFD5156FD", "VZEFDSF", 5000)
    Citizen.CreateThread(function()
        exports['vNotif']:createNotification({
            type = 'JAUNE',
            content = "Début de la transmition de la position du transport brinks"
        })

        local route = nil
        local plyPed = PlayerPedId()
        local plyPos = GetEntityCoords(plyPed)
        local isInSouth = coordsIsInSouth(plyPos)
        if isInSouth then
            route = list.south[math.random(1, #list.south)]
        else
            route = list.north[math.random(1, #list.north)]
        end
        
        local ped = entity:CreatePed("mp_s_m_armoured_01", route.start).id
        local ped2 = entity:CreatePed("mp_s_m_armoured_01", route.start).id
        AddRelationshipGroup("brinks")
        SetPedCombatAttributes(ped, 0, true) 
        SetPedCombatAttributes(ped, 5, true) 
        SetPedCombatAttributes(ped, 46, true)
        SetPedFleeAttributes(ped, 0, true)
        SetPedRelationshipGroupHash(ped, GetHashKey("brinks"))
        GiveWeaponToPed(ped, GetHashKey("weapon_smg"), 255, false, true)
        SetPedCombatAttributes(ped2, 0, true) 
        SetPedCombatAttributes(ped2, 5, true) 
        SetPedCombatAttributes(ped2, 46, true)
        SetPedFleeAttributes(ped2, 0, true)
        SetPedRelationshipGroupHash(ped2, GetHashKey("brinks"))
        GiveWeaponToPed(ped2, GetHashKey("weapon_smg"), 255, false, true)

        SetRelationshipBetweenGroups(4, GetHashKey("brinks"), GetHashKey("PLAYER")) 
        local vehicle = Modules.World.CreateVehicle("stockade", route.start, true)
        SetPedIntoVehicle(ped, vehicle, -1)
        SetPedIntoVehicle(ped2, vehicle, 0)

        SetDriverAbility(ped, 1.0)
        SetDriverAggressiveness(ped, 0.0)
        TaskVehicleDriveToCoordLongrange(ped, vehicle, route.finish, 50.0, 427, 5.0);
        
        local count = 100
        local alphaBlip = 255
        local alphaZone = 180

        local blip = AddBlipForCoord(GetEntityCoords(vehicle))
        SetBlipSprite(blip, 477)
        SetBlipScale(blip, 0.75)
        SetBlipColour(blip, 1)
        SetBlipAsShortRange(blip, false)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName("Camion BRINKS")
        EndTextCommandSetBlipName(blip)

        local zone = AddBlipForRadius(GetEntityCoords(vehicle), 100.0)
        SetBlipColour(zone, 1)
        SetBlipAlpha(zone, alphaZone)

        TriggerServerEvent("brinksSendStart", NetworkGetNetworkIdFromEntity(vehicle))

        while true do
            if count == 0 then
                SetBlipCoords(blip, GetEntityCoords(vehicle))
                SetBlipCoords(zone, GetEntityCoords(vehicle))
                count = 100
                alphaBlip = 255
                alphaZone = 180
            end
            if #(GetEntityCoords(vehicle) - route.finish) < 10.0 then
                DeleteEntity(ped)
                DeleteEntity(ped2)
                DeleteEntity(vehicle)
                break
            end 
            alphaBlip = alphaBlip - 2
            alphaZone = alphaZone - 1
            if alphaZone < 20 then
                alphaZone = 20
            end
            SetBlipAlpha(blip, alphaBlip)
            SetBlipAlpha(zone, alphaZone)
            count = count - 1
            Wait(100)
            if (not IsPedInAnyVehicle(ped, false)) or IsEntityDead(ped) then
                local isInSouth = coordsIsInSouth(GetEntityCoords(vehicle))
                if isInSouth then
                    TriggerServerEvent('core:makeCall', "lspd",
                        GetEntityCoords(vehicle), true,
                        "Appel de renfort d'un convoi brink", false, "illegal")
                else
                    TriggerServerEvent('core:makeCall', "lssd",
                        GetEntityCoords(vehicle), true,
                        "Appel de renfort d'un convoi brinks", false, "illegal")
                end
                Wait(5000)
                RemoveBlip(blip)
                RemoveBlip(zone)
                break
            end
        end
    end)
end

local brinksVeh = nil
RegisterNetEvent("brinksStartAttack", function(netBrinks)
    brinksVeh = NetworkGetEntityFromNetworkId(netBrinks)

    while brinksVeh ~= nil do
        local time = 600
        local pos = p:pos()
        local dst = #(pos - GetWorldPositionOfEntityBone(brinksVeh, GetEntityBoneIndexByName(brinksVeh, "door_dside_r")))
    
        if dst <= 5.0 then
            time = 0
        end
        if dst <= 1.5 then
            ShowHelpNotification("Appuyer sur ~INPUT_CONTEXT~ pour faire meuler le coffre", true)

            if IsControlJustPressed(1, 51) then
                local haveMeuleuse = false
                for _, value in pairs(p:getInventaire()) do
                    if value.name == "meuleuse" then
                        haveMeuleuse = true
                        break
                    end
                end

                if not haveMeuleuse then
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        content = "Vous n'avez pas de meuleuse"
                    })
                else
                    FreezeEntityPosition(brinksVeh, true)
                    local ped = PlayerPedId()
                    local pedCo = GetEntityCoords(ped)
                    
                    local pos = GetOffsetFromEntityInWorldCoords(brinksVeh, 0, -1.5, 0.25)
                    local trolly = CreateObject(LoadModel("hei_prop_hei_cash_trolly_01"), pos, 0, 0, 0)
                    SetEntityHeading(trolly, GetEntityHeading(brinksVeh)-180)

                    local grinder = CreateObject(LoadModel("tr_prop_tr_grinder_01a"), pedCo, 1, 1, 0)
                    local bag = CreateObject(LoadModel("ch_p_m_bag_var02_arm_s"), pedCo, 1, 1, 0)
                    local animDict = 'anim@scripted@player@mission@tunf_train_ig1_container_p1@male@'

                    loadAnimDict(animDict)
                    loadPtfxAsset('scr_tn_tr')

                    local pos = GetOffsetFromEntityInWorldCoords(brinksVeh, 0, -1.65, 0)
                
                    local scene = NetworkCreateSynchronisedScene(vec3(pos.x, pos.y, GetEntityCoords(ped).z-1), GetEntityRotation(brinksVeh), 2, true, false, 1065353216, 0, 1065353216)

                    NetworkAddPedToSynchronisedScene(ped, scene, animDict, "action", 4.0, -4.0, 1033, 0, 1000.0, 0)
                    NetworkAddEntityToSynchronisedScene(sceneObject, scene, animDict, "action_container", 1.0, -1.0, 1148846080)
                    NetworkAddEntityToSynchronisedScene(lockObject, scene, animDict, "action_lock", 1.0, -1.0, 1148846080)
                    NetworkAddEntityToSynchronisedScene(grinder, scene, animDict, "action_angle_grinder", 1.0, -1.0, 1148846080)
                    NetworkAddEntityToSynchronisedScene(bag, scene, animDict, "action_bag", 1.0, -1.0, 1148846080)

                    SetEntityCoords(ped, GetEntityCoords(sceneObject))
                    NetworkStartSynchronisedScene(scene)
                    Wait(4000)
                    UseParticleFxAssetNextCall('scr_tn_tr')
                    local sparks = StartParticleFxLoopedOnEntity("scr_tn_tr_angle_grinder_sparks", grinder, 0.0, 0.25, 0.0, 0.0, 0.0, 0.0, 1.0, false, false, false, 1065353216, 1065353216, 1065353216, 1)
                    Wait(1000)
                    StopParticleFxLooped(sparks, 1)
                    Wait(GetAnimDuration(animDict, 'action') * 1000 - 7500)
                    SetVehicleDoorOpen(brinksVeh, 2, false, false)
                    SetVehicleDoorOpen(brinksVeh, 3, false, false)
                    Wait(2500)
                    DeleteEntity(grinder)
                    DeleteEntity(bag)
                    
                    moneyLoot(trolly, { min = 350, max = 650}, GetEntityCoords(ped))

                    collectgarbage("collect")
                    brinksVeh = nil
                end
            end
        end

        Wait(time)
    end
end)

RegisterNetEvent("brinksDoorOpen", function()
    brinksVeh = false
end)