local token = nil
local societyInventory = {}
societyInventory.item = {}
societyInventory.cloths = {}
local weapons = {}
local items = {}
local itemsSociety = {}
local itemsVehicle = {}
local itemsProperty = {}
local vehWeight = 80
local propertyName = nil
local lockCar = false
local _property = nil
Society = false
Police = true
Vehicle = false
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

RegisterNetEvent("core:RefreshSocietyInventory")
AddEventHandler("core:RefreshSocietyInventory", function(inventory)
    societyInventory = inventory
end)
Vehicle = false
local casierJob = nil
local numberCasier = nil
local open = false

CreateThread(function()
    while true do
        Wait(0)
        if open then
            DisableControlAction(0, 24, true) -- disable attack
            DisableControlAction(0, 25, true) -- disable aim
            DisableControlAction(0, 1, true) -- LookLeftRight
            DisableControlAction(0, 2, true) -- LookUpDown
            DisableControlAction(0, 142, open)
            DisableControlAction(0, 18, open)
            DisableControlAction(0, 322, open)
            DisableControlAction(0, 106, open)
            DisableControlAction(0, 263, true) -- disable melee
            DisableControlAction(0, 264, true) -- disable melee
            DisableControlAction(0, 257, true) -- disable melee
            DisableControlAction(0, 140, true) -- disable melee
            DisableControlAction(0, 141, true) -- disable melee
            DisableControlAction(0, 142, true) -- disable melee
            DisableControlAction(0, 143, true) -- disable melee
        end
    end
end)

function OpenInventorySocietyMenu(capacity)
    if open then
        open = false
        SetNuiFocusKeepInput(false)
        EnableControlAction(0, 1, true)
        EnableControlAction(0, 24, true)
        EnableControlAction(0, 25, true)
        EnableControlAction(0, 2, true)
        EnableControlAction(0, 142, true)
        EnableControlAction(0, 18, true)
        EnableControlAction(0, 322, true)
        EnableControlAction(0, 106, true)
        SetNuiFocus(false, false)
        openRadarProperly()
        SendNuiMessage(json.encode({
            type = 'closeWebview'
        }))
        return
    else
        open = true
        if loadedJob.grade[pJobGrade] ~= nil then
            if loadedJob.grade[pJobGrade].coffre ~= nil then
                if loadedJob.grade[pJobGrade].coffre then
                    local invSociety = TriggerServerCallback("core:GetSocietyInventoryItem", pJob)
                    local inv = p:getInventaire()
                    items = {}
                    local clothes = {}
                    weapons = {}
                    itemsSociety = {}
                    for k, v in pairs(inv) do
                        if v.type == "items" or v.type == "weapons" or v.type == "clothes" then
                            table.insert(items,
                                { name = v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows,
                                    type = v.type,
                                    metadatas = v.metadatas, weight = v.weight })
                        elseif v.type == "clothes" then
                            -- table.insert(clothes,
                            --     { name = k, count = v.count, label = v.label, cols = v.cols, rows = v.rows, type = v.type,
                            --         metadatas = v.metadatas })
                        elseif v.type == "weapons" then
                            -- table.insert(weapons,
                            --     { name =  v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows, type = v.type,
                            --         metadatas = v.metadatas })
                        end
                    end
                    for k, v in pairs(invSociety) do
                        if v.type == "items" or v.type == "weapons" then
                            table.insert(itemsSociety,
                                { name = v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows,
                                    type = v.type,
                                    metadatas = v.metadatas, weight = v.weight })
                        end
                    end
                    Society = true
                    Vehicle = false
                    Casier = false
                    Police = false
                    PropertyCoffre = false
                    Citizen.CreateThread(function()
                        SendNUIMessage({
                            type = "openWebview",
                            name = "inventory",
                            data = { items = items, clothes = {}, weapons = Weapons,
                                target = { items = itemsSociety, maxWeight = capacity and capacity or 1000.0, name = "Coffre " .. pJob } }
                        })
                    end)

                else

                    -- ShowNotification("Tu n'as pas accès au coffre de cette société")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Tu n'as ~s pas accès au coffre ~c de cette société"
                    })

                    open = false
                    SetNuiFocusKeepInput(false)
                    EnableControlAction(0, 1, true)
                    EnableControlAction(0, 24, true)
                    EnableControlAction(0, 25, true)
                    EnableControlAction(0, 2, true)
                    EnableControlAction(0, 142, true)
                    EnableControlAction(0, 18, true)
                    EnableControlAction(0, 322, true)
                    EnableControlAction(0, 106, true)
                    SetNuiFocus(false, false)
                    --DisplayRadar(true)
                    SendNuiMessage(json.encode({
                        type = 'closeWebview'
                    }))
                    return
                end
            end
        end
    end
