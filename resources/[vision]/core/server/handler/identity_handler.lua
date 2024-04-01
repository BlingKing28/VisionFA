RegisterNetEvent("core:SetPlayerIdentity")
AddEventHandler("core:SetPlayerIdentity", function(token, nom, prenom, age, sexe, taille, birthplaces)
    if CheckPlayerToken(source, token) then
        local player = GetPlayer(source)
        player:setLastname(nom)
        player:setFirstname(prenom)
        player:setAge(age)
        player:setSex(sexe)
        player:setSize(taille)
        player:setBirthplaces(birthplaces)
        triggerEventPlayer("core:setIdentityPlayer", source, nom, prenom, age, sexe, taille, birthplaces)    
        --RefreshPlayerData(source)
        MarkPlayerDataAsNonSaved(source)
        SavePlayerData(source, true)
    end
end)


-- Changement du nom et prénom en BDD

RegisterCommand("identitycorrection", function(token, source)

    local nom = GetPlayer(token):getLastname()

    local prenom = GetPlayer(token):getFirstname()

    print('Nom : '..nom .. ' | Prénom : '.. prenom )

    GetPlayer(token):setLastname(prenom)
    GetPlayer(token):setFirstname(nom)

    local newnom = GetPlayer(token):getLastname()

    local newprenom = GetPlayer(token):getFirstname()

    print('New Nom : '..newnom .. ' | New Prénom : '.. newprenom )

end)

RegisterNetEvent("core:InstancePlayer")
AddEventHandler("core:InstancePlayer", function(token, instance, reason)
    local src = source
    if CheckPlayerToken(src, token) then
        SetPlayerRoutingBucket(src, tonumber(instance))
        ChangePlayerBucket(src, tonumber(instance))

        TriggerClientEvent("Core:PrintChangeInstance", src, src, tonumber(instance), reason)
    else
        ---ACEvent
    end
end)

Citizen.CreateThread(function()
    while RegisterServerCallback == nil do
        Wait(0)
    end
    RegisterServerCallback("core:CheckInstance", function(source)
        --if CheckPlayerToken(source, token) then
            if GetPlayerRoutingBucket(source) == 0 then
                return true
            else
                return false
            end
        --else
        --    ---ACEvent
        --end
    end)
    
    RegisterServerCallback("core:GetInstanceID", function(source)
        return GetPlayerRoutingBucket(source)
    end)
end)

RegisterCommand("getInstance", function(source, args, rawCommand)
    print(GetPlayerRoutingBucket(source))
end, false)

RegisterCommand("leaveinstance", function(source, args, rawCommand)
    SetPlayerRoutingBucket(source, 0)
    ChangePlayerBucket(source, 0)
end, false)

RegisterCommand("instance", function(source, args, rawCommand)
    if tonumber(args[1]) and tonumber(args[2]) then
        if GetPlayer(source):getPermission() >= 3 then
            SetPlayerRoutingBucket(tonumber(args[1]), tonumber(args[2]))
            ChangePlayerBucket(tonumber(args[1]), tonumber(args[2]))
        end
    else
        SetPlayerRoutingBucket(source, 0)
        ChangePlayerBucket(source, 0)
    end
end, false)

exports("playerIdentity", function(playerid)
    return {prenom = GetPlayer(playerid):getFirstname(), nom = GetPlayer(playerid):getLastname()}
    --return GetPlayer(playerid):getIdentity()
end)

exports("getId", function(playerid)
    return GetPlayer(playerid):getId()
end)
