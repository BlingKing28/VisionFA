SuspectList = {}
CreateThread(function()
    local List = LoadResourceFile(GetCurrentResourceName(), 'suspects.json')
	SuspectList = List and json.decode(List) or {}
    Wait(5000)
    while true do 
        Wait(60000*5)        
	    SaveResourceFile(GetCurrentResourceName(), 'suspects.json', json.encode(SuspectList))
    end
end)

RegisterCommand("swaddsuspect", function(source, args)
    if HasPermissions(source) then 
        if args[1] then 
            if GetPlayerName(args[1]) then 
                local sourcep = tonumber(args[1])
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
                Wait(50)
                if discord ~= "N/A" then 
                    local found = false
                    for k,v in pairs(SuspectList) do 
                        if v.discord == discord then 
                            found = true
                        end
                    end
                    Wait(50)
                    if found then 
                        printLang("[ERREUR] La personne est déjà dans la liste des suspects.", "[ERROR] The person is already in the suspect list")
                    else
                        table.insert(SuspectList, {discord = discord, name = GetPlayerName(sourcep), date = os.date("%x")})
                        if Cfg.DefaultMode == "slow" then
                            TriggerClientEvent("sw:addFromSuspectList", sourcep)
                        end
                        printLang("[ERREUR] La personne a été ajouté a la liste des suspects.", "[ERROR] The person has been added to the suspect list")
                    end
                end
            else
                printLang("[^1ERREUR^7] Le joueur n'existe pas", "[^1ERROR^7] The player doesn't exist.")
            end
        else
            printLang("[ERREUR] Vous devez entrer un identifiant", "[ERROR] You need to enter an id")
        end
    end
end)

RegisterCommand("swrmsuspect", function(source, args)
    if HasPermissions(source) then 
        if args[1] then 
            local sourcep = tonumber(args[1])
            if GetPlayerName(sourcep) then
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
                for k,v in pairs(SuspectList) do 
                    if v.discord == discord then 
                        table.remove(SuspectList, k)
                        printLang("[^2SUCCESS^7] Vous venez de supprimé " .. GetPlayerName(sourcep) .. " de la liste des suspects.", "[^2SUCCESS^7] You removed " .. GetPlayerName(sourcep) .. " from the suspect list.")
                    end
                end
                if Cfg.DefaultMode == "slow" then
                    TriggerClientEvent("sw:removedFromSuspectList", sourcep)
                end
            else
                printLang("[^1ERREUR^7] Le joueur n'existe pas", "[^1ERROR^7] The player doesn't exist.")
            end
        else
            printLang("[^1ERREUR^7] Vous devez entrer un identifiant", "[^1ERROR^7] You need to enter an id")
        end
    end
end)

RegisterNetEvent("sw:amisuspect", function()
    local src = source
    if next(SuspectList) then 
        local discord = "N/A"
        for k,v in ipairs(GetPlayerIdentifiers(source))do
            if string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = v
            end
        end
        for k,v in pairs(SuspectList) do 
            if v.discord == discord then 
                TriggerClientEvent("sw:addFromSuspectList", source)
            end
        end
    end
end)