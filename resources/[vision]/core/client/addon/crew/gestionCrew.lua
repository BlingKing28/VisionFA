local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local sourcePlayer, playerCrew, crewInfo, crewMembers, crewGrade, crewVah, crewProperty, perms
RegisterCommand("crewGestion", function()
    if p:getCrew() ~= "None" then
        openCrewGestion()
    end
end)

local function listMember(crewMembers, crewGrade)
    local players = {}
    for i = 1, #crewMembers, 1 do
        players[i] = {}
        players[i]["lname"] = crewMembers[i].lastname
        players[i]["fname"] = crewMembers[i].firstname
        players[i]["license"] = crewMembers[i].license
        players[i]["rank"] = crewMembers[i].rank
        if p:getLicense() == crewMembers[i].license then sourcePlayer = i end
    end
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
        local var1, var2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
        local street = GetStreetNameFromHashKey(var1);
        local quarter = GetStreetNameFromHashKey(var2);
        property[i] = {}
        property[i]["type"] = data.type
        property[i]["address"] = street
        property[i]["id"] = crewProperty[i].id
    end
    return property
end

function isJson(crewInfo)
    if type(crewInfo.perm) == "string" then
        return json.decode(crewInfo.perm) 
    end
    return crewInfo.perm
end

function openCrewGestion()
    if p:getCrew() == "None" then
        return
    end
    playerCrew = p:getCrew()
    crewInfo, crewMembers, crewGrade = TriggerServerCallback("core:getCrewInfo", token, playerCrew)
    crewVeh = TriggerServerCallback("core:getCrewVeh", token, playerCrew)
    crewProperty = TriggerServerCallback("core:getCrewProperty", token, playerCrew)
    perms = isJson(crewInfo)
    players, sourcePlayer = listMember(crewMembers, crewGrade)

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
            color_title = crewInfo.color,
            background = crewInfo.color,
            crewName = crewInfo.name,
            crewDevise = crewInfo.devise,
            membres = #players,
            rang = players[sourcePlayer]["rank"],
            territoires = 3,
            recrute = perms.recrute,
            exclure = perms.exclure,
            editPerm = perms.editPerm,
            editMembres = perms.editMembres,
            sendDm = perms.sendDm,
            crewOrEnterprise = true,
            nbrRank = 5,
            jobLabel = "",
            players = players,
            properties = listProperty(crewProperty),
            vehs = listVeh(crewVeh)
        }
    }));
end

local function getIdFromlicense(license)
    for i = 1, #crewMembers, 1 do
        if (crewMembers[i].license == license) then
            return crewMembers[i].player_id

        end
    end
    return "error cant find member id"
end

RegisterNUICallback("crewMember_callback", function(data)
    local tablee = {}
    for k, v in pairs(GetActivePlayers()) do
        table.insert(tablee, GetPlayerServerId(v))
    end
    local selectedMember = {
        player_id = getIdFromlicense(data.player.license),
        crew_id = crewInfo.id
    }
    if data.action == "infoPlayer" then
    elseif data.action == "upPlayer" then
        if players[sourcePlayer]["rank"] <= perms.editMembres then
            TriggerServerEvent("core:promoteCrewMember", token, selectedMember, data.player.rank - 1, tablee)
        else
            print("you dont have the perms to do that action")
            return
        end
    elseif data.action == "downPlayer" then
        if players[sourcePlayer]["rank"] <= perms.editMembres then
            TriggerServerEvent("core:promoteCrewMember", token, selectedMember, data.player.rank + 1, tablee)
        else
            print("you dont have the perms to do that action")
            return
        end
    elseif data.action == "kickPlayer" then
        if players[sourcePlayer]["rank"] <= perms.exclure then
            TriggerServerEvent("core:excludeCrewMember", token, selectedMember, tablee)
        else
            print("you dont have the perms to do that action")
            return
        end
    else
        print("error on crewMember_callback")
    end
    openCrewGestion()
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

RegisterNUICallback("crewGestion_callback", function(data)
    if players[sourcePlayer]["rank"] >= perms.editPerm then
        newPerms = checkModificationPerms(data)
        if (newPerms == 0) then print("perms not modified") return end
        if (playerCrew) then
            TriggerServerEvent("core:changePerms", token, playerCrew, newPerms)
        else
            print("you dont have a crew")
            return
        end
    else
        print("you dont have the perms to do that action")
        return
    end
    openCrewGestion()
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
