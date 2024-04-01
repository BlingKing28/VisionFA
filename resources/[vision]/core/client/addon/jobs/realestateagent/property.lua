local token = nil
local properties = {}
local selectedProperty = nil
local loaded_vehicles = {}
local in_garage = false
local just_outed_of_garage = false
IsInGarage = in_garage

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

-- Only the connecting player receives it
RegisterNetEvent("core:property:getProperties")
AddEventHandler("core:property:getProperties", function(properties2)
    properties = properties2
    LoadProperties(properties)

    -- if player is in a property, load it
    local last_property = TriggerServerCallback("core:getPlayerLastProperty", token)
    if (last_property ~= nil) then
        for _, property in pairs(properties) do
            if property.id == last_property.id then
                selectedProperty = last_property
                TriggerServerEvent("core:InstancePlayer", token, selectedProperty.id, "Property : Ligne 25")
                TriggerServerEvent("core:AddPlayerInHouse", token, GetPlayerServerId(PlayerId()), selectedProperty.id)
                if selectedProperty.data.type == "garage" then
                    GarageInterior(FindInterior(selectedProperty))
                else
                    AppartementInterior(FindInterior(selectedProperty))
                end
                break
            end
        end
    end
end)

function GetAllProperties()
    return properties
end

-- Everyone receives it
RegisterNetEvent("core:property:new")
AddEventHandler("core:property:new", function(new_property)
    table.insert(properties, new_property)
    LoadProperty(new_property)
end)

-- Only the new co owner receives it
RegisterNetEvent("core:property:addCoOwner")
AddEventHandler("core:property:addCoOwner", function(propertyId, target)

    for i, property in pairs(properties) do
        if property.id == propertyId then
            table.insert(property.co_owner, target)
            selectedProperty.co_owner = property.co_owner
            break
        end
    end

    -- Update selected property if the player is in it
    if selectedProperty ~= nil and selectedProperty.id == propertyId then
        if selectedProperty.data.type == "garage" then
            GarageInterior(FindInterior(selectedProperty))
        else
            AppartementInterior(FindInterior(selectedProperty))
        end
    end
end)

-- Only the new co owner receives it
RegisterNetEvent("core:property:removeCoOwner")
AddEventHandler("core:property:removeCoOwner", function(propertyId, target)
    for i, property in pairs(properties) do
        if property.id == propertyId then
            for k, co_owner in pairs(property.co_owner) do
                if co_owner == target then
                    table.remove(property.co_owner, k)
                    selectedProperty.co_owner = property.co_owner
                    break
                end
            end
            break
        end
    end

    -- if player is in the property, remove markers
    if selectedProperty ~= nil and selectedProperty.id == propertyId then
        zone.removeZone("property_leave")
        zone.removeZone("property_gestion")
        if selectedProperty.data.type ~= "garage" then
            zone.removeZone("property_coffre")
        end
    end
end)

-- Everyone receives it
RegisterNetEvent("core:property:delete")
AddEventHandler("core:property:delete", function(propertyId)
    -- Check if the player is in the property
    -- If so, leave it
    if selectedProperty ~= nil and selectedProperty.id == propertyId then
        LeaveProperty()
        selectedProperty = nil
    end
    -- Rebuild the properties table
    local newProperties = {}
    for i, property in pairs(properties) do
        if property.id ~= propertyId then
            table.insert(newProperties, property)
        end
    end
    properties = newProperties

    -- Remove the property from the zone
    zone.removeZone("property " .. propertyId)
end)

-- Only players in the property receive it
RegisterNetEvent("core:property:updateVehicles")
AddEventHandler("core:property:updateVehicles", function(propertyId)
    if selectedProperty ~= nil and selectedProperty.id == propertyId then

        -- Delete all vehicles
        for i, j in pairs(loaded_vehicles) do
            if DoesEntityExist(j.entity) then
                DeleteEntity(j.entity)
            end
        end

        -- Load new ones
        GarageInterior(FindInterior(selectedProperty))
        
    end
end)

