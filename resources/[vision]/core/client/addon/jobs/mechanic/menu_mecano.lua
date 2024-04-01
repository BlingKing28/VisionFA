local open = false
local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

function deleteflat(entity)
    TriggerEvent('persistent-vehicles/forget-vehicle', entity)
    removeKeys(GetVehicleNumberPlateText(entity), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(entity))))
    TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(entity))
    DeleteEntity(entity)
    if DoesEntityExist(entity) then
        SetEntityAsMissionEntity(entity, true, true)
        TriggerEvent('persistent-vehicles/forget-vehicle', entity)
        removeKeys(GetVehicleNumberPlateText(entity), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(entity))))
        TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(entity))
        DeleteEntity(entity)
    end
    if DoesEntityExist(entity) then
        removeKeys(GetVehicleNumberPlateText(entity), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(entity))))
        TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(entity))
        DeleteObject(entity)
    end
end

function LoadMecanoJob()
    shopui = ""
    dictname = ""
    local garagePos = nil
    local MecanoDuty = false
    local posGestion
    local posCoffre
    local posService
    local posCasier
    local posFourriere
    local posPed
    local posSpawn
    local char = nil
    local textChar = ""
    local openRadial = false
    if p:getJob() == "bennys" then
        shopui = "vision"
        dictname = "menu_title_bennys"
        char = "CHAR_CARSITE3"
        textChar = "Benny's"
        posPed = vector4(-230.44616699219, -1318.3414306641, 30.300481796265, 269.8056640625)
        posGestion = vector3(-194.24476623535, -1314.9232177734, 31.300472259521)
        posCoffre = vector3(-192.50886535645, -1321.3864746094, 31.30047416687)
        garagePos = vector3(-206.45794677734, -1323.8568115234, 30.913496017456)
        posCasier = vector3(-194.97541809082, -1336.146484375, 31.300479888916)
        posFourriere = vector3(-174.61442565918, -1289.3253173828, 30.2961063385017)
        posSpawn = vector4(-181.17384338379, -1287.1469726563, 31.296106338501, 174.92324829102)
        mech_spawn = vector3(-178.6449432373, -1324.5291748047, 31.283283233643)
        mech_delete = vector3(-182.35163879395, -1325.2912597656, 31.233097076416)
        spawn4 = vector4(-180.94476318359, -1318.5400390625, 31.296543121338, 2.2975685596466)
        spawn3 = vector3(-180.94476318359, -1318.5400390625, 31.296543121338)
        livery_flat = 1
        livery_slam = 10
        livery_sadlerrt = 2
        imgName = "Bennys"
        header = "header_bennys.webp"
    elseif p:getJob() == "sunshine" then
        shopui = "vision"
        dictname = "sunshine"
        char = "SUNSHINE"
        textChar = "Sunshine Garage"
        posPed = vector4(915.9246, -2100.032, 29.4595, 125.9822)
        garagePos = vector3(892.6656, -2102.468, 33.8885)
        posCasier = vector3(882.9964, -2100.725, 29.4594)
        posCoffre = vector3(886.4254, -2097.374, 33.8886)
        posGestion = vector3(892.6656, -2102.468, 33.8885)
        posFourriere = vector3(866.9704, -2145.061, 29.5704)
        posSpawn = vector4(862.3558, -2137.480, 29.5148, 351.9650)
        mech_spawn = vector3(875.5851, -2100.379, 29.4796)
        mech_delete = vector3(862.0167, -2145.642, 30.4642)
        spawn4 = vector4(879.5482, -2109.020, 29.4594, 259.2134)
        spawn3 = vector3(879.5482, -2109.020, 29.4594)
        livery_flat = 2
        livery_slam = 11
        livery_sadlerrt = 1
        imgName = "SunshineGarage"
        header = "header_sunshine.webp"
    elseif p:getJob() == "hayes" then -- pos à mettre
        shopui = "vision"
        dictname = "hayes"
        char = "HAYES"
        textChar = "Hayes Auto"
        posPed = vector4(-1406.3979492188, -444.482421875, 34.909706115723, 121.60081481934)
        garagePos = vector3(-1421.4741210938, -446.16607666016, 34.909706115723)
        posCasier = vector3(-1424.841796875, -457.35000610352, 34.90970993042)
        posCoffre = vector3(-1429.2263183594, -457.81723022461, 34.90970993042)
        posGestion = vector3(-1427.5712890625, -459.77090454102, 34.90970993042)
        posFourriere = vector3(-1412.6877441406, -431.04446411133, 35.183479309082)
        posSpawn = vector4(-1415.9300537109, -432.15802001953, 35.030872344971, 123.54905700684)
        mech_spawn = vector3(-1411.6405029297, -436.75045776367, 34.90970993042)
        mech_delete = vector3(-1397.6047363281, -461.36920166016, 33.479774475098)
        spawn4 = vector4(-1416.0408935547, -430.83834838867, 35.032279968262, 30.937286376953)
        spawn3 = vector3(-1416.0408935547, -430.83834838867, 35.032279968262)
        livery_flat = 2
        livery_slam = 11
        livery_sadlerrt = 1
        imgName = "hayes"
        header = "header_hayes.webp"
    elseif p:getJob() == "beekers" then -- pos à mettre
        shopui = "vision"
        dictname = "beekers"
        char = "BEEKERS"
        textChar = "Beekers Garage"
        posPed = vector4(115.36325836182, 6625.7685546875, 30.787309646606, 135.15690612793)
        garagePos = vector3(111.20211029053, 6621.3359375, 30.787294387817)
        posCasier = vector3(103.02476501465, 6625.6391601563, 30.787311553955)
        posCoffre = vector3(98.783226013184, 6621.2602539063, 31.435417175293)
        posGestion = vector3(99.890640258789, 6620.162109375, 31.435417175293)
        posFourriere = vector3(107.73583221436, 6614.2895507813, 31.007011413574)
        posSpawn = vector4(109.69146728516, 6606.3100585938, 30.859384536743, 312.70989990234)
        mech_spawn = vector3(119.10305786133, 6640.1860351563, 30.867761611938)
        mech_delete = vector3(116.0295715332, 6650.2998046875, 30.554176330566)
        spawn4 = vector4(111.95973968506, 6646.5571289063, 30.473178863525, 133.71981811523)
        spawn3 = vector3(111.95973968506, 6646.5571289063, 30.473178863525)
        livery_flat = 2
        livery_slam = 11
        livery_sadlerrt = 1
        imgName = "beekers"
        header = "header_beekers.webp"
    elseif p:getJob() == "harmony" then
        shopui = "vision"
        dictname = "harmony"
        char = "HARMONY"
        textChar = "Harmony Repair"
        posPed = vector4(1171.6137695313, 2637.1555175781, 36.7844581604, 286.00482177734)
        garagePos = vector3(1188.8212890625, 2640.4418945313, 37.401973724365)
        posCasier = vector3(1188.8212890625, 2640.4418945313, 37.401973724365)
        posCoffre = vector3(1184.1978759766, 2636.3305664063, 36.753852844238)
        posGestion = vector3(1187.3055419922, 2637.3344726563, 37.401977539063)
        posFourriere = vector3(1189.8201904297, 2651.1906738281, 36.835174560547)
        posSpawn = vector4(1171.8256835938, 2627.5773925781, 36.794910430908, 91.592864990234)
        mech_spawn = vector3(1171.1796875, 2633.1520996094, 36.809864044189)
        mech_delete = vector3(1165.8029785156, 2635.32421875, 37.791526794434)
        spawn4 = vector4(1165.8029785156, 2635.32421875, 36.791526794434, 359.63809204102)
        spawn3 = vector3(1165.8029785156, 2635.32421875, 36.791526794434)
        livery_flat = 3
        livery_slam = 12
        livery_sadlerrt = 3
        imgName = "Harmony"
        header = "header_harmonyrepair.webp"
    end

    zone.addZone(
        "casier_mecano" .. p:getJob(),
        posCasier,
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les casiers",
        function()
            OpenmecanoCasier() --TODO: fini le menu society
        end,
        false,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    local inChoice = false
    local selectedPlayer = nil

    local function StartChoiceFourriere(players)
        selectedPlayer = nil

        -- New notif
        exports['vNotif']:createNotification({
            type = 'VERT',
            duration = 10, -- In seconds, default:  4
            content = "Appuyer sur ~K E pour ~s valider"
        })

        exports['vNotif']:createNotification({
            type = 'JAUNE',
            duration = 10, -- In seconds, default:  4
            content = "Appuyer sur ~K L pour ~s changer de cible"
        })
            
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            duration = 10, -- In seconds, default:  4
            content = "Appuyez sur ~K X pour ~s annuler"
        })

        local timer = GetGameTimer() + 10000
        while inChoice do
            if next(players) then
                local mCoors = GetEntityCoords(GetPlayerPed(players[1]))
                DrawMarker(20, mCoors.x, mCoors.y, mCoors.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255
                    ,
                    255, 120, 0, 1, 2, 0, nil, nil, 0)
                if GetGameTimer() > timer then
                    -- ShowNotification("~r~Le délai est dépassé")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Le délai a été dépassé"
                    })

                    inChoice = false
                    return
                elseif IsControlJustPressed(0, 51) then -- E
                    selectedPlayer = players[1]
                    inChoice = false
                    return
                elseif IsControlJustPressed(0, 182) then -- L
                    table.remove(players, 1)
                    if next(players) then
                        timer = GetGameTimer() + 10000
                    end
                elseif IsControlJustPressed(0, 73) then -- X
                    -- ShowNotification("~r~Vous avez annulé")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'JAUNE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous avez ~s annulé"
                    })

                    selectedPlayer = nil
                    inChoice = false
                    return
                end
            else
                -- ShowNotification("~r~Il n'y a personne autour de vous")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Il n'y a personne autour de vous"
                })

                selectedPlayer = nil
                inChoice = false
                return
            end
            Wait(0)
        end
    end

    zone.addZone(
        "fourriere" .. p:getJob(),
        posFourriere,
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir la fourrière",
        function()
            local player = GetAllPlayersInArea(p:pos(), 3.0)
            for k, v in pairs(player) do
                if v == PlayerId() then
                    table.remove(player, k)
                end
            end
            if player ~= nil then
                if next(player) then
                    inChoice = true
                    StartChoiceFourriere(player)
                    if selectedPlayer ~= nil then
                        OpenMenuFourriere(posSpawn, GetPlayerServerId(selectedPlayer)) --TODO: fini le menu society
                    end
                else
                    -- ShowNotification("~r~Il n'y a personne autour de vous")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Il n'y a personne autour de vous"
                    })

                end
            else
                -- ShowNotification("~r~Il n'y a personne autour de vous")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Il n'y a personne autour de vous"
                })

            end
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )


    local casierOpen = false
    function OpenmecanoCasier()
        if not casierOpen then
            casierOpen = true

            CreateThread(function()
                while casierOpen do
                    Wait(0)
                    DisableControlAction(0, 1, casierOpen)
                    DisableControlAction(0, 2, casierOpen)
                    DisableControlAction(0, 142, casierOpen)
                    DisableControlAction(0, 18, casierOpen)
                    DisableControlAction(0, 322, casierOpen)
                    DisableControlAction(0, 106, casierOpen)
                    DisableControlAction(0, 24, true) -- disable attack
                    DisableControlAction(0, 25, true) -- disable aim
                    DisableControlAction(0, 263, true) -- disable melee
                    DisableControlAction(0, 264, true) -- disable melee
                    DisableControlAction(0, 257, true) -- disable melee
                    DisableControlAction(0, 140, true) -- disable melee
                    DisableControlAction(0, 141, true) -- disable melee
                    DisableControlAction(0, 142, true) -- disable melee
                    DisableControlAction(0, 143, true) -- disable melee
                end
            end)
            SetNuiFocusKeepInput(true)
            SetNuiFocus(true, true)
            Citizen.CreateThread(function()
                SendNUIMessage({
                    type = "openWebview",
                    name = "Casiers",
                    data = {
                        count = 60,
                    },
                })
            end)
        else
            casierOpen = false
            SetNuiFocusKeepInput(false)
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
            EnableControlAction(0, 142, true)
            EnableControlAction(0, 18, true)
            EnableControlAction(0, 322, true)
            EnableControlAction(0, 106, true)
            SetNuiFocus(false, false)
            SendNuiMessage(json.encode({
                type = 'closeWebview',
            }))
            return
        end
    end

    RegisterNUICallback("focusOut", function(data, cb)
        if casierOpen then
            casierOpen = false
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
            EnableControlAction(0, 142, true)
            EnableControlAction(0, 18, true)
            EnableControlAction(0, 322, true)
            EnableControlAction(0, 106, true)
            openRadarProperly()
        end
        cb({})
    end)

    RegisterNUICallback("casier__callback", function(data)
        local casier = TriggerServerCallback("core:GetAllCasierByJob", pJob)
        if casier == nil then
            TriggerServerEvent("core:CreateNewCasier", token, pJob, data.numero)
            casier = TriggerServerCallback("core:GetAllCasierByJob", pJob)
        end

        if casier ~= nil and casier[data.numero] == nil then
            TriggerServerEvent("core:CreateNewCasier", token, pJob, data.numero)
            casier = TriggerServerCallback("core:GetAllCasierByJob", pJob)
        end

        if casier ~= nil and casier[data.numero] ~= nil then
            OpenInventoryCasier(pJob, data.numero)
        end

    end)
    ---zone
    zone.addZone(
        "society_mecano",
        posGestion,
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les actions d'entreprise",
        function()
            OpenSocietyMenu() --TODO: fini le menu society
        end,
        false,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    zone.addZone(
        "coffre_mecano",
        posCoffre,
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le coffre de l'entreprise",
        function()
            OpenInventorySocietyMenu() --TODO: fini le menu society
        end,
        false,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    zone.addZone(
        "mech_delete",
        mech_delete,
        "Appuyer sur ~INPUT_CONTEXT~ pour ranger le véhicule",
        function()
            if IsPedInAnyVehicle(p:ped(), false) then
                if GetVehicleBodyHealth(p:currentVeh()) / 10 >= 80 or
                    GetVehicleEngineHealth(p:currentVeh()) / 10 >= 80 then
                    local veh = GetVehiclePedIsIn(p:ped(), false)
                    TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                    if p:getJob() == "bennys" then
                        removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                        TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                    elseif p:getJob() == "sunshine" then
                        removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                        TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                    elseif p:getJob() == "hayes" then
                        removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                        TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                    elseif p:getJob() == "beekers" then
                        removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                        TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                    end
                    DeleteEntity(veh)
                else
                    -- ShowNotification("~r~Votre véhicule est trop abimé")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Votre véhicule est trop abimé"
                    })

                end
            end

        end,
        true,
        36, 0.5, { 255, 0, 0 }, 255
    )

    zone.addZone(
        "mech_spawn",
        mech_spawn,
        "Appuyer sur ~INPUT_CONTEXT~ pour sortir le véhicule",
        function()
            if MecanoDuty then
                OpenMenuVehMecano() --TODO: fini le menu society
            else
                -- ShowNotification("~r~Vous n'êtes pas en service")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Vous n'êtes ~s pas en service"
                })

            end
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )


    local listVeh = {
        headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/'..header,
        headerIcon = 'assets/icons/voiture-icon.png',
        headerIconName = 'VEHICULES',
        callbackName = 'vehMenuMecano',
        elements = {
            {
                id = 1,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/'..imgName..'/flatbed3.webp',
                label = 'Flatbed',
                name = "flatbed3"
            },
            {
                id = 2,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/'..imgName..'/slamtruck.webp',
                label = 'Slamtruck',
                name = "slamtruck"
            },
            {
                id = 3,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/'..imgName..'/towtruck.webp',
                label = 'Tow Truck',
                name = "towtruck"
            },
            {
                id = 4,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/'..imgName..'/towtruck2.webp',
                label = 'Tow Truck Rouillé',
                name = "towtruck2"
            },
            {
                id = 5,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/'..imgName..'/sadlerrt.webp',
                label = 'Sadler RT',
                name = "sadlerrt"
            },
        }
    }
    function OpenMenuVehMecano()
        forceHideRadar()
            SendNuiMessage(json.encode({
                type = 'openWebview',
                name = 'MenuCatalogue',
                data = listVeh
            }))
    end

    function MechanicDuty()
        closeUI()
        openRadial = false
        if MecanoDuty then
            TriggerServerEvent('core:DutyOff', pJob)
            -- ShowNotification("Vous avez ~r~quitté~s~ votre service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s quitté ~c votre service"
            })

            MecanoDuty = false
            Wait(5000)
        else
            TriggerServerEvent('core:DutyOn', pJob)
            -- ShowNotification("Vous avez ~g~pris~s~ votre service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'VERT',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s pris ~c votre service"
            })

            MecanoDuty = true
            Wait(5000)
        end
    end

    function RepareVehMoteur()
        if MecanoDuty then
            openRadial = false
            closeUI()
            local closestVeh, closestDist = GetClosestVehicle(p:pos())
            if closestDist <= 5 then
                local GetEngine = GetVehicleEngineHealth(closestVeh)
                if #(p:pos() - GetWorldPositionOfEntityBone(closestVeh, GetEntityBoneIndexByName(closestVeh, "overheat"))
                    + vector3(0.0, 0.0, 1.0)) < 5.0 or GetEntityBoneIndexByName(closestVeh, "overheat") == -1 then
                    local time = 1000 - GetVehicleEngineHealth(closestVeh)
                    if GetVehicleEngineHealth(closestVeh) < 950.0 then
                        p:PlayAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "fixing_a_ped", 174)

                        TaskStartScenarioInPlace(p:ped(), 'PROP_HUMAN_BUM_BIN', -1, true)

                        SendNuiMessage(json.encode({
                            type = 'openWebview',
                            name = 'Progressbar',
                            data = {
                                text = "Réparation en cours...",
                                time = 10,
                            }
                        }))
                        Modules.UI.RealWait(10000)
                        --[[ ShowAdvancedNotification(textChar, "Information",
                            "Réparation terminée.", char, char) ]]

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Réparation ~s terminée."
                        })

                        ClearPedTasksImmediately(p:ped())
                        SetVehicleEngineHealth(closestVeh, 1000.0)
                    else
                        --[[ ShowAdvancedNotification(textChar, "Information",
                            "Le véhicule est en bon état.", char, char) ]]

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Le véhicule est en ~s bon état."
                        })

                    end
                end
            end
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function RepareCarosserie()
        if MecanoDuty then
            openRadial = false
            closeUI()
            if #(p:pos() - garagePos) <= 50 then
                local closestVeh, closestDist = GetClosestVehicle(p:pos())
                if closestDist <= 3 then
                    print(GetVehicleBodyHealth(closestVeh))
                    print(GetVehicleEngineHealth(closestVeh))
                    local GetEngine = GetVehicleEngineHealth(closestVeh)
                    local time = 1000 - GetVehicleBodyHealth(closestVeh)

                    RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
                    while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
                        Wait(1)
                    end
                    TaskPlayAnim(p:ped(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0,
                        -8.0, -1, 1, 0, false,
                        false, false)
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'Progressbar',
                        data = {
                            text = "Réparation en cours...",
                            time = 10,
                        }
                    }))
                    RemoveAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
                    Modules.UI.RealWait(10000)
                    --[[ ShowAdvancedNotification(textChar, "Information", "Réparation terminée."
                        , char, char) ]]

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'JAUNE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Réparation ~s terminée."
                    })

                    ClearPedTasksImmediately(p:ped())
                    SetVehicleBodyHealth(closestVeh, 1000.0)
                    SetVehicleFixed(closestVeh)
                    SetVehicleDeformationFixed(closestVeh)
                    SetVehicleEngineHealth(closestVeh, GetEngine)
                    SetVehicleUndriveable(closestVeh, false)
                end
            else
                -- ShowNotification("Vous devez être à proximité du garage.")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Vous devez être à proximité du garage."
                })

            end
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function CleanVeh()
        if MecanoDuty then
            openRadial = false
            closeUI()
            local closestVeh, closestDist = GetClosestVehicle(p:pos())
            if closestDist <= 3 then
                TaskStartScenarioInPlace(p:ped(), 'WORLD_HUMAN_MAID_CLEAN', -1, true)
                SendNuiMessage(json.encode({
                    type = 'openWebview',
                    name = 'Progressbar',
                    data = {
                        text = "Nettoyage en cours...",
                        time = 8,
                    }
                }))
                Modules.UI.RealWait(8000)

                SetVehicleDirtLevel(closestVeh, 0)
                ClearPedTasksImmediately(p:ped())
                --[[ ShowAdvancedNotification(textChar, "Information", "Nettoyage terminé.", char
                    , char) ]]

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'JAUNE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Nettoyage ~s terminée."
                })
            end
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function FactureMecano()
        if MecanoDuty then
            openRadial = false
            closeUI()
            TriggerEvent("nuiPapier:client:startCreation",2)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function CreateAdvert()
        if MecanoDuty then
            openRadial = false
            closeUI()
            CreateJobAnnonce()
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function OpenMenuMecano()
        if not openRadial then
            openRadial = true
            CreateThread(function()
                while openRadial do
                    Wait(0)
                    DisableControlAction(0, 1, openRadial)
                    DisableControlAction(0, 2, openRadial)
                    DisableControlAction(0, 142, openRadial)
                    DisableControlAction(0, 18, openRadial)
                    DisableControlAction(0, 322, openRadial)
                    DisableControlAction(0, 106, openRadial)
                end
            end)
            SetNuiFocusKeepInput(true)
            SetNuiFocus(true, true)
            Wait(200)
            CreateThread(function()
                function SubRadial()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "NETTOYAGE",
                                icon = "assets/svg/radial/sponge.svg",
                                action = "CleanVeh"
                            },
                            {
                                name = "CARROSSERIE",
                                icon = "assets/svg/radial/car.svg",
                                action = "RepareCarosserie"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "MainRadial"
                            },
                            {
                                name = "MOTEUR",
                                icon = "assets/svg/radial/engine.svg",
                                action = "RepareVehMoteur"
                            }
                        }, title = "REPARER"
                        }
                    }));
                end

                function MainRadial()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "ANNONCE",
                                icon = "assets/svg/radial/megaphone.svg",
                                action = "CreateAdvert"
                            },
                            {
                                name = "FACTURE",
                                icon = "assets/svg/radial/billet.svg",
                                action = "FactureMecano"
                            },
                            {
                                name = "PRISE DE SERVICE",
                                icon = "assets/svg/radial/checkmark.svg",
                                action = "MechanicDuty"
                            },
                            {
                                name = "COMMANDES",
                                icon = "assets/svg/radial/paper.svg",
                                action = "StockMenu"
                            },
                            {
                                name = "REPARER",
                                icon = "assets/svg/radial/repair.svg",
                                action = "SubRadial"
                            },
                        }, title = string.upper(textChar)
                        }
                    }));
                end
                MainRadial()
            end)
        else
            openRadial = false
            SetNuiFocusKeepInput(false)
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
            EnableControlAction(0, 142, true)
            EnableControlAction(0, 18, true)
            EnableControlAction(0, 322, true)
            EnableControlAction(0, 106, true)
            SetNuiFocus(false, false)
            SendNuiMessage(json.encode({
                type = 'closeWebview',
            }))
            return
        end
    end

    function StockMenu()
        if MecanoDuty then
            openRadial = false
            closeUI()
            handleOpenCommandMenu()
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function InfoVeh(entity)
        print("1", entity)
        local textChar = "Mecano"
        local char = "MECANO"
        ShowAdvancedNotification(textChar,
            "Véhicule : " .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(entity))),
            "\nPlaque~b~ : " .. GetVehicleNumberPlateText(entity)
            .. "\n~s~Carrosserie : ~b~" ..
            math.round(GetVehicleBodyHealth(entity) / 10, 2) .. "~s~%"
            .. "\nÉtat moteur : ~b~" .. math.round(GetVehicleEngineHealth(entity) / 10, 2) .. "~s~%"
            .. "\nEssence : ~o~" .. math.round(GetVehicleFuelLevel(entity), 2) .. "~s~%", char, char)
            print("2", entity)
    
        -- show advanced notification with engine, brakes, transmission, turbo, suspension stats
        local moteurstats = GetVehicleMod(entity, 11)
        if moteurstats == -1 then
            moteurstats = "Non installé"
        else
            moteurstats = "Niveau " .. moteurstats
        end
        local freinstats = GetVehicleMod(entity, 12)
        if freinstats == -1 then
            freinstats = "Non installé"
        else
            freinstats = "Niveau " .. freinstats
        end
        local transmissionstats = GetVehicleMod(entity, 13)
        if transmissionstats == -1 then
            transmissionstats = "Non installé"
        else
            transmissionstats = "Niveau " .. transmissionstats
        end
        local suspensionstats = GetVehicleMod(entity, 15)
        if suspensionstats == -1 then
            suspensionstats = "Non installé"
        else
            suspensionstats = "Niveau " .. suspensionstats
        end
        local turbostats = IsToggleModOn(entity, 18)
        if not turbostats then
            turbostats = "Non installé"
        else
            turbostats = "Installé"
        end
        print("3", entity)
    
        ShowAdvancedNotification(textChar,
            "Véhicule : " .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(entity))),
            "~s~Moteur : ~b~ " ..
            moteurstats ..
            "~s~\nFreins : ~b~ " ..
            freinstats ..
            "~s~\nTransmission : ~b~ " ..
            transmissionstats ..
            "~s~\nSuspension : ~b~ " ..
            suspensionstats ..
            "~s~\nTurbo : ~b~" ..
            turbostats, char, char)
            print("4", entity)
    end

    --magasin

    local open = false
    local market_main = RageUI.CreateMenu("", "Fournisseur", 0.0, 0.0, shopui, dictname)
    market_main.Closed = function()
        open = false
    end

    local marketCfg = {
        {
            item = "weapon_petrolcan",
            price = 0,
            index = 1,
        },
        {
            item = "spray",
            price = 0,
            index = 1,
        },
        {
            item = "repairkit",
            price = 100,
            index = 1,
        },
        {
            item = "cleankit",
            price = 40,
            index = 1,
        },
        {
            item = "sangle",
            price = 100,
            index = 1,
        },
    }
    local marketItem = {}



    for i = 1, 10 do
        table.insert(marketItem, i)
    end

    function OpenMechanicSell()
        if open then
            open = false
            RageUI.Visible(market_main, false)
            return
        else
            open = true
            RageUI.Visible(market_main, true)

            CreateThread(function()
                while open do
                    RageUI.IsVisible(market_main, function()
                        for k, v in pairs(marketCfg) do
                            RageUI.List(GetItemLabel(v.item), marketItem, v.index, nil,
                                { RightLabel = "~g~" .. v.price .. "$" }, true, {
                                onListChange = function(Index, Item)
                                    v.index = Index
                                end,
                                onSelected = function()
                                    TriggerSecurEvent("core:marketBuyItem", v.item, v.price, v.index)
                                end
                            })
                        end
                    end)
                    Wait(1)
                end
            end)
        end
    end

    RegisterJobMenu(OpenMenuMecano)

    RegisterNUICallback("focusOut", function(data, cb)
        if openRadial then
            openRadial = false
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
            EnableControlAction(0, 142, true)
            EnableControlAction(0, 18, true)
            EnableControlAction(0, 322, true)
            EnableControlAction(0, 106, true)
        end
        cb({})
    end)
    --Event

