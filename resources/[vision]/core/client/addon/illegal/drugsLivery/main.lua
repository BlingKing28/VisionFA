local inDrugsDeliveries = false
local owner = false
local veh
local createdVeh
local ped = {}
local data
local token = nil
local commandData
local propsToSpawn
local items = {}
local objectType
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)
local message
local mess2
local mess3
local peds
local createVeh
local finishLivraison
local object
--local quantity
local objectCreated
local notif
local object
local take
local taken
local index
local taken
local props = {
    offset = { 0.449, 0.02, -0.041, 3.1, -88.09, 0.0 }
}
local remove
local timer --timer of 10min before the
function StartDrugsDeliveries()
    inDrugsDeliveries = true
    veh = nil
    message = false
    mess2 = false
    mess3 = false
    peds = {}
    createVeh = false
    finishLivraison = false
    --object = nil
    --quantity = 0
    objectCreated = false
    notif = {}
    object = {}
    take = false
    taken = 0
    index = 0
    taken = 0
    props = {
        offset = { 0.449, 0.02, -0.041, 3.1, -88.09, 0.0 }
    }
    remove = {}
    CreateThread(function()
        while inDrugsDeliveries do
            local pNear = false
            if #(p:pos() - data.pos.xyz) <= 50 then
                if not objectCreated then
                    objectCreated = true
                    for i = 1, #data.props do
                        object[i] = entity:CreateObject(propsToSpawn, data.props[i].posProp, true)
                        SetEntityAsMissionEntity(object[i].id, true, true)
                        --SetNetworkIdExistsOnAllMachines(ObjToNet(object[i].id), true)
                        FreezeEntityPosition(object[i].id, true)
                        TriggerServerEvent("drugsDeliveries:openVeh", token, createdVeh)
                        SetModelAsNoLongerNeeded(propsToSpawn) -- free memory
                    end
                end
                pNear = true
                if objectCreated then
                    --CreateBulle de bg
                    for i = 1, #object do
                        if not notif[i] then
                            notif[i] = true
                            remove[i] = false
                            Bulle.add("drugsDeliveries"..i, vector3(GetEntityCoords(object[i].id).x, GetEntityCoords(object[i].id).y, GetEntityCoords(object[i].id).z),
                            function()
                                RobertoBulle("ped"..i, vector3(GetEntityCoords(object[i].id).x, GetEntityCoords(object[i].id).y, GetEntityCoords(object[i].id).z + 1), 'ramasser', 255, 0)
                            end,
                            function()
                                if not take then
                                    take = true
                                    p:PlayAnim("pickup_object", "pickup_low", 0)
                                    Wait(1000)
                                    AttachEntityToEntity(object[i]:getEntityId(), p:ped(),
                                    GetEntityBoneIndexByName(p:ped(), "IK_R_Hand"), props.offset[1], props.offset[2]
                                        , props.offset[3], props.offset[4], props.offset[5], props.offset[6], false,
                                        false, false, false, 0.0, true)
                                    index = i
                                    if not remove[i] then TriggerServerEvent("drugsDeliveries:removeItemSpawned", token, i) end
                                    remove[i] = true
                                    Bulle.remove("drugsDeliveries"..i)
                                else
                                    ShowNotification("Vous ne pouvez pas ramasser vous avez déjà quelque choses dans les mains")
                                end
                            end)
                        end
                    end
                end
            end

            if take then
                pNear = true
                local vehs = GetAllVehicleInArea(p:pos(), 10.0)
                for key, veh in pairs(vehs) do
                    if GetDistanceBetweenCoords(p:pos(), GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "platelight")), true) < 1.5 or
                        GetDistanceBetweenCoords(p:pos(), GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "boot")), true) < 1.5 then
                        ShowHelpNotification("Appuyer sur ~r~~INPUT_CONTEXT~~s~ pour mettre l'objet dans le coffre.")
                        if IsControlJustReleased(0, 38) and take then
                            SetVehicleDoorOpen(veh, 5, false, false)
                            p:PlayAnim("anim@heists@narcotics@trash", "throw_b", 49)
                            Wait(1000)
                            object[index]:delete()
                            take = false
                            ClearPedTasks(p:ped())
                            if items[index] ~= nil then TriggerServerEvent("drugsDeliveries:addItemTrunk", token, GetVehicleNumberPlateText(veh), items[index].name, items[index].quantity) end
                            SetVehicleDoorShut(veh, 5, false, false)
                            taken = taken + 1
                            index = 0
                        end
                    end
                end
            end

            if taken == 4 then
                if owner then TriggerServerEvent("drugsDeliveries:msg2", vector2(data.pos.x, data.pos.y)) end
                TriggerServerEvent("drugsDeliveries:deleteconvo", token)
                inDrugsDeliveries = false
            end
            if pNear then
                Wait(1)
            else
                Wait(500)
            end

        end
    end)
