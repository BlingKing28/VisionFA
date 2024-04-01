RegisterNetEvent('core:FreezePlayer')
AddEventHandler("core:FreezePlayer", function(token, id, staut)
    local src = source
    local id = id
    if CheckPlayerToken(src, token) then
        if GetPlayer(source):getPermission() >= 3 then
            TriggerClientEvent("core:FreezePlayer", tonumber(id), staut)
        else
            DropPlayer(source, "T'es qui ?")
        end
    else
        --AcTodo: Ac detection
    end
end)

RegisterNetEvent("core:ReturnPlayer", function(token, id, coords)
    if CheckPlayerToken(source, token) then
        if GetPlayer(source):getPermission() >= 2 then
            TriggerClientEvent("core:ReturnPlayer", tonumber(id), coords)
        end
    end
end)

RegisterNetEvent('core:GotoBring')
AddEventHandler("core:GotoBring", function(token, pId, id)
    local src = source
    if pId == nil then
        pId = src
    else
        id = src
    end
    if CheckPlayerToken(src, token) then
        if GetPlayer(src):getPermission() >= 2 then
            TriggerClientEvent("core:GotoBring", tonumber(pId), GetEntityCoords(GetPlayerPed(id)))
        else
            DropPlayer(src, "T'es qui ?")
        end
    else
        --AcTodo: Ac detection
    end
end)

RegisterNetEvent('core:KickPlayer')
AddEventHandler("core:KickPlayer", function(token, id, reason)
    local src = source
    local id = id
    if CheckPlayerToken(src, token) then
        if GetPlayer(src):getPermission() >= 3 then
            SendDiscordLog("kick", src, string.sub(GetDiscord(id), 9, -1), GetPlayer(id):getLastname() .. " " .. GetPlayer(id):getFirstname(), GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(), reason)
            DropPlayer(tonumber(id), reason)
        else
            DropPlayer(src, "T'es qui ?")
        end
    else
        --AcTodo: Ac detection
    end
end)

RegisterServerEvent("core:StaffSpectate")
AddEventHandler("core:StaffSpectate", function(token, id)
    local source = source
    if CheckPlayerToken(source, token) then
        if GetPlayer(source):getPermission() >= 3 then
            TriggerClientEvent("core:StaffSpectate", source, GetEntityCoords(GetPlayerPed(tonumber(id))), tonumber(id))
        else
            DropPlayer(source, "T'es qui ?")
        end
    else
        --AcTodo: Ac detection
    end
end)
