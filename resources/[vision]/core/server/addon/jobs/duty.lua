inDuty = {
    ["lspd"] = {},
    ["ems"] = {},
    ["bcms"] = {},
    ["weazelnews"] = {},
    ["bennys"] = {},
    ["hayes"] = {},
    ["beekers"] = {},
    ["sunshine"] = {},
    ["taxi"] = {},
    ["ltdsud"] = {},
    ["ltdmirror"] = {},
    ["sushistar"] = {},
    ["bahamas"] = {},
    ["burgershot"] = {},
    ["cardealerSud"] = {},
    ["unicorn"] = {},
    ["realestateagent"] = {},
    ["autoecole"] = {},
    ["justice"] = {},
    ["avocat"] = {},
    ["avocat2"] = {},
    ["tacosrancho"] = {},
    ["gouv"] = {},
    ["usss"] = {},
    ["boi"] = {},
    ["concessvelo"] = {},
    ["pawnshop"] = {},
    ["lsfd"] = {},
    ["lucky"] = {},
    ["athena"] = {},
    ["mostwanted"] = {},
    ["casse"] = {},
    ["tequilala"] = {},
    ["uwu"] = {},
    ["pizzeria"] = {},
    ["pearl"] = {},
    ["upnatom"] = {},
    ["hornys"] = {},
    ["mayansclub"] = {},
    ["concessentreprise"] = {},
    ["tattooSud"] = {},
    ["comrades"] = {},
    ["sultan"] = {},
    ["mirror"] = {},
    ["g6"] = {},
    ["barber"] = {},
    --["barberNord"] = {},
    ["shenails"] = {},
    ["harmony"] = {},
    ["lssd"] = {},
    ["cardealerNord"] = {},
    ["bayviewLodge"] = {},
    ["bean"] = {},
    ["pops"] = {},
    ["cluckin"] = {},
    ["domaine"] = {},
    ["barber2"] = {},
    ["ammunation"] = {},
    ["vangelico"] = {},
    ["tattooNord"] = {},
    ["don"] = {},
    ["records"] = {},
    ["rockford"] = {},
    ["postop"] = {},
    ["yellowJack"] = {},
    ["blackwood"] = {},
    ["lst"] = {},
    ["bp"] = {},
}

local callActive = {
    ["lspd"] = { target = {} },
    ["ems"] = { target = {} },
    ["bcms"] = { target = {} },
    ["lsfd"] = { target = {} },
    ["bennys"] = { target = {} },
    ["hayes"] = { target = {} },
    ["beekers"] = { target = {} },
    ["sunshine"] = { target = {} },
    ["taxi"] = { target = {} },
    ["ltdsud"] = { target = {} },
    ["ltdmirror"] = { target = {} },
    ["weazelnews"] = { target = {} },
    ["sushistar"] = { target = {} },
    ["bahamas"] = { target = {} },
    ["burgershot"] = { target = {} },
    ["cardealerSud"] = { target = {} },
    ["unicorn"] = { target = {} },
    ["realestateagent"] = { target = {} },
    ["autoecole"] = { target = {} },
    ["justice"] = { target = {} },
    ["avocat"] = { target = {} },
    ["avocat2"] = { target = {} },
    ["tacosrancho"] = { target = {} },
    ["gouv"] = { target = {} },
    ["usss"] = { target = {} },
    ["boi"] = { target = {} },
    ["concessvelo"] = { target = {} },
    ["pawnshop"] = { target = {} },
    ["lucky"] = { target = {} },
    ["athena"] = { target = {} },
    ["mostwanted"] = { target = {} },
    ["casse"] = { target = {} },
    ["tequilala"] = { target = {} },
    ["uwu"] = { target = {} },
    ["pizzeria"] = { target = {} },
    ["pearl"] = { target = {} },
    ["upnatom"] = { target = {} },
    ["hornys"] = { target = {} },
    ["mayansclub"] = { target = {} },
    ["concessentreprise"] = { target = {} },
    ["tattooSud"] = { target = {} },
    ["comrades"] = { target = {} },
    ["sultan"] = { target = {} },
    ["mirror"] = { target = {} },
    ["g6"] = { target = {} },
    ["barber"] = { target = {} },
    --["barberNord"] = { target = {} },
    ["shenails"] = { target = {} },
    ["harmony"] = { target = {} },
    ["lssd"] = { target = {} },
    ["cardealerNord"] = { target = {} },
    ["bayviewLodge"] = { target = {} },
    ["bean"] = { target = {} },
    ["pops"] = { target = {} },
    ["cluckin"] = { target = {} },
    ["domaine"] = { target = {} },
    ["barber2"] = { target = {} },
    ["ammunation"] = { target = {} },
    ["vangelico"] = { target = {} },
    ["don"] = { target = {} },
    ["records"] = { target = {} },
    ["rockford"] = { target = {} },
    ["postop"] = { target = {} },
    ["yellowJack"] = { target = {} },
    ["blackwood"] = { target = {} },
    ["tattooNord"] = { target = {} },
    ["lst"] = { target = {} },
    ["bp"] = { target = {} },
}

