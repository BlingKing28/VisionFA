RegisterNetEvent("core:makeAnnounceWeazel")
AddEventHandler("core:makeAnnounceWeazel", function(token, message)
    if CheckPlayerToken(source, token) then
        if CheckPlayerJob(source, "weazelnews") then
            TriggerClientEvent('core:ShowAdvancedNotification', -1, "Weazel News", "~r~Annonce", message, "CHAR_VISION", "char_weazelnews")
        end
    end
end)

-- RegisterNetEvent("AnnonceWeazel")
-- AddEventHandler("AnnonceWeazel", function(token, data, coords)
--     if CheckPlayerToken(source, token) then
--         if CheckPlayerJob(source, "weazelnews") then
--             TriggerClientEvent('AnnonceWeazel', -1, GetPlayer(source):getLastname() .. " " ..  GetPlayer(source):getFirstname(), os.date("%H:%M"), data, coords)
--         end
--     end
-- end)

RegisterNetEvent("AnnonceSociety")
AddEventHandler("AnnonceSociety", function(token, jobs, message, phone)
    if CheckPlayerToken(source, token) then
        TriggerClientEvent('AnnonceSociety', -1, jobs, message, phone)
    end
end)

RegisterNetEvent("core:makeAnnounceLspd")
AddEventHandler("core:makeAnnounceLspd", function(token, message)
    if CheckPlayerToken(source, token) then
        if CheckPlayerJob(source, "lspd") then
            TriggerClientEvent('core:ShowAdvancedNotification', -1, "LSPD", "~r~Annonce", message, "CHAR_VISION", "ELLEHESSPEDER")
        end
    end
end)

local AntiSpam = false
RegisterNetEvent("weazelAnnonce:SendDataForAnnonce")
AddEventHandler("weazelAnnonce:SendDataForAnnonce", function(token, data)
    local src = source
    if CheckPlayerToken(src, token) then
        if CheckPlayerJob(src, "weazelnews") then
            if AntiSpam == true then
                --[[TriggerClientEvent("core:ShowNotification", src, "Tu dois attendre 5 min avant de faire une nouvelle annonce !")]]
                TriggerClientEvent("__vision::createNotification", src, {
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Tu dois attendre 5 min avant de faire une nouvelle annonce !"
                })
            else
                TriggerClientEvent('weazelAnnonce:showAnnonce', -1, data)
                AntiSpam = true
                SetTimeout(1000 * 60 * 5, function()
                    AntiSpam = false
                end)
            end
        end
    end
end)

RegisterNetEvent("core:makeAnnounceEntreprise")
AddEventHandler("core:makeAnnounceEntreprise", function(token, message)
    if CheckPlayerToken(source, token) then
        local char = "vision"
        local char2 = "CHAR_VISION"
        local source = source
        local job = GetPlayer(source):getJob()
        if job == "bennys" then  
            char = "CHAR_CARSITE3"
            char2 = "CHAR_CARSITE3"
        elseif job == "sunshine" then
            char = "SUNSHINE"
            char2 = "CHAR_VISION"
        elseif job == "lspd" then
            char = "LSPD"
            char2 = "CHAR_VISION"
        elseif job == "weazelnews" then
            char = "WEAZEL"
            char2 = "CHAR_VISION"
        elseif job == "tacosrancho" then
            char = "TACOS2RANCHO"
            char2 = "CHAR_VISION"
        elseif job == "bahamas" then
            char = "BAHAMAS"
            char2 = "CHAR_VISION"
        elseif job == "lucky" then
            char = "LUCKY-PLUCKER"
            char2 = "CHAR_VISION"
        elseif job == "athena" then
            char = "ATHENABAR"
            char2 = "CHAR_VISION"
        elseif job == "mostwanted" then
            char = "MOSTWANTED"
            char2 = "CHAR_VISION"
        elseif job == "sushistar" then
            char = "SUSHISTAR"
            char2 = "CHAR_VISION"
--[[         elseif job == "concessvelo" then
            char = "VESPUCCIBIKE"
            char2 = "CHAR_VISION" ]]
        elseif job == "burgershot" then
            char = "BURGERSHOT"
            char2 = "CHAR_VISION"
        elseif job == "taxi" then
            char = "DOWNTOWN"
            char2 = "CHAR_VISION"
        elseif job == "realestateagent" then 
            char = "dynasty"
            char2 = "CHAR_VISION"
        elseif job == "mayansclub" then 
            char = "CHAR_CHAT_CALL"
            char2 = "CHAR_CHAT_CALL"
        elseif job == "cardealerSud" then 
            char = "LSMOTORS"
            char2 = "CHAR_VISION"
        elseif job == "pawnshop" then 
            char = "PAWNSHOP"
            char2 = "CHAR_VISION"
        elseif job == "unicorn" then 
            char = "VANILLA"
            char2 = "CHAR_VISION"
        elseif job == "ems" then 
            char = "EMS"
            char2 = "CHAR_VISION"
        elseif job == "bcms" then 
            char = "BCMS"
            char2 = "CHAR_VISION"
        elseif job == "casse" then 
            char = "casse"
            char2 = "CHAR_VISION"
        elseif job == "tequilala" then
            char = "tequilala"
            char2 = "CHAR_VISION"
        elseif job == "tattooNord" then 
            char = "tattooNord"
            char2 = "CHAR_VISION" 
        elseif job == "tattooSud" then 
            char = "tattooSud"
            char2 = "CHAR_VISION"       
        elseif job == "ltdsud" then 
            char = "LTD"
            char2 = "CHAR_VISION"          
        elseif job == "uwu" then
            char = "UWUCAFE"
            char2 = "CHAR_VISION"
        elseif job == "pizzeria" then
            char = "Pizzeria"
            char2 = "CHAR_VISION"
        elseif job == "pearl" then
            char = "Pearl"
            char2 = "CHAR_VISION"
        elseif job == "upnatom" then
            char = "Upnatom"
            char2 = "CHAR_VISION"
        elseif job == "hornys" then
            char = "Hornys"
            char2 = "CHAR_VISION"
        elseif job == "comrades" then
            char = "comrades"
            char2 = "CHAR_VISION"
        elseif job == "sultan" then
                char = "sultan"
                char2 = "CHAR_VISION"
        elseif job == "mirror" then
            char = "mirror"
            char2 = "CHAR_VISION"
        elseif job == "bp" then
            char = "BP"
            char2 = "CHAR_VISION"
        elseif job == "gouv" then
            char = "gouv"
            char2 = "CHAR_VISION"
        end
        SendDiscordLog("entreprise", source, string.sub(GetDiscord(source), 9, -1), GetPlayer(source):getLastname() .. " ".. GetPlayer(source):getFirstname(), GetPlayer(source):getJob(), message)
        TriggerClientEvent('core:ShowAdvancedNotification', -1, tostring(string.upper(jobs[GetPlayer(source):getJob()].label)), "~r~Annonce", message, char2, char)

    end
end)

RegisterServerCallback("core:GetPhoneNumber", function(source)
    return exports["lb-phone"]:GetPhoneNumber(source)
end)