end

RegisterNetEvent("drugsDeliveries:removeItemSpawnedCallback")
AddEventHandler("drugsDeliveries:removeItemSpawnedCallback", function(i)
    if object ~= nil and object[i] ~= nil then
        if DoesEntityExist(object[i].id) then
            if index == 0 or i ~= index then
                object[i]:delete()
                taken = taken + 1
            end
        end
    end
end)

-- RegisterNetEvent("drugsDeliveries:StartMissionBlips")
-- AddEventHandler("drugsDeliveries:StartMissionBlips", function(data)
-- end)

function setEnemyBlip(pos)
    local timeBlips = 5 * 60000
    local random = math.random(100, 300.0)
    local random2 = math.random(1, 4)
    if random2 == 1 then
        pos = vector3(pos.x + random, pos.y + random, pos.z + random)
    elseif random2 == 2 then
        pos = vector3(pos.x + random, pos.y - random, pos.z + random)
    elseif random2 == 3 then
        pos = vector3(pos.x - random, pos.y + random, pos.z + random)
    elseif random2 == 4 then
        pos = vector3(pos.x - random, pos.y - random, pos.z + random)
    end
    local blips = AddBlipForRadius(pos, 500.0)
    SetBlipSprite(blips, 9)
    SetBlipColour(blips, 1)
    SetBlipAlpha(blips, 100)
    --StartDrugsDeliveries()
    Modules.UI.RealWait(timeBlips)
    RemoveBlip(blips)
end