-- Only players in the property receive it
RegisterNetEvent("core:property:refreshInventory")
AddEventHandler("core:property:refreshInventory", function(propertyId, inventory)

    if selectedProperty ~= nil and selectedProperty.id == propertyId then

        selectedProperty.inventory = inventory
        SendNUIMessage({
            type = "updateInventory",
            data = {
                items = p:getInventaire(),
                clothes = {},
                weapons = {},
                target = {
                    items = inventory,
                    maxWeight = tonumber(selectedProperty.weight),
                    name = "Propriété " .. selectedProperty.name
                }
            }
        })
    end
end)

-- Only player who ring the doorbell receive it
RegisterNetEvent("core:property:enterByDoorbell")
AddEventHandler("core:property:enterByDoorbell", function(propertyId)
    selectedProperty = TriggerServerCallback("core:property:getProperty", token, propertyId)
    TriggerServerEvent("core:InstancePlayer", token, selectedProperty.id, "Property : Ligne 289")
    TriggerServerEvent("core:AddPlayerInHouse", token, GetPlayerServerId(PlayerId()), selectedProperty.id)
    EnterProperty(selectedProperty)
end)


CreateThread(function()
    Wait(2000)
    DoScreenFadeIn(800)
    TriggerServerEvent("core:property:getProperties", token)
    while true do
        if in_garage then
            for i, j in pairs(loaded_vehicles) do
                SetEntityCoordsNoOffset(j.entity, j.pos.xyz, 0.0, 0.0, 0.0)
                SetEntityHeading(j.entity, j.pos.w)
                SetVehicleOnGroundProperly(j.entity)
            end
        end
        Wait(500)
    end
end)

CreateThread(function()
    local current_plate
    local currentveh = nil
    while true do
        if in_garage then
            if p:isInVeh() then
                ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour sortir")
                if IsControlJustPressed(0, 38) then
                    in_garage = false
                    current_plate = vehicle.getPlate(p:currentVeh())
                    for i, j in pairs(loaded_vehicles) do
                        if DoesEntityExist(j.entity) then
                            DeleteEntity(j.entity)
                        end
                        -- find the vehicle player is in
                        if j.plate == current_plate then
                            currentVeh = j
                        end
                    end                            
                    LeaveGarage(currentVeh)
                    currentVeh = nil
                    loaded_vehicles = {}
                end
                
            end
            Wait(1)
        else
            Wait(500)
        end
    end
end)

function DrawBlip(_type, name, pos)
    local blip = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(blip, _type)
    if _type == 40 then
        SetBlipColour(blip, 2)
    else 
        SetBlipColour(blip, 29)
    end
    SetBlipScale(blip, 0.75)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)
end

-- Arg 1: The properties list
-- Load all properties in the world (blip and marker)
function LoadProperties(props)
    for i, property in pairs(props) do
        LoadProperty(property)
    end
end

function LoadProperty(property)

    local blip, marker = 40, 25

    if property.data.type == "garage" then
        blip, marker = 357, 36
    elseif property.data.type == "stockage" then
        blip, marker = 473, 25
    end

    -- If the player has access to the property, set the blip color to green
    if PlayerHasAccessToProperty(property) then
        -- Create the blip
        DrawBlip(blip, property.name, vector3(property.enter_pos.x, property.enter_pos.y, property.enter_pos.z))
    end

    -- Create the marker
    zone.addZone(
        "property " .. property.id,
        vector3(property.enter_pos.x, property.enter_pos.y, property.enter_pos.z - 0.9),
        "Appuyez sur ~INPUT_CONTEXT~ pour accéder à la propriété",
        function()
            selectedProperty = TriggerServerCallback("core:property:getProperty", token, property.id)
            if p:isInVeh() then
                if just_outed_of_garage then return end
                if not PlayerHasAccessToProperty(selectedProperty) then
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        content = "~s Vous n'avez pas accès à cette propriété"
                    })
                    return
                end
                if selectedProperty.data.type == "garage" then
                    in_garage = true
                    local veh = p:currentVeh()
                    local plate = vehicle.getPlate(veh)
                    local props = vehicle.getProps(veh)

                    -- If garage is full
                    if #selectedProperty.garage >= GetGarageVehCount(selectedProperty) then
                        exports['vNotif']:createNotification({
                            type = 'ROUGE',
                            content = "~s Le garage est plein"
                        })
                        return
                    end

                    -- Delete the vehicle
                    TriggerServerEvent("core:SetVehicleIn", all_trim(plate))
                    
                    -- Remove vehicle from persistent-vehicles
                    TriggerEvent('persistent-vehicles/forget-vehicle', p:currentVeh())
                    DeleteEntity(veh)

                    -- Set the vehicle in the garage
                    TriggerServerEvent("core:property:addVehicle", token, selectedProperty.id, props)

                    -- Wait for the vehicle to be saved
                    Wait(400)
                    
                    -- Set player in the property
                    TriggerServerEvent("core:InstancePlayer", token, selectedProperty.id, "Property : Ligne 289")
                    TriggerServerEvent("core:AddPlayerInHouse", token, GetPlayerServerId(PlayerId()), selectedProperty.id)

                    -- Enter the property
                    EnterProperty(selectedProperty)

                else 
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        content = "~s Vous ne pouvez pas entrer en véhicule dans cette propriété"
                    })
                end
            else
                SendNuiMessage(json.encode({
                    type = 'openWebview',
                    name = 'MenuProprieteAlt',
                    data =   {
                        boiteWeight = computeInventoryWeight(selectedProperty.data.mailbox),
                        isLocked    = IsPropertyLocked(selectedProperty),
                        name        = selectedProperty.name,
                        canPerqui   = false,
                        owner       = selectedProperty.owner_fullname
                    }
                }))
            end
        end,
        true,
        marker,             -- Id / type du marker
        0.6,                -- La taille
        { 51, 204, 255 },   -- RGB
        170                 -- Alpha
    )
