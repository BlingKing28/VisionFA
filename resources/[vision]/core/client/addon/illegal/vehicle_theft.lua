local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local vehicleThieft = nil
function HookVehicleLSPD()
    CreateThread(function()
        vehicleThieft = nil
        local vehicle, dst = GetClosestVehicle(p:pos())
        local random = math.random(0, 100)

        if dst < 1.5 then
            local seat = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle))
            for i = -1, seat - 2 do
                if not IsVehicleSeatFree(vehicle, i) then
                    -- ShowNotification("~r~Il y a quelqu'un dans le vehicule")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Il y a quelqu'un dans le vehicule"
                    })

                    return
                end
            end
            RequestAnimDict('missheistfbisetup1')
            while not HasAnimDictLoaded('missheistfbisetup1') do
                Wait(0)
            end
            TaskPlayAnim(GetPlayerPed(-1), 'missheistfbisetup1' , 'hassle_intro_loop_f' ,8.0, -8.0, -1, 1, 0, false, false, false )
            SendNuiMessage(json.encode({
                type = 'openWebview',
                name = 'Progressbar',
                data = {
                    text = "Crochetage en cours...",
                    time = 10,
                }
            }))
            RemoveAnimDict("missheistfbisetup1")
            Wait(10000)
            ClearPedTasks(p:ped())
            NetworkRequestControlOfEntity(vehicle)
            SetVehicleDoorsLocked(vehicle, 0)
            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
            SetVehicleUndriveable(vehicle, true)
            -- ShowNotification("~g~Vous avez crocheté le vehicule")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'VERT',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Vous avez crocheté le vehicule"
            })

        else
            local randomAlarm = math.random(0, 100)
            if randomAlarm < 10 then
                SetVehicleAlarm(vehicle, true)
                SetVehicleAlarmTimeLeft(vehicle, 30000)
            end
            -- ShowNotification("~r~Vous n'êtes pas à proximité d'un véhicule")
        end
    end)
end

function HookVehicle()

    CreateThread(function()
        vehicleThieft = nil
        local vehicle, dst = GetClosestVehicle(p:pos())
        local random = math.random(0, 100)

        if dst < 3.5 then

            local seat = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle))
            for i = -1, seat - 2 do
                if not IsVehicleSeatFree(vehicle, i) then
                    -- ShowNotification("~r~Il y a quelqu'un dans le vehicule")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Il y a quelqu'un dans le vehicule"
                    })

                    return
                end
            end

            local vehicleClass = GetVehicleClass(vehicle)
--[[ 
            print(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))

            print(vehicleClass) ]]

            if vehicleClass == 15 or vehicleClass == 16 or vehicleClass == 19 or vehicleClass == 17 then
                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Il est impossible de ~s crocheter ce véhicule"
                })
                return
            else

                RequestAnimDict('missheistfbisetup1')
                while not HasAnimDictLoaded('missheistfbisetup1') do
                    Wait(1)
                end
                for _, value in pairs(p:getInventaire()) do
                    if value.name == "crochet" then
                        TriggerServerEvent("core:RemoveItemToInventory", token, "crochet", 1, value.metadatas)
                    end
                end
                if random < 35 then
                    TriggerServerEvent('core:makeCall', "lspd", p:pos(), true, "Vol de véhicule", false, nil)
                    TriggerServerEvent('core:makeCall', "lssd", p:pos(), true, "Vol de véhicule", false, nil)
                    -- ShowNotification("~r~Votre crochet s'est cassé")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Votre crochet s'est cassé"
                    })

                    return
                end
                TaskPlayAnim(GetPlayerPed(-1), 'missheistfbisetup1' , 'hassle_intro_loop_f' ,8.0, -8.0, -1, 1, 0, false, false, false )
                RemoveAnimDict("missheistfbisetup1")
                SendNuiMessage(json.encode({
                    type = 'openWebview',
                    name = 'Progressbar',
                    data = {
                        text = "Crochetage en cours...",
                        time = 40,
                    }
                }))
                Modules.UI.RealWait(40000)
                ClearPedTasks(p:ped())
                NetworkRequestControlOfEntity(vehicle)
                SetVehicleDoorsLocked(vehicle, 0)
                SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                SetVehicleUndriveable(vehicle, true)
                TriggerServerEvent("core:addCrewExp", p:getCrew(), 50, "hook")

                -- ShowNotification("~g~Vous avez crocheté le vehicule")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'VERT',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Vous avez crocheté le vehicule"
                })

                vehicleThieft = vehicle
                StartVehicleLoop()
                TriggerServerEvent("core:hooklog", p:pos(), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))), GetVehicleNumberPlateText(vehicle))
            end
        else
            local randomAlarm = math.random(0, 100)
            if randomAlarm < 10 then
                SetVehicleAlarm(vehicle, true)
                SetVehicleAlarmTimeLeft(vehicle, 30000)
            end
            -- ShowNotification("~r~Vous n'êtes pas à proximité d'un véhicule")
        end
    end)
end

function StartVehicleLoop()
    CreateThread(function()
        local timer = GetGameTimer() + 15000
        local start = false
        while vehicleThieft ~= nil do
            Wait(0)
            if GetGameTimer() > timer and not IsPedInVehicle(p:ped(), vehicleThieft, true) then
                SetVehicleDoorsLocked(vehicleThieft, 2)
                return
            elseif IsPedInVehicle(p:ped(), vehicleThieft, true) then
                if IsVehicleEngineStarting(vehicleThieft) then
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'Progressbar',
                        data = {
                            text = "Démarrage en cours...",
                            time = 10,
                        }
                    }))
                    SetVehicleEngineOn(p:currentVeh(), false, true, true)
                    start = true
                end
                if start then
                    SetVehicleUndriveable(vehicleThieft, true)
                end
                if not IsVehicleEngineStarting(vehicleThieft) and start and p:currentVeh() then
                    SetTimeout(10000, function()
                        SetVehicleUndriveable(vehicleThieft, false)
                        SetVehicleAlarm(vehicleThieft, true)
                        SetVehicleAlarmTimeLeft(vehicleThieft, 30000)
                    end)
                    start = false
                    -- stop the alarm after 30 seconds
                    SetTimeout(40000, function()
                        SetVehicleAlarm(vehicleThieft, false)
                    end)
                    return
                end
                -- return
            end
        end
    end)
end

RegisterNetEvent("core:hookVehicle")
AddEventHandler("core:hookVehicle", function()
    HookVehicle()
end)
