local bans = {}

function IsPlayerBanned(source)
    local ids = GetPlayerIdentifiers(source)
    --local tokens = {}
    --local numIds = GetNumPlayerTokens(source)
    --for i = 0, numIds - 1 do 
    --    table.insert(tokens, GetPlayerToken(source, i))
    --end
    local idsToCheck = {}
    for k, v in pairs(ids) do
        idsToCheck[v] = true
    end

    for k, v in pairs(bans) do
        for _, i in pairs(v.ids) do
            if idsToCheck[i] ~= nil then

                local exp = v.expiration
                local unban, d, h, m = CheckTimeRemaning(exp, k)
                if not unban then
                    return true, v, d, h, m
                else
                    return false
                end
            end
        end
    end
    return false
end

function CheckTimeRemaning(time, key)
    local d = 0
    local h = 0
    local m = 0
    local unban = false
    if time ~= 0 then
        if (tonumber(time)) > os.time() then

            local tempsrestant = (((tonumber(time)) - os.time()) / 60)
            if tempsrestant >= 1440 then
                local day = (tempsrestant / 60) / 24
                local hrs = (day - math.floor(day)) * 24
                local minutes = (hrs - math.floor(hrs)) * 60
                d = math.floor(day)
                h = math.floor(hrs)
                m = math.ceil(minutes)
            elseif tempsrestant >= 60 and tempsrestant < 1440 then
                local day = (tempsrestant / 60) / 24
                local hrs = tempsrestant / 60
                local minutes = (hrs - math.floor(hrs)) * 60
                d = math.floor(day)
                h = math.floor(hrs)
                m = math.ceil(minutes)
            elseif tempsrestant < 60 then
                d = 0
                h = 0
                m = math.ceil(tempsrestant)
            end
        else
            unban = true
            DeleteBan(key)
        end
    end
    return unban, d, h, m
end

function BanPlayer(source, raison, time2, by, heureoujour)
    local source = source
    local ids = GetPlayerIdentifiers(source)
    local time = 0
    if heureoujour == nil then heureoujour = "heure" end
    heureoujour = string.lower(heureoujour)
    
    if heureoujour == "heures" then 
        time = time2 * 3600
    elseif heureoujour == "jours" then 
        time = time2 * 86400
    elseif heureoujour == "perm" then 
        time = 0
    end
    local expiration = time
    local added = os.date("%d/%m/%Y %X")

    if expiration < os.time() and heureoujour ~= "perm" then
        expiration = os.time() + expiration
    end
    local timetext = heureoujour ~= "perm" and (time2 .. " " .. heureoujour) or "Permanent"
    DropPlayer(source, "Ban: " .. raison .. "\n\nTemps: " .. timetext)
    math.randomseed(os.time())
    local idban = math.random(112, 9999) + math.random(11, 99) + 999
    table.insert(bans, { raison = raison, ids = ids, by = GetPlayerName(by), expiration = expiration, banDate = tostring(added), id = idban})
    
    SendDiscordLog("ban", source, string.sub(GetDiscord(source), 9, -1), GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(),
        by, string.sub(GetDiscord(by), 9, -1), GetPlayer(by):getLastname() .. " " .. GetPlayer(by):getFirstname(),
        raison, tostring(expiration), idban)
    MySQL.Async.insert("INSERT INTO `ban` (`ids`, `raison`, `by`, `expiration`, `date`) VALUES (@1, @2, @3, @4, @5)",
    {
        ["@1"] = json.encode(ids),
        ["@2"] = raison,
        ["@3"] = by and GetPlayerName(by) or "CONSOLE",
        ["@4"] = tostring(expiration),
        ["@5"] = tostring(added),
    },
    function(affectedRows)
    end)
end

function UnBanPlayer(id)
    for k,v in pairs(bans) do 
        if v.id == id then 
            table.remove(bans, k)
        end
    end
    MySQL.Async.execute("DELETE FROM ban WHERE id = @id",
    {
        ['@id'] = id,
    },
    function(affectedRows)
    end)
end

function DeleteBan(key)
    MySQL.Async.execute("DELETE FROM ban WHERE ban.ids = @1 AND ban.expiration = @2 AND ban.date = @3",
    {
        ['@1'] = json.encode(bans[key].ids),
        ['@2'] = bans[key].expiration,
        ['@3'] = bans[key].banDate,
    },
    function(affectedRows)
        bans[key] = nil
    end)
end

-- Init
MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * FROM ban', {}, function(result)

        for k, v in pairs(result) do
            table.insert(bans,
                { id = v.id, raison = v.raison, ids = json.decode(v.ids), by = v.by, expiration = tonumber(v.expiration), banDate = v.date,
                    needSave = false })
        end
    end)
end)

RegisterNetEvent("core:ban:banplayer")
AddEventHandler("core:ban:banplayer", function(token, id, raison, time, by, heureoujour)
    local src = source
    if CheckPlayerToken(src, token) then
        if GetPlayer(src):getPermission() >= 3 then
            BanPlayer(id, raison, time, by, heureoujour)
        else
            DropPlayer(src, "Red is kinda sus")
        end
    end
end)

RegisterNetEvent("core:ban:unbanplayer", function(token, id)
    local src = source
    if CheckPlayerToken(src, token) then
        if GetPlayer(src):getPermission() >= 3 then
            UnBanPlayer(id)
        else
            DropPlayer(src, "Red is kinda sus")
        end
    end
end)