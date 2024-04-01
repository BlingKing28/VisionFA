-- External calls

AddEventHandler("server:queue:CheckIfPlayerIsBanned", function(source, cb)
    local bool, table, day, hour, min = IsPlayerBanned(source)
    cb(bool, table, day, hour, min)
end)


AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    local src = source
    deferrals.defer()
    Wait(0)
    deferrals.update("Vous rejoignez...")
    Wait(0)
    local boolean, table, day, hour, min = IsPlayerBanned(src)
    if boolean then
        local table = table or {raison = "Aucune raison", id = "Aucun ID"}
        local day = day or "0"
        local hour = hour or "0"
        local min = min or "0"

        deferrals.done("Vous avez été banni !\n\nRaison du ban : " .. table.raison .. " \nTemps restant : ".. day .. ' jours ' .. hour .. " heures " .. min .. " minutes" .."\nID Ban : " .. table.id)
    end
    deferrals.done()
end)