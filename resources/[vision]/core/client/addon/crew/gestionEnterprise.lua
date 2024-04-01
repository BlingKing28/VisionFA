local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)
local societyMember
local jobInfo, jobVeh, jobProperty, property, jobLabel, playerJob, sourcePlayer, perms
RegisterCommand("jobGestion", function()
    openJobGestion()
end)

RegisterNetEvent("core:GetEmployeeList")
AddEventHandler("core:GetEmployeeList", function(list)
    print(json.encode(list))
    societyMember = list
    for k, v in pairs(societyMember) do
        print(v.id, v.grade, v.nom, v.prenom )
    end
end)

RegisterNetEvent("core:getJobInfo")
AddEventHandler("core:getJobInfo", function(list)
    jobInfo = list[1]
end)

RegisterNetEvent("core:getJobVeh")
AddEventHandler("core:getJobVeh", function(list)
    jobVeh = list
end)

RegisterNetEvent("core:getJobProperty")
AddEventHandler("core:getJobProperty", function(list)
    jobProperty = list
end)

local function listMember()
    local players = {}
    for i = 1, #societyMember, 1 do
        players[i] = {}
        players[i]["lname"] = societyMember[i].nom
        players[i]["fname"] = societyMember[i].prenom
        players[i]["id"] = societyMember[i].id
        players[i]["license"] = societyMember[i].license
        players[i]["rank"] = societyMember[i].grade
        players[i]["jobLabel"] = tostring(loadedJob.grade[societyMember[i].grade].label)
        print(tostring(loadedJob.grade[societyMember[i].grade].label), societyMember[i].grade)
        if p:getId() == societyMember[i].id then 
            sourcePlayer = i 
            jobLabel = tostring(loadedJob.grade[societyMember[i].grade].label)
        end
    end
    print(json.encode(players))
    return players, sourcePlayer
end

local function listVeh(crewVeh)
    local veh = {}

    for i = 1, #crewVeh, 1 do
        veh[i] = {}
        veh[i]["vehName"] = crewVeh[i].name
        veh[i]["pounded"] = crewVeh[i].stored == 2 and true or false
        veh[i]["plate"] = crewVeh[i].plate
    end

    return veh
end

local function listProperty(crewProperty)
    local property = {}
    for i = 1, #crewProperty, 1 do
        local coords = json.decode(crewProperty[i].enter_pos)
        local data = json.decode(crewProperty[i].data)
        local var1, var2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z, Citizen.ResultAsInteger(),
            Citizen.ResultAsInteger())
        local street = GetStreetNameFromHashKey(var1);
        local quarter = GetStreetNameFromHashKey(var2);
        property[i] = {}
        property[i]["type"] = data.type
        property[i]["address"] = street
        property[i]["id"] = crewProperty[i].id
    end

    return property
end

function openJobGestion()
    if p:getJob() == "aucun" then
        return
    end
    playerJob = p:getJob()
    TriggerServerEvent("core:GetEmployeeList", token, playerJob)
    TriggerServerEvent("core:getJobInfo", token, playerJob)
    TriggerServerEvent("core:getJobVeh", token, playerJob)
    TriggerServerEvent("core:getJobProperty", token, playerJob)
    Wait(1000)
    perms = json.decode(jobInfo.perm)
    players, sourcePlayer = listMember()
    property = listProperty(jobProperty)

    DisableControlAction(0, 24, true) -- disable attack
    DisableControlAction(0, 25, true) -- disable aim
    DisableControlAction(0, 1, true) -- LookLeftRight
    DisableControlAction(0, 2, true) -- LookUpDown
    DisableControlAction(0, 142, true)
    DisableControlAction(0, 18, true)
    DisableControlAction(0, 322, true)
    DisableControlAction(0, 106, true)
    DisableControlAction(0, 263, true) -- disable melee
    DisableControlAction(0, 264, true) -- disable melee
    DisableControlAction(0, 257, true) -- disable melee
    DisableControlAction(0, 140, true) -- disable melee
    DisableControlAction(0, 141, true) -- disable melee
    DisableControlAction(0, 142, true) -- disable melee
    DisableControlAction(0, 143, true) -- disable melee

    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'CrewMenuGestion',
        data = {
            color_title = jobInfo.color,
            background = jobInfo.color,
            crewName = playerJob,
            crewDevise = jobInfo.devise,
            membres = #players,
            rang = TriggerServerCallback("core:getNumberOfDuty", token, playerJob),
            territoires = #property,
            recrute = perms.recrute,
            exclure = perms.exclure,
            editPerm = perms.editPerm,
            editMembres = perms.editMembres,
            sendDm = perms.sendDm,
            crewOrEnterprise = false,
            nbrRank = 5,
            jobLabel = jobLabel,
            players = players,
            properties = property,
            vehs = listVeh(jobVeh)
        }
    }));
