-- Pre-load the language
local lang = Languages[Config.language]

-- @desc Handle /me command
--local function onMeCommand(source, args)
--    local text = "* " .. lang.prefix .. table.concat(args, " ") .. " *"
--    if text ~= "* l'individu ouvre le coffre *" then
--        SendDiscordLog("3DME", source, string.sub(GetDiscord(source), 9, -1),
--            GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(), text)
--    end
--    TriggerClientEvent('3dme:shareDisplay', -1, text, source)
--end
--
---- Register the command
--RegisterCommand("me", onMeCommand)


RegisterNetEvent("core:sendtext", function(players, texttosend)
    local source = source
    SendDiscordLog("3DME", source, string.sub(GetDiscord(source), 9, -1),
            GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(), texttosend)
    TriggerClientEvents("3dme:shareDisplay", players, texttosend, source)
end)