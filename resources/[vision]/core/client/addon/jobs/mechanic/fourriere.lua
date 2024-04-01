local fourriereOpen = false
local actuel = nil
local stock = nil
local amount = 100
local posVeh
local data_ui = {
    headerImage = 'assets/Fourriere/header.png',
    headerIcon = 'assets/icons/voiture-icon.png',
    headerIconName = 'FOURRIERE',
    callbackName = 'fourriere_callback',
    showTurnAroundButtons = false,
    elements = {}
}

function OpenMenuFourriere(posSpawn, id)
    posVeh = posSpawn
    fourriereOpen = true
    data_ui.elements = {}
    stock = TriggerServerCallback("core:GetAllVehPounder", id, true)

    if json.encode(stock) ~= "[]" or crewStock ~= nil then
        if json.encode(stock) ~= "[]" then
            for k, v in pairs(stock) do
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

RegisterNUICallback("fourriere_callback", function(data, cb)
    if vehicle.IsSpawnPointClear(vector3(posVeh.x, posVeh.y, posVeh.z), 3.0) then
        local veh = vehicle.create(stock[data.id].name, posVeh, stock[data.id].props)
        TaskWarpPedIntoVehicle(p:ped(), veh, -1)
        TriggerServerEvent("core:SetVehicleOut", string.upper(vehicle.getPlate(veh)), VehToNet(veh), veh)
        SetVehicleFuelLevel(veh,
        GetVehicleHandlingFloat(veh, "CHandlingData", "fPetrolTankVolume"))
        SendNuiMessage(json.encode({
            type = 'closeWebview'
        }))
    else
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Le véhicule ne peut pas sortir"
        })
    end
end)