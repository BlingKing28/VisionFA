local PlayersToken = {}
PlayersLastTrigger = {}

local function DoesPlayerHaveToken(source)
    if PlayersToken[source] == nil then
        return false
    else
        return true
    end
end

local function SetPlayerToken(source, token)
    if not DoesPlayerHaveToken(source) then
        PlayersToken[source] = token
        return true
    else
        return false
    end
end

function CheckPlayerToken(source, token)
    if DoesPlayerHaveToken(source) then
        if PlayersToken[source] == token then
            return true
        else
            return false
        end
    else
        return false
    end
end

function CheckLastTrigger(source, time)
    if PlayersLastTrigger[source] == nil then
        PlayersLastTrigger[source] = time
        return true
    else
        if PlayersLastTrigger[source] == time or tonumber(time) < tonumber(PlayersLastTrigger[source]) then
            return false
        else
            PlayersLastTrigger[source] = time
            return true
        end
    end
end

function CheckGiveTrigger(source, time, secu, item, count, ban)
    if CheckLastTrigger(source, time) then
        local size = GetPlayer(source):getSize()
        local fname = GetPlayer(source):getFirstname()
        local crypte = _TRGSE(source..time..tostring(count)..size..item..fname)
        if tostring(crypte) == tostring(secu) then
            return true
        else
            if count == nil then count = "0" end
            SunWiseKick(source, "(Give Trigger) : "..ban.." - Item : "..item.." x"..tostring(count))
            DropPlayer(source, "(Give Trigger) : "..ban.." - Item : "..item.." x"..tostring(count))
            return false
        end
    else
        PlayersLastTrigger[source] = nil
        SunWiseKick(source, "(Try a fake exec) : "..ban.." - Item : "..item.." x"..tostring(count))
        DropPlayer(source, "(Try a fake exec) : "..ban.." - Item : "..item.." x"..tostring(count))
    end
end

function CheckTrigger(source, time, secu, ban)
    if CheckLastTrigger(source, time) then
        local size = GetPlayer(source):getSize()
        local fname = GetPlayer(source):getFirstname()
        local crypte = _TRGSE(fname..time..source..size)
        if tostring(crypte) == tostring(secu) then
            return true
        else
            SunWiseKick(source, "(Execute Trigger) : "..ban)
            DropPlayer(source, "(Execute Trigger) : "..ban)
            return false
        end
    else
        PlayersLastTrigger[source] = nil
        SunWiseKick(source, "(Try a fake exec) : "..ban)
        DropPlayer(source, "(Try a fake exec) : "..ban)
    end
end

function CheckPlayerJob(source, jobNeeded)
    local player = GetPlayer(source)
    if player:getJob() ~= jobNeeded then
        -- ban ?
        return false
    else
        return true
    end
end

AddEventHandler("playerDropped", function()
    local src = source
    PlayersLastTrigger[src] = nil
end)


RegisterNetEvent("core:RegisterPlayerToken")
AddEventHandler("core:RegisterPlayerToken", function(t)
    if not SetPlayerToken(source, t) then
        DropPlayer(source, "Red is kidda sus nah ?") -- TODO Vrais système de ban
    end
end)


RegisterNetEvent("core:WrongTokenRequest")
AddEventHandler("core:WrongTokenRequest", function(ressource)
    DropPlayer(source, "Red is kidda sus nah ? " .. ressource) -- TODO Vrais système de ban
end)

local StoreSunWise = false

local function funcRestartBoucle()
    Citizen.Wait(15000)
    StoreSunWise = false
end

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == "SunWise" then
        print("Stored resource SunWise has whitelisted for stop checks")
        StoreSunWise = true
        funcRestartBoucle()
    end
end)

local Images = {}

RegisterNetEvent("core:getscreenshotsw", function(img, id)
    Images[id] = img
end)

local discordwb = "achanger"

RegisterNetEvent("sw:detect2222", function(hasreason)
    local src = source
    if GetResourceState("SunWise") ~= hasreason then
        if not StoreSunWise then
            SendToDiscIGAC(src, hasreason and "La personne a essayé de stop la ressource SunWise. Etat de la ressource : " .. hasreason or "La personne a essayé de stop la ressource SunWise (check core)", true)
        end
    end
end)

local function getGoodDiscord(discord)
    if discord and string.find(discord, "discord:") then 
        newdiscord = discord:gsub("discord:", "")
        newdiscord = discord .. " ( <@" .. newdiscord .. "> )"
        return newdiscord
    end
    return discord
end