end

function UnloadMechanicJob()
    zone.removeZone("coffre_mecano")
    zone.removeZone("society_mecano")
    zone.removeZone("casier_mecano")
    zone.removeZone("item_mecano")
    zone.removeZone("mech_spawn")
    zone.removeZone("mech_delete")
    zone.removeZone("service_mecano")
end

RegisterNUICallback("vehMenuMecano", function (data, cb)
    if vehicle.IsSpawnPointClear(spawn3, 3.0) then
        if DoesEntityExist(vehs) then
            TriggerEvent('persistent-vehicles/forget-vehicle', vehs)
            removeKeys(GetVehicleNumberPlateText(vehs), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs))))
            TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(vehs))
            DeleteEntity(vehs)
        end
        vehs = vehicle.create(data.name,
            spawn4,
            {})
        if p:getJob() == "bennys" then
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
        elseif p:getJob() == "sunshine" then
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
        elseif p:getJob() == "harmony" then
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
        elseif p:getJob() == "hayes" then
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
        elseif p:getJob() == "beekers" then
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
        end
        if data.name == "flatbed3" then
            SetVehicleMod(vehs, 48, livery_flat)
            SetVehicleLivery(vehs, livery_flat)
        elseif data.name == "slamtruck" then
            SetVehicleMod(vehs, 48, livery_slam)
            SetVehicleLivery(vehs, livery_slam)
        elseif data.name == "sadlerrt" then
            SetVehicleMod(vehs, 48, livery_sadlerrt)
            SetVehicleLivery(vehs, livery_sadlerrt)
        end
    else

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "Il n'y a ~s pas de place ~c pour le véhicule"
        })

    end
end)