end

local clothes = {}
function OpenInventoryVehicle(Plate, model, entity)
    local invVehicle = TriggerServerCallback("core:GetVehicleInventory", Plate, model, entity, VehToNet(entity))
    ExecuteCommand("me ouvre le coffre")
    local inv = p:getInventaire()
    items = {}
    clothes = {}
    weapons = {}
    itemsVehicle = {}
    for k, v in pairs(inv) do
        if v.type == "items" or v.type == "weapons" or v.type == "clothes" then
            table.insert(items,
                { name = v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows, type = v.type,
                    metadatas = v.metadatas, weight = v.weight })
        end
    end
    for k, v in pairs(invVehicle) do
        if v.type == "items" or v.type == "weapons" or v.type == "clothes" then
            table.insert(itemsVehicle,
                { name = v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows, type = v.type,
                    metadatas = v.metadatas, weight = v.weight })
        end
    end

    Vehicle = true
    Society = false
    Casier = false
    Police = false
    PropertyCoffre = false
    Citizen.CreateThread(function()
        local name = GetLabelText(GetDisplayNameFromVehicleModel(model))
        if coffre[model] ~= nil then
            SendNUIMessage({
                type = "openWebview",
                name = "inventory",
                data = { items = items, clothes = {}, weapons = Weapons,
                    target = { items = itemsVehicle, maxWeight = coffre[model] / 1000, name = "Coffre " .. name } }
            })
        else
            SendNUIMessage({
                type = "openWebview",
                name = "inventory",
                data = { items = items, clothes = {}, weapons = Weapons,
                    target = { items = itemsVehicle, maxWeight = 100, name = "Coffre " .. name } }
            })
        end
    end)
end

function OpenInventoryProperty(property, property_inventory, player_inventory)
    Vehicle = false
    Society = false
    Casier = false
    Police = false
    PropertyCoffre = true

    _property = property

    if open then
        open = false
        SetNuiFocusKeepInput(false)
        EnableControlAction(0, 1, true)
        EnableControlAction(0, 24, true)
        EnableControlAction(0, 25, true)
        EnableControlAction(0, 2, true)
        EnableControlAction(0, 142, true)
        EnableControlAction(0, 18, true)
        EnableControlAction(0, 322, true)
        EnableControlAction(0, 106, true)
        SetNuiFocus(false, false)
        --DisplayRadar(true)
        SendNuiMessage(json.encode({
            type = 'closeWebview'
        }))
        return
    else
        open = true
        SendNUIMessage({
            type = "openWebview",
            name = "inventory",
            data = {
                items = player_inventory,
                clothes = {},
                weapons = {},
                target = {
                    items = property_inventory,
                    maxWeight = property.weight,
                    name = "Propriété " .. property.name
                }
            }
        })
    end
end

function OpenMailBoxProperty(property, property_mailbox, player_inventory)

    _property = property

    if open then
        open = false
        SetNuiFocusKeepInput(false)
        EnableControlAction(0, 1, true)
        EnableControlAction(0, 24, true)
        EnableControlAction(0, 25, true)
        EnableControlAction(0, 2, true)
        EnableControlAction(0, 142, true)
        EnableControlAction(0, 18, true)
        EnableControlAction(0, 322, true)
        EnableControlAction(0, 106, true)
        SetNuiFocus(false, false)
        SendNuiMessage(json.encode({
            type = 'closeWebview'
        }))
        return
    else
        open = true
        Vehicle = false
        Society = false
        Casier = false
        Police = false
        PropertyCoffre = false
        MailBox = true
        SendNUIMessage({
            type = "openWebview",
            name = "inventory",
            data = {
                items = player_inventory,
                clothes = {},
                weapons = {},
                target = {
                    items = property_mailbox,
                    maxWeight = 3.0,
                    name = "Boite aux lettres de : " .. _property.name 
                }
            } 
        })
    end
end

