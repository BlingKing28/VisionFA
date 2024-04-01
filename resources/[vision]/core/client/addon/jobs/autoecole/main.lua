local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)
local open = false
local code = false
local fail = false
local speed_wait = 0
local inPermis = false
function InitLicense()
    code = TriggerServerCallback("core:getLicenseInPlayer", token, "traffic_law")
end

local code_config = {
    vector3(224.85809326172, 371.42068481445, 105.11414337158),
    vector3(226.0104675293, 371.07345581055, 105.11414337158),
    vector3(227.10748291016, 370.63323974609, 105.11414337158),
    vector3(224.15725708008, 369.61001586914, 105.11414337158),
    vector3(225.2864074707, 369.18054199219, 105.11414337158),
    vector3(226.52012634277, 368.73281860352, 105.11414337158)
}
-- passage du code dans la salle
for k, v in pairs(code_config) do
    zone.addZone("autoecole_code" .. k, v, "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
        function()
            exports["tuto-fa"]:GotoStep(3)
            OpenCode()
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
end

local main2 = RageUI.CreateMenu("", "Action Disponible", 0.0, 0.0, "root_cause", "shopui_title_drivingschool")
main2.Closed = function()
    open = false
    RageUI.Visible(main2, false)
end

function OpenCode()
    if open then
        open = false
        RageUI.Visible(main2, false)
        return
    else
        open = true
        RageUI.Visible(main2, true)
        code = TriggerServerCallback("core:getLicenseInPlayer", token, "traffic_law")
        local driving = TriggerServerCallback("core:getLicenseInPlayer", token, 'driving')
        local moto = TriggerServerCallback("core:getLicenseInPlayer", token, 'moto')
        local camion = TriggerServerCallback("core:getLicenseInPlayer", token, 'camion')
        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(main2, function()
                    if not code then
                        RageUI.Button("Passer l'examen du code", false, { RightBadge = RageUI.BadgeStyle.Tick }, true,
                            {
                                onSelected = function()
                                    DriveSchool.note = 0
                                    RageUI.CloseAll()
                                    SendNUIMessage({
                                        type = "openWebview",
                                        name = "autoecole",
                                        data = DriveSchool.Question
                                    })
                                end
                            }, nil)
                    else
                        RageUI.Button("Passer l'examen du code", false, {}, false, {}, nil)
                        RageUI.Button("Passer le permis voiture", false, {}, not driving, {
                            onSelected = function()
                                -- if spawnpoint is free
                                if vehicle.IsSpawnPointClear(AutoEcole.spawn.xyzw, 3) then
                                    RageUI.CloseAll()
                                    open = false
                                    StartPermis("voiture")
                                else
                                    -- ShowNotification("La sortie de véhicule est occupée")

                                    -- New notif
                                    exports['vNotif']:createNotification({
                                        type = 'ROUGE',
                                        -- duration = 5, -- In seconds, default:  4
                                        content = "La ~s sortie ~c de véhicule est ~s occupée"
                                    })

                                end
                            end
                        }, nil)
                        RageUI.Button("Passer le permis moto", false, {}, not moto, {
                            onSelected = function()
                                -- if spawnpoint is free
                                if vehicle.IsSpawnPointClear(AutoEcole.spawn.xyzw, 3) then
                                    RageUI.CloseAll()
                                    open = false
                                    StartPermis("moto")
                                else
                                    -- ShowNotification("La sortie de véhicule est occupée")

                                    -- New notif
                                    exports['vNotif']:createNotification({
                                        type = 'ROUGE',
                                        -- duration = 5, -- In seconds, default:  4
                                        content = "La ~s sortie ~c de véhicule est ~s occupée"
                                    })

                                end
                            end
                        }, nil)
                        RageUI.Button("Passer le permis camion", false, {}, not camion, {
                            onSelected = function()
                                -- if spawnpoint is free
                                if vehicle.IsSpawnPointClear(AutoEcole.spawn.xyzw, 3) then
                                    RageUI.CloseAll()
                                    open = false
                                    StartPermis("camtar")
                                else
                                    -- ShowNotification("La sortie de véhicule est occupée")

                                    -- New notif
                                    exports['vNotif']:createNotification({
                                        type = 'ROUGE',
                                        -- duration = 5, -- In seconds, default:  4
                                        content = "La ~s sortie ~c de véhicule est ~s occupée"
                                    })

                                end
                            end

                        }, nil)
                    end
                end)
                Wait(1)
            end
        end)
    end
end