local BanIds = {}
function SendToDiscIGAC(sourcep, message, shouldsendimage, webhh)
    local embeded = {}
    local img    
    TriggerClientEvent("core:takescreensw", tonumber(sourcep), "http://imageserver.visionrp.fr/upload/", sourcep)
    Wait(1000)
    local license, identifier, liveid, xblid, discord, playerip = "N/A", "N/A","N/A","N/A","N/A","N/A"
    for k,v in ipairs(GetPlayerIdentifiers(sourcep))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
            identifier = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xblid  = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            playerip = v
        end
    end
    local RandomizeNumber1 = math.random(11, 999)
    local RandomizeNumber2 = math.random(22, 8888)                        
    local banid = RandomizeNumber1 .. "TEMPCORE" .. RandomizeNumber2
    if shouldsendimage and Images then
        local shouldbreak = 1000
        while Images[sourcep] == nil do Wait(1) shouldbreak = shouldbreak - 1 if shouldbreak < 0 then break end end
        img = Images[sourcep]
        discord = getGoodDiscord(discord)
        local tokens = {}
        for i = 0, GetNumPlayerTokens(sourcep)-1 do
            if GetPlayerToken(sourcep, i) ~= nil then
                table.insert(tokens, GetPlayerToken(sourcep, i))
            end
        end
        Wait(80)
        local table = {}
        table.banid = banid
        table.id = sourcep
        table.license = license
        table.liveid = liveid
        table.identifier = identifier
        table.discord = discord
        table.xblid = xblid
        table.msg = message
        table.playerip = playerip
        table.tokens = tokens
        table.img = img
        Wait(50)
        TriggerEvent("sw:sendinfoban", table)
        embeded = {
            {
                ["title"]= GetPlayerName(sourcep) .. " (ID : ".. sourcep ..")",
                ["type"]="rich",
                ["color"] =15105570,
                ["description"] = "**License** : " .. license .. "\n**Steam** : ".. identifier .."\n**LiveID** : ".. liveid .."\n**Discord** : ".. discord .."\n**Player Endpoint** : ".. playerip .." (ping : ".. GetPlayerPing(sourcep) .." ms)\n\n" .. message ..  "\n**BanID** : " .. banid,
                ["footer"]=  {
                    ["text"]= "by Flozii#0502",
                    ["icon_url"] = logo,
                },
                ["image"] = {
                    ["url"] = img,
                }
            }
        }
    else
        embeded = {
            {
                ["title"]= GetPlayerName(sourcep) .. " " .. "(ID : ".. sourcep ..")",
                ["type"]="rich",
                ["color"] =15105570,
                ["description"] = "**License** : " .. license .. "\n**Steam** : ".. identifier .."\n**LiveID** : ".. liveid .."\n**Discord** : ".. discord .."\n**Player Endpoint** : ".. playerip .." (ping : ".. GetPlayerPing(sourcep) .." ms)\n\n" .. message ..  "\n**BanID** : " .. banid,
                ["footer"]=  {
                    ["text"]= "by Flozii#0502",
                    ["icon_url"] = logo,
                }
            }
        }
    end
    PerformHttpRequest(webhh and webhh or discordwb, function(err, text, headers) end, 'POST', json.encode({ username = "SunWise Anticheat",  embeds = embeded}), { ['Content-Type'] = 'application/json' })
end

local Checkings = {}

RegisterNetEvent("core:secu:ImConnected", function()
    local src = source
    table.insert(Checkings, {src = src, count = 0, checked = false})
    TriggerClientEvent("sw:checkalive", src)
end)

RegisterNetEvent("core:sw:alivechecker", function()
    local src = source 
    for k,v in pairs(Checkings) do 
        if tonumber(src) == tonumber(Checkings[k].src) then 
            table.remove(Checkings, k)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(1000)
        if GetResourceState("SunWise") == "started" then
            for k,v in pairs(Checkings) do 
                if v then 
                    --if Checkings[k].checked == false then
                        Checkings[k].count = Checkings[k].count + 1
                        if Checkings[k].count > 15 then 
                            if GetPlayerName(Checkings[k].src) and GetPlayerPing(Checkings[k].src) < 1000.0 then
                                SendToDiscIGAC(tonumber(Checkings[k].src), "La personne a essayé de **freeze** la ressource SunWise. Temps sans réponse : " .. Checkings[k].count .. " secondes", true)
                                Checkings[k].count = 1
                                --Checkings[k].checked = true
                            else
                                Checkings[k].count = 1
                            end
                        end
                    --end
                end
            end
        end
    end
end)