local isProduction = false

PerformHttpRequest('https://api.ipify.org/', function(err, text, headers)
    if text == "135.125.4.181" then
        isProduction = true
    end
end)

RegisterNetEvent("core:DutyOn")
AddEventHandler("core:DutyOn", function(job)
    if job ~= nil then
        table.insert(inDuty[job], source)
        SendDiscordLog("dutyon", "Prise de service", source, string.sub(GetDiscord(source), 9, -1), GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(), job)
        if job ~= "lspd" or job ~= "lssd" and isProduction then
            PerformHttpRequest("http://141.94.99.95:3003/time/start", function(err, text, headers) end, 'POST',
                json.encode({ token = "54bbe11b-040c-4b98-b895-47ef16f46dc3",
                    discord = string.sub(GetDiscord(source), 9, -1), userData = json.encode(GetPlayer(source)),
                    entreprise = job })
                , { ['Content-Type'] = 'application/json' }
            )
        end
    else
        print("[ERROR] Le job " .. job .. " n'existe pas")
    end
end)


RegisterNetEvent("core:DutyOff")
AddEventHandler("core:DutyOff", function(job)
    if job ~= nil then
        for k, v in pairs(inDuty[job]) do
            if v == source then
                table.remove(inDuty[job], k)
                SendDiscordLog("dutyoff", "Fin de service", source, string.sub(GetDiscord(source), 9, -1), GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(), job)
                if job ~= "lspd" or job ~= "lssd" and isProduction then
                    PerformHttpRequest("http://141.94.99.95:3003/time/stop", function(err, text, headers) end, 'POST',
                        json.encode({ token = "54bbe11b-040c-4b98-b895-47ef16f46dc3",
                            discord = string.sub(GetDiscord(source), 9, -1), userData = json.encode(GetPlayer(source)),
                            entreprise = job })
                        , { ['Content-Type'] = 'application/json' }
                    )
                end
            end
        end
    else
        print("[ERROR] Le job " .. job .. " n'existe pas")
    end
end)

AddEventHandler("playerDropped", function()
    local source = source
    local obj = GetPlayer(source)
    if obj ~= nil then
        if obj:getJob() ~= nil then
            if inDuty[obj:getJob()] ~= nil then
                for k, v in pairs(inDuty[obj:getJob()]) do
                    if v == source then
                        table.remove(inDuty[obj:getJob()], k)
                    end
                end
            end
        end
    end
end)

function makeCallGreatAgain(job, pos, msg, type)
    print(job, json.encode(pos), msg, type)
    callActive[job].target = {
        id = 0,
        lastName = '',
        name = 'Inconnu(e)',
    }
    print("makeCallGreatAgain",json.encode(inDuty[job]), json.encode(callActive[job]))
    for k, v in pairs(inDuty[job]) do
        TriggerClientEvent("core:callIncoming", v, job, pos, callActive[job].target, msg, type)
    end
end