end

function UnloadProperty(property)
    zone.removeZone("property " .. property.id)
end

function IsPropertyLocked(property)
    if property.data.doorState == true then
        return false
    elseif PlayerHasAccessToProperty(property) then
        return false
    else
        return true
    end
end

function PlayerHasAccessToProperty(property)
    -- If the player is the owner, return true
    while not p do Wait(1) end
    -- if property.rentalEnd is outdated, return false
    local current_time = TriggerServerCallback('core:property:getTimestamp', token)
    if property.rentalEnd ~= nil and tonumber(property.rentalEnd) < current_time then
        return false
    end

    if tonumber(property.owner) == p:getId() then
        return true
    end
    -- If the player is the one of the co-owners, return true
    if property.co_owner then
        for k, v in pairs(property.co_owner) do
            if tonumber(v) == p:getId() then
                return true
            end
        end
    end

    -- If the player is in the crew, return true
    -- put a string to lower
    if string.lower(property.type) == "entreprise" and property.crew == p:getJob() then
        return true
    end
    if string.lower(property.type) == "crew" and property.crew == p:getCrew() then
        return true
    end

    -- Else, player can't enter without ringing
    return false
end

function PlayerCanSearchInProperty(property)
    if p:getJob() == "lspd" or p:getJob() == "lssd" or (p:getJob() == "realestateagent" and dutyproperty) or p:getJob() == "justice" then
        return true
    end
    if p:getPermission() >= 3 then
        return true
    end
    return false
end

function computeInventoryWeight(inventory)
    if not inventory then return 0 end
    local weight = 0
    for k, v in pairs(inventory) do
        weight = weight + (v.weight * v.count)
    end
    return weight
end

function GetGarageVehCount(property)
    return #FindInterior(property).vehPos
end

function FindInterior(property)
    if property.data.type == "habitation" then
        property.data.type = "Appartement"
    end
    
    if property.data.type == "stockage" then
        property.data.type = "Entrepot"
    end

    if property.data.type == "garage" then
        property.data.type = "Garage"
    end

    for k, v in pairs(Property) do
        for i = 1, #Property[k].data do
            RemoveIpl(Property[k].data[i].ipl)
        end
        if k == property.data.type then
            for _, data in pairs(v.data) do
                if data.name == property.data.interior then
                    table.insert(Utils.GlobalCache, {type = "property", value = GetInteriorAtCoords(data.pos)})
                    PinInteriorInMemory(int)
                    if data.ipl ~= "" then
                        EnableIpl(data.ipl, true)
                        while not IsIplActive(data.ipl) do
                            Wait(25)
                        end
                    end
                    return data
                end
            end
        end
    end
end