function splitItem()
    items = {}
    local nbr = 0
    --print("splitItem", #commandData, json.encode(commandData[1]), commandData[1].spawnName)
    if #commandData == 1 and commandData[1].quantity < 4 then
        for i = 1, commandData[1].quantity do
            items[i] = {}
            items[i].name = commandData[1].spawnName
            items[i].quantity = 1
            --print("Item0-1", items[i].name, items[i].quantity)
        end
        return
    end
    if #commandData == 1 then --if 1 item split in four
        nbr = 0
        for i = 1, 4 do
            items[i] = {}
            items[i].name = commandData[1].spawnName
            items[i].quantity = math.floor(commandData[1].quantity/4)
            --print("Item1", items[i].name, items[i].quantity)
            nbr = nbr + math.floor(commandData[1].quantity/4)
        end
        if nbr < commandData[1].quantity then items[4].quantity = items[4].quantity + (commandData[1].quantity - nbr) end
    elseif #commandData == 2 then --if 2 items split in 2 by 2
        if commandData[1].quantity < 2 then
            items[1] = {}
            items[1].name = commandData[1].spawnName
            items[1].quantity = 1
            --print("Item2-1", items[1].name, items[1].quantity)
        else
            nbr = 0
            for i = 1, 2 do
                items[i] = {}
                items[i].name = commandData[1].spawnName
                items[i].quantity = math.floor(commandData[1].quantity/2)
                --print("Item2-1", items[i].name, items[i].quantity)
                nbr = nbr + math.floor(commandData[i].quantity/2)
            end
            if nbr < commandData[1].quantity then items[2].quantity = items[2].quantity + (commandData[1].quantity - nbr) end
        end
        if commandData[2].quantity < 2 then
            items[3] = {}
            items[3].name = commandData[1].spawnName
            items[3].quantity = 1
            --print("Item2-1", items[3].name, items[3].quantity)
        else
            nbr = 0
            for i = 1, 2 do
                items[i+2] = {}
                items[i+2].name = commandData[2].spawnName
                items[i+2].quantity = math.floor(commandData[2].quantity/2)
                --print("Item2-2", items[i+2].name, items[i+2].quantity)
                nbr = nbr + math.floor(commandData[2].quantity/2)
            end
            if nbr < commandData[2].quantity then items[4].quantity = items[4].quantity + (commandData[2].quantity - nbr) end
        end
    elseif #commandData == 3 then --if 3 items split in 2 the bigger en 2 other
        local bigger = 0
        local index = 1
        for i = 1, #commandData do --find the biggest quantity item
            if commandData[i].quantity > bigger then
                bigger = commandData[i].quantity
                index = i
            end
        end
        --print("big", bigger, index)
        if commandData[index].quantity < 2 then
            items[1] = {}
            items[1].name = commandData[index].spawnName
            items[1].quantity = 1
            --print("Item3-1", items[1].name, items[1].quantity)
        else
            nbr = 0
            for i = 1, 2 do
                items[i] = {}
                items[i].name = commandData[index].spawnName
                items[i].quantity = math.floor(commandData[index].quantity/2)
                --print("Item3-1", items[i].name, items[i].quantity)
                nbr = nbr + math.floor(commandData[i].quantity/2)
            end
            if nbr < commandData[index].quantity then items[2].quantity = items[2].quantity + (commandData[index].quantity - nbr) end
        end
        local j = 3
        for i = 1, #commandData do --find the biggest quantity item
            if i ~= index then
                items[j] = {}
                items[j].name = commandData[i].spawnName
                items[j].quantity = math.floor(commandData[i].quantity)
                --print("Item3-2", items[j].name, items[j].quantity)
                j = j + 1
            end
        end
    else  --if 4 items or more split in 3 plus the other
        for i = 1, 4 do
            items[i] = {}
            items[i].name = commandData[i].spawnName
            items[i].quantity = math.floor(commandData[i].quantity)
            --print("Item4-1", items[i].name, items[i].quantity)
        end
        -- for i = 1, #commandData do --find the biggest quantity item
        --     items[4] = {}
        --     items[4].name = commandData[i].spawnName
        --     items[4].quantity = math.floor(commandData[i].quantity)
        --     print("Item4-2", items[i].name, items[i].quantity)
        -- end
    end
end

RegisterNetEvent("drugsDeliveries:removeBulle")
AddEventHandler("drugsDeliveries:removeBulle", function(robertoName)
    Bulle.remove(robertoName)
    if owner then TriggerServerEvent("drugsDeliveries:msg2", vector2(data.pos.x, data.pos.y)) end
    TriggerServerEvent("drugsDeliveries:deleteconvo", token)
    inDrugsDeliveries = false
end)

function BulleVehToHook(carPos, veh)
    Bulle.add("drugsDeliveries"..tostring(carPos.x), vector3(carPos.x, carPos.y, carPos.z),
    function()
        RobertoBulle("car"..tostring(carPos.x), vector3(carPos.x, carPos.y, carPos.z + 2), 'crocheter', 255, 0)
    end,
    function()
        local result = exports['lockpick']:startLockpick()
        print(result, 'lockpicking result')
        if result then
            Bulle.remove("drugsDeliveries"..tostring(carPos.x))
            local vehicle, dst = GetClosestVehicle(p:pos())
            SetVehicleDoorsLocked(vehicle, 0)
            TriggerServerEvent("drugsDeliveries:openVeh", token, vehicle, "drugsDeliveries"..tostring(carPos.x))
            if owner then TriggerServerEvent("drugsDeliveries:msg2", vector2(data.pos.x, data.pos.y)) end
            TriggerServerEvent("drugsDeliveries:deleteconvo", token)
            inDrugsDeliveries = false
        end
    end)
end

RegisterNetEvent("drugsDeliveries:StartMission")
AddEventHandler("drugsDeliveries:StartMission", function(dataDeliveries, crewName, typeObject, _data, _createdVeh)
    --print(dataDeliveries, crewName, typeObject, json.encode(_data))
    data = _data
    createdVeh = _createdVeh
    objectType = typeObject
    commandData = dataDeliveries
    propsToSpawn = Drugs.props.ground[typeObject]
    --splitItem()
    if p:getCrew() == crewName then
        print("1")
        inDrugsDeliveries = true
        owner = true
        TriggerServerEvent("drugsDeliveries:msg1", vector2(data.pos.x, data.pos.y))
        --StartDrugsDeliveries()
        BulleVehToHook(data.pos, createdVeh)
    else
        if inDrugsDeliveries then return end
        local ct = nil
        for k, v in pairs(Drugs.crew) do
            if v.name == crewName then
                ct = v.typeCrew
            end
        end
        if ct == nil then return end
        for k, v in pairs(Drugs.crew) do
            if v.name == p:getCrew() and v.typeCrew == ct then
                print("2")
                owner = false
                inDrugsDeliveries = false
                TriggerServerEvent("drugsDeliveries:msgEnemy")
                setEnemyBlip(data.pos)
                BulleVehToHook(data.pos, createdVeh)
            end
        end
        --elseif p:getCrew() ~= "None" then --todo check in bdd if crew have drugs weapond ect + add other crew on start script too
    end
end)