RegisterNetEvent("core:makeCall")
AddEventHandler("core:makeCall", function(job, pos, isPnjCall, msg, sonnette, type)
    local source = source
    if not isPnjCall then
        if callActive[job].target.id == source then
            TriggerClientEvent('core:takeCall', callActive[job].target.id, 'callAlrdyActive')
            return
        end

        callActive[job].target = {
            id = source,
            lastName = GetPlayer(source):getLastname(),
            name = GetPlayer(source):getFirstname(),
        }
    else
        callActive[job].target = {
            id = source,
            lastName = '',
            name = 'Inconnu(e)',
        }
    end

    if sonnette then
        -- get the label of the job
        local label = ''
        for k, v in pairs(Jobs) do
            if v.name == job then
                label = v.label
            end
        end
        -- TriggerClientEvent("core:ShowNotification", callActive[job].target.id, "Vous venez d'appeler l'entreprise ~g~" .. label)

        -- New notif
		TriggerClientEvent("__vision::createNotification", callActive[job].target.id, {
			type = 'CLOCHE',
			-- duration = 5, -- In seconds, default:  4
			content = "Vous venez d'appeler l'entreprise : ~s" .. label
		})
    end

    for k, v in pairs(inDuty[job]) do
        TriggerClientEvent("core:callIncoming", v, job, pos, callActive[job].target, msg, type)
    end

    if not isPnjCall then
        SetTimeout(60000, function()
            if next(callActive[job].target) then
                if type ~= 'illegal' then
                    TriggerClientEvent('core:takeCall', callActive[job].target.id, 'noAnswer')
                end
                callActive[job].target = {}
            end
        end)
    end
end)

RegisterNetEvent("core:callAccept")
AddEventHandler("core:callAccept", function(job, pos, targetData, type)
    local isPnj = false
    if callActive[job].target.name == 'Inconnu(e)' then
        isPnj = true
    end
    callActive[job].target = {}

    for k, v in pairs(inDuty[job]) do
        if v == source then
            TriggerClientEvent("core:callAccepted", v, job, pos, targetData, type)
        end
    end

    if not isPnj then
        if not next(callActive[job].target) then
            if type == nil then
                TriggerClientEvent('core:takeCall', targetData.id, 'callTake')
            end
        end
    end
end)

Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(1) end

    RegisterServerCallback("core:getNumberOfDuty", function(source, token, job)
        if CheckPlayerToken(source, token) then
            if job ~= "aucun" then
                if inDuty[job] ~= nil then
                    if #inDuty[job] ~= nil then
                        return #inDuty[job]
                    else
                        return 0
                    end
                else
                    print("[ERROR] Le job " .. job .. " n'existe pas")
                    return 0
                end
            else
                return 0
            end
        end
    end)

    RegisterServerCallback("core:GetHoraire", function(source, token)
        if CheckPlayerToken(source, token) then
            return os.date("%H")
        end
    end)

    RegisterServerCallback("core:getOnDuty", function(source, token, job)
        if CheckPlayerToken(source, token) then
            if job ~= "aucun" then
                if inDuty[job] ~= nil then
                    if inDuty[job] ~= nil then
                        return inDuty[job]
                    else
                        return false
                    end
                else
                    print("[ERROR] Le job " .. job .. " n'existe pas")
                    return false
                end
            else
                return false
            end
        end
    end)

    RegisterServerCallback("core:getOnDutyNames", function(source, token, job)
        if CheckPlayerToken(source, token) then
            if job ~= "aucun" then
                if inDuty[job] ~= nil then
                    if inDuty[job] ~= nil then
                        local names = {}
                        for k, v in pairs(inDuty[job]) do
                            local obj = GetPlayer(v)
                            table.insert(names, obj:getLastname() .. " " .. obj:getFirstname())
                        end
                        return names
                    else
                        return false
                    end
                else
                    print("[ERROR] Le job " .. job .. " n'existe pas")
                    return false
                end
            else
                return false
            end
        end
    end)
end)


exports("getOnDuty", function(job)
    --print(inDuty[job], job)
    return inDuty[job]
end)

CreateThread(function()
    -- thread to check all the players in duty and if they are still connected
    while true do
        Wait(900000) -- 15 minutes
        for k, v in pairs(inDuty) do
            for i, j in pairs(v) do
                if GetPlayer(j) == nil then
                    table.remove(inDuty[k], i)
                end
            end
        end
    end
end)


AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName and isProduction then
        PerformHttpRequest("http://141.94.99.95:3003/time/restart", function(err, text, headers) end, 'POST',
            json.encode({ token = "54bbe11b-040c-4b98-b895-47ef16f46dc3" })
            , { ['Content-Type'] = 'application/json' }
        )
        return
    end
    print('The resource ' .. resourceName .. ' has been started.')

    --sp_switchFrequence = {} 
    --MySQL.Async.fetchAll("SELECT * FROM frequency", {}, function(result)
    --    if result[1] ~= nil then
    --        for k, v in pairs(result) do
    --            sp_switchFrequence[v.job] = v.freq
    --        end
    --    end
    --end)
end)


--RegisterServerCallback("radio:askfreq", function(source)
--    return sp_switchFrequence
--end)