function EnterProperty(propertyData)
    CreateThread(function()
        DoScreenFadeOut(800)

        while not IsScreenFadedOut() do
            Wait(20)
        end

        local interior = FindInterior(propertyData)
        SetEntityCoords(p:ped(), interior.pos)
        Wait(50)
        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do Wait(1) end
        SetEntityCoords(p:ped(), interior.pos)
        if string.lower(propertyData.data.type) == "garage" then
            GarageInterior(interior)
        else
            AppartementInterior(interior)
        end
        -- Save the last property
        TriggerServerEvent("core:updateLastProperty", token, json.encode({
            id = propertyData.id,
            type = "property"
        }))
        TriggerServerEvent("core:enterDecorationProperty", token, propertyData, true)
        DoScreenFadeIn(800)
    end)
end

function LeaveProperty()
    DoScreenFadeOut(800)

    while not IsScreenFadedOut() do
        Wait(20)
    end

    TriggerServerEvent("core:rmvPlayerInHouse", token, GetPlayerServerId(PlayerId()), selectedProperty.id)
    TriggerServerEvent("core:InstancePlayer", token, 0, "Property : Ligne 465")
    TriggerServerEvent('core:leaveDecorationProperty', token, selectedProperty, false)
    SetEntityCoords(p:ped(), selectedProperty.enter_pos.x, selectedProperty.enter_pos.y, selectedProperty.enter_pos.z)

    zone.removeZone("property_leave")
    zone.removeZone("property_coffre")
    zone.removeZone("property_gestion")
    TriggerServerEvent("core:updateLastProperty", token, json.encode({}))
    Wait(50)
    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do Wait(1) end
    SetEntityCoords(p:ped(), selectedProperty.enter_pos.x, selectedProperty.enter_pos.y, selectedProperty.enter_pos.z)
    selectedProperty = nil
    DoScreenFadeIn(800)
    for k,v in pairs(Utils.GlobalCache) do 
        if v.type == "property" then 
            UnpinInterior(v.value)
            table.remove(Utils.GlobalCache, k)
        end
    end
end

function LeaveGarage(veh)
    DoScreenFadeOut(800)

    while not IsScreenFadedOut() do
        Wait(20)
    end

    -- Remove the player from the house
    TriggerServerEvent("core:rmvPlayerInHouse", token, GetPlayerServerId(PlayerId()), selectedProperty.id)
    TriggerServerEvent("core:InstancePlayer", token, 0, "Property : Ligne 495")

    -- Remove markers
    zone.removeZone("property_leave")
    zone.removeZone("property_gestion")

    -- Save the last property
    TriggerServerEvent("core:updateLastProperty", token, json.encode({}))
    Wait(50)

    -- Teleport the player outside
    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do Wait(1) end
    SetEntityCoords(p:ped(), selectedProperty.enter_pos.x, selectedProperty.enter_pos.y, selectedProperty.enter_pos.z)

    -- If player is in a vehicle, spawn it outside
    if veh then 
        local leaveVeh = vehicle.create(
            veh.model,
            vector4(selectedProperty.enter_pos.x, selectedProperty.enter_pos.y, selectedProperty.enter_pos.z, 0.0),
            veh.props
        )
        SetVehicleNumberPlateText(leaveVeh, veh.plate)
        TriggerServerEvent("core:SetVehicleOut", string.upper(vehicle.getPlate(leaveVeh)), VehToNet(leaveVeh), leaveVeh)
        TaskWarpPedIntoVehicle(p:ped(), leaveVeh, -1)

        TriggerServerEvent("core:property:removeVehicle", token, selectedProperty.id, veh.plate)
        just_outed_of_garage = true
    end
    selectedProperty = nil
    
    DoScreenFadeIn(800)
    
    Wait(1000)
    just_outed_of_garage = false
end

function EnableIpl(ipl, value)
    if type(ipl) == "table" then
        for k, v in pairs(ipl) do
            EnableIpl(v, value)
        end
    else
        if value then
            if not IsIplActive(ipl) then
                RequestIpl(ipl)
            end
        else
            if IsIplActive(ipl) then
                RemoveIpl(ipl)
            end
        end
    end
end

function ParseInventory(inventory)

    -- if inventory is empty, return empty table
    if not inventory then return {} end

    -- if inventory is not empty, parse it
    local parsed = {}
    for k, v in pairs(inventory) do
        if v.type == "items" or v.type == "weapons" or v.type == "clothes" then
            table.insert(parsed, {
                name = v.name,
                count = v.count,
                label = v.label,
                cols = v.cols,
                rows = v.rows,
                type = v.type,
                metadatas = v.metadatas,
                weight = v.weight
            })
        end
    end
    return parsed