function OpenInventoryCasier(job, id)
    if open then
        open = false
        SetNuiFocusKeepInput(false)
        EnableControlAction(0, 1, true)
        EnableControlAction(0, 24, true)
        EnableControlAction(0, 25, true)
        EnableControlAction(0, 2, true)
        EnableControlAction(0, 142, true)
        EnableControlAction(0, 18, true)
        EnableControlAction(0, 322, true)
        EnableControlAction(0, 106, true)
        SetNuiFocus(false, false)
        --DisplayRadar(true)
        SendNuiMessage(json.encode({
            type = 'closeWebview'
        }))
        return
    else
        open = true
        casierJob = job
        numberCasier = id
        local casier = TriggerServerCallback("core:GetInventoryCasierByid", casierJob, numberCasier)

        local inv = p:getInventaire()
        items = {}
        clothes = {}
        weapons = {}
        itemsVehicle = {}
        for k, v in pairs(inv) do
            if v.type == "items" or v.type == "weapons" or v.type == "clothes" then
                table.insert(items,
                    { name = v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows, type = v.type,
                        metadatas = v.metadatas, weight = v.weight })
            end
        end
        for k, v in pairs(casier) do
            if v.type == "items" or v.type == "weapons" or v.type == "clothes" then
                table.insert(itemsVehicle,
                    { name = v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows, type = v.type,
                        metadatas = v.metadatas, weight = v.weight })
            end
        end

        Society = false
        Vehicle = false
        Police = false
        PropertyCoffre = false
        Casier = true
        Citizen.CreateThread(function()
            SendNUIMessage({
                type = "openWebview",
                name = "inventory",
                data = { items = items, clothes = {}, weapons = Weapons,
                    target = { items = itemsVehicle, maxWeight = 500, name = "Casier " .. job .. " n°" .. id } }
            })
        end)
    end
end

local lastIdpolice = nil
local lastNamePolice = nil
function OpenInventoryPolicePlayer(entity, data)
    if open then
        open = false
        SetNuiFocusKeepInput(false)
        EnableControlAction(0, 1, true)
        EnableControlAction(0, 24, true)
        EnableControlAction(0, 25, true)
        EnableControlAction(0, 2, true)
        EnableControlAction(0, 142, true)
        EnableControlAction(0, 18, true)
        EnableControlAction(0, 322, true)
        EnableControlAction(0, 106, true)
        SetNuiFocus(false, false)
        --DisplayRadar(true)
        SendNuiMessage(json.encode({
            type = 'closeWebview'
        }))
        return
    else
        open = true
        ExecuteCommand("me fouille la personne")
        RequestAnimDict('custom@police')
            while not HasAnimDictLoaded('custom@police') do
                Wait(0)
            end
        p:PlayAnim('random@train_tracks', 'idle_e', 1)
        
        local casier = TriggerServerCallback("core:GetInventoryPlayerPolice", token, entity)
        lastIdpolice = entity
        lastNamePolice = data
        local inv = p:getInventaire()
        items = {}
        clothes = {}
        weapons = {}
        itemsVehicle = {}
        for k, v in pairs(inv) do
            if v.type == "items" or v.type == "weapons" or v.type == "clothes" then
                table.insert(items,
                    { name = v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows, type = v.type,
                        metadatas = v.metadatas, weight = v.weight })
            end
        end
        for k, v in pairs(casier) do
            if v.type == "items" or v.type == "weapons" or v.type == "clothes" then
                table.insert(itemsVehicle,
                    { name = v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows, type = v.type,
                        metadatas = v.metadatas, weight = v.weight })
            end
        end

        Society = false
        Vehicle = false
        Casier = false
        PropertyCoffre = false
        Police = true
        Citizen.CreateThread(function()
            SendNUIMessage({
                type = "openWebview",
                name = "inventory",
                data = { items = items, clothes = {}, weapons = Weapons,
                    target = { items = itemsVehicle, maxWeight = 25.0, name = data.nom} }
            })
        end)

        Modules.UI.RealWait(8000)
        ClearPedTasks(p:ped())
    end

end

