local cheatname = "SunWise AntiCheat"

local generalstatus = "Starting"
local statuswl = "Waiting for someone to log on"
local statusversion = "Checking"
local isProduction = true
-- Ban ID table when CFG.LOGSONLY is true
local AllBanIds = {}
local AllStoredExplosions = {}

SetConvarServerInfo(cheatname, "🌞 This server is secured by " ..cheatname)

local function SWPrint(message)
    return print("[^4"..cheatname.."^7] " .. message)
end

local function printErr(message)
    return print("[^4"..cheatname.."^7] [^1ERROR^7] " .. message)
end

local function printSucc(message)
    return print("[^4"..cheatname.."^7] [^2SUCCESS^7] " .. message)
end

function printLang(msgFR, msgEN)
    if Cfg.Lang == "FR" then
        return print("[^4"..cheatname.."^7] " .. msgFR)
    elseif Cfg.Lang == "EN" then
        return print("[^4"..cheatname.."^7] " .. msgEN)
    end
end

local function printDev(msg)
    return print("[^4"..cheatname.."^7] [^5DEV MODE^7] " .. msg)
end

if Cfg.Lang ~= nil then
    if not string.upper(Cfg.Lang) == "FR" or not string.upper(Cfg.Lang) == "EN" then
        Cfg.Lang = "EN"
        printErr("^1You did not set an language for the " .. cheatname .. ". ^4Using \"EN\" language.^1 Please set your language in config.lua of " .. GetCurrentResourceName() .. " script ^7")
    end
else
    printErr("^1Cfg.Lang in config file is nil ^7")
end

function GetLang()
    return string.upper(Cfg.Lang)
end

if CfgSH.UseESX == true then
    ESX = nil
    TriggerEvent(CfgSH.SharedObjectTrigger, function(obj) ESX = obj end)
end

local function tableContains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

ServerCallbacks = {}

RegisterNetEvent('tsc:ws:sw', function(name, requestId, ...) -- trigger server callback
    local _source = source
    TriggerServerCallback(name, requestID, _source, function(...)
        TriggerClientEvent('swcallbppp', _source, requestId, ...)
    end, ...)
end)

RegisterServerCallback = function(name, cb)
    ServerCallbacks[name] = cb
end

TriggerServerCallback = function(name, requestId, source, cb, ...)
    if ServerCallbacks[name] ~= nil then
        ServerCallbacks[name](source, cb, ...)
    else
    end
end

RegisterServerCallback("sw:checkgroup", function(source, cb)
    local discord = "N/A"
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        end
    end
    cb(discord)
end)

RegisterServerCallback("sw:detect8888", function(source, cb)
    cb(IsPlayerUsingSuperJump(source))
end)

local catProtector = [[
            ^3SunWise AntiCheat^7
    
                          (`.-,')
                        .-'     ;
                    _.-'   , `,-
              _ _.-'     .'  /._
            .' `  _.-.  /  ,'._;)
           (       .  )-| (
            )`,_ ,'_,'  \_;)
    ('_  _,'.'  (___,))
     `-:;.-'
]]