end

function OpenPropertyGestion(data)
    local current_time = TriggerServerCallback('core:property:getTimestamp', token)
    local remainingDaysOfLocation = math.floor((selectedProperty.rentalEnd - current_time) / 86400)

    if remainingDaysOfLocation < 0 then
        remainingDaysOfLocation = 0
    end

    if p:getJob() == "realestateagent" and dutyproperty then
        forceHideRadar()
        SetNuiFocusKeepInput(false)
        SetNuiFocus(true, false)
        Wait(100)
        local valueHide = false

        -- if data.rentalEnd is in more than 300 days, set valueHide to true
        -- rentalEnd is a timestamp, so we need to convert it to a table
        local acces = 'ouvert'
        if remainingDaysOfLocation > 300 then
            valueHide = true
        end

        if selectedProperty.data.doorState == false then
            acces = 'fermer'
        end 

        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'gestionpropriete',
            data = {
                hideDuration    = valueHide,
                timeLeft        = remainingDaysOfLocation,
                acces           = acces,
                type            = selectedProperty.type,
                haveAccess      = selectedProperty.co_owner,
                maxDuration     = 15
            }
        }))
    else
        forceHideRadar()
        SetNuiFocusKeepInput(false)
        SetNuiFocus(true, false)
        Wait(100)
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'Menu_propriete',
            data = {
                data_boite      = ParseInventory(TriggerServerCallback('core:property:getMailbox', token, selectedProperty.id)),
                number_day      = remainingDaysOfLocation,
                name            = data.name,
                advancedPerm    = false
            }
        }));
    end
end

-- Functions for the interiors

function AppartementInterior(property)

    if PlayerHasAccessToProperty(selectedProperty) or PlayerCanSearchInProperty(selectedProperty) then
        -- Draw gestion marker
        zone.addZone(
            "property_gestion",
            vector3(property.gestion.x, property.gestion.y, property.gestion.z - 0.9),
            "Appuyez sur ~INPUT_CONTEXT~ pour accéder à la gestion de la propriété",
            function()
                OpenPropertyGestion(property)
            end,
            true,
            25,                 -- Id / type du marker
            0.6,                -- La taille
            { 51, 204, 255 },   -- RGB
            170                 -- Alpha
        )

        -- Draw coffre marker
        zone.addZone(
            "property_coffre",
            vector3(property.coffre.x, property.coffre.y, property.coffre.z - 0.9),
            "Appuyez sur ~INPUT_CONTEXT~ pour accéder au coffre de la propriété",
            function()
                OpenInventoryProperty(
                    selectedProperty,   -- La propriété
                    ParseInventory(TriggerServerCallback("core:property:getPropertyInventory", token, selectedProperty.id)), -- L'inventaire de la propriété (formaté)
                    ParseInventory(p:getInventaire())    -- L'inventaire du joueur (formaté)
                )
            end,
            true,
            25,                 -- Id / type du marker
            0.6,                -- La taille
            { 51, 204, 255 },   -- RGB
            170                 -- Alpha
        )
    end

    -- Draw leave marker
    zone.addZone(
        "property_leave",
        vector3(property.leave.x, property.leave.y, property.leave.z - 0.9),
        "Appuyez sur ~INPUT_CONTEXT~ pour sortir de la propriété",
        function()
            LeaveProperty(property)
        end,
        true,
        25,                 -- Id / type du marker
        0.6,                -- La taille
        { 51, 204, 255 },   -- RGB
        170                 -- Alpha
    )

end