RegisterNUICallback('inventory-put-item', function(data, cb)
    if data.quantity > 0 then
        for k, v in pairs(TriggerServerCallback("core:GetInventory", token)) do

            if v.name == data.item.name then

                if v.count >= data.quantity then

                    if Society then
                        if data.item ~= nil then

                            local approuved = TriggerServerCallback("core:addItemToInventorySociety", token, pJob,
                                data.item.name, data.quantity, data.item.metadatas)
                            if approuved then
                                for i = 1, 4 do
                                    if Weapons[i] ~= nil then
                                        if data.item.name == Weapons[i].name and
                                            json.encode(data.item.metadatas) == json.encode(Weapons[i].metadatas) then
                                            if HasPedGotWeapon(p:ped(), GetHashKey(data.item.name), false) then
                                                data.item.metadatas.ammo = GetAmmoInPedWeapon(p:ped(),
                                                    GetHashKey(data.item.name))
                                            end
                                            weaponOut = false
                                            RemoveAllPedWeapons(p:ped(), 1)
                                            Weapons[i] = nil
                                        end
                                    end
                                end
                                TriggerServerEvent("core:SetWeaponSave", token, Weapons)
                                TriggerServerEvent("core:RemoveItemToInventory", token, data.item.name, data.quantity,
                                    data.item.metadatas)
                            end
                            local inv = TriggerServerCallback("core:GetSocietyInventoryItem", pJob)
                            local pInv = TriggerServerCallback("core:GetInventory", token)
                            itemsSociety = {}

                            for k, v in pairs(inv) do
                                table.insert(itemsSociety,
                                    { name = v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows,
                                        type = v.type,
                                        metadatas = v.metadatas, weight = v.weight })

                            end
                            -- TriggerServerEvent("core:UpdateInventoryforall", token, itemsSociety, nil, nil, nil)

                            SendNUIMessage({
                                type = "updateInventory",
                                data = { items = pInv, clothes = {}, weapons = weapons,
                                    target = { items = itemsSociety, maxWeight = 1000, name = "Coffre " .. pJob } }
                            })
                            return
                        end
                    end
                    if Vehicle then
                        if data.item ~= nil then
                            local invVehicle

                            local closestVeh, closestDist = GetClosestVehicle(p:pos())
                            local model = GetEntityModel(closestVeh)

                            if #(p:pos() - GetWorldPositionOfEntityBone(closestVeh,
                                GetEntityBoneIndexByName(closestVeh, "platelight"))) then
                                local Plate = vehicle.getProps(closestVeh).plate
                                local removeItem = TriggerServerCallback("core:AddItemToVehicle", token, data.item.name,
                                    data.quantity, tostring(Plate), data.item.metadatas)
                                if removeItem then
                                    for i = 1, 4 do
                                        if Weapons[i] ~= nil then
                                            if data.item.name == Weapons[i].name and
                                                json.encode(data.item.metadatas) == json.encode(Weapons[i].metadatas) then
                                                if HasPedGotWeapon(p:ped(), GetHashKey(data.item.name), false) then
                                                    data.item.metadatas.ammo = GetAmmoInPedWeapon(p:ped(),
                                                        GetHashKey(data.item.name))
                                                end
                                                weaponOut = false
                                                RemoveAllPedWeapons(p:ped(), 1)
                                                Weapons[i] = nil
                                            end
                                        end
                                    end
                                    TriggerServerEvent("core:SetWeaponSave", token, Weapons)
                                    TriggerServerEvent("core:RemoveItemToInventory", token, data.item.name, data.quantity, data.item.metadatas)
                                end
                                invVehicle = TriggerServerCallback("core:GetVehicleInventory", Plate, nil, nil, nil)



                                local pInv = TriggerServerCallback("core:GetInventory", token)

                                itemsVehicle = {}

                                for k, v in pairs(invVehicle) do
                                    table.insert(itemsVehicle,
                                        { name = v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows,
                                            type = v.type,
                                            metadatas = v.metadatas, weight = v.weight })

                                end

                                if coffre[model] ~= nil then
                                    SendNUIMessage({
                                        type = "updateInventory",
                                        data = { items = pInv, clothes = {}, weapons = weapons,
                                            target = { items = itemsVehicle, maxWeight = coffre[model] / 1000,
                                                name = "Coffre " ..
                                                    GetLabelText(GetDisplayNameFromVehicleModel(model)) } }
                                    })
                                else
                                    SendNUIMessage({
                                        type = "updateInventory",
                                        data = { items = pInv, clothes = {}, weapons = weapons,
                                            target = { items = itemsVehicle, maxWeight = 100,
                                                name = "Coffre " ..
                                                    GetLabelText(GetDisplayNameFromVehicleModel(model)) } }
                                    })
                                end
                            end
                            return
                        end
                    end
                    if Casier then
                        if data.item ~= nil then
                            local casier = TriggerServerCallback("core:addItemToInventoryCasier", token, casierJob,
                                numberCasier, data.item.name, data.quantity, data.item.metadatas)
                            if casier then
                                for i = 1, 4 do
                                    if Weapons[i] ~= nil then
                                        if data.item.name == Weapons[i].name and
                                            json.encode(data.item.metadatas) == json.encode(Weapons[i].metadatas) then
                                            if HasPedGotWeapon(p:ped(), GetHashKey(data.item.name), false) then
                                                data.item.metadatas.ammo = GetAmmoInPedWeapon(p:ped(),
                                                    GetHashKey(data.item.name))
                                            end
                                            weaponOut = false
                                            RemoveAllPedWeapons(p:ped(), 1)
                                            Weapons[i] = nil
                                        end
                                    end
                                end
                                TriggerServerEvent("core:SetWeaponSave", token, Weapons)
                                TriggerServerEvent("core:RemoveItemToInventory", token, data.item.name, data.quantity,
                                    data.item.metadatas)
                            end
                            local inv = TriggerServerCallback("core:GetInventoryCasierByid", casierJob, numberCasier)
                            local pInv = TriggerServerCallback("core:GetInventory", token)
                            itemsSociety = {}
                            for k, v in pairs(inv) do
                                table.insert(itemsSociety,
                                    { name = v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows,
                                        type = v.type,
                                        metadatas = v.metadatas, weight = v.weight })

                            end
                            -- TriggerServerEvent("core:UpdateInventoryforall", token, nil, nil, nil, itemsSociety)

                            SendNUIMessage({
                                type = "updateInventory",
                                data = { items = pInv, clothes = {}, weapons = weapons,
                                    target = { items = itemsSociety, maxWeight = 500,
                                        name = "Casier " .. casierJob .. " n°" .. numberCasier } }
                            })
                            return
                        end

                    end
                    if PropertyCoffre then
                        if data.item ~= nil then
                            local approuved = TriggerServerCallback("core:addItemToInventoryProperty", token, _property.id, data.item, data.quantity)
                            if approuved then
                                for i = 1, 4 do
                                    if Weapons[i] ~= nil then
                                        if data.item.name == Weapons[i].name and
                                            json.encode(data.item.metadatas) == json.encode(Weapons[i].metadatas) then
                                            if HasPedGotWeapon(p:ped(), GetHashKey(data.item.name), false) then
                                                data.item.metadatas.ammo = GetAmmoInPedWeapon(p:ped(),
                                                    GetHashKey(data.item.name))
                                            end
                                            weaponOut = false
                                            RemoveAllPedWeapons(p:ped(), 1)
                                            Weapons[i] = nil
                                        end
                                    end
                                end
                                TriggerServerEvent("core:SetWeaponSave", token, Weapons)
                                TriggerServerEvent("core:RemoveItemToInventory", token, data.item.name, data.quantity, data.item.metadatas)
                                return
                            end
                        end
                    end
                    if MailBox then
                        if data.item ~= nil then
                            local approuved = TriggerServerCallback("core:property:addItemToMailBox", token, _property.id, data.item, data.quantity)
                            if approuved then
                                for i = 1, 4 do
                                    if Weapons[i] ~= nil then
                                        if data.item.name == Weapons[i].name and
                                            json.encode(data.item.metadatas) == json.encode(Weapons[i].metadatas) then
                                            if HasPedGotWeapon(p:ped(), GetHashKey(data.item.name), false) then
                                                data.item.metadatas.ammo = GetAmmoInPedWeapon(p:ped(),
                                                    GetHashKey(data.item.name))
                                            end
                                            weaponOut = false
                                            RemoveAllPedWeapons(p:ped(), 1)
                                            Weapons[i] = nil
                                        end
                                    end
                                end
                                TriggerServerEvent("core:SetWeaponSave", token, Weapons)
                                TriggerServerEvent("core:RemoveItemToInventory", token, data.item.name, data.quantity, data.item.metadatas)
                                Wait(100)
                            end
                            SendNUIMessage({
                                type = "updateInventory",
                                data = {
                                    items = p:getInventaire(),
                                    clothes = {},
                                    weapons = weapons,
                                    target = {
                                        items = TriggerServerCallback("core:property:getMailBox", token, _property.id),
                                        maxWeight = 3.0,
                                        name =  "Boite aux lettres de : " .. propertyName.name
                                    }
                                }
                            })
                            return
                        end
                    end
                end
            end
        end
    end
