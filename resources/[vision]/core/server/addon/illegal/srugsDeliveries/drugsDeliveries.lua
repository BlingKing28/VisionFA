local commandToDo = {}
local commandDone = {}
local store = {}
local crewCommandWeapon = {}
vehsToUnlock = {}
Armes = {
    --pf
    ["plate"] = {cd = 432000, quantityMax = 6, level = 1},
    --gang
    ["weapon_bat"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_bottle"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_crowbar"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_golfclub"] = {cd = 172800, quantityMax = 10, level = 2}, 
    ["weapon_hatchet"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_knuckle"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_machete"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_nightstick"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_wrench"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_knife"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_switchblade"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_battleaxe"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_poolcue"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_canette"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_bouteille"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_pelle"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_pickaxe"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_sledgehammer"] = {cd = 172800, quantityMax = 10, level = 2},
    ["weapon_dagger"] = {cd = 172800, quantityMax = 10, level = 2},

    --mc
    ["weapon_pistol"] = {cd = 345600, quantityMax = 4, level = 3},
    ["weapon_vintagepistol"] = {cd = 259200, quantityMax = 4, level = 3},
    ["weapon_snspistol"] = {cd = 259200, quantityMax = 4, level = 3},
    ["weapon_dbshotgun"] = {cd = 604800, quantityMax = 4, level = 3},
    ["weapon_molotov"] = {cd = 604800, quantityMax = 3, level = 3},

    --orga
    ["weapon_katana"] = {cd = 604800, quantityMax = 2, level = 3},
    ["weapon_combatpistol"] = {cd = 345600, quantityMax = 4, level = 3},
    ["weapon_heavypistol"] = {cd = 345600, quantityMax = 4, level = 3},
    ["weapon_revolver"] = {cd = 345600, quantityMax = 4, level = 3},
    ["weapon_doubleaction"] = {cd = 604800, quantityMax = 4, level = 3},
    ["weapon_microsmg"] = {cd = 432000, quantityMax = 2, level = 3},
    ["weapon_machinepistol"] = {cd = 432000, quantityMax = 2, level = 3},
    ["weapon_minismg"] = {cd = 432000, quantityMax = 2, level = 3},
    ["weapon_assaultshotgun"] = {cd = 604800, quantityMax = 2, level = 3},
    ["weapon_sawnoffshotgun"] = {cd = 604800, quantityMax = 2, level = 3},
    ["weapon_pumpshotgun"] = {cd = 604800, quantityMax = 2, level = 3},
    ["weapon_heavyshotgun"] = {cd = 604800, quantityMax = 2, level = 3},

    --mafia
    ["weapon_pistol50"] = {cd = 345600, quantityMax = 4, level = 3},
    ["weapon_autoshotgun"] = {cd = 432000, quantityMax = 2, level = 3},
    ["weapon_combatshotgun"] = {cd = 864000, quantityMax = 2, level = 3},
    ["weapon_compactrifle"] = {cd = 432000, quantityMax = 2, level = 3},
    ["weapon_assaultrifle"] = {cd = 864000, quantityMax = 2, level = 3},
    ["weapon_gusenberg"] = {cd = 864000, quantityMax = 2, level = 3},
    ["weapon_smg"] = {cd = 345600, quantityMax = 2, level = 3},
    ["weapon_carbinerifle"] = {cd = 864000, quantityMax = 2, level = 3},
    ["weapon_specialcarbine"] = {cd = 864000, quantityMax = 2, level = 3},
}

CreateThread(function()
    MySQL.Async.fetchAll('SELECT * FROM `command_tablet`', {}, 
    function(result)
        if result ~= nil then
            for k, v in pairs(result) do
                if v.done == false then
                    table.insert(commandToDo, {
                        order = json.decode(v.order),
                        time = v.time,
                        date = v.date,
                        total = v.total,
                        typeObject = v.typeObject,
                        crewName = v.crewName,
                        done = v.done
                    })
                else
                    table.insert(commandDone, {
                        order = json.decode(v.order),
                        time = v.time,
                        date = v.date,
                        total = v.total,
                        typeObject = v.typeObject,
                        crewName = v.crewName,
                        done = v.done
                    })
                end
            end
        end
        -- local AllStore = MySQL.Async.fetchAll("SELECT tablet.*, tablet_type.name as name, tablet_type.typeObject as typeObject, tablet_type.price as price, tablet_type.image as image FROM tablet INNER JOIN tablet_type ON tablet.tablet_type_id = tablet_type.id")
        -- for k, v in pairs(AllCommand) do
        --     if store[v.crew] == nil then
        --         store[v.crew] = {}
        --     end
        --     store[v.crew][v.name] = {}
        --     store[v.crew][v.name].name = v.name
        --     store[v.crew][v.name].typeObject = v.typeObject
        --     store[v.crew][v.name].price = v.price
        --     store[v.crew][v.name].spawnName = v.name
        --     store[v.crew][v.name].image = v.image
        -- end
    end)
end)

RegisterNetEvent("drugsDeliveries:msg1")
AddEventHandler("drugsDeliveries:msg1", function(pos)
    local pPhone = exports["lb-phone"]:GetEquippedPhoneNumber(source)
    exports["lb-phone"]:SendMessage("666-8596", pPhone,
        "yo, voila la position pour l'echange, viens recuperer tes marchandises"
        , nil, nil, nil)
    Wait(5000)
    exports["lb-phone"]:SendCoords("666-8596", pPhone, pos)
end)

RegisterNetEvent("drugsDeliveries:msgEnemy")
AddEventHandler("drugsDeliveries:msgEnemy", function(pos)
    local pPhone = exports["lb-phone"]:GetEquippedPhoneNumber(source)
    exports["lb-phone"]:SendMessage("666-8596", pPhone,
        "yo, j'ai recu l'info qu'une livraison étais en cours!"
        , nil, nil, nil)
end)

RegisterNetEvent("drugsDeliveries:msg2")
AddEventHandler("drugsDeliveries:msg2", function()
    local pPhone = exports["lb-phone"]:GetEquippedPhoneNumber(source)
    exports["lb-phone"]:SendMessage("666-8596", pPhone,
        "Merci à la prochaine.", nil, nil, nil)
end)

RegisterNetEvent("drugsDeliveries:deleteconvo")
AddEventHandler("drugsDeliveries:deleteconvo", function()
    local pPhone = exports["lb-phone"]:GetEquippedPhoneNumber(source)
    -- sql query to get the id of the conversation
    local channelId = MySQL.Sync.fetchScalar([[SELECT c.channel_id FROM phone_message_channels c WHERE c.is_group = 0
            AND EXISTS (SELECT TRUE FROM phone_message_members m WHERE m.channel_id = c.channel_id AND m.phone_number = @from)
            AND EXISTS (SELECT TRUE FROM phone_message_members m WHERE m.channel_id = c.channel_id AND m.phone_number = @to)]]
        , { ["@from"] = "666-8596", ["@to"] = pPhone })
    MySQL.Async.execute("DELETE FROM phone_message_messages WHERE channel_id = @channel",
        { ["@channel"] = channelId })
    MySQL.Async.execute("DELETE FROM phone_message_channels WHERE channel_id = @channel",
        { ["@channel"] = channelId })
end)

RegisterNetEvent("drugsDeliveries:addItemTrunk")
AddEventHandler("drugsDeliveries:addItemTrunk", function(token, plate, item, nbr)
    --print(_Utils.Trim(GetVehicleNumberPlateText(veh)), GetVehicleIndexFromPlate(_Utils.Trim(GetVehicleNumberPlateText(veh))))
    --local plate = GetVehicleNumberPlateText(veh)
    --local index = GetVehicleIndexFromPlate(plate)
    AddItemToInventoryVehicleStaff(plate, item, nbr, {})
end)

RegisterNetEvent("drugsDeliveries:removeItemTrunk")
AddEventHandler("drugsDeliveries:removeItemTrunk", function(token, plate)
    --local plate = GetVehicleNumberPlateText(veh)
    --local index = GetVehicleIndexFromPlate(plate)
    RemoveItemToVehicle(plate, "sacCocain", 10, {})
end)

RegisterNetEvent("drugsDeliveries:removeItemSpawned")
AddEventHandler("drugsDeliveries:removeItemSpawned", function(token, i)
    TriggerClientEvent("drugsDeliveries:removeItemSpawnedCallback", -1, i)
end)



RegisterNetEvent("drugsDeliveries:spawn")
AddEventHandler("drugsDeliveries:spawn", function(data, order)
    local veh = data.veh
    local pos = data.pos
    local veh = CreateVehicle(GetHashKey(veh), pos.x, pos.y, pos.z, pos.w, true, true)
    while not DoesEntityExist(veh) do
        Wait(1)
    end
    SetVehicleDoorsLocked(veh, 0)
    local plate = GetVehicleNumberPlateText(veh)
    local index = GetVehicleIndexFromPlate(plate)
    -- for key, item in pairs(order) do
    --     AddItemToInventoryVehicleStaff(plate, item.spawnName, tonumber(item.quantity), {})
    -- end
    MarkVehicleAsNotSaved(index, plate)
    Wait(1000)
    SetVehicleDoorsLocked(veh, 0)
end)

RegisterNetEvent("drugsDeliveries:openVeh")
AddEventHandler("drugsDeliveries:openVeh", function(token, veh, robertoName)
    SetVehicleDoorsLocked(veh, 0)
    TriggerClientEvents("drugsDeliveries:removeBulle", GetAllCrewIds(), robertoName)
end)

function spawnVeh(data, order)
    local vehname = data.veh
    local pos = data.pos
    local veh = CreateVehicle(GetHashKey(vehname), pos.x, pos.y, pos.z, pos.w, true, true)
    while not DoesEntityExist(veh) do
        Wait(1)
    end
    SetVehicleDoorsLocked(veh, 1)
    local plate = GetVehicleNumberPlateText(veh)
    newVeh(plate, vehname, veh, true)
    table.insert(vehsToUnlock, plate)
    Wait(1000)
    local vehClass = GetVehicle(plate)
    print(json.encode(order))
    for key, item in pairs(order) do
        AddItemToInventoryVehicleStaff(plate, item.spawnName, tonumber(item.quantity), {})
    end
    SetVehicleDoorsLocked(veh, 1)
    return veh
end

RegisterNetEvent("drugsDeliveries:start")
AddEventHandler("drugsDeliveries:start", function(data, crewName, typeObject)
    TriggerClientEvents("drugsDeliveries:StartMission", GetAllCrewIds(), data, crewName, typeObject)
end)

function addCommandToBdd(order, time, date, total, typeObject, crewName)
    MySQL.Async.execute("INSERT INTO `command_tablet` (`order`, `time`, `date`, `total`, `typeObject`, `done`, `crewName`) VALUES (@1, @2, @3, @4, @5, @6, @7)",
        {
            ["1"] = tostring(json.encode(order)),
            ["2"] = time,
            ["3"] = tostring(date),
            ["4"] = total,
            ["5"] = typeObject,
            ["6"] = false,
            ["7"] = crewName
        }, function(affectedRows)
            print("aff", affectedRows)
    end)
end

RegisterNetEvent("drugsDeliveries:saveCommand")
AddEventHandler("drugsDeliveries:saveCommand", function(token, data, crewName, typeObject)
    local source = source
    local date = os.date("%Y-%m-%dT%X")--2022-12-05T22:30:17-01:00
    if CheckPlayerToken(source, token) then
        if json.encode(commandToDo) == "[]" then
            table.insert(commandToDo, {
                order = data.order,
                time = data.time,
                date = date,
                total = data.total,
                typeObject = typeObject,
                crewName = crewName,
                done = false
            })
            addCommandToBdd(data.order, data.time, date, data.total, typeObject, crewName)
            if crewName == "TEST CREW" then
                local dataInit, veh = init(data.order)--for test only
                Wait(1000)--for test only
                print(json.encode(dataInit), os.time(os.date('*t')), os.time(os.date('*t'))+172800)--for test only
                makeCallGreatAgain('lspd', dataInit.pos, "Livraison suspecte", "drugs")--for test only
                TriggerClientEvent("drugsDeliveries:StartMission", -1, data.order, crewName, typeObject, dataInit, veh)--for test only
            end
            SendDiscordLog("tablet", source, string.sub(GetDiscord(source), 9, -1),
                GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(), crewName,
                json.encode(data.order))
            TriggerClientEvent('drugsDeliveries:saveCommandReturn', source, true, data.order, data.total, typeObject)
            return
        else
            for k, v in pairs(commandToDo) do
                if v.time == data.time and v.crewName == crewName then
                    TriggerClientEvent('drugsDeliveries:saveCommandReturn', source, "Votre crew a déjà une livraison à cette heure ci", data.order, data.total, typeObject)
                    return
                end
            end
            table.insert(commandToDo, {
                order = data.order,
                time = data.time,
                date = date,
                total = data.total,
                typeObject = typeObject,
                crewName = crewName,
                done = false
            })
            SendDiscordLog("tablet", source, string.sub(GetDiscord(source), 9, -1),
                GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(), crewName,
                json.encode(data.order))
            addCommandToBdd(data.order, data.time, date, data.total, typeObject, crewName)
            if crewName == "TEST CREW" then
                local dataInit, veh = init(data.order)--for test only
                Wait(1000)--for test only
                print(json.encode(dataInit), os.time(os.date('*t')), os.time(os.date('*t'))+172800)--for test only
                makeCallGreatAgain('lspd', dataInit.pos, "Livraison suspecte", "drugs")--for test only
                TriggerClientEvent("drugsDeliveries:StartMission", -1, data.order, crewName, typeObject, dataInit, veh)--for test only
            end
            TriggerClientEvent('drugsDeliveries:saveCommandReturn', source, true, data.order, data.total, typeObject)
            return
        end
    end
end)

function init(order)
    math.randomseed(GetGameTimer())
    local ramdom = math.random(1, #Drugs.Delivery)
    data = Drugs.Delivery[ramdom]
    local veh = spawnVeh(data, order)
    return data, veh
end

Citizen.CreateThread(function()
    while true do
        Wait(1 * 50000) -- 50 seconds
        local hour = os.date("%H:%M")
        -- local numberToRemove = {}
        for k, v in pairs(commandToDo) do
            if tostring(v.time) == tostring(hour) and v.done == false then
                v.done = true
                MySQL.Async.execute("UPDATE `command_tablet` SET `done` = @done WHERE `date` = @date and `time` = @time and `crewName` = @crewName",
                {
                    ["done"] = v.done,
                    ["date"] = v.date,
                    ["time"] = v.time,
                    ["crewName"] = v.crewName
                }, function(result)

                end)
                table.insert(commandDone, v)
                local dataInit, veh = init(v.order)
                Wait(1000)
                TriggerClientEvent("drugsDeliveries:StartMission", -1, v.order, v.crewName, v.typeObject, dataInit, veh)
                Wait(30000)
                makeCallGreatAgain('lspd', dataInit.pos, "Livraison suspecte", "drugs")
                makeCallGreatAgain('lssd', dataInit.pos, "Livraison suspecte", "drugs")
                -- table.insert(numberToRemove, k)
            end
        end
        -- for k, v in pairs(numberToRemove) do
        --     for kk, vv in pairs(commandToDo) do
        --         if(vv.time == hour) then
        --             table.remove(commandToDo, kk)
        --         end
        --     end
        -- end
    end
end)

RegisterNetEvent("drugsDeliveries:getStore")
AddEventHandler("drugsDeliveries:getStore", function(token, crew)
    if (store[crew] ~= nil) then
        return store[crew]
    end
    return nil
end)

RegisterNetEvent("drugsDeliveries:getHistoryOrderServer")
AddEventHandler("drugsDeliveries:getHistoryOrderServer", function(token)
    TriggerClientEvent("drugsDeliveries:getHistoryOrderClient", source, commandDone)
    return true
    --return commandDone
end)

-- function initNewCrew()
--     local crewId = 0 --crewid in bdd
--     local crewRank = 1 --1=gang, 2=mc, 3=orga, 4=mafia
--     local tabletType = MySQL.Sync.fetchAll('SELECT * FROM tablet_type')
--     for k,v in pairs(objectToAdd[crewRank]) do
--         for kk, vv in pairs(tabletType) do
--             if vv.name == v.name
--                 MySQL.Async.execute("INSERT INTO tablet (id_crew, tablet_type_id) VALUES (@1, @2)",
--                 {
--                     ["1"] = crewId,
--                     ["2"] = vv.id
--                 }, function(affectedRows)
--                     print(affectedRows)
--                 end)
--             end
--         end
--     end
-- end

--crewCommandWeapon
RegisterNetEvent("clear")
AddEventHandler("clear", function(crew)
    table.remove(crewCommandWeapon, 1)
end)

RegisterNetEvent("core:GetWeaponListCrew")
AddEventHandler("core:GetWeaponListCrew", function(crew, level)
    local source = source
    local timestamp = os.time(os.date('*t'))
    if crewCommandWeapon[crew] == nil then
        MySQL.Async.fetchAll('SELECT * FROM `tablet_armes` WHERE `crew_name` = @crew', {
            ['@crew'] = crew
        }, function(result)
            crewCommandWeapon[crew] = {}
            if json.encode(result) ~= '[]' then
                for k,v in pairs(result) do
                    if timestamp > v.cooldown and v.cooldown ~= 0 then
                        v.quantity = 0
                        v.cooldown = 0
                    end
                    table.insert(crewCommandWeapon[crew], {
                        id = v.id,
                        weapon = v.weapon_name,
                        quantity = v.quantity,
                        cooldown = v.cooldown
                    })
                    TriggerClientEvent("core:GetlistWeaponMyCrewClient", source, crewCommandWeapon[crew], timestamp)
                end
            end
        end)
    else
        for k,v in pairs(crewCommandWeapon[crew]) do
            if v.cooldown then
                if timestamp > v.cooldown and v.cooldown ~= 0 then
                    v.quantity = 0
                    v.cooldown = 0
                end
            end
        end
        TriggerClientEvent("core:GetlistWeaponMyCrewClient", source, crewCommandWeapon[crew], timestamp)
    end
end)


-- [         script:core] TEST CREW
-- [   j       ] [{"quantity":4,"stock":9,"spawnName":"weapon_snspistol","id":1,"price":600,"name":"Pétoire","image":"assets/TabletteIllegale/weapons/weapon_assaultrifle_mk2.png","type":"weapons"}]
-- [        v           [{"cooldown":0,"quantity":9,"weapon":"weapon_snspistol","id":4}]
function WeapondAlreadyExist(weaponName, crew)
    for k,v in pairs(crewCommandWeapon[crew]) do
        if v.weapon == weaponName then
            print(v.weapon, "exist")
            return false 
        end
    end
    return true
end

RegisterNetEvent("core:AddWeaponListCrew")
AddEventHandler("core:AddWeaponListCrew", function(crew, command)
    print("-----------------------")
    print(crew)
    print(json.encode(command))
    print(json.encode(crewCommandWeapon[crew]))
    print("-----------------------")

    if json.encode(crewCommandWeapon[crew]) ~= '[]' then
        for k,v in pairs(crewCommandWeapon[crew]) do
            for i,j in pairs(command) do 
                if v.weapon == j.spawnName and not WeapondAlreadyExist(j.spawnName, crew) then
                    v.quantity = v.quantity + j.quantity
                    if Armes[v.weapon].quantityMax <= v.quantity then
                        v.cooldown = os.time(os.date('*t')) + Armes[v.weapon].cd
                    end
                    -- if j.cooldown ~= nil then
                    --     v.cooldown = j.cooldown
                    -- else
                    --     v.cooldown = 0
                    -- end
                    MySQL.Async.execute("UPDATE `tablet_armes` SET `quantity` = @quant, `cooldown` = @coolD WHERE `id` = @id",
                    {
                        ["quant"] = v.quantity,
                        ["coolD"] = v.cooldown,
                        ["id"] = v.id
                    }, function(result)
                    end)
                elseif WeapondAlreadyExist(j.spawnName, crew) then
                    if j.cooldown == nil then
                        j.cooldown = 0
                    end
                    if Armes[j.spawnName].quantityMax <= j.quantity then
                        j.cooldown = os.time(os.date('*t'))+Armes[j.spawnName].cd
                    end
                    table.insert(crewCommandWeapon[crew],{
                        weapon = j.spawnName,
                        quantity = j.quantity,
                        cooldown = j.cooldown}
                    )
                    MySQL.Async.execute("INSERT INTO `tablet_armes` (`crew_name`, `weapon_name`, `quantity`, `cooldown`) VALUES (@crewN, @weaponN, @quant, @coolD)",
                    {
                        ["crewN"] = crew,
                        ["weaponN"] = j.spawnName,
                        ["quant"] =  j.quantity,
                        ["coolD"] = j.cooldown
                    }, function(result)
                        print("Print INSERT 1 --> ", result)
                    end)
                end
            end
        end
    else
        for i,j in pairs(command) do 
            if j.cooldown == nil then
                j.cooldown = 0
            end
            if Armes[j.spawnName].quantityMax <= j.quantity then
                j.cooldown = os.time(os.date('*t'))+Armes[j.spawnName].cd
            end
            table.insert(crewCommandWeapon[crew],{
                weapon = j.spawnName,
                quantity = j.quantity,
                cooldown = j.cooldown}
            )
            MySQL.Async.execute("INSERT INTO `tablet_armes` (`crew_name`, `weapon_name`, `quantity`, `cooldown`) VALUES (@crewN, @weaponN, @quant, @coolD)",
            {
                ["crewN"] = crew,
                ["weaponN"] = j.spawnName,
                ["quant"] = j.quantity,
                ["coolD"] = j.cooldown
            }, function(result)
                print("Print INSERT 2 --> ",result)
            end)
        end
    end
end)




RegisterNetEvent("core:StartCooldown")
AddEventHandler("core:StartCooldown", function(crew, weapon, cooldown)
    for k,v in pairs(crewCommandWeapon[crew]) do
        if v.weapon == weapon then
            time = os.time(os.date('*t'))+v.cooldown
            MySQL.Async.execute("UPDATE `tablet_armes` SET `cooldown` = @coolD WHERE `id` = @id",
            {
                ["coolD"] = time,
                ["id"] = v.id
            }, function(result)
            end)
        end
    end
end)