function GarageInterior(property)
    local vehicles = TriggerServerCallback("core:property:getVehiclesInGarage", token, selectedProperty.id)

    in_garage = true

    if PlayerHasAccessToProperty(selectedProperty) or PlayerCanSearchInProperty(selectedProperty) then

        -- Draw gestion marker
        zone.addZone(
            "property_gestion",
            vector3(property.gestion.x, property.gestion.y, property.gestion.z - 0.9),
            "Appuyez sur ~INPUT_CONTEXT~ pour accéder à la gestion de la propriété",
            function()
                OpenPropertyGestion(property)
            end,
            true,
            25,                 -- Id / type du marker
            0.6,                -- La taille
            { 51, 204, 255 },   -- RGB
            170                 -- Alpha
        )
        zone.addZone(
            "property_key",
            vector3(property.key.x, property.key.y, property.key.z),
            "Appuyez sur ~INPUT_CONTEXT~ pour accéder au coffre de clefs de la propriété",
            function()
                OpenInventoryProperty(
                    selectedProperty,   -- La propriété
                    ParseInventory(TriggerServerCallback("core:property:getPropertyInventory", token, selectedProperty.id)), -- L'inventaire de la propriété (formaté)
                    ParseInventory(p:getInventaire()),    -- L'inventaire du joueur (formaté)
                    "keys"
                )
            end,
            true,
            25,                 -- Id / type du marker
            0.6,                -- La taille
            { 51, 204, 255 },   -- RGB
            170                 -- Alpha
        )
    end
    zone.addZone(
        "property_leave",
        vector3(property.leave.x, property.leave.y, property.leave.z - 0.9),
        "Appuyez sur ~INPUT_CONTEXT~ pour sortir",
        function()
            for k, v in pairs(loaded_vehicles) do
                if DoesEntityExist(v.entity) then
                    DeleteEntity(v.entity)
                end
            end
            loaded_vehicles = {}
            in_garage = false
            LeaveGarage()
        end,
        true,
        25,                 -- Id / type du marker
        0.6,                -- La taille
        { 51, 204, 255 },   -- RGB
        170                 -- Alpha
    )

    -- Spawn the vehicles
    local up = 0
    for k, _veh in pairs(vehicles) do
        if property.vehPos[k] == nil then up = up + 1 end
        local veh = vehicle.createLocal(_veh.name, property.vehPos[k+up], _veh.props)
        if veh ~= nil then
            SetVehicleOnGroundProperly(veh)
            SetVehicleDoorsLocked(veh, 0)
            FreezeEntityPosition(veh, true)
            SetVehicleDirtLevel(veh, 0.0)
            SetVehicleNumberPlateText(veh, _veh.plate)
            table.insert(loaded_vehicles, {
                props = _veh.props,
                pos = property.vehPos[k+up],
                entity = veh,
                model = _veh.name,
                plate = _veh.plate
            })
        end
    end
end

-- NUI Callbacks

RegisterNUICallback("MenuProprieteAlt", function (data, cb)
    if data.type == "entrer" then
        -- Enter to the property
        if PlayerHasAccessToProperty(selectedProperty) or not IsPropertyLocked(selectedProperty) then
            TriggerServerEvent("core:InstancePlayer", token, selectedProperty.id, "Property : Ligne 775")
            TriggerServerEvent("core:AddPlayerInHouse", token, GetPlayerServerId(PlayerId()), selectedProperty.id)
            EnterProperty(selectedProperty)
        else
            -- Notify the player that he can't enter
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "~s Vous n'avez pas le droit de rentrer !"
            })
        end
    elseif data.type == "perquisitionner" then
        if PlayerCanSearchInProperty(property) then
            TriggerServerEvent("core:InstancePlayer", token, selectedProperty.id, "Property : Ligne 787")
            EnterProperty(selectedProperty)
        else
            -- Notify the player that he can't enter
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "~s Vous n'avez pas le droit de perquisitionner !"
            })
        end
    elseif data.type == "sonner" then 
        TriggerServerEvent("core:property:ring", token, selectedProperty.id)
    elseif data.button == "addToBoite" then
        closeUI()
        Wait(100)
        OpenMailBoxProperty(
            selectedProperty,                                                                               -- La propriété
            ParseInventory(TriggerServerCallback("core:property:getMailbox", token, selectedProperty.id)),  -- L'inventaire de la propriété (formaté)
            ParseInventory(p:getInventaire())                                                               -- L'inventaire du joueur (formaté)
        )
        -- This return prevent the UI to close after the mailbox is opened
        return
    end
    closeUI()
end)

