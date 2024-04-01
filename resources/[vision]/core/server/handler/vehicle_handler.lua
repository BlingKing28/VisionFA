local vehiculesTmp = {}

local function LoadAllVehicle() -- done
    MySQL.Async.fetchAll('SELECT * FROM vehicles', {}, function(result)
        for k, v in pairs(result) do
            local veh = vehicle:new(v)
            --vehicles[v.plate] = veh
            --print(json.encode(veh))
        end
    end)
    CorePrint("Tous les vehicules de la bdd ont été load.")
end

MySQL.ready(function()
    Wait(1000)
    LoadAllVehicle()
end)

local function carIsInGarage(plate) -- done
    local propertyListPlate = AllPropertiesPlate()
    for k, v in pairs(propertyListPlate) do
        if v == plate then return true end
    end
    return false
end

function MarkVehicleAsNotSaved(source, plate) -- done
    local veh = GetVehicle(plate)
    if veh == nil then return end
    veh:setNeedSave(true)
end

function getAllVehicleFromId(id, crew, job) -- done replace of GetVehicleIndexFromPlate
    local vehList = {}
    local vehicles = GetAllVehiclesClass()
    for k, v in pairs(vehicles) do
        if v.owner == id or v.vente == crew or v.job == job then
            table.insert(vehList, v)
        else
            for kk, vv in ipairs(v.coowner) do
                if vv == id then
                    table.insert(vehList, v)
                    break
                end
            end
        end
    end
    return vehList
end

function getAllVehicleFromIdPounder(id, crew, job, needAll) -- done replace of GetVehicleIndexFromPlate
    local vehList = {}
    local vehicles = GetAllVehiclesClass()
    for k, v in pairs(vehicles) do
        if not v.tmp then
            if v.owner == id or v.vente == crew or v.job == job then
                if needAll then table.insert(vehList, v)
                else table.insert(vehList, {plate = v.plate, currentPlate = v.currentPlate, name = v.name, stored = v.stored, job = v.job, vente = v.vente}) end
            else
                for kk, vv in ipairs(v.coowner) do
                    if vv == id then
                        if needAll then table.insert(vehList, v)
                        else table.insert(vehList, {plate = v.plate, currentPlate = v.currentPlate, name = v.name, stored = v.stored, job = v.job, vente = v.vente}) end
                        break
                    end
                end
            end
        end
    end
    print(json.encode(vehList))
    return vehList
end

function givekeytmp(id, crew, job, src) -- done to delete after 1week
    CheckColumn()
    Wait(1000)
    local id = GetPlayer(src):getId()
    MySQL.Async.fetchAll('SELECT hasvoted FROM players WHERE id = ? LIMIT 1', { id }, function(result)
        if result[1].hasvoted == 0 then
            local vehicles = GetAllVehiclesClass()
            local grade = GetPlayer(src):getJobGrade()
            for k, v in pairs(vehicles) do
                if v.job == job then
                    if grade >= 4 then
                        TriggerClientEvent('core:createKeys', v.plate, v.name)
                    end
                elseif v.owner == id or v.vente == crew then
                    TriggerClientEvent('core:createKeys', src, v.plate, v.name)
                else
                    for kk, vv in ipairs(v.coowner) do
                        if vv == id then
                            TriggerClientEvent('core:createKeys', src, v.plate, v.name)
                            break
                        end
                    end
                end
            end
            MySQL.Async.execute('UPDATE players SET hasvoted = ? WHERE id = ?', { 1, id }, function() end)
            TriggerClientEvent("core:givekeyret", src, "VERT", "Vous avez recus vos clées!")
        else
            --TriggerClientEvent("core:givekeyret", src, "ROUGE", "Vous avez deja recus vos clées!")
        end
    end)
end

function SetVehicleInPounder(plate) -- done
    local veh = GetVehicle(plate)
    if veh == nil then return end
    veh:setVehiclePound(2)
end

function SetVehicleProps(plate, props) -- done
    local veh = GetVehicle(plate)
    if veh == nil then return end
    veh:setVehiclePropsClass(props)
end

