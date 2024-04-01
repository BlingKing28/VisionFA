local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)
print('pound2')


local fourriereOpen = false
local actuel = nil
local stock = nil
local amount = 100
local fourrieres = {
    {
        coords = vector4(120.34503936768, 6625.791015625, 30.95396232605, 140.82247924805),
        spawnCar = {
            vector4(119.30187988281, 6618.9262695313, 31.408340454102, 140.82247924805),
        }
    }
}

local data_ui = {
    headerImage = 'assets/Fourriere/header.png',
    headerIcon = 'assets/icons/voiture-icon.png',
    headerIconName = 'FOURRIERE',
    callbackName = 'fourriere_callback_paleto',
    showTurnAroundButtons = false,
    elements = {}
}

function getTableSize(t)
    local count = 0
    for _, __ in pairs(t) do
        count = count + 1
    end
    return count
end


local function OpenFourriere(ped)
    fourriereOpen = true
    data_ui.elements = {}
    stock = TriggerServerCallback("core:GetVehiclesInPound")
    playerCrew = p:getCrew()

    if json.encode(stock) ~= "[]" or crewStock ~= nil then
        if json.encode(stock) ~= "[]" then
            for k, v in pairs(stock) do
                print(json.encode(v))
                if v.job ~= nil then 
                    cat = "Entreprise"
                elseif v.vente ~= nil then
                    cat = "Crew"
                else
                    cat = "Personnel"
                end
                if v.stored == 2 then
                    table.insert(data_ui.elements, {
                        id = k,
                        price = amount,
                        image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Concessionnaire/Voiture/"..v.name..".webp",
                        name=v.name,
                        label=v.name.." "..v.currentPlate,
                        category= cat,
                    })
                end
            end
        end

        playerCoords = GetEntityCoords(PlayerPedId())
        pedCoords = GetEntityCoords(ped)
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamActive(cam, 1)
        SetCamCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.5)
        SetCamFov(cam, 50.0)
        PointCamAtCoord(cam, pedCoords.x, pedCoords.y, pedCoords.z + 0.5)
        RenderScriptCams(true, 0, 3000, 1, 0)   
        FreezeEntityPosition(PlayerPedId(), true)
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogueAchat',
            data = data_ui,
        }));
    else
        -- ShowNotification("Aucun véhicule dans la fourrière")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Aucun véhicule dans la fourrière"
        })

    end
end

RegisterNUICallback("focusOut", function (data, cb)
    if fourriereOpen then
        TriggerScreenblurFadeOut(0.5)
        openRadarProperly()
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
        FreezeEntityPosition(PlayerPedId(), false)
    end
end)

RegisterNUICallback("fourriere_callback_paleto", function(data, cb)
    tableSize = getTableSize(fourrieres[actuel].spawnCar)
    count = 0
    if data.category == "Entreprise" then                    
        if not TriggerServerEvent("core:paySocietyPounder", 100, p:getJob()) then
            for key, value in pairs(fourrieres[actuel].spawnCar) do
                count = count + 1
                if vehicle.IsSpawnPointClear(value.xyz, 3.0) then
                    local veh = vehicle.create(stock[data.id].name, value, stock[data.id].props)
                    TaskWarpPedIntoVehicle(p:ped(), veh, -1)
                    TriggerServerEvent("core:SetVehicleOut", string.upper(vehicle.getPlate(veh)), VehToNet(veh), veh)
                    SetVehicleFuelLevel(veh,
                    GetVehicleHandlingFloat(veh, "CHandlingData", "fPetrolTankVolume"))
                    SendNuiMessage(json.encode({
                        type = 'closeWebview'
                    }))
                    fourriereOpen = false
                    break
                else
                    if count == tableSize then
                        -- ShowNotification("~r~Le véhicule ne peut pas sortir")

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'ROUGE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "~s Le véhicule ne peut pas sortir"
                        })

                    end
                end
            end                       
        else 
            -- ShowNotification("Vous n'avez ~r~pas assez d'argent~s~")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous n'avez ~s pas assez d'argent"
            })

        end
    else                
        if p:pay(100) then
            for key, value in pairs(fourrieres[actuel].spawnCar) do
                count = count + 1
                if vehicle.IsSpawnPointClear(value.xyz, 3.0) then
                    local veh = vehicle.create(stock[data.id].name, value, stock[data.id].props)
                    TaskWarpPedIntoVehicle(p:ped(), veh, -1)
                    TriggerServerEvent("core:SetVehicleOut", string.upper(vehicle.getPlate(veh)), VehToNet(veh), veh)
                    SetVehicleFuelLevel(veh,
                    GetVehicleHandlingFloat(veh, "CHandlingData", "fPetrolTankVolume"))
                    SendNuiMessage(json.encode({
                        type = 'closeWebview'
                    }))
                    fourriereOpen = false
                    break
                else
                    if count == tableSize then
                        -- ShowNotification("~r~Le véhicule ne peut pas sortir")

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'ROUGE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "~s Le véhicule ne peut pas sortir"
                        })

                    end
                end
            end                    
        else
            -- ShowNotification("Vous n'avez ~r~pas assez d'argent~s~")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous n'avez ~s pas assez d'argent"
            })

        end
    end
end)

local peds = {}

CreateThread(function()
    for k, v in pairs(fourrieres) do
        while zone == nil do Wait(1) end
        peds[k] = entity:CreatePedLocal("a_m_m_hillbilly_01", v.coords.xyz, v.coords.w)
        peds[k]:setFreeze(true)
        SetEntityInvincible(peds[k].id, true)
        SetEntityAsMissionEntity(peds[k].id, 0, 0)
        SetBlockingOfNonTemporaryEvents(peds[k].id, true)
        zone.addZone(
            "fourrière_paleto" .. k, -- Nom
            v.coords.xyz, -- Position
            "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir la fourrière", -- Text affiché
            function()
                local harmony = TriggerServerCallback("core:getNumberOfDuty", token, 'harmony')
                if harmony > 0 then
                    -- ShowNotification("La fourrière est fermée")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s La fourrière est fermée"
                    })

                else
                    actuel = k
                    OpenFourriere(peds[k].id)
                end
            end,
            true, -- Avoir un marker ou non
            -1, -- Id / type du marker
            0.8, -- La taille
            { 235, 192, 15 }, -- RGB
            170, -- Alpha
            3 -- Interact Dist
        )        
    end
end)