RegisterNUICallback("MenuPropriete", function (data, cb)
    if data.type == "access" then
        -- data.value = "ouvert" | "fermer" | "sonnette"
        if data.value == "sonnette" then
            TriggerServerEvent("core:property:enterByDoorbell", token, selectedProperty.id)
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez ouvert la porte aux personnes qui sonnent"
            })
        else
            TriggerServerEvent("core:property:updateDoorState", token, selectedProperty.id, data.value == "ouvert")
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez ".. data.value .. " la porte"
            })
        end
    elseif data.type == "set_double" then
        -- Create a double to nearest player
        local nearestPlayer = ChoicePlayersInZone(3.0, false)
        if nearestPlayer ~= nil then
            TriggerServerEvent("core:property:addCoOwner", token, selectedProperty.id, GetPlayerServerId(nearestPlayer))
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez donné un double à ".. GetPlayerServerId(nearestPlayer)
            })
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "~s Aucun joueur à proximité !"
            })
        end
    elseif data.type == "revoke_access" then
        -- Remove access to nearest player
        local nearestPlayer = ChoicePlayersInZone(3.0, false)
        if nearestPlayer ~= nil then
            TriggerServerEvent("core:property:removeCoOwner", token, selectedProperty.id, GetPlayerServerId(nearestPlayer))
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez retiré l'accès à ".. GetPlayerServerId(nearestPlayer)
            })
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "~s Aucun joueur à proximité !"
            })
        end
    elseif data.type == "give_property" then
        local nearestPlayer = ChoicePlayersInZone(3.0, false)
        if nearestPlayer ~= nil then
            TriggerServerEvent("core:property:give", token, selectedProperty.id, GetPlayerServerId(nearestPlayer))
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez donné la propriété à ".. GetPlayerServerId(nearestPlayer)
            })
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "~s Aucun joueur à proximité !"
            })
        end
    elseif data.type == "delete_property" then
        if dutyproperty or p:getPermission() >= 3 then
            TriggerServerEvent("core:property:delete", token, selectedProperty.id)
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez supprimé la propriété"
            })
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous n'avez pas la permission de faire ça !"
            })
        end
    elseif data.type == "emptyMailbox" then
        TriggerServerEvent("core:property:emptyMailbox", token, selectedProperty.id)
        exports['vNotif']:createNotification({
            type = 'VERT',
            content = "Vous avez vidé la boîte aux lettres"
        })
    elseif data.rename then
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            content = "~s Cette action n'est plus disponible actuellement."
        })
    end
    closeUI()
end)

RegisterNUICallback("GestionPropriete", function (data, cb)
    if data.button then
        if data.button == "sell" then
            -- sell (the owner will buy the property to the real estate agency)
            TriggerServerEvent("core:property:updateRentDuration", token, selectedProperty.id, 3600)
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez vendu la propriété"
            })
        elseif data.button == "delete" then
            TriggerServerEvent("core:property:delete", token, selectedProperty.id)
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez supprimé la propriété"
            })
        elseif data.button == "giveDouble" then
            -- Create a double to nearest player
            local nearestPlayer = ChoicePlayersInZone(3.0, false)
            if nearestPlayer ~= nil then
                TriggerServerEvent("core:property:addCoOwner", token, selectedProperty.id, GetPlayerServerId(nearestPlayer))
                exports['vNotif']:createNotification({
                    type = 'VERT',
                    content = "Vous avez donné un double à ".. GetPlayerServerId(nearestPlayer)
                })
            else
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    content = "~s Aucun joueur à proximité !"
                })
            end
        end
    elseif data.submit then
        if data.submit.type then
            -- Update access type (entreprise, crew, "[]" as perso)
            if data.submit.type == "[]" then data.submit.type = "individuel" end
            TriggerServerEvent("core:property:updateType", token, selectedProperty.id, data.submit.type)
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez défini le type d'accès à ".. data.submit.type
            })
        end
        if data.submit.acces then
            if data.submit.acces == "ouvert" then
                TriggerServerEvent("core:property:updateDoorState", token, selectedProperty.id, true)
            else
                TriggerServerEvent("core:property:updateDoorState", token, selectedProperty.id, false)
            end
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez ".. data.submit.acces .." la porte"
            })
        end
        if data.submit.prolongation then
            TriggerServerEvent("core:property:updateRentDuration", token, selectedProperty.id, data.submit.prolongation)
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez prolongé la location de".. data.submit.prolongation .."jours"
            })
        end
    end
    exports['vNotif']:createNotification({
        type = 'VERT',
        content = "Mise à jour effectuée"
    })
    closeUI()
end)