end

RegisterNUICallback("jobMember_callback", function(data)
    print(data.action, data.player.id, data.player.rank)
    if data.action == "infoPlayer" then
        print(data.player.id)
    elseif data.action == "upPlayer" then
        if players[sourcePlayer]["rank"] >= perms.editMembres then
            TriggerServerEvent("core:PromotePlayer", token, data.player.license, data.player.id, playerJob, data.player.rank + 1)
        else
            print("you dont have the perms to do that action")
            return
        end
    elseif data.action == "downPlayer" then
        if players[sourcePlayer]["rank"] >= perms.editMembres then
            TriggerServerEvent("core:PromotePlayer", token, data.player.license, data.player.id, playerJob, data.player.rank - 1)
        else
            print("you dont have the perms to do that action")
            return
        end
    elseif data.action == "kickPlayer" then
        if players[sourcePlayer]["rank"] >= perms.exclure then
            TriggerServerEvent("core:KickPlayerFromJob", token, data.player.license, data.player.id, playerJob)
        else
            print("you dont have the perms to do that action")
            return
        end
    else
        print("error on jobMember_callback")
    end
    openJobGestion()
end)

local function checkModificationPerms(data)
    if data.recrute == perms.recrute and data.exclure == perms.exclure and data.editPerm == perms.editPerm and
        data.editMembres == perms.editMembres and data.sendDm == perms.sendDm then return 0 end
    if perms.recrute ~= data.recrute then perms.recrute = data.recrute end
    if perms.exclure ~= data.exclure then perms.exclure = data.exclure end
    if perms.editPerm ~= data.editPerm then perms.editPerm = data.editPerm end
    if perms.editMembres ~= data.editMembres then perms.editMembres = data.editMembres end
    if perms.sendDm ~= data.sendDm then perms.sendDm = data.sendDm end
    return perms
end

RegisterNUICallback("jobGestion_callback", function(data)
    print(data.recrute, data.exclure, data.editPerm, data.editMembres, data.sendDm)
    if players[sourcePlayer]["rank"] >= perms.editPerm then
        newPerms = checkModificationPerms(data)
        if (newPerms == 0) then print("perms not modified") end
        if (playerJob) then
            print(playerJob, newPerms.recrute)
            TriggerServerEvent("core:changePermsJob", token, playerJob, newPerms)
        else
            print("you dont have a job")
            return
        end
    else
        print("you dont have the perms to do that action")
        return
    end
    openJobGestion()
end)

RegisterNUICallback("focusOut", function(data, cb)
    EnableControlAction(0, 24, true) -- disable attack
    EnableControlAction(0, 25, true) -- disable aim
    EnableControlAction(0, 1, true) -- LookLeftRight
    EnableControlAction(0, 2, true) -- LookUpDown
    EnableControlAction(0, 142, true)
    EnableControlAction(0, 18, true)
    EnableControlAction(0, 322, true)
    EnableControlAction(0, 106, true)
    EnableControlAction(0, 263, true) -- disable melee
    EnableControlAction(0, 264, true) -- disable melee
    EnableControlAction(0, 257, true) -- disable melee
    EnableControlAction(0, 140, true) -- disable melee
    EnableControlAction(0, 141, true) -- disable melee
    EnableControlAction(0, 142, true) -- disable melee
    EnableControlAction(0, 143, true) -- disable melee
end)