function SendItemToVehicle(source, item, amount, plate, metadatas, coffresize) -- done
    local veh = GetVehicle(plate)
    local var, isfull = AddItemToInventoryVehicle(plate, item, tonumber(amount), metadatas, coffresize)
    veh:setNeedSave(true)
    MarkPlayerDataAsNonSaved(source)
    return var, isfull
end

function SendItemToVehicleStaff(source, item, amount, plate, metadatas) -- done
    local veh = GetVehicle(plate)
    AddItemToInventoryVehicleStaff(plate, item, tonumber(amount), metadatas)
    veh:setNeedSave(true)
    MarkPlayerDataAsNonSaved(source)
end

function RemoveItemFromVehicle(source, item, amount, plate, metadatas) -- done
    local veh = GetVehicle(plate)
    if item == "bike" then
        RemoveItemToVehicleBike(plate, item, tonumber(amount), metadatas)
    elseif item == "identitycard" then
        RemoveItemToVehicleIdentity(plate, item, tonumber(amount), metadatas)
    else
        RemoveItemToVehicle(plate, item, tonumber(amount), metadatas)
    end
    veh:setNeedSave(true)
    MarkPlayerDataAsNonSaved(source)
end

function newVeh(plate, model, entity, netId, tmp, trunk)
    local veh = {}
    veh.plate = plate
    veh.owner = nil
    veh.name = model
    veh.props = json.encode({})
    veh.garage = nil
    veh.stored = nil
    veh.vente = nil
    veh.coowner = json.encode({})
    veh.job = nil
    if trunk then
        veh.inventory = json.encode(trunk)
    else
        if coffre[GetHashKey(model)] ~= nil and coffre[GetHashKey(model)] / 1000 ~= nil then
            veh.inventory = json.encode({item={}, cloths={}, weapons={}, weight={max=coffre[GetHashKey(model)] / 1000, current=0}})
        else
            veh.inventory = json.encode({item={}, cloths={}, weapons={}, weight={max=100, current=0}})
        end
    end
    veh.mileage = nil
    veh.fuel = nil
    veh.body = json.encode({})
    veh.currentPlate = plate
    veh.needSave = false
    veh.netId = netId
    veh.entity = entity
    veh.usedTrunk = nil
    veh.tmpVeh = tmp
    return vehicle:new(veh, tmp)
end

function carDealerCreateCar(data)
    return vehicle:new(data)
end

Citizen.CreateThread(function()
    while RegisterServerCallback == nil do
        Wait(1000)
    end

    RegisterServerCallback("core:NewVehJob", function(source, plate, model, entity, netId, job) -- done
        local veh = {}
        veh.plate = plate
        veh.owner = job == nil and GetPlayer(source):GetId() or nil
        veh.name = model
        veh.props = json.encode({})
        veh.garage = nil
        veh.stored = nil
        veh.vente = nil
        veh.coowner = json.encode({})
        veh.job = job
        if coffre[GetHashKey(model)] ~= nil and coffre[GetHashKey(model)] / 1000 ~= nil then
            veh.inventory = json.encode({item={}, cloths={}, weapons={}, weight={max=coffre[GetHashKey(model)] / 1000, current=0}})
        else
            veh.inventory = json.encode({item={}, cloths={}, weapons={}, weight={max=100, current=0}})
        end        
        veh.mileage = nil
        veh.fuel = nil
        veh.body = json.encode({})
        veh.currentPlate = plate
        veh.needSave = false
        veh.netId = netId
        veh.entity = entity
        veh.usedTrunk = nil
        veh.tmpVeh = true
    
        return vehicle:new(veh, true)
    end)

    RegisterServerCallback("core:GetVehicleInventory", function(source, plate, model, entity, netId) -- done
        if (GetVehicle(plate) == nil) then
            newVeh(plate, model, entity, netId, true)
        end
        return GetVehicle(plate):getInventory().item
    end)

    RegisterServerCallback("core:setTmpVehOut", function(source, plate, model, entity, netId, trunk) -- done
        newVeh(plate, model, entity, netId, true, trunk)
        return true
    end)

    RegisterServerCallback('core:GetVehicles', function(source) -- done
        local id = GetPlayer(source):getId()
        local crew = GetPlayer(source):getCrew()
        local job = GetPlayer(source):getJob()
        return getAllVehicleFromId(id, crew, job)
    end)

    RegisterServerCallback('core:GetVehiclesInPound', function(source) -- done
        local id = GetPlayer(source):getId()
        local crew = GetPlayer(source):getCrew()
        local job = GetPlayer(source):getJob()
        local vehicles = getAllVehicleFromIdPounder(id, crew, job, true)
        local veh = {}
        for k, v in pairs(vehicles) do
            if not IsVehicleInGarage(v.plate) then
                table.insert(veh, v)
            end
        end
        return veh
    end)

    RegisterServerCallback('core:getOriginPlate', function(source, plate) -- done
        local vehicles = GetAllVehiclesClass()
        for k, v in pairs(vehicles) do
            if v.currentPlate == plate then
                return v.plate
            end
        end
        return nil
    end)

    RegisterServerCallback('core:AllGetVehicles', function(source) -- done
        return GetAllVehiclesClass() -- return any
    end)

    RegisterServerCallback('core:GetAllVehPounder', function(source, target, needAll) -- done
        local id = GetPlayer(target):getId()
        local crew = GetPlayer(target):getCrew()
        local job = GetPlayer(target):getJob()
        return getAllVehicleFromIdPounder(id, crew, job, needAll)
    end)
end)

-- RegisterNetEvent("core:CloseVehicleChest")
-- AddEventHandler("core:CloseVehicleChest", function(plate) -- delete useless
--     RemovePlayerFromInventoryRefresh(plate, source)
-- end)

RegisterNetEvent("core:SetPropsVeh")
AddEventHandler("core:SetPropsVeh", function(token, plate, props) -- done
    if CheckPlayerToken(source, token) then
        SetVehicleProps(plate, props)
    end
end)

RegisterNetEvent("core:AddItemToVehicle")
AddEventHandler("core:AddItemToVehicle", function(token, item, amount, plate, metadatas) -- done
    local source = source
    if CheckPlayerToken(source, token) then
        local itemWeight = GetItemWeightWithCount(item, amount)
        local entity
        for k, v in pairs(GetAllVehicles()) do
            if all_trim(GetVehicleNumberPlateText(v)) == plate then
                entity = v
            end
        end
        if getInventoryWeightVehicle(plate) + itemWeight <= coffre[GetEntityModel(entity)] then
            SendItemToVehicle(source, item, amount, plate, metadatas, coffre[GetEntityModel(entity)]/1000)
        end
    end
end)

RegisterNetEvent("core:AddItemToVehicleStaff")
AddEventHandler("core:AddItemToVehicleStaff", function(token, item, amount, plate, metadatas) -- done
    local source = source
    if CheckPlayerToken(source, token) then
        SendItemToVehicleStaff(source, item, amount, plate, metadatas)
    end
end)

RegisterNetEvent("core:RemoveItemFromVehicle")
AddEventHandler("core:RemoveItemFromVehicle", function(token, item, amount, plate, name) -- done
    if CheckPlayerToken(source, token) then
        local itemWeight = GetItemWeightWithCount(item, amount)
        if getInventoryWeight(source) + itemWeight <= items.maxWeight or item == "money" then
            RemoveItemFromVehicle(source, item, amount, plate, name)
        end
    end
end)

RegisterNetEvent("core:SetVehicleOut")
AddEventHandler("core:SetVehicleOut", function(plate, netId, entity) -- done
    local veh = GetVehicle(plate)
    if veh == nil then
        print("No vehicle SetVehicleOut")
        return
    end
    veh:setVehicleOut(netId, entity)
end)

RegisterNetEvent("core:removeVeh")
AddEventHandler("core:removeVeh", function(plate) -- done
    local veh = GetVehicle(plate)
    if veh == nil then
        print("No vehicle removeVeh")
        return
    end
    RemoveVehicle(plate)
end)

RegisterNetEvent("core:SetVehicleIn")
AddEventHandler("core:SetVehicleIn", function(plate) -- done
    local veh = GetVehicle(plate)
    if veh == nil then
        print("No vehicle SetVehicleIn")
        return false
    end
    veh:setVehicleIn()
    return true
end)

RegisterServerCallback('core:SetVehicleIn', function(plate) -- done
    local veh = GetVehicle(plate)
    if veh == nil then
        print("No vehicle SetVehicleIn")
        return false
    end
    veh:setVehicleIn()
    return true
end)

RegisterServerCallback('core:ChangePlateVeh', function(source, plate, newPlate, model) -- done
    local source = source
    local veh = GetVehicle(plate)

    if veh == nil then return false end

    veh:changePlate(newPlate)

    SendDiscordLog("plate", source, string.sub(GetDiscord(source), 9, -1), GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(), model, plate, newPlate)

    return true
end)

RegisterServerCallback("core:AddItemToVehicle", function(source, token, item, amount, plate, metadatas) -- done
    local source = source
    if CheckPlayerToken(source, token) then
        local itemWeight = GetItemWeightWithCount(item, amount)
        local veh = GetVehicle(plate)
        local entity
        for k, v in pairs(GetAllVehicles()) do
            if all_trim(GetVehicleNumberPlateText(v)) == plate then
                entity = v
            end
        end
        if coffre[GetEntityModel(entity)] == nil then
            TriggerClientEvent("core:noCarCoffre", source, GetEntityModel(entity))
        else
            if getInventoryWeightVehicle(plate) + itemWeight <= coffre[GetEntityModel(entity)] then
                local bool, isfull = SendItemToVehicle(source, item, amount, plate, metadatas, coffre[GetEntityModel(entity)]/1000)
                if isfull then 
                    -- TriggerClientEvent("core:ShowNotification", source, "Le coffre du véhicule est ~r~plein~s~.") 

                    TriggerClientEvent("__vision::createNotification", source, {
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~c Le coffre du véhicule est ~s plein "
                    })
                end
                return bool
            end
        end
        return false
    end
    return false
end)

-- @Loops

Citizen.CreateThread(function()  -- done
    local vehicles
    while true do
        Wait(5 * 60000) -- 5min
        vehicles = GetAllVehiclesClass()
        for k, v in pairs(vehicles) do
            if v.needSave then
                v:saveVehicle()
            end
        end
    end
end)

Citizen.CreateThread(function()  -- done
    local veh
    local vehicles
    Wait(1 * 60000) -- 1min
    while true do
        vehicles = GetAllVehiclesClass()
        for k, v in pairs(vehicles) do
            veh = GetVehicle(v.currentPlate)
            if veh ~= nil then
                if veh.tmpVeh == false then
                    if not DoesEntityExist(NetworkGetEntityFromNetworkId(veh:getNetId())) then
                        local isInGarage = carIsInGarage(veh:getPlate())
                        if v.stored == 1 then
                            if isInGarage == false then
                                print("pounded", v.currentPlate)
                                veh:setVehiclePound(2)
                            end
                        elseif v.stored == 2 then
                            if isInGarage == true then
                                print("unpounded", v.currentPlate)
                                veh:setVehiclePound(1)
                            end
                        end
                    end
                else
                    if not DoesEntityExist(NetworkGetEntityFromNetworkId(veh:getNetId())) then
                        local isInGarage = carIsInGarage(veh:getPlate())
                        print("is", isInGarage)
                        if isInGarage == false then
                            print("pounded tmp veh", v.currentPlate)
                            RemoveVehicle(v.currentPlate)
                        end
                    end
                end
            end
        end
        Wait(15 * 60000) -- 5min
    end
end)

RegisterNetEvent("core:SyncInvVeh")
AddEventHandler("core:SyncInvVeh", function(token, Plate, model)  -- rework with class + -1 to change
    if CheckPlayerToken(source, token) then
        TriggerClientEvent("core:SyncInvVeh", -1, Plate, model)
    end
end)

RegisterServerCallback('core:plateExist', function(source, plate)  -- done
    local vehicles = GetAllVehiclesClass()
    for k, v in pairs(vehicles) do
        if v.currentPlate == plate or v.plate == plate then
            return true
        end
    end
    return false
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        CorePrint("Resource stopping, saving vehicles.")
        local vehicles
        vehicles = GetAllVehiclesClass()
        for k, v in pairs(vehicles) do
            if v.tmpVeh == false then
                v:saveVehicle()
            end
        end
    end
end)