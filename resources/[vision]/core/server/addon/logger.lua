local isProduction = true

PerformHttpRequest('https://api.ipify.org/', function(err, text, headers)
    print("perf", err, text)
    if text == "94.23.188.114" or text == "135.125.4.181" then
        isProduction = true
    end
end)

function SendDiscordLog(type, source, ...)
    --print(type, logs[type].text, source)
    if logs[type] ~= nil and isProduction then
        text        = string.format(logs[type].text, source, ...)
        color       = logs[type].color
        local url   = url
        local embed = {
            {
                ["color"] = color,
                ["title"] = logs[type].title,

                ["description"] = text,
                ["footer"] = {
                    ["text"] = os.date("%Y/%m/%d %X"),
                    ["icon_url"] = "https://cdn.discordapp.com/attachments/791407719948091442/1010676021063843850/server_icon.png",

                },
            }
        }
        PerformHttpRequest(logs[type].hook, function(err, text, headers) end, 'POST',
            json.encode({ username = "LOG", embeds = embed,
                avatar_url = "https://cdn.discordapp.com/attachments/791407719948091442/1010676021063843850/server_icon.png" })
            , { ['Content-Type'] = 'application/json' })
    end
end

function SendDiscordLogImage(type, source, url, ...)
    if logs[type] ~= nil and isProduction then
        text        = string.format(logs[type].text, source, ...)
        color       = logs[type].color
        local url   = url
        local embed = {
            {
                ["color"] = color,
                ["title"] = logs[type].title,

                ["description"] = text,
                ["footer"] = {
                    ["text"] = os.date("%Y/%m/%d %X"),
                    ["icon_url"] = "https://cdn.discordapp.com/attachments/791407719948091442/1010676021063843850/server_icon.png",

                },
                ["image"] = {
                    ["url"] = url,
                } 


            }
        }
        PerformHttpRequest(logs[type].hook, function(err, text, headers) end, 'POST',
            json.encode({ username = "LOG", embeds = embed,
                avatar_url = "https://cdn.discordapp.com/attachments/791407719948091442/1010676021063843850/server_icon.png" })
            , { ['Content-Type'] = 'application/json' })
    end
end

exports('SendDiscordLog', function(type, source, ...)
    SendDiscordLog(type, source, ...)
end)

RegisterNetEvent("core:heistlog")
AddEventHandler("core:heistlog", function(id, pos)
    SendDiscordLog("heist", source, string.sub(GetDiscord(source), 9, -1),
        GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(), pos, id)
end)

RegisterNetEvent("core:logs")
AddEventHandler("core:logs", function(token, data)
    if CheckPlayerToken(source, token) then
        SendDiscordLog(data.type, source, string.sub(GetDiscord(source), 9, -1),
            GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(), data.value)
    else
        -- AC ban
    end
end)

RegisterNetEvent("core:perquisitionlog")
AddEventHandler("core:perquisitionlog", function(id, name, owner, crew)
    SendDiscordLog("perquisition", source, string.sub(GetDiscord(source), 9, -1),
        GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(),
        id, name, owner, crew)
    end)

RegisterNetEvent("core:sprayLog")
AddEventHandler("core:sprayLog", function(sprayLocation, finalText)
    SendDiscordLog("sprayLog", source, string.sub(GetDiscord(source), 9, -1),
        GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(),
        math.floor(sprayLocation.x), math.floor(sprayLocation.y), finalText)
end)

RegisterNetEvent("core:superette")
AddEventHandler("core:superette", function(totalMoney, name, reason)
    SendDiscordLog("superette", source, string.sub(GetDiscord(source), 9, -1),
        GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(),
        totalMoney, name, reason)
end)

RegisterNetEvent("core:ammunationtake")
AddEventHandler("core:ammunationtake", function(totalMoney, name, reason)
    SendDiscordLog("Ammunation-TakeItem", source, string.sub(GetDiscord(source), 9, -1),
        GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(),
        totalMoney, name, reason)
end)