end)

 -- A optimiser
RegisterNUICallback('inventory-take-item', function(data, cb)
    if data.quantity > 0 then
        if Police then
            if data.item ~= nil then
                local inv = TriggerServerCallback("core:GetInventoryPlayerPolice", token, lastIdpolice)
                local pInv = TriggerServerCallback("core:GetInventory", token)
                for k, v in pairs(inv) do
                    if v.name == data.item.name and data.quantity <= v.count then
                        local poulice = TriggerServerCallback("core:RemoveItemToInventoryPolice", token, lastIdpolice,
                            data.item.name, data.quantity, data.item.metadatas)
                        if poulice then
                            TriggerSecurGiveEvent("core:addItemToInventory", token, data.item.name, data.quantity,
                                data.item.metadatas)
                            goto finshPolice
                        end

                    end
                end
                ::finshPolice::
                inv = TriggerServerCallback("core:GetInventoryPlayerPolice", token, lastIdpolice)
                pInv = TriggerServerCallback("core:GetInventory", token)
                ExecuteCommand("me vous confisque quelque chose")

                itemsSociety = {}
                for k, v in pairs(inv) do
                    table.insert(itemsSociety,
                        { name = v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows, type = v.type,
                            metadatas = v.metadatas, weight = v.weight })

                end

                SendNUIMessage({
                    type = "updateInventory",
                    data = { items = pInv, clothes = {}, weapons = weapons,
                        target = { items = itemsSociety, maxWeight = 25.0,
                            name = lastNamePolice.nom} }
                })
            end
        end
        if Society then
            if data.item ~= nil then
                local inv = TriggerServerCallback("core:GetSocietyInventoryItem", pJob)
                local pInv = TriggerServerCallback("core:GetInventory", token)

                for k, v in pairs(inv) do
                    if v.name == data.item.name and data.quantity <= v.count then
                        local societer = TriggerServerCallback("core:RemoveItemToInventorySociety", token, pJob,
                            data.item.name, data.quantity, data.item.metadatas)
                        if societer then
                            TriggerSecurGiveEvent("core:addItemToInventory", token, data.item.name, data.quantity,
                                data.item.metadatas)
                            goto finshSociety
                        end
                    end
                end

                ::finshSociety::
                inv = TriggerServerCallback("core:GetSocietyInventoryItem", pJob)
                pInv = TriggerServerCallback("core:GetInventory", token)

                itemsSociety = {}
                for k, v in pairs(inv) do
                    table.insert(itemsSociety,
                        { name = v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows, type = v.type,
                            metadatas = v.metadatas, weight = v.weight })

                end
                SendNUIMessage({
                    type = "updateInventory",
                    data = { items = pInv, clothes = {}, weapons = weapons,
                        target = { items = itemsSociety, maxWeight = 1000, name = "Coffre " .. pJob } }
                })
                -- TriggerServerEvent("core:UpdateInventoryforall", token, itemsSociety, nil, nil, nil)
            end
        end
        if Vehicle then
            print(json.encode(data))
            if data.item ~= nil then
                local invVehicle
                local closestVeh, closestDist = GetClosestVehicle(p:pos())
                local model = GetEntityModel(closestVeh)

                if #(p:pos() - GetWorldPositionOfEntityBone(closestVeh,
                    GetEntityBoneIndexByName(closestVeh, "platelight"))) then
                    Plate = vehicle.getProps(closestVeh).plate
                    invVehicle = TriggerServerCallback("core:GetVehicleInventory", Plate, nil, nil, nil)
                    local pInv = TriggerServerCallback("core:GetInventory", token)
                    for k, v in pairs(invVehicle) do
                        print(json.encode(v))
                        if v.name == data.item.name and data.quantity <= v.count then
                            TriggerServerEvent("core:RemoveItemFromVehicle", token, data.item.name, data.quantity,
                                Plate, data.item.metadatas)
                            TriggerSecurGiveEvent("core:addItemToInventory", token, data.item.name, data.quantity,
                                data.item.metadatas)
                            goto finishVeh
                        end
                    end
                    ::finishVeh::
                    TriggerServerEvent("core:SyncInvVeh", token, Plate,
                        GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(closestVeh))), closestVeh)
                    invVehicle = TriggerServerCallback("core:GetVehicleInventory", Plate, nil, nil, nil)
                    pInv = TriggerServerCallback("core:GetInventory", token)

                    itemsVehicle = {}

                    for k, v in pairs(invVehicle) do
                        table.insert(itemsVehicle,
                            { name = v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows,
                                type = v.type,
                                metadatas = v.metadatas, weight = v.weight })

                    end
                    -- TriggerServerEvent("core:UpdateInventoryforall", token, nil, itemsVehicle, nil, nil)
                    if coffre[model] ~= nil then
                        SendNUIMessage({
                            type = "updateInventory",
                            data = { items = pInv, clothes = {}, weapons = weapons,
                                target = { items = itemsVehicle, maxWeight = coffre[model] / 1000,
                                    name = "Coffre " ..
                                        GetLabelText(GetDisplayNameFromVehicleModel(model)) } }
                        })
                    else
                        SendNUIMessage({
                            type = "updateInventory",
                            data = { items = pInv, clothes = {}, weapons = weapons,
                                target = { items = itemsVehicle, maxWeight = 100,
                                    name = "Coffre " ..
                                        GetLabelText(GetDisplayNameFromVehicleModel(model)) } }
                        })
                    end
                end
            end
        end
        if Casier then
            if data.item ~= nil then
                local inv = TriggerServerCallback("core:GetInventoryCasierByid", casierJob, numberCasier)
                local pInv = TriggerServerCallback("core:GetInventory", token)

                for k, v in pairs(inv) do
                    if v.name == data.item.name and data.quantity <= v.count then
                        local casier = TriggerServerCallback("core:removeItemToInventoryCasier", token, casierJob,
                            numberCasier, data.item.name, data.quantity, data.item.metadatas)
                        if casier then
                            TriggerSecurGiveEvent("core:addItemToInventory", token, data.item.name, data.quantity,
                                data.item.metadatas)
                            goto finshCasier
                        end
                    end
                end
                ::finshCasier::
                inv = TriggerServerCallback("core:GetInventoryCasierByid", casierJob, numberCasier)
                pInv = TriggerServerCallback("core:GetInventory", token)

                itemsSociety = {}
                for k, v in pairs(inv) do
                    table.insert(itemsSociety,
                        { name = v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows, type = v.type,
                            metadatas = v.metadatas, weight = v.weight })

                end
                -- TriggerServerEvent("core:UpdateInventoryforall", token, nil, nil, nil, itemsSociety)

                SendNUIMessage({
                    type = "updateInventory",
                    data = { items = pInv, clothes = {}, weapons = weapons,
                        target = { items = itemsSociety, maxWeight = 500,
                            name = "Casier " .. casierJob .. " n°" .. numberCasier } }
                })
            end
            -- core:removeItemToInventoryCasier
        end
        if PropertyCoffre then
            if data.item ~= nil then
                if TriggerServerCallback("core:removeItemToInventoryProperty", token, _property.id, data.item, data.quantity) then
                    TriggerSecurGiveEvent("core:addItemToInventory", token, data.item.name, data.quantity, data.item.metadatas)
                end
            end
        end
    end
