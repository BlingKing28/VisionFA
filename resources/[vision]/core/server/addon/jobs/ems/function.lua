RegisterNetEvent("core:RevivePlayer")
AddEventHandler("core:RevivePlayer", function(token, player)
    local source = source
    if CheckPlayerToken(source, token) then
        if GetPlayer(source):getPermission() >=2 or GetPlayer(source):getJob() == "ems" or GetPlayer(source):getJob() == "lsfd" or GetPlayer(source):getJob() == "bcms" then 
        --si tu veux rajouter des genres de récompenses au mec qui l'a réa tu peux le faire ici
            TriggerClientEvent('core:RevivePlayer', player)
        else
            DropPlayer(source, "T'es qui ?")
        end
    end
end)

RegisterNetEvent("core:HealthPlayer")
AddEventHandler("core:HealthPlayer", function(token, player)
    if CheckPlayerToken(source, token) then
        TriggerClientEvent('core:HealthPlayer', player)
    end
end)

RegisterNetEvent("core:GetPatientIdentity")
AddEventHandler("core:GetPatientIdentity", function(token, player)
    local src = source
    if CheckPlayerToken(src, token) then
        local player = GetPlayer(player)
        if player ~= nil then
            TriggerClientEvent('core:GetPatientIdentity', src, player:getIdentity())
        end
    end
end)

RegisterNetEvent("core:GetCauseOfDeath")
AddEventHandler("core:GetCauseOfDeath", function(token, player)
    local src = source
    if CheckPlayerToken(src, token) then
        local _player = GetPlayer(player)
        if _player ~= nil then
            local death = TriggerClientCallback(player, 'core:GetCauseOfDeath')
            TriggerClientEvent('core:GetCauseOfDeath', src, death)
        end
    else
        --AC:Todo
    end
end)

RegisterServerEvent("core:reviveanimrevived")
AddEventHandler("core:reviveanimrevived", function(players, playerheading, coords, playerlocation)
    local src = source
    SendDiscordLog("reviveems", src, string.sub(GetDiscord(src), 9, -1),
        GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(),
         coords, 
         GetPlayer(players):getLastname() .. " " .. GetPlayer(players):getFirstname(), 
         string.sub(GetDiscord(players), 9, -1))
    TriggerClientEvent("core:anim:revived", players, playerheading, coords, playerlocation, src)
    
end)

RegisterServerEvent("core:reviveanimreviver")
AddEventHandler("core:reviveanimreviver", function(players, playerheading, coords, playerlocation)
    local src = source
    TriggerClientEvent("core:anim:reviver", players)
end)

local brancardlist = {}

--Precondition : model de brancard valide et existe
--Postcondition : Ajoute le brancard concerné avec le joueur dessus à la table brancardlist
RegisterServerEvent("core:tableinsertplayer")
AddEventHandler("core:tableinsertplayer",function(model)
    local player = source
    model = json.encode(model)
    if brancardlist[model] == nil then
        brancardlist[model] = {}
    end
	table.insert(brancardlist[model], player)
   -- print(json.encode(brancardlist))
end)

--Precondition : model de brancard valide et existe
--Postcondition : Retire le brancard concerné avec le joueur dessus à la table brancardlist
RegisterServerEvent("core:tableremoveplayer")
AddEventHandler("core:tableremoveplayer",function(model)
    local player = source
    model = json.encode(model)
    if brancardlist[model] ~= nil then
        brancardlist[model] = nil
    end
   -- print(json.encode(brancardlist))
end)


--Precondition : model de brancard valide et existe, source valide
--Postcondition : Check si le brancard est dans la table brancardlist et renvoie l'id du joueur dessus si oui. Aussi non retourne nil
Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(1000) end
    RegisterServerCallback("core:tablecheckplayer", function(source, model)
       -- print("test: " ..json.encode(model))
        model = json.encode(model)
        if brancardlist[model] == nil then
            return nil
        else
           -- print(brancardlist[model][1])
            return brancardlist[model][1]
        end
    end)
end)

--Precondition : player , un id joueur valide, model, un brancard valide, raison e {"baisserbrancard", "releverbrancard", nil} 
--Postcondition : Appel côté client l'allongement du joueur sur le brancard 
RegisterServerEvent("core:leanbrancardserver")
AddEventHandler("core:leanbrancardserver",function(player, model, raison)
    TriggerClientEvent("core:leanbrancard", player, nil ,model, raison)
end)

--Precondition : player , un id joueur valide, model, un brancard valide
--Postcondition : Appel côté client le relèvement du joueur sur le brancard 
RegisterServerEvent("core:leanoffbrancardserver")
AddEventHandler("core:leanoffbrancardserver",function(player, model)
    TriggerClientEvent("core:releaseleanbrancard", player, model)
end)