function StartPermis(permis)
    ---SpawnVeh With Player
    local veh = nil
    inPermis = true
    local outPos = AutoEcole.spawn.xyzw
    local index = 1
    if permis == "moto" then
        veh = vehicle.create("bati", outPos, {})
        local plate = vehicle.getProps(veh).plate
        local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
        local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, veh, VehToNet(veh), p:getJob())
        createKeys(plate, model)
    elseif permis == "voiture" then
        veh = vehicle.create("blista", outPos, {})
        local plate = vehicle.getProps(veh).plate
        local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
        local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, veh, VehToNet(veh), p:getJob())
        createKeys(plate, model)
    elseif permis == "camtar" then
        veh = vehicle.create("trash2", outPos, {})
        local plate = vehicle.getProps(veh).plate
        local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
        local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, veh, VehToNet(veh), p:getJob())
        createKeys(plate, model)
    end

    TaskWarpPedIntoVehicle(p:ped(), veh, -1)
    -- ShowNotification("Bienvenue dans votre permis de conduire, suivez les indications sur votre GPS et respectez le code de la route")

    -- New notif
    exports['vNotif']:createNotification({
        type = 'JAUNE',
        -- duration = 5, -- In seconds, default:  4
        content = "Bienvenue dans votre ~s permis de conduire,~c suivez les indications sur votre GPS et respectez le code de la route"
    })

    Wait(100)
    local error = 0
    local type = 18
    local checkpoint = nil
    CreateThread(function()
        while inPermis do
            -- if the player goes out of the vehicle he has 5 seconds to get back in
            if not IsPedInVehicle(p:ped(), veh, false) then
                Visual.Subtitle("Vous avez quitté le véhicule, vous avez 5 secondes pour rentrer", 5000)
                Wait(5000)
                if not IsPedInVehicle(p:ped(), veh, false) then
                    -- end the test and delete the vehicle
                    inPermis = false
                    TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                    removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                    TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                    DeleteEntity(veh)
                    index = 1
                    error = 0
                    DeleteCheckpoint(checkpoint)
                    checkpoint = nil
                    return
                end
            end
            if checkpoint == nil then
                SetNewWaypoint(AutoEcole.pos[index].x, AutoEcole.pos[index].y)
                checkpoint = CreateCheckpoint(type, AutoEcole.pos[index].x, AutoEcole.pos[index].y,
                    AutoEcole.pos[index].z + 1, AutoEcole.pos[index + 1].x, AutoEcole.pos[index + 1].y,
                    AutoEcole.pos[index + 1].z - 1.5, 2.0, 255, 255, 255, 255, false)
            end
            if #(p:pos() - AutoEcole.pos[index]) <= 10 then
                index = index + 1
                DeleteCheckpoint(checkpoint)
                checkpoint = nil
            end
            if index == #AutoEcole.pos then
                -- if the player has 3 or more errors, fail the test and notify the player
                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                DeleteEntity(veh)
                if error >= 3 then
                    -- ShowNotification("Vous avez ~r~échoué~w~ l'examen")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous avez ~s échoué ~c l'examen"
                    })

                    inPermis = false
                    DeleteCheckpoint(checkpoint)
                    checkpoint = nil
                    index = 1
                    error = 0
                    return
                else
                    -- ShowNotification("Vous avez ~g~réussi~w~ l'examen")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'VERT',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous avez ~s réussi ~c l'examen"
                    })

                    local SID = GetPlayerServerId(PlayerId())
                    if permis == "voiture" then
                        TriggerServerEvent("core:addLicence", SID, token, "driving")
                    elseif permis == "moto" then
                        TriggerServerEvent("core:addLicence", SID, token, "moto")
                    elseif permis == "camtar" then
                        TriggerServerEvent("core:addLicence", SID, token, "camion")
                    end
                    inPermis = false
                    DeleteCheckpoint(checkpoint)
                    checkpoint = nil
                    index = 1
                    error = 0
                    return
                end
                break
            end
            if (index + 1) == #AutoEcole.pos then
                -- last checkpoint is finish line
                type = 10
            end
            if error < 3 then
                -- if the speed is above 80 km/h add error and give them time to slow down
                if GetEntitySpeed(veh) * 3.6 > 80 and speed_wait == 0 then
                    error = error + 1
                    speed_wait = 100
                end
                -- if the car health is below 85% add 3 errors and end the test
                if GetVehicleBodyHealth(veh) < 85 and not fail then
                    error = error + 3
                    fail = true
                end
            end
            if speed_wait > 0 then
                speed_wait = speed_wait - 1
            end
            Wait(1)
        end
    end)
end