local catplaying = [[
    ._       __          ____
    ;  `\--,-' /`)    _.-'    `-._
     \_/    ' | /`--,'  ^3SunWise^7   `-.     .--....____
      /                  ^3Anticheat^7    `._.'           `---...
      |-.   _      ;                        .-----..._______)
    ,,\q/ (q_>'_...                      .-'
    ===/ ; _.-'===             /       ,'
    `""`-'_,;  `""`        ___(       |
             \         ; /'/   \      \
              `.      //' (    ;`\    `\
              / \    ;     `-  /  `-.  /
             (  (;   ;     (__/    /  /
              \,_)\  ;           ,'  /
      .-.          |  |           `--'
     (^1MOD^7)-._     (__,>      
     ^2Developped by Flozii#0502^7
]]

function SWPrintDebug(message)
    if Cfg.DebugInfo == true then
        return print("[^4"..cheatname.."^7] [^3DEBUG^7] " .. message)
    end
end

if GetCurrentResourceName() ~= "SunWise" then
    print("^6------------------------^7")
    print("^6------------------------^7")
    print("^6------------------------^7")
    print("^6------------------------^7")
    print("^6------------------------^7")
    printLang("[^1Error^7] Le nom de l'anticheat doit être SunWise, si il ne s'appelle pas comme cela il ne fonctionnera pas", "[^1Error^7] The name of the anticheat must be SunWise, if it is not called like that it will not work.")
    print("^6------------------------^7")
    print("^6------------------------^7")
    print("^6------------------------^7")
    print("^6------------------------^7")
    print("^6------------------------^7")
    printLang("Arret de l'anticheat ...", "Stopping the anticheat ...")    
    generalstatus = "Stopped"
    print("^6------------------------^7")
    print("Stopping resource " .. GetCurrentResourceName())
    return
end

if string.find(string.lower(GetCurrentResourceName()), "anticheat") then
    print("^6------------------------^7")
    print("^6------------------------^7")
    print("^6------------------------^7")
    print("^6------------------------^7")
    print("^6------------------------^7")
    if GetLang() == "FR" then
        printErr("^1Le nom de l'anticheat ne doit pas contenir \"anticheat\".\nLes cheaters pourront exploiter cette ressource !^7")
    elseif GetLang() == "EN" then
        printErr("^1The anticheat name must not contain \"anticheat\". Cheaters will be able to exploit this resource !^7")
    end
    print("^6------------------------^7")
    print("^6------------------------^7")
    print("^6------------------------^7")
    print("^6------------------------^7")
    print("^6------------------------^7")
    if GetLang() == "FR" then
        SWPrint("Arret de l'anticheat ...")    
    elseif GetLang() == "EN" then
        SWPrint("Stopping the anticheat ...")  
    end
    generalstatus = "Stopped"
    print("^6------------------------^7")
    print("Stopping resource " .. GetCurrentResourceName())
    StopResource(GetCurrentResourceName())
    return
elseif string.find(string.lower(GetCurrentResourceName()), "anti") then
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    if GetLang() == "FR" then
        printErr("^1Le nom de l'anticheat ne doit pas contenir \"anti\".\nLes cheaters pourront exploiter cette ressource !^7")
    elseif GetLang() == "EN" then
        printErr("^1The anticheat name must not contain \"anti\". Cheaters will be able to exploit this resource !^7")
    end
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    if GetLang() == "FR" then
        SWPrint("Arret de l'anticheat ...")    
    elseif GetLang() == "EN" then
        SWPrint("Stopping the anticheat ...")  
    end
    generalstatus = "Stopped"
    print("^6------------------------------------------------------------------------------------------------^7")
    print("Stopping resource " .. GetCurrentResourceName())
    StopResource(GetCurrentResourceName())
    return
elseif string.find(string.lower(GetCurrentResourceName()), "cheat") then
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    if GetLang() == "FR" then
        printErr("^1Le nom de l'anticheat ne doit pas contenir \"cheat\".\nLes cheaters pourront exploiter cette ressource !^7")
    elseif GetLang() == "EN" then
        printErr("^1The anticheat name must not contain \"cheat\". Cheaters will be able to exploit this resource !^7")
    end
    generalstatus = "Stopped"
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    print("^6------------------------------------------------------------------------------------------------^7")
    if GetLang() == "FR" then
        SWPrint("Arret de l'anticheat ...")    
    elseif GetLang() == "EN" then
        SWPrint("Stopping the anticheat ...")  
    end
    generalstatus = "Stopped"
    print("^6------------------------------------------------------------------------------------------------^7")
    print("Stopping resource " .. GetCurrentResourceName())
    StopResource(GetCurrentResourceName())
    return
else
    print(catProtector)
    if GetLang() == "FR" then
        print("^2Pour plus d'informations, veuillez visiter^7 -> https://discord.gg/BKvG2Dy7rf")    
    elseif GetLang() == "EN" then
        print("^2For more informations, please visit^7 -> https://discord.gg/BKvG2Dy7rf")    
    end
end
print("")
print("")

CreateThread(function()
    while not Cfg do Wait(1) end
    if Cfg.ShouldSendWebhook() then
        isProduction = true
    else
        isProduction = false
    end

    -- Convars
    if Cfg.AntiPlaySound then
        SetConvar("sv_enableNetworkedSounds", "false")
    end
end)

function checkversion(err, response, headers)
    local data = json.decode(response)
    local get_data_file = LoadResourceFile(GetCurrentResourceName(), "version.json")
    local version_json = json.decode(get_data_file).version
    if err == 200 then
        statusversion = "Checking version"
        if tostring(version_json) ~= tostring(data.version) and tostring(version_json) < tostring(data.version) then
            if GetLang() == "FR" then
                printErr("^1Votre version semble être passé ! Votre version : ".. version_json ..". Nouvelle version " .. data.version .. ".^7\n^4Merci de télécharger la nouvelle version sur^7 https://discord.gg/BKvG2Dy7rf.")
            elseif GetLang() == "EN" then
                printErr("^2Your version seems to have passed.^7\n^4Please download the new version on^7 https://discord.gg/BKvG2Dy7rf")
            end
            statusversion = "Your version seems to have passed. Please download the new version on https://discord.gg/BKvG2Dy7rf"
        elseif tostring(version_json) > tostring(data.version) then
            if GetLang() == "FR" then
                printErr("^1Votre version semble être trop haute !^7\n^4Merci de télécharger la nouvelle version sur^7 https://discord.gg/BKvG2Dy7rf.")
            elseif GetLang() == "EN" then
                printErr("^2Your version seems to be too high.^7\n^4Please download the new version on^7 https://discord.gg/BKvG2Dy7rf")
            end
            statusversion = "Your version seems to be higher than the anticheat version."
        else
            if GetLang() == "FR" then
                printSucc("^2Vous avez la derniere version de l'anticheat.^7")
            elseif GetLang() == "EN" then
                printSucc("^2You have the lastest version of the anticheat.^7")
            end
            statusversion = "You have the lastest version of the anticheat"
        end
    else
        if err == 502 then
            printErr("Error while checking version. Main site is down (" .. err .. ")")
            statusversion = "Error main site is down, retying"
            Wait(60000)
            requestCheckHTTP()
        else
            Wait(3000)
            statusversion = "Error : " .. err .. ". Retrying..."
            printErr("Error while checking version. Error ID : " .. err)
            Wait(60000)
            requestCheckHTTP()
        end
    end
    SetTimeout(3600000, requestCheckHTTP)
end

function requestCheckHTTP()
    PerformHttpRequest("https://pastebin.com/raw/wFz8mUcc", checkversion, "GET")
end

requestCheckHTTP()

local function OnPlayerConnecting(name, setKickReason, deferrals)
    local source = source
    SendToDiscIG(source, string.format(CfgSH.IsConnecting, GetPlayerName(source), source), nil, nil, "Connections")

    if Cfg.AntiVpn then
        local ip = tostring(GetPlayerEndpoint(source))
        local xPlayer = nil
        if CfgSH.UseESX then
            xPlayer = ESX.GetPlayerFromId(source)
        end
        PerformHttpRequest("https://blackbox.ipinfo.app/lookup/" .. ip, function(errorCode, resultDatavpn, resultHeaders)
            if resultDatavpn == "N" then
                if GetLang() == "FR" then
                    SWPrintDebug(name .. " se connecte sans vpn. IP : " .. ip)
                elseif GetLang() == "EN" then
                    SWPrintDebug(name .. " is connecting without a vpn. IP : " .. ip)
                end
            else
                SWPrintDebug(name .. " is connecting with a vpn : " .. ip)
                local group = utils_Set(Cfg.WhitelistedGroups)
                if CfgSH.UseESX then
                    if not group[xPlayer.getGroup()] then
                        setKickReason(CfgSH.VpnKick)
                        SendToDiscIG(source, string.format(CfgSH.IsUsingVpn, name), nil, nil, "VpnBlacklist")
                    else
                        if GetLang() == "FR" then
                            SWPrint("" .. name .. " se connecte avec un VPN mais il est staff.")
                        elseif GetLang() == "EN" then
                            SWPrint("" .. name .. " is connecting with an vpn but he is staff so the connection is allowed.")
                        end
                    end
                else
                    local perm = 0 --exports["core"]:GetPlayerPerm(source)
                    if not group[perm] then
                        setKickReason(CfgSH.VpnKick)
                        SendToDiscIG(source, string.format(CfgSH.IsUsingVpn, name), nil, nil, "VpnBlacklist")
                    else
                        if GetLang() == "FR" then
                            SWPrintDebug("" .. name .. " se connecte avec un VPN mais il est staff.")
                        elseif GetLang() == "EN" then
                            SWPrintDebug("" .. name .. " is connecting with an vpn but he is staff so the connection is allowed.")
                        end
                    end
                end
            end
        end)
    end

    if Cfg.AntiXSSInjection == true then
		local cname = string.gsub(name, "%s+", "")

        for k,v in pairs(Cfg.BlacklistedNames) do
            if string.find(cname, v) then
                setKickReason("Your username seems to be weird...\nIf this is an error, please contact the server owner\n\nSunWise AntiCheat")
                if string.find(cname, "<script") then
                    SendToDiscIG2("Blocking connection", "Blocked connection of **" .. name .. "**. Because he seems to be a bot and anti XSS injections is enabled", "AntiXSSInjection")
                else
                    SendToDiscIG2("Blocking connection", "Blocked connection of **" .. name .. "**. Because he has an blacklisted name.\nHis name contains " .. v .. "", "AntiXSSInjection")
                end
            end
        end

    end
end

AddEventHandler("playerConnecting", OnPlayerConnecting)

local logo = "https://cdn.discordapp.com/attachments/677585623736909834/832384107722965034/sunwisediscord.png"
Images = {}

local LastScreenID = nil
local function FlzScreenshot(id)
    --if LastScreenID ~= id then
    --    LastScreenID = id 
        TriggerClientEvent("sunwise:takescreen", tonumber(id), Cfg.HttpStoreImages, id)
   -- end
end

RegisterNetEvent("sunwise:getscreenshot", function(img, id)
    for k,v in pairs(Images) do 
        if v.id == id then 
            table.remove(Images, k)
        end
    end
    Wait(50)
    table.insert(Images, {id = id, img = img})
 --   print("sunwise:getscreenshot", img, id)
end)

function SendToDiscIG2(title,message, typer)
    if isProduction then
        local embed = {}
        embed = {
            {
                ["author"] = {                
                    ["name"] = "SunWise AntiCheat",
                    ["icon_url"] = logo,
                },
                ["title"]= title,
                ["type"]="rich",
                ["color"] =15105570,
                ["description"] = message,
                ["footer"]=  {
                    ["text"]= "by Flozii#0502",
                    ["icon_url"] = logo,
                },
            }
        }

        if message == nil or message == '' then return FALSE end
        PerformHttpRequest(Cfg.Webhook[typer], function(err, text, headers) end, 'POST', json.encode({ username = "SunWise AntiCheat",  embeds = embed}), { ['Content-Type'] = 'application/json' })
    end
end

local function getGoodDiscord(discord)
    if discord and string.find(discord, "discord:") then 
        newdiscord = discord:gsub("discord:", "")
        newdiscord = discord .. " ( <@" .. newdiscord .. "> )"
        return newdiscord
    end
    return discord
end

function tableHasValue(tablee, value)
    local toreturn = nil
    for k,v in pairs(tablee) do 
        if v == value then 
            toreturn = value
        end
    end
    return toreturn
end

function SendToDiscIG(sourcep, message, kickban, banid, typer, shouldsendimage)
    local embeded = {}
    local img
    
    if isProduction then
        local license, identifier, liveid, xblid, discord, playerip = "N/A", "N/A","N/A","N/A","N/A","N/A"
        for k,v in ipairs(GetPlayerIdentifiers(sourcep)) do
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
        if not tableHasValue(CfgSH.WhitelistedPlayers, discord) then 
            if Cfg.Screenshot == true and shouldsendimage then
                FlzScreenshot(sourcep)
                Wait(2000)
            end
            discord = getGoodDiscord(discord)
            if shouldsendimage and Images then
                for k,v in pairs(Images) do 
                    if v.id == sourcep then 
                        img = v.img
                    end
                end
                if kickban == nil then
                    embeded = {
                        {
                            ["title"]= GetPlayerName(sourcep) .. " " .. "(ID : ".. sourcep ..")",
                            ["type"]="rich",
                            ["color"] =15105570,
                            ["description"] = "**License** : " .. license .. "\n**Steam** : ".. identifier .."\n**LiveID** : ".. liveid .."\n**Discord** : ".. discord .."\n**Player Endpoint** : ".. playerip .." (ping : ".. GetPlayerPing(sourcep) .." ms)\n\n" .. message ..  "",
                            ["footer"]=  {
                                ["text"]= "by Flozii#0502",
                                ["icon_url"] = logo,
                            },
                            ["image"] = {
                                ["url"] = img,
                            }
                        }
                    }
                elseif string.lower(kickban) == "ban" then
                    embeded = {
                        {
                            ["title"]= GetPlayerName(sourcep) .. " " .. "(ID : ".. sourcep ..")",
                            ["type"]="rich",
                            ["color"] =15105570,
                            ["description"] = "**BanID**: ".. banid .."\n**License** : " .. license .. "\n**Steam** : ".. identifier .."\n**LiveID** : ".. liveid .."\n**Discord** : ".. discord .."\n**Player Endpoint** : ".. playerip .." (ping : ".. GetPlayerPing(sourcep) .." ms)\n\n" .. message ..  "",
                            ["footer"]=  {
                                ["text"]= "by Flozii#0502",
                                ["icon_url"] = logo,
                            },
                            ["image"] = {
                                ["url"] = img,
                            }
                        }
                    }
                elseif string.lower(kickban) == "kick" then
                    embeded = {
                        {
                            ["title"]= GetPlayerName(sourcep) .. " " .. "(ID : ".. sourcep ..")",
                            ["type"]="rich",
                            ["color"] =15105570,
                            ["description"] = "**License** : " .. license .. "\n**Steam** : ".. identifier .."\n**LiveID** : ".. liveid .."\n**Discord** : ".. discord .."\n**Player Endpoint** : ".. playerip .." (ping : ".. GetPlayerPing(sourcep) .." ms)\n\n" .. message ..  "",
                            ["footer"]=  {
                                ["text"]= "by Flozii#0502",
                                ["icon_url"] = logo,
                            },
                            ["image"] = {
                                ["url"] = img,
                            }
                        }
                    }                
                end
            else
                if kickban == nil then
                    embeded = {
                        {
                            ["title"]= GetPlayerName(sourcep) .. " " .. "(ID : ".. sourcep ..")",
                            ["type"]="rich",
                            ["color"] =15105570,
                            ["description"] = "**License** : " .. license .. "\n**Steam** : ".. identifier .."\n**LiveID** : ".. liveid .."\n**Discord** : ".. discord .."\n**Player Endpoint** : ".. playerip .." (ping : ".. GetPlayerPing(sourcep) .." ms)\n\n" .. message ..  "",
                            ["footer"]=  {
                                ["text"]= "by Flozii#0502",
                                ["icon_url"] = logo,
                            }
                        }
                    }
                elseif string.lower(kickban) == "ban" then
                    embeded = {
                        {
                            ["title"]= GetPlayerName(sourcep) .. " " .. "(ID : ".. sourcep ..")",
                            ["type"]="rich",
                            ["color"] =15105570,
                            ["description"] = "**BanID**: ".. banid .."\n**License** : " .. license .. "\n**Steam** : ".. identifier .."\n**LiveID** : ".. liveid .."\n**Discord** : ".. discord .."\n**Player Endpoint** : ".. playerip .." (ping : ".. GetPlayerPing(sourcep) .." ms)\n\n" .. message ..  "",
                            ["footer"]=  {
                                ["text"]= "by Flozii#0502",
                                ["icon_url"] = logo,
                            },
                        }
                    }
                elseif string.lower(kickban) == "kick" then
                    embeded = {
                        {
                            ["title"]= GetPlayerName(sourcep) .. " " .. "(ID : ".. sourcep ..")",
                            ["type"]="rich",
                            ["color"] =15105570,
                            ["description"] = "**License** : " .. license .. "\n**Steam** : ".. identifier .."\n**LiveID** : ".. liveid .."\n**Discord** : ".. discord .."\n**Player Endpoint** : ".. playerip .." (ping : ".. GetPlayerPing(sourcep) .." ms)\n\n" .. message ..  "",
                            ["footer"]=  {
                                ["text"]= "by Flozii#0502",
                                ["icon_url"] = logo,
                            },
                        }
                    }
                end
            end
            PerformHttpRequest(Cfg.Webhook[typer], function(err, text, headers) end, 'POST', json.encode({ username = "SunWise Anticheat",  embeds = embeded}), { ['Content-Type'] = 'application/json' })
        else
            if kickban ~= nil then
                SWPrintDebug(sourcep, message)
            end
        end
    end
end

local function kickplayer(player, msg, typer)
    if CfgSH.UseESX then
        for _,group in pairs(Cfg.WhitelistedGroups) do
            local xPlayer = ESX.GetPlayerFromId(player)
            if xPlayer.getGroup() ~= group then
                if player then
                    if player then
                        SendToDiscIG(player, string.format(CfgSH.WebHookTextKick, GetPlayerName(player), msg), "kick", nil, typer, true)
                        if GetLang() == "FR" then 
                            printkick("" .. GetPlayerName(player) .. " a été ^6kick^7 pour : ^2" .. msg .. "^7.")
                        elseif GetLang() == "EN" then 
                            printkick("" .. GetPlayerName(player) .. " has been ^6kicked^7 for : ^2" .. msg .. "^7.")
                        end
                        if CfgSH.DevMode == false then
                            DropPlayer(player, msg)
                        end
                    else
                        if GetLang() == "FR" then 
                            printErr("Un cheateur s'est déconnecté. Impossible de le retracer")
                        elseif GetLang() == "EN" then 
                            printErr("A cheater as logged out.")
                        end
                    end
                end
            end
        end
    else
        local group = utils_Set(Cfg.WhitelistedGroups)
        local perm = 0 --exports["core"]:GetPlayerPerm(playerid)
        if not group[perm] then
            if player then
                if player then
                    SendToDiscIG(player, string.format(CfgSH.WebHookTextKick, GetPlayerName(player), msg), "kick", nil, typer, true)
                    if GetLang() == "FR" then 
                        printkick("" .. GetPlayerName(player) .. " a été ^6kick^7 pour : ^2" .. msg .. "^7.")
                    elseif GetLang() == "EN" then 
                        printkick("" .. GetPlayerName(player) .. " has been ^6kicked^7 for : ^2" .. msg .. "^7.")
                    end
                    if CfgSH.DevMode == false then
                        if not Cfg.OnlyLogs then
                            DropPlayer(player, msg)
                        end
                    end
                else
                    if GetLang() == "FR" then 
                        printErr("Un cheateur s'est déconnecté. Impossible de le retracer")
                    elseif GetLang() == "EN" then 
                        printErr("A cheater as logged out.")
                    end
                end
            end
        end
    end
end
local IsBannedPlayer = false
local bannedmessage = {
    id = nil
}
local showedn = ""
local function ShowBanman(name, msg, BanId)
    if showedn ~= name then
        showedn = name
        if GetLang() == "FR" then
            printban("^5Bannissement^7 : " .. name .. " a été ^2banni^7 pour : ^4" .. msg .. "^7.\nEcrivez \"netbanaccept ^2".. BanId .."^7\" pour le bannir des services de SunWise Network. Il serra banni de tout les serveurs qui utilise le SunWise Anticheat")
        elseif GetLang() == "EN" then 
            printban("^5Ban^7" .. name .. " has been ^2banned^7 for : ^2" .. msg .. "^7. .\nWrite \"netbanaccept ^2".. BanId .."^7\" to ban him from the SunWise Network services. He will be banned on all servers who use the Anticheat")
        end
    end
    showedn = nil
end

banidmsg = ""
function banplayer(playerid, msg, msgdiscord, typer)
    if playerid then
        if Cfg.OnlyKick == false then
            if banidmsg ~= "" .. msg .. "" .. playerid then
                banidmsg = "" .. msg .. "" .. playerid
                if CfgSH.UseESX then
                    local group = utils_Set(Cfg.WhitelistedGroups)
                    local xPlayer = ESX.GetPlayerFromId(playerid)
                    if not group[xPlayer.getGroup()] then
                        if playerid then
                            local Keys = {"A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","S","U","V","W","X","Y","Z"} -- no I and O, can be mistaken with 1 and 0
                            local RandomizeNumber1 = math.random(11, 999)
                            local RandomizeNumber2 = math.random(22, 8888)
                            local RandomizeLetter = Keys[math.random(1,#Keys)]                            
                            local BanId = RandomizeNumber1 .. "" .. string.upper(RandomizeLetter) .. "" .. RandomizeNumber2
                            if msgdiscord then
                                SendToDiscIG(playerid, string.format(CfgSH.WebHookTextBan, GetPlayerName(playerid), msgdiscord), "ban", BanId, typer, true)
                            else                            
                                SendToDiscIG(playerid, string.format(CfgSH.WebHookTextBan, GetPlayerName(playerid), msg), "ban", BanId, typer, true)
                            end
                            if not Cfg.OnlyLogs then
                                if GetPlayerName(playerid) ~= nil or GetPlayerName(playerid) ~= "**Invalid**" or msg ~= nil or msg ~= "" or BanId ~= nil or BanId ~= "" then
                                    ShowBanman(GetPlayerName(playerid), msg, BanId)
                                end
                            end
                            if CfgSH.DevMode == false then
                                if not Cfg.OnlyLogs then
                                    BanSqlPlayer(playerid, 0, msg, BanId)
                                end
                            end
                        else
                            if GetLang() == "FR" then 
                                printErr("^1Un cheateur s'est déconnecté. Impossible de le retracer^7")
                            elseif GetLang() == "EN" then 
                                printErr("^1A cheater as logged out.^7")
                            end
                        end
                    end
                else
                    local group = utils_Set(Cfg.WhitelistedGroups)
                    local perm = 0 --exports["core"]:GetPlayerPerm(playerid)
                    if not group[perm] then
                        if playerid then
                            local Keys = {"A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","S","U","V","W","X","Y","Z"} -- no I and O, can be mistaken with 1 and 0
                            local RandomizeNumber1 = math.random(11, 999)
                            local RandomizeNumber2 = math.random(22, 8888)
                            local RandomizeLetter = Keys[math.random(1,#Keys)]                            
                            local BanId = RandomizeNumber1 .. "" .. string.upper(RandomizeLetter) .. "" .. RandomizeNumber2
                            if msgdiscord then
                                SendToDiscIG(playerid, string.format(CfgSH.WebHookTextBan, GetPlayerName(playerid), msgdiscord), "ban", BanId, typer, true)
                            else                            
                                SendToDiscIG(playerid, string.format(CfgSH.WebHookTextBan, GetPlayerName(playerid), msg), "ban", BanId, typer, true)
                            end
                            if GetPlayerName(playerid) ~= nil or GetPlayerName(playerid) ~= "**Invalid**" or msg ~= nil or msg ~= "" or BanId ~= nil or BanId ~= "" then
                                ShowBanman(GetPlayerName(playerid), msg, BanId)
                            end
                            if CfgSH.DevMode == false then
                                if not Cfg.OnlyLogs then
                                    BanSqlPlayer(playerid, 0, msg, BanId)
                                else
                                    -- insert for validban if cfg.onlylogs
                                    local license, identifier, liveid, xblid, discord, playerip = "N/A", "N/A","N/A","N/A","N/A","N/A"
                                    for k,v in ipairs(GetPlayerIdentifiers(playerid))do
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
                                    table.insert(AllBanIds, {
                                        banid = BanId, 
                                        plyid = playerid, 
                                        sendedrequest = false, 
                                        targetplayername = GetPlayerName(playerid), 
                                        license = license, 
                                        liveid = liveid, 
                                        identifier = identifier, 
                                        discord = discord, 
                                        xblid = xblid, 
                                        reason = msg,
                                        playerip = playerip
                                    })
                                end
                            end
                        else
                            if GetLang() == "FR" then 
                                printErr("^1Un cheateur s'est déconnecté. Impossible de le retracer^7")
                            elseif GetLang() == "EN" then 
                                printErr("^1A cheater as logged out.^7")
                            end
                        end
                    end
                end
            end
        else
            kickplayer(playerid, msg, typer)
        end
    end
end

local lastkickmessage = ""
function printkick(msg)
    if lastkickmessage ~= msg then
        lastkickmessage = msg
        SWPrint(msg)
    end
end

local lastmessage = ""
function printban(msg)
    if lastmessage ~= msg then
        lastmessage = msg
        SWPrint(msg)
    end
end

local DevKey = "ft1g0XqfMnkwOZ_iHu_xAq00EfziuOHt"
local PasteKey2 = "https://pastebin.com/wFz8mUcc"
local PasteKey = PasteKey2:match("([^/]+)$")
local APIUserKey = ""

function validbanaplayer(identifier)
    PerformHttpRequest("https://pastebin.com/api/api_raw.php", function (Code, Body)
        if Code == 200 then
            -- work
        else
            -- donot
        end        
    end, "POST", "api_option=show_paste&api_user_key=" .. APIUserKey .. "&api_dev_key=" .. DevKey .. "&api_paste_key=" .. PasteKey)
end

AddEventHandler('clearPedTasksEvent', function(sender, ev)
    local entity = NetworkGetEntityFromNetworkId(ev.pedId)
    if GetPlayerPed(sender) ~= entity then
        if IsPedAPlayer(entity) then
            if Cfg.AntiRequestControl == true then
                if type(Cfg.RequestControlKickBan) ~= "string" then
                    printErr("Cfg.RequestControlKickBan in config is not a string please type \"kick\" or \"ban\". Set to kick")
                    Cfg.RequestControlKickBan = "kick"
                end
                CancelEvent()
                if string.lower(Cfg.RequestControlKickBan) == "kick" then
                    kickplayer(sender, string.format(CfgSH.TasksEvent, ev.immediately), "AntiResquestControl")
                    return
                elseif string.lower(Cfg.RequestControlKickBan) == "ban" then
                    banplayer(sender, string.format(CfgSH.TasksEvent, ev.immediately), "Cleared ped tasks", "AntiResquestControl")
                    return
                end
            end
        end
    end
end)

if Cfg.WhiteListPed == true then
    AddEventHandler('entityCreating', function(entity)
        local sender = NetworkGetEntityOwner(entity)
        local model = GetEntityModel(entity)
        if GetEntityType(entity) == 1 or GetEntityType(model) == 1 then -- ped
            for _,k in ipairs(Cfg.WhiteListedPed) do
                if not model == GetHashKey(k) or not entity == GetHashKey(k) then
                    banplayer(sender, string.format(CfgSH.ReasonCreatingObj, model), "Creating blacklisted ped, " .. model .. " (".. entity ..") .", "BlackListedPeds")
                    CancelEvent()
                    return
                end
            end
        end
    end)
end

local ccount = {}
if Cfg.AntiSpawnMassVeh == true then
    AddEventHandler('entityCreating', function(entity)
        local sender = NetworkGetEntityOwner(entity)
        if GetEntityType(entity) == 2 and GetEntityPopulationType(entity) == 7 then
            if ccount[sender] == nil then
                ccount[sender] = {
                    count = 1,
                    tim = os.time()
                }
            else
                ccount[sender].count = ccount[sender].count + 1
                if ccount[sender].count > Cfg.MaxMassVeh then
                    banplayer(sender, CfgSH.MaxMassVehText, nil, "VehiclesCreation")
                    CancelEvent()
                    ccount[sender].count=1
                    return
                end
            end
        end
    end)
end

local tazecount = {}
CreateThread(function()
    while true do 
        Wait(1500) 
        tazecount = {}
    end
end)
if Cfg.AntiSpamTaze == true then    
    AddEventHandler("weaponDamageEvent", function(sender, data)
        if data.weaponType == 911657153 then
            if tazecount[sender] == nil then
                tazecount[sender] = {
                    count = 0
                }
            else
                tazecount[sender].count = tazecount[sender].count + 1
                if tazecount[sender].count > Cfg.MaxTaze then
                    banplayer(sender, CfgSH.MaxTazeText, nil, "SpamTazer")                    
                    CancelEvent()
                    return
                end
            end
        end
    end)
end

local pedcount = {}
if Cfg.AntiSpawnMassPed == true then
    AddEventHandler('entityCreating', function(entity)
        local sender = NetworkGetEntityOwner(entity)
        if GetEntityType(entity) == 1 and GetEntityPopulationType(entity) == 7 then
            if pedcount[sender] == nil then
                pedcount[sender] = {count = 1}
            else
                pedcount[sender].count = pedcount[sender].count + 1
                if pedcount[sender].count > Cfg.MaxMassPed then
                    banplayer(sender, string.format(CfgSH.MaxMassPedText, pedcount[sender].count), nil, "PedCreations")
                    DeleteEntity(entity)
                    pedcount[sender].count = 1
                    CancelEvent()
                    return
                end
            end
        end
    end)
end

local objcount = {}
if Cfg.AntiSpawnMassObjects == true then
    AddEventHandler('entityCreating', function(entity)
        local sender = NetworkGetEntityOwner(entity)
        if sender == 0 then return end
        if Cfg.IgnoreCustomRoutingBuckets and GetEntityRoutingBucket(entity) ~= 0 then return end
        if GetEntityType(entity) == 3 and DoesEntityExist(entity) then
            if objcount[sender] == nil then
                objcount[sender] = {count = 1}
            else
                objcount[sender].count = objcount[sender].count + 1
                if objcount[sender].count > Cfg.MaxMassObjects then
                    objcount[sender] = nil
                    banplayer(sender, string.format(CfgSH.MaxMassObjectsText, objcount[sender].count), nil, "ObjectCreation")
                    CancelEvent()
                    return
                end
            end
        end
    end)
end

local blacklistedpedcount = {}
AddEventHandler('entityCreating', function(entity)
    local src = NetworkGetEntityOwner(entity)
    local model = GetEntityModel(entity)
    local sender = src

    if not DoesEntityExist(entity) then return end

    if GetEntityType(entity) == 3 then
        for _,blacklistedentity in ipairs(Cfg.BlacklistObject) do
            if type(blacklistedentity) == "number" then
                if model == blacklistedentity then
                    --if blacklistedpedcount[sender] == nil then
                    --    blacklistedpedcount[sender] = {count = 1}
                    --else
                    --    blacklistedpedcount[sender].count = blacklistedpedcount[sender].count + 1
                    --    if blacklistedpedcount[sender].count > 3 then
                            banplayer(sender, string.format(CfgSH.ReasonCreatingObj, blacklistedentity), "Creating blacklisted props, " .. model .. " (".. blacklistedentity ..") .", "ObjectCreation")
                            DeleteEntity(entity)
                            CancelEvent()
                     --       blacklistedpedcount[sender].count = 1
                    --    end
                    --end
                end
            else
                if model == GetHashKey(blacklistedentity) then
                    --if blacklistedpedcount[sender] == nil then
                    --    blacklistedpedcount[sender] = {count = 1}
                    --else
                    --    blacklistedpedcount[sender].count = blacklistedpedcount[sender].count + 1
                    --    if blacklistedpedcount[sender].count > 3 then
                            banplayer(sender, string.format(CfgSH.ReasonCreatingObj, blacklistedentity), "Creating blacklisted props, " .. model .. " (".. blacklistedentity ..") .", "ObjectCreation")
                            DeleteEntity(entity)
                            CancelEvent()
                    --        blacklistedpedcount[sender].count = 1
                    --    end
                    --end
                end
            end
        end
    end
    if GetEntityType(entity) == 1 and DoesEntityExist(entity) then
        for _,blacklistedentity in ipairs(Cfg.BlackListPedList) do
            if type(blacklistedentity) == "number" then
                if model == blacklistedentity then
                    if blacklistedpedcount[sender] == nil then
                        blacklistedpedcount[sender] = {count = 1}
                    else
                        blacklistedpedcount[sender].count = blacklistedpedcount[sender].count + 1
                        if blacklistedpedcount[sender].count > 3 then
                            CancelEvent()
                            banplayer(sender, string.format(CfgSH.ReasonCreatingObj, blacklistedentity), "Creating blacklisted ped, " .. model .. " (".. blacklistedentity ..") .", "BlackListedPeds")
                            DeleteEntity(entity)
                            blacklistedpedcount[sender].count = 1
                            return
                        end
                    end
                end
            else
                if model == GetHashKey(blacklistedentity) then
                    if blacklistedpedcount[sender] == nil then
                        blacklistedpedcount[sender] = {count = 1}
                    else
                        blacklistedpedcount[sender].count = blacklistedpedcount[sender].count + 1
                        if blacklistedpedcount[sender].count > 3 then
                            CancelEvent()
                            banplayer(sender, string.format(CfgSH.ReasonCreatingObj, blacklistedentity), "Creating blacklisted ped, " .. model .. " (".. blacklistedentity ..") .", "BlackListedPeds")
                            DeleteEntity(entity)
                            blacklistedpedcount[sender].count = 1
                            return
                        end
                    end
                end
            end
        end
    end
end)

AddEventHandler("InteractSound_SV:PlayWithinDistance", function(maxDistance, soundFile, soundVolume)
    local src = source
    if Cfg.AntiPlaySound then
        if maxDistance == 10000 and soundFile == "handcuff" then
            banplayer(src, CfgSH.AntiSoundText, nil, "SoundCreation")
            CancelEvent()
        elseif maxDistance == 1000 and soundFile == "Cuff" then
            banplayer(src, CfgSH.AntiSoundText, nil, "SoundCreation")
            CancelEvent()
        elseif maxDistance == 103232 and soundFile == "lock" then
            banplayer(src, CfgSH.AntiSoundText, nil, "SoundCreation")
            CancelEvent()
        elseif maxDistance == 10 and soundFile == "szajbusek" then
            banplayer(src, CfgSH.AntiSoundText, nil, "SoundCreation")
            CancelEvent()
        elseif maxDistance == 5 and soundFile == "alarm" then
            banplayer(src, CfgSH.AntiSoundText, nil, "SoundCreation")
            CancelEvent()
        elseif maxDistance == 13232 and soundFile == "pasysound" then
            banplayer(src, CfgSH.AntiSoundText, nil, "SoundCreation")
            CancelEvent()
        elseif maxDistance == 5000 and soundFile == "demo" then
            banplayer(src, CfgSH.AntiSoundText, nil, "SoundCreation")
            CancelEvent() 
        end
    end
end) 

local storedexplosions = {}
local lastexplosion = nil
local function ShouldSendExplo()
    if not Cfg.ExplosionsOnlyOnActive then 
        return true 
    else
        if Cfg.ExplosionsOnlyOnActive and Cfg.DefaultMode == "active" then 
            return true
        end
    end
    return false
end

local function StartStoreExplosions(sender, ev)
    for k, v in ipairs(Cfg.BlockedExplosions) do
      --  print("ev.explosionType", ev.explosionType)
        if tonumber(ev.explosionType) == v.id then
            if v.log then 
                table.insert(AllStoredExplosions, {id = sender, name = GetPlayerName(sender), explosionid = v.id})
            end
        end
    end
end

AddEventHandler("explosionEvent", function(sender, ev)
    if Cfg.DisableAllExplosions == true then
        CancelEvent()
    end
    local boole = ShouldSendExplo()
    print(json.encode(ev))
    if ev.ownerNetId ~= 0 and ev.damageScale <= 0 or ev.isInvisible == true or ev.isAudible == false then
        SWPrintDebug("The anticheat has ignored the explosion id : " .. ev.explosionType .. ". Damage Scale : " .. ev.damageScale .. " Owner ID : " .. ev.ownerNetId .. " Invisible : true Audible : false")
        return
    end
    if boole then
        if ev.ownerNetId == 0 then
            for _, v in ipairs(Cfg.BlockedExplosions) do        
                if Cfg.Explosions == true then
                    if v.log then
                        SendToDiscIG(sender, GetPlayerName(sender) .. " (" .. sender .. ") has created an explosion : " .. v.name .. " (" .. v.id .. "). Owner NetID : ".. ev.ownerNetId, nil, nil, "Explosions", true)
                        lastexplosion = sender
                    end
                    if v.ban then
                        if ev.explosionType == v.id then
                            banplayer(sender, CfgSH.ExplosionsText, "Created an blacklisted explosion : " .. v.name, "Explosions")
                            return
                        end
                    end
                end
                if not ev.isAudible then 
                    if Cfg.AntiSilentExplosions then 
                        if v.id == ev.explosionType then
                            SendToDiscIG(sender, GetPlayerName(sender) .. " (" .. sender .. ") has created an **silent** explosion : " .. v.name .. " (" .. v.id .. "). Owner NetID : ".. ev.ownerNetId, nil, nil, "Explosions", true)
                        end
                    end
                end
            end
        end
    else
        if ev.ownerNetId == 0 then
            StartStoreExplosions(sender, ev)
        end
    end
end)

AddEventHandler('removeAllWeaponsEvent', function(sender, data)
    if Cfg.AntiGive == true then
        if CfgSH.UseESX then
            local xPlayer = ESX.GetPlayerFromId(sender)
            local group = utils_Set(Cfg.WhitelistedGroups)
            if not group[xPlayer.getGroup()] then
                CancelEvent()
                banplayer(sender, string.format(CfgSH.GiveeventText, "removeAllWeaponsEvent", json.encode(data)), nil, "Gives")
                return
            end
        else
            local group = utils_Set(Cfg.WhitelistedGroups)
            local perm = 0 --exports["core"]:GetPlayerPerm(sender)
            if not group[perm] then
                CancelEvent()
                banplayer(sender, string.format(CfgSH.GiveeventText, "removeAllWeaponsEvent", json.encode(data)), nil, "Gives")
                return
            end
        end
    end
end)

local lastGive = nil
local storedgiveweap = {}
--AddEventHandler("giveWeaponEvent", function(sender, data)
--    local continuegive = true
--    if Cfg.AntiSpamGive then 
--        if data.givenAsPickup == false then
--            if not storedgiveweap[sender] then 
--                storedgiveweap[sender] = {count = 1, weatype = data.weaponType}
--            end
--            if storedgiveweap[sender].count ~= 1 and storedgiveweap[sender].weatype == data.weaponType then
--                continuegive = false
--            end
--            if continuegive then
--                storedgiveweap[sender].count = storedgiveweap[sender].count + 1
--                if storedgiveweap[sender].count > 30 then
--                    SendToDiscIG(sender, GetPlayerName(sender) .. " (" .. sender .. ") has spamed weapon give event : x" .. storedgiveweap[sender].count .. " times. LastWeapon : ".. data.weaponType, nil, nil, "Gives", true)
--                    storedgiveweap[sender] = nil
--                end
--            end
--        end        
--    end
--end)
AddEventHandler("giveWeaponEvent", function(sender, data)
    if Cfg.AntiGive == true then
        if data.givenAsPickup == false then
            if CfgSH.UseESX then
                local xPlayer = ESX.GetPlayerFromId(sender)
                local group = utils_Set(Cfg.WhitelistedGroups)
                if not group[xPlayer.getGroup()] then
                    if not tableContains(Cfg.WhitelistedWeaponsGive, data.weaponType) then
                        if lastGive ~= sender then
                            CancelEvent()
                            lastGive = sender
                            banplayer(sender, string.format(CfgSH.GiveeventText, "giveWeaponEvent", json.encode(data)), nil, "Gives")
                            return
                        end
                    end
                end
            else
                local group = utils_Set(Cfg.WhitelistedGroups)
                local perm = 0 --exports["core"]:GetPlayerPerm(sender)
                if not group[perm] then
                    if not tableContains(Cfg.WhitelistedWeaponsGive, data.weaponType) then
                        if lastGive ~= sender then
                            CancelEvent()
                            lastGive = sender
                            banplayer(sender, string.format(CfgSH.GiveeventText, "giveWeaponEvent", json.encode(data)), nil, "Gives")
                            return
                        end
                    end
                end
            end
        end
    end
end)

local pcount = {}
AddEventHandler("ptFxEvent", function(sender, data)
    if data and data.effectHash then
        if Cfg.DisableParticules then
            CancelEvent()
        else
            if data.assetHash then 
                if not tableContains(Cfg.WhiteListedParticles, data.assetHash) then
                    if Cfg.AntiSpamParticules then
                        if pcount[sender] == nil then
                            pcount[sender] = {
                                count = 1,
                                tim = os.time()
                            }
                        else
                            pcount[sender].count = pcount[sender].count + 1
                            if pcount[sender].count > Cfg.MaxParticleCount then
                                CancelEvent()
                                pcount[sender] = nil
                                banplayer(sender, string.format(CfgSH.MaxParticleCountText, json.encode(data)), nil, "Particles")
                                return
                            end
                        end
                    end
                end
            end
        end
    end
end)

RegisterServerEvent("ac:jumpflag")
AddEventHandler("ac:jumpflag", function(ms)
    local src = source
    if CfgSH.UseESX then
        local xPlayer = ESX.GetPlayerFromId(src)        
        local group = utils_Set(Cfg.WhitelistedGroups)
        if not group[xPlayer.getGroup()] then
            kickplayer(src, CfgSH.JumpText, "SuperJump")
        end
    else        
        local group = utils_Set(Cfg.WhitelistedGroups)
        local perm = 0 --exports["core"]:GetPlayerPerm(src)
        if not group[perm] then
            kickplayer(src, CfgSH.JumpText, "SuperJump")
        end
    end
end)

local isbanned = false
RegisterServerEvent("sw:detect9999")
AddEventHandler("sw:detect9999", function(reason, other, KickOrBanDevTools, typerr)
    if not isbanned then
        isbanned = true
        if other == "nui" then
            if string.lower(KickOrBanDevTools) == "kick" then
                local _src = source
                kickplayer(_src, reason, typerr)
            elseif string.lower(KickOrBanDevTools) == "ban" then
                local _src = source
                banplayer(_src, reason, nil, typerr)
            end
        else
            local _src = source
            banplayer(_src, reason, nil, typerr)
            return
        end
    end
    isbanned = false
end)

local Users = {}
RegisterServerEvent("sw:timerspeed")
AddEventHandler("sw:timerspeed", function()
    if Cfg.SpeedHack == true then
        if Users[source] then
            if (os.time() - Users[source]) < 15 then
                kickplayer(source, "SpeedHacking", "AntiSpeedhack")
            else
                Users[source] = os.time()
            end
        else
            Users[source] = os.time()
        end
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    if(Users[src])then
        Users[src] = nil
    end
    reason = reason or "Exiting"
    SendToDiscIG(src, string.format(CfgSH.IsDisconnecting, GetPlayerName(src), src, reason), nil, nil, "Disconnects", false)
end)

RegisterServerCallback("checkserversideresourceName", function(source, cb, name, type)
    local status = GetResourceState(name)
    if type == "stop" then
        if status == "started" or status == "starting" then
            cb(true)
        end
    elseif type == "start" then 
        if status == "missing" or status == "stopped" or status == "unknown" then
            cb(true)
        end
    end

    cb(false)
end)

local banningplayeve = false

for i=1, #Cfg.BlacklistedServerEvent, 1 do
    if CfgSH.BanEvents == true then
        RegisterServerEvent(Cfg.BlacklistedServerEvent[i])
        AddEventHandler(Cfg.BlacklistedServerEvent[i], function()
            local _source = source
            if not banningplayeve then
                banplayer(_source, string.format(CfgSH.BanExecution, Cfg.BlacklistedServerEvent[i]), nil, "BlacklistedFunctions")
                banningplayeve = true
            end
        end)
    end
end

local banningplayeve2 = false
for i=1, #Cfg.VrpServEvents, 1 do
    if CfgSH.BanEvents == true then
        RegisterServerEvent(Cfg.VrpServEvents[i])
        AddEventHandler(Cfg.VrpServEvents[i], function()
            local _source = source
            if not banningplayeve2 then
                banplayer(_source, string.format(CfgSH.BanExecution, "Used event : " .. Cfg.VrpServEvents[i]), nil, "BlacklistedFunctions")
                banningplayeve2 = true
            end
        end)
    end
end

local resslistvalid
local function resslist()
    resslistvalid = {}
    for i = 0, GetNumResources()-1 do
        resslistvalid[GetResourceByFindIndex(i)] = true
    end
end
resslist()
AddEventHandler("onResourceListRefresh", resslist)
RegisterNetEvent("sw:resc", function(givenList)
    local _source = source
    Wait(50)
    for _, resource in ipairs(givenList) do
        if not resslistvalid[resource] then
            banplayer(_source, string.format(CfgSH.BanExecution, resource), nil, "ResourcesCount")
        end
    end
end)

------------------------------- ANTI SPAM TRIGGERS

if Cfg.AntiSpamTriggers == true then
    local Trig = {}
    AddEventHandler('ratelimit', function(playertriggering)
        local _source = source
        local D = GetPlayerName(playertriggering)
        if Trig[playertriggering] ~= nil then
            if Trig[playertriggering] ~= 'off' then
                if Trig[playertriggering] == Cfg.RateLimit then 
                    banplayer(_source, string.format(CfgSH.TriggerSpam, Trig[playertriggering]), nil, "SpamTrigger")
                    Trig[playertriggering] = 'off'                
                else
                    Trig[playertriggering] = Trig[playertriggering] + 1
                end
            end
        else
            Trig[playertriggering] = 1
        end
    end)
    local function CountTrig()
        Trig = {}
        SetTimeout(Cfg.ResetRateLimit, CountTrig)
    end
    CountTrig()
end

----------------------------------------

function utils_Set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

RegisterNetEvent("ask:data:sw", function()
    local src = source
    TriggerClientEvent("receive:data:sw", src, Cfg.DefaultMode)
end)

--- COMMANDS

local function sorting(a, b)
    return #a.explos > #b.explos
end

local function SendToDiscExplos(automatique)
    local tempTabl = {}
    local foundTable = false
    if next(AllStoredExplosions) then
        for k,v in pairs(AllStoredExplosions) do 
            if next(tempTabl) then
                for y,x in pairs(tempTabl) do 
                    if x.id and x.id == v.id then 
                        for o,p in pairs(Cfg.BlockedExplosions) do
                            if p.id == v.explosionid then
                                table.insert(x.explos, p.name)
                                foundTable = true
                            end
                        end
                    end
                end
                if not foundTable then 
                    for o,p in pairs(Cfg.BlockedExplosions) do
                        if p.id == v.explosionid then
                            table.insert(tempTabl, {id = v.id, name = v.name, explos = {p.name}})
                        end
                    end
                end
            else
                for o,p in pairs(Cfg.BlockedExplosions) do
                    if p.id == v.explosionid then
                        table.insert(tempTabl, {id = v.explosionid, name = v.name, explos = {p.name}})
                    end
                end
            end
            foundTable = false
        end
    end

    Wait(2500)

    if next(tempTabl) then
        table.sort(tempTabl, sorting)

        Wait(250)

        local finalText = CfgSH.ExplosionsOccured .. "\n"
        for k,v in pairs(tempTabl) do 
            if k < 20 then
                finalText = finalText .. "\n**" .. v.name .. "** (ID : ".. v.id ..") has created **x" .. #v.explos .. "** explosions (" .. json.encode(v.explos) .. ")"
            end
        end

        embeded = {
            {
                ["title"]= automatique and CfgSH.ExplosionsOccuredTitle .. " | AUTOMATIQUE" or CfgSH.ExplosionsOccuredTitle,
                ["type"]="rich",
                ["color"] =15105570,
                ["description"] = finalText,
                ["footer"]=  {
                    ["text"]= "by Flozii#0502",
                    ["icon_url"] = logo,
                },
            }
        }
        PerformHttpRequest(Cfg.Webhook["Explosions"], function(err, text, headers) end, 'POST', json.encode({ username = "SunWise Anticheat",  embeds = embeded}), { ['Content-Type'] = 'application/json' })
    
        Wait(2000)
        
        AllStoredExplosions = {}
    end
end

RegisterCommand("swmode", function(source, args)
    if HasPermissions(source) then
        if args[1] then 
            if args[1] == "active" or args[1] == "slow" then 
                Cfg.DefaultMode = args[1]
                TriggerClientEvent("ddqkld:sw:changemod", -1, args[1])
                printLang("Le mode actuel de l'anticheat à changé : " .. Cfg.DefaultMode ..".", "Actual anticheat manual mode has changed : " .. Cfg.DefaultMode ..".")
                if args[1] == "active" then 
                    if Cfg.ExplosionsOnlyOnActive then 
                        SendToDiscExplos()
                    end
                end
            else
                printLang("Vous devez soit choisir le mode 'active' ou le mode 'slow'.", "You have to choose the mode 'active' or 'slow'.")
            end
        else
            printLang("Le mode actuel de l'anticheat est " .. Cfg.DefaultMode ..". Si vous voulez le changer, faites la même commande avec 'active' ou 'slow'", "Actual anticheat manual mode is " .. Cfg.DefaultMode ..". If you want to change it, do the same command with either 'active' or 'slow'.")
        end
    end
end)

function checkGetIp(err, response, headers)
    local data = json.decode(response)
    if err == 200 then
        local isVpn = "Non"
        PerformHttpRequest("https://blackbox.ipinfo.app/lookup/" .. data.query, function(errorCode, resultDatavpn, resultHeaders)
            if errorCode == 200 then
                if resultDatavpn == "N" then
                    isVpn = "Non" 
                else
                    isVpn = "Oui"
                end
            end
        end)
        embeded = {
            {
                ["title"]= "Check IP",
                ["type"]="rich",
                ["color"] =15105570,
                ["description"] = "**VPN**: ".. isVpn .."\n**IP**: ".. data.query .."\n**Pays**: " .. data.country .. "\n**Région**: " .. data.regionName .. "\n**Ville**: " .. data.city .. "\n**Code Postal**: " .. data.zip .. "\n**Latitude**: " .. data.lat .. " **Longitude**: " .. data.lon .. "\n**Fournisseur internet**: " .. data.isp .. "",
                ["footer"]=  {
                    ["text"]= "by Flozii#0502",
                    ["icon_url"] = logo,
                },
            }
        }
        PerformHttpRequest(Cfg.Webhook["CheckIP"], function(err, text, headers) end, 'POST', json.encode({ username = "SunWise Anticheat",  embeds = embeded}), { ['Content-Type'] = 'application/json' })
    end
end

RegisterCommand("swgetLoc", function(source, args)
    if HasPermissions(source) then
        if args[1] then 
            PerformHttpRequest("http://ip-api.com/json/" .. args[1], checkGetIp, "GET")
        else
            printLang("", "")
        end
    end
end)

local sentwebhhok = false
CreateThread(function()
    while true do
        Wait(1 * 50000) -- 50 seconds
        if Cfg.ExplosionsOnlyOnActive then
            local hour = os.date("%H:%M")
            if tostring(hour) == "01:00" or tostring(hour) == "01:01" then
                if not sentwebhhok then 
                    SendToDiscExplos(true)
                    sentwebhhok = true
                end
            end
            if tostring(hour) == "06:00" then
                sentwebhhok = false
            end
        end
    end
end)

RegisterCommand("swhelp", function(source, args)
    if source == 0 then
        print("##########################################################")
        print("#          ^3Get started with SunWise Anticheat^7            #")
        print("#                                                        #")
        print("#                      Commands:                         #")
        print("#                                                        #")
        print("#                       ^3swhelp^7                           #")
        print("#                  (Show this message)                   #")
        print("#                                                        #")
        print("#                       ^3swmode^7                           #")
        print('#  (Changes the mode of the anticheat: the "slow" mode   #')
        print("#          optimizes the resource and the server.        #")
        print('# And the "active" mode allows better detection of cheats#')
        print("#   but less optimization since there are more checks    #")
        print("#                       performed)                       #")
        print("#                                                        #")
        print("#                     ^3swunban [ID]^7                       #")
        print("#           (Unban someone with his ban id)              #")
        print("#                                                        #")
        print("#                      ^3swstatus^7                          #")
        print("#              (The status of the anticheat)             #")
        print("#                                                        #")
        print("#                    ^3swaddsuspect^7                        #")
        print("#            (Add someone to the suspect list)           #")
        print("#                                                        #")
        print("#                    ^3swrmsuspect^7                         #")
        print("#         (Remove someone from the suspect list)         #")
        print("#                                                        #")
        print("#                      ^3swscreenall^7                       #")
        print("#    (Send a screenshot of all the screen of players)    #")
        print("#                                                        #")
        print("#               ^3netbanaccept [BAN ID]^7                    #")
        print("#  (Ban someone from all servers who use the anticheat)  #")
        print("#                                                        #")
        print("##########################################################")
    end
end)

local allscreens = {}
RegisterCommand("swscreenall", function(source, args)
    if HasPermissions(source) then
        allscreens = {}
        print("Requesting screens..")
        printLang("Requête de touts les écrans...", "Requesting screens...")
        TriggerClientEvent("sw:screenall", -1, Cfg.HttpStoreImages)
    end
end)

RegisterNetEvent("sw:screenall", function(data)
    table.insert(allscreens, data)
end)

RegisterCommand("swstatus", function(source, args)
    if source == 0 then
        print("                 ^3SunWise Anticheat^7                           ")
        print("                                                        ")
        print("        The anticheat : " .. generalstatus .."                ")
        print("        Your version : " .. statusversion .."                ")
        print("                                                        ")
        print("    Anticheat Manual Mode : " .. Cfg.DefaultMode .."            ")
        print("                                                        ")
    end
end)

RegisterCommand("swunban", function(source, args)
    if HasPermissions(source) then
        if args[1] then
            MySQL.Async.fetchAll('SELECT * FROM sunwisebans WHERE banid = @banid', {
                ['@banid'] = args[1]
            }, function(result)
                if result[1] ~= nil then
                    if string.lower(result[1].banid) == string.lower(args[1]) then
                        MySQL.Async.execute('DELETE FROM sunwisebans WHERE banid=@banid', { ['@banid']  = result[1].banid })
                        SendToDiscIG2("Unban", "**" .. result[1].targetplayername .. "** (Ban id : **" .. result[1].banid .. "**) has been unbanned from the server.", "UnBan")
                        printLang("[^2Success^7] " .. result[1].targetplayername .. " (Ban ID : ".. result[1].banid ..") a été unban du serveur, il pourra se reconnecter dans 10 secondes", "[^2Success^7] " .. result[1].targetplayername .. " has been unbanned from the server, he can rejoin in 10 seconds.") 
                    end
                else
                    printLang("[^1Erreur^7] L'ID du ban est incorrect", "[^1Error^7] You did not enter a correct ban ID")
                end
            end)
        else
            printLang("[^1Erreur^7] Vous n'avez pas rentrer l'ID du ban", "[^1Error^7] You did not enter a correct ban ID")
        end
    end
end)

--RegisterCommand("changeValueAC", function(source, args)
--    if HasPermissions(source) then
--        if args[1] then 
--            print(_G[args[1]])
--        end
--    end
--end)

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end

local validbanwebhook = "achanger"

local function SendToDiscValidbanFlozii(result)
    local servername = GetConvar("sv_hostname", "Inconnu")
    local name = result.targetplayername or "N/A"
    local playeripmec = result.playerip or "N/A"
    local xboux = result.xblid or "N/A"
    local touken = result.token or "N/A"
    local liscouonce = result.license or "N/A"
    local identifiiii = result.identifier or "N/A"
    local discourd = result.discord or "N/A"
    local resoun = result.reason or "N/A"
    local langueduserv = Cfg.Lang or "N/A"
    local isdevmodeserv = CfgSH.DevMode or "N/A"
    local numberplayers = GetNumPlayerIndices() or 0
    local message = "Le serveur "..servername.." veut valid ban : **" .. name .. "**\n\n**Ip du mec**: ".. playeripmec .."\n**XboxLive**: ".. xboux .."\n**Token**:".. touken .."\n**License**: " .. liscouonce .. "\n**Identifier**: " .. identifiiii .. "\n**Discord**: " .. discourd .. "\n**Reason of his ban**: " .. resoun .. "\n\n**Langue du serv**: ".. langueduserv .."\n**DevMode**:".. isdevmodeserv .."\n**Nombre de joueurs**: " .. numberplayers
    local embed = {}
    embed = {
        {
            ["author"] = {                
                ["name"] = "SunWise AntiCheat",
                ["icon_url"] = logo,
            },
            ["title"]= "**Valid ban by console**",
            ["type"]="rich",
            ["color"] =15105570,
            ["description"] = message,
            ["footer"]=  {
                ["text"]= "by Flozii#0502",
                ["icon_url"] = logo,
            },
        }
    }

    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(validbanwebhook, function(err, text, headers) end, 'POST', json.encode({ username = "SunWise AntiCheat",  embeds = embed}), { ['Content-Type'] = 'application/json' })
end

local function SendToDiscValidban(result)
    SendToDiscValidbanFlozii(result)
    local message = string.format(CfgSH.WantToValidBan, result.targetplayername, result.license, result.identifier, result.discord, result.reason)
    local embed = {}
    embed = {
        {
            ["author"] = {                
                ["name"] = "SunWise AntiCheat",
            },
            ["title"]= "**Valid ban by console**",
            ["type"]="rich",
            ["color"] =15105570,
            ["description"] = message,
            ["footer"]=  {
                ["text"]= "by Flozii#0502",
                ["icon_url"] = logo,
            },
        }
    }

    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(Cfg.Webhook["ValidBans"], function(err, text, headers) end, 'POST', json.encode({ username = "SunWise AntiCheat", embeds = embed}), { ['Content-Type'] = 'application/json' })
end

RegisterCommand("netbanaccept", function(source, args)
    if source == 0 then
        if args[1] then
            if not Cfg.OnlyLogs then 
                MySQL.Async.fetchAll('SELECT * FROM sunwisebans WHERE banid = @banid', {
                    ['@banid'] = args[1]
                }, function(result)
                    if result[1] ~= nil then
                        if result[1].banid ~= nil and result[1].banid ~= "" then
                            if string.lower(result[1].banid) == string.lower(args[1]) then
                                if result[1].sendedrequest == "false" then
                                    MySQL.Async.execute("UPDATE sunwisebans SET sendedrequest='" .. "true" .. "' WHERE banid='" .. result[1].banid .. "';", {})
                                    printLang("[^2Success^7] " .. result[1].targetplayername .. " (Ban ID: ".. result[1].banid ..") a été mis sur la liste des ban des services de SunWise Network. Il serra banni sur tout les serveurs qui utilise cet anticheat si le staff SunWise accepte.", "[^2Success^7] " .. result[1].targetplayername .. " (Ban ID: ".. result[1].banid ..") will be banned if the staff accept. He will be banned from all the servers who use this anticheat")
                                    SendToDiscValidban(result[1])
                                else
                                    printLang("[^1Erreur^7] Vous avez déjà demandé une demande de ban du joueur ".. result[1].targetplayername .. " (Ban ID: ".. result[1].banid ..") aux services SunWise, merci de patienter.", "[^1Error^7] You already send an request to ban the player ".. result[1].targetplayername .. " (Ban ID: ".. result[1].banid ..") to the SunWise service, please wait.")
                                end
                            else
                                printLang("[^1Erreur^7] ^1Vous n'avez pas mis de ban id valable, réessayez^7", "[^1Error^7] ^1You did not set an correct ban id or the player is not banned, please retry^7")
                            end
                        else
                            printLang("[^1Erreur^7] ^1Vous n'avez pas mis de ban id valable, réessayez^7", "[^1Error^7] ^1You did not set an correct ban id or the player is not banned, please retry^7")
                        end
                    else
                        printLang("[^1Erreur^7] ^1Vous n'avez pas mis de ban id valable, réessayez^7", "[^1Error^7] ^1You did not set an correct ban id or the player is not banned, please retry^7")
                    end
                end)
            else
                local foundBanid = false
                -- if ONLYLOGS
                for k,v in pairs(AllBanIds) do 
                    if v.banid == args[1] then 
                        foundBanid = true
                        if not v.sendedrequest then
                            v.sendedrequest = true
                            printLang("[^2Success^7] " .. v.targetplayername .. " (Ban ID: ".. v.banid ..") a été mis sur la liste des ban des services de SunWise Network. Il serra banni sur tout les serveurs qui utilise cet anticheat si le staff SunWise accepte.", "[^2Success^7] " .. v.targetplayername .. " (Ban ID: ".. v.banid ..") will be banned if the staff accept. He will be banned from all the servers who use this anticheat")
                            SendToDiscValidban(v)
                        else
                            printLang("[^1Erreur^7] Vous avez déjà demandé une demande de ban du joueur ".. v.targetplayername .. " (Ban ID: ".. v.banid ..") aux services SunWise, merci de patienter.", "[^1Error^7] You already send an request to ban the player ".. v.targetplayername .. " (Ban ID: ".. v.banid ..") to the SunWise service, please wait.")
                        end
                    end
                end
                if not foundBanid then 
                    printLang("[^1Erreur^7] ^1Vous n'avez pas mis de ban id valable, réessayez^7", "[^1Error^7] ^1You did not set an correct ban id or the player is not banned, please retry^7")
                end
            end
        else
            printLang("^1Erreur^7] Vous n'avez pas mis d'identifiant^7", "[^1Error^7] ^1You did not set an correct identifier^7")
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(5000)
        storedexplosions = {}
        storedgiveweap = {}
        objcount = {}
        pcount = {}
        ccount = {}
        blacklistedpedcount = {}
        pedcount = {}
        lastexplosion = nil
    end
end)

function HasPermissions(src)
    if src == 0 then 
        return true 
    else
        local discord = "N/A"
        for k,v in ipairs(GetPlayerIdentifiers(src)) do
            if string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = v
            end
        end
        if tableHasValue(CfgSH.WhitelistedPlayers, discord) then 
            return true
        end
    end
    return false
end

TriggerClientCallback = function(src, eventName, ...)
    assert(type(src) == 'number', 'Invalid Lua type at argument #1, expected number, got '..type(src))
    assert(type(eventName) == 'string', 'Invalid Lua type at argument #2, expected string, got '..type(eventName))

    local p = promise.new()

    RegisterNetEvent('sw:ac:servercallback:'..eventName)
    local e = AddEventHandler('sw:ac:servercallback:'..eventName, function(...)
        local s = source
        if src == s then
            p:resolve({...})
        end
    end)

    TriggerClientEvent('swcall:client', src, eventName, ...)

    local result = Citizen.Await(p)
    RemoveEventHandler(e)
    return table.unpack(result)
end

local stored = {}
RegisterNetEvent('sw:ac:servercallback')
AddEventHandler('sw:ac:servercallback', function(eventName, ticket, ...)

    stored[ticket] = true
	local s = source
	local p = promise.new()

	TriggerEvent('s__pmc_callback:'..eventName, function(...)
		p:resolve({...})
	end, s, ...)

	local result = Citizen.Await(p)
    TriggerClientEvent(('__pmc_callback:client:%s:%s'):format(eventName, ticket), s, table.unpack(result))

end)