end)

local try = false
local openTrunk = false
Keys.Register("K", "K", "Coffre de véhicule", function()


    local closestVeh, closestDist = GetClosestVehicle(p:pos())
    print("Debug Opened Trunk ID 1: " ..json.encode(closestVeh))
    if closestDist <= 15 then
        if not IsInGarage then

        local bone = "platelight"
        if GetWorldPositionOfEntityBone(closestVeh, GetEntityBoneIndexByName(closestVeh, bone)) == vector3(0, 0, 0) then
            print("Debug Opened Trunk ID 2: " ..GetVehicleClass(closestVeh))
            if tostring(closestVeh) == "826114" or tostring(closestVeh) == "1377794" then -- stockade
                bone = "door_pside_r"
            elseif GetVehicleClass(closestVeh) == 8 then
                bone = "swingarm"
            elseif GetVehicleClass(closestVeh) == 20 then
                bone = "reversinglight_r"
            elseif GetVehicleClass(closestVeh) == 14 then --boat
                bone = "engine"
            elseif GetVehicleClass(closestVeh) == 16 then -- plane
                bone = "airbrake_l"
            elseif GetVehicleClass(closestVeh) == 15 then -- plane
                bone = "engine"
            else
                bone = "boot"
            end
        end
        if (GetVehicleClass(closestVeh) == 15 and #(p:pos() - GetWorldPositionOfEntityBone(closestVeh,
            GetEntityBoneIndexByName(closestVeh, bone))) <= 3.5) or (#(p:pos() - GetWorldPositionOfEntityBone(closestVeh, 
            GetEntityBoneIndexByName(closestVeh, bone))) <= 2.0) then

                Plate = vehicle.getProps(closestVeh).plate
                print("Debug Opened Trunk ID 3: " ..Plate)
                if GetVehicleDoorLockStatus(closestVeh) == 0 then
                    isUsing = TriggerServerCallback("core:getUsingStatusCoffre", Plate)
                    if not isUsing then
                        vehWeight = GetEntityModel(closestVeh)
                        TriggerServerEvent("core:setLockCoffreCar", token, Plate, true)
                        print("Debug Opened Trunk ID 4: " ..Plate.. " " ..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(closestVeh))))
                        OpenInventoryVehicle(Plate, GetEntityModel(closestVeh), closestVeh)
                        if open then
                            open = false
                            SetNuiFocusKeepInput(false)
                            EnableControlAction(0, 1, true)
                            EnableControlAction(0, 24, true)
                            EnableControlAction(0, 25, true)
                            EnableControlAction(0, 2, true)
                            EnableControlAction(0, 142, true)
                            EnableControlAction(0, 18, true)
                            EnableControlAction(0, 322, true)
                            EnableControlAction(0, 106, true)
                            SetNuiFocus(false, false)
                            --DisplayRadar(true)
                            SendNuiMessage(json.encode({
                                type = 'closeWebview'
                            }))
                            return
                        else
                            open = true
                            openTrunk = true
                            print("Debug Opened Trunk ID 5: Opened")
                        end
                    else
                        --ShowNotification("Quelqu'un est déjà en train de fouiller dans le coffre")
                        exports['vNotif']:createNotification({
                            type = 'ROUGE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Quelqu'un regarde déjà le coffre"
                        })
                        open = false
                        return
                    end
                else
                -- ShowNotification("Le véhicule est verrouillé")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'JAUNE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Le véhicule est ~s verrouillé"
                })

            end
        else
            if not try then
                try = true
                -- ShowNotification("~r~Vous n'êtes pas au niveau du coffre")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Vous n'êtes pas au niveau du coffre"
                    })

                    Citizen.CreateThread(function()
                        while try do
                            DrawLine(p:pos(), GetWorldPositionOfEntityBone(closestVeh,
                                GetEntityBoneIndexByName(closestVeh, bone)), 255, 255, 255, 170);

                            Wait(1)
                        end
                    end)
                    Wait(5000)
                    try = false
                end
            end
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Vous ne pouvez pas ouvrir de coffre dans un garage"
            })
        end

    end


end)

RegisterNUICallback("focusOut", function()
    open = false
    SetNuiFocusKeepInput(false)
    EnableControlAction(0, 1, true)
    EnableControlAction(0, 24, true)
    EnableControlAction(0, 25, true)
    EnableControlAction(0, 2, true)
    EnableControlAction(0, 142, true)
    EnableControlAction(0, 18, true)
    EnableControlAction(0, 322, true)
    EnableControlAction(0, 106, true)
    SetNuiFocus(false, false)
    --DisplayRadar(true)
    Society = false
    Police = true
    Vehicle = false
    Casier = false
    if PropertyCoffre then
        TriggerServerEvent("core:property:setUsingCoffre", token, _property.id, false)
        PropertyCoffre = false
    end
    if openTrunk == true then
        print("Debug Opened Trunk ID 6: Close")
        local closestVeh, closestDist = GetClosestVehicle(p:pos())
        Plate = vehicle.getProps(closestVeh).plate
        TriggerServerEvent("core:setLockCoffreCar", token, Plate, false)
        if closestDist <= 15 then
            local bone = "platelight"
            if GetWorldPositionOfEntityBone(closestVeh, GetEntityBoneIndexByName(closestVeh, bone)) == vector3(0, 0, 0) then
                print("Debug Opened Trunk ID 7: " ..GetVehicleClass(closestVeh))
                if GetVehicleClass(closestVeh) == 8 then
                    bone = "swingarm"
                elseif GetVehicleClass(closestVeh) == 20 then
                    bone = "reversinglight_r"
                else
                    bone = "boot"
                end
            end
        end
    end
    openTrunk = false
end)

RegisterNetEvent("core:SyncInvVeh")
AddEventHandler("core:SyncInvVeh", function(plate, model, veh)

    if Vehicle then
        if Plate == plate then
            OpenInventoryVehicle(plate, model, veh)
        end
    end
end)