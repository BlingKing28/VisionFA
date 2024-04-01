-- -276.49411010742, 6020.0151367188, 30.965690612793, 358.27435302734
local ped = nil
local created = false
local blipTravailRout
local trailer = nil
if not created then
    ped = entity:CreatePedLocal("s_m_m_cntrybar_01", vector3(-276.49411010742, 6020.0151367188, 30.965690612793),
    358.27435302734)
    created = true
end
SetEntityInvincible(ped.id, true)
ped:setFreeze(true)
SetEntityAsMissionEntity(ped.id, 0, 0)
SetBlockingOfNonTemporaryEvents(ped.id, true)
local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)
local spawnPlaces = {
    --vector4(-797.92742919922, 5390.0419921875, 33.299438476563, 358.06530761719),
    vector4(-285.1208190918, 6035.7719726563, 30.507102966309, 43.359828948975),
    vector4(-278.78448486328, 6043.3784179688, 30.543684005737, 56.082725524902),
}

local PossibleTrajets = {
    {arrive = vector3(-803.01586914063, 5433.1225585938, 34.504707336426), trailer = "trailerlogs", recompense = 50},
    {arrive = vector3(572.30743408203, -2325.0280761719, 5.9090967178345), trailer = "trailerlarge", recompense = 300},
    {arrive = vector3(-37.423530578613, -1684.5108642578, 29.402700424194), trailer = "tr4", recompense = 200},
}

local function CreateMissionRoutier(trajet)
    blipRoutier = AddBlipForCoord(trajet.arrive)
    SetBlipColour(blipRoutier, 15)
    SetBlipRoute(blipRoutier, 1)
    while true do 
        Wait(10)
        local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), trajet.arrive)
        if distance < 75.0 then 
            DrawMarker(39, trajet.arrive, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 175, 1, 0, 0, 0)
        end
        if distance < 5.0 then 
            if IsPedInAnyVehicle(PlayerPedId()) then
                local bool, trail = GetVehicleTrailerVehicle(GetVehiclePedIsIn(PlayerPedId()))
                if bool then
                    ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour terminer la livraison")
                    if IsControlJustPressed(0, 38) then 
                        DeleteEntity(trail)
                        exports['vNotif']:createNotification({
                            type = 'VERT',
                            content = "Vous avez gagné " .. trajet.recompense .. "$"
                        })
                        TriggerSecurGiveEvent("core:addItemToInventory", token, "money", trajet.recompense, {})
                        RemoveBlip(blipRoutier)
                        blipRoutier = nil
                        blipTravailRout = AddBlipForCoord(-278.55627441406, 6044.62109375, 30.538732528687)
                        SetBlipColour(blipTravailRout, 15)
                        SetBlipRoute(blipTravailRout, 1)
                    end
                else
                    ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour quitter votre service, vous pouvez également retourner la où vous avez pris votre service")
                    if IsControlJustPressed(0, 38) then 
                        RemoveBlip(blipTravailRout)
                        DeleteEntity(GetVehiclePedIsIn(PlayerPedId()))
                        break
                    end
                end
            end
        end
        local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -278.55627441406, 6044.62109375, 30.538732528687)
        if distance < 55.0 then 
            DrawMarker(39, -278.55627441406, 6044.62109375, 31.538732528687, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 175, 1, 0, 0, 0)
        end
        if distance < 5.0 then 
            ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour quitter votre service")
            if IsControlJustPressed(0, 38) then 
                RemoveBlip(blipTravailRout)
                DeleteEntity(GetVehiclePedIsIn(PlayerPedId()))
                break
            end
        end
    end
end

local function spawnVeh()
    if vehicle.IsSpawnPointClear(vector3(-285.1208190918, 6035.7719726563, 30.507102966309), 3.0) then
        if DoesEntityExist(vehs) then
            TriggerEvent('persistent-vehicles/forget-vehicle', vehs)
            removeKeys(GetVehicleNumberPlateText(vehs), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs))))
            TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(vehs))
            DeleteEntity(vehs)
        end
        vehs = vehicle.create('phantom', vector4(-285.1208190918, 6035.7719726563, 30.507102966309, 43.359828948975), {})
        local plate = vehicle.getProps(vehs).plate
        local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
        TaskWarpPedIntoVehicle(PlayerPedId(), vehs, -1)
        local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
        createKeys(plate, model)
        local randomm = math.random(1, #PossibleTrajets)
        local tr = PossibleTrajets[randomm].trailer
        trailer = vehicle.create(PossibleTrajets[randomm].trailer, vector4(-285.1208190918, 6035.7719726563, 30.507102966309, 43.359828948975) + vector4(0.0, 5.0, 0.0, 0.0), {})
        AttachVehicleToTrailer(vehs, trailer, 8.0)
        CreateMissionRoutier(PossibleTrajets[randomm])
    end
end

zone.addZone("routier_pos_prendre",
    vector3(-276.49411010742, 6020.0151367188, 30.9656923389),
    "Appuyer sur ~INPUT_CONTEXT~ pour récupérer ton camion",
    function()
        spawnVeh()
    end
)