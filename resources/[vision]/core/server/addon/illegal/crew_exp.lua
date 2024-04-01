local ExpLevel = {
    [1] = 0,
    [2] = 40000,
    [3] = 80000,
    [4] = 120000,
    [5] = 160000, 
}

CrewAcces = {
    --mafia
    ["Cartel Santa Blanca"] = {id = 1},
    ["TEST CREW"] = {id = 2},
    ["Mafia Arménienne"] = {id = 3},
    ["Los Sicarios"] = {id = 4},--to replace
    ["Mafia Albanaise"] = {id = 5},--to replace
    ["TRIADE"] = {id = 6},
    ["Cartel De Bogota"] = {id = 7},
    --orga
    ["Wonderland"] = {id = 10},
    ["Loco Syndicate"] = {id = 11},--to replace
    ["Cartel Madrazo"] = {id = 12},--to replace
    ["Luz Familiar"] = {id = 13},
    ["Faucons Rouge"] = {id = 14},
    ["Los Surenos"] = {id = 15},
    ["Cherokees"] = {id = 16},
    ["Blacks Angels"] = {id = 17},
    --mc
    ["Grim Bastards"] = {id = 20},
    ["The Lost MC"] = {id = 21},
    ["MayansMC"] = {id = 22},
    ["Calaveras Nomads"] = {id = 23},--to replace
    ["Angels Of Death"] = {id = 24},
    --gang
    ["Aztecas"] = {id = 30},
    ["BallasGang"] = {id = 31},
    ["Los Santos Vagos"] = {id = 32},
    ["Les Families"] = {id = 33},
    ["BallasGangz"] = {id = 34},--to replace
    ["les papys"] = {id = 35},
    ["YBD"] = {id = 36},
    ["13 Crimson Gang"] = {id = 37},--to replace
    --pf
    ["9 Blocc"] = {id = 40},
    ["Kuso Gaki"] = {id = 41},
    ["Les sdf de la freeway"] = {id = 42},--to replace
    ["Boston Street"] = {id = 43},
    ["Sokudo Chasers"] = {id = 44},
    ["Night Shift"] = {id = 45},
    ["Vinewood Boyz"] = {id = 46},
}


CrewExp = {}
RegisterNetEvent("core:addCrewExp")
AddEventHandler("core:addCrewExp", function(crew, expADD, origin)
    local src = source
    if CrewAcces[crew] ~= nil then
        local NewExp = 0
        if CrewExp[crew] == nil then
            MySQL.Async.fetchAll('SELECT exp FROM crew WHERE name = @crew',{
                ["@crew"] = crew
            }, function(resultat)
                CrewExp[crew] = 0
                NewExp = tonumber(resultat[1].exp) + expADD
                CrewExp[crew] = NewExp
            end)
        else
            for k,v in pairs(CrewExp) do
                if k == crew then
                    local lastvalue = v
                    CrewExp[crew] = lastvalue + expADD
                end
            end
        end

        -- New notif
        TriggerClientEvent("__vision::createNotification", src, {
            type = 'VERT',
            -- duration = 5, -- In seconds, default:  4
            content = "Réputation du crew ~s augmenté ~c de ~s".. expADD .."~c point(s) !"
        })
        SendDiscordLog("xp", src, string.sub(GetDiscord(src), 9, -1),
            GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(), crew, expADD, origin)

    end
end)

RegisterNetEvent("core:rmvCrewExp")
AddEventHandler("core:rmvCrewExp", function(crew, expADD)
    if CrewAcces[crew] ~= nil then
        local src = source
        local NewExp = 0
        if CrewExp[crew] == nil then
            MySQL.Async.fetchAll('SELECT exp FROM crew WHERE name = @crew',{
                ["@crew"] = crew
            }, function(resultat)
                CrewExp[crew] = 0
                NewExp = tonumber(resultat[1].exp) - expADD
                if NewExp < 0 then
                    NewExp = 0
                end
                CrewExp[crew] = NewExp
            end)
        else
            for k,v in pairs(CrewExp) do
                if k == crew then
                    local lastvalue = v
                    CrewExp[crew] = lastvalue - expADD
                    if CrewExp[crew] < 0 then
                        CrewExp[crew] = 0
                    end
                end
            end
        end
        

        TriggerClientEvent("__vision::createNotification", src, {
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "Réputation du crew ~s diminué ~c de ~s".. expADD .."~c point(s) !"
        })

    end
end)

-- CreateThread(function()
--     while true do 
--         Wait(4000)
--         print(json.encode(CrewExp))
--     end
-- end)

RegisterNetEvent("core:addCrewExpStaff")
AddEventHandler("core:addCrewExpStaff", function(crewID, expADD)
    local crew = nil
    local src = source
    local NewExp = 0
    for k,v in pairs(CrewAcces) do 
        if v.id == crewID then
            crew = k
        end
    end
    if CrewExp[crew] == nil then
        MySQL.Async.fetchAll('SELECT exp FROM crew WHERE name = @crew',{
            ["@crew"] = crew
        }, function(resultat)
            NewExp = tonumber(resultat[1].exp) + expADD
            CrewExp[crew] = NewExp
        end)
    else
        for k,v in pairs(CrewExp) do
            if k == crew then
                local lastvalue = v
                CrewExp[crew] = lastvalue + expADD
            end
        end
    end
    -- New notif
    TriggerClientEvent("__vision::createNotification", src, {
        type = 'VERT',
        -- duration = 5, -- In seconds, default:  4
        content = "Vous venez ~sd'ajouter ~c".. expADD .." xp au crew ~s" .. crew .. "~c !"
    })
    SendDiscordLog("xp", src, string.sub(GetDiscord(src), 9, -1),
        GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(), crew, expADD, "staffCommand")
end)

RegisterNetEvent("core:rmvCrewExpStaff")
AddEventHandler("core:rmvCrewExpStaff", function(crewID, expADD)
    local crew = nil
    local src = source
    local NewExp = 0
    for k,v in pairs(CrewAcces) do 
        if v.id == crewID then
            crew = k
        end
    end
    if CrewExp[crew] == nil then
        MySQL.Async.fetchAll('SELECT exp FROM crew WHERE name = @crew',{
            ["@crew"] = crew
        }, function(resultat)
            CrewExp[crew] = 0
            NewExp = tonumber(resultat[1].exp) - expADD
            if NewExp < 0 then
                NewExp = 0
            end
            CrewExp[crew] = NewExp
        end)
    else
        for k,v in pairs(CrewExp) do
            if k == crew then
                local lastvalue = v
                CrewExp[crew] = lastvalue - expADD
                if CrewExp[crew] < 0 then
                    CrewExp[crew] = 0
                end
            end
        end
    end
    -- New notif
    TriggerClientEvent("__vision::createNotification", src, {
        type = 'VERT',
        -- duration = 5, -- In seconds, default:  4
        content = "Vous venez de ~sretirer ~c".. expADD .." xp au crew ~s" .. crew .. "~c !"
    })


end)

Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(1) end
    RegisterServerCallback("core:GetCrewLevel", function(source, crewName)
        local ReturnCrewExp = 0
        local ReturnCrewLevel = 1
        if CrewExp[crewName] == nil then
            MySQL.Async.fetchAll('SELECT exp FROM crew WHERE name = @crew',{
                ["@crew"] = crewName
            }, function(resultat)
                CrewExp[crewName] = tonumber(resultat[1].exp)
                ReturnCrewExp = tonumber(resultat[1].exp)
            end)
        else
            for k,v in pairs(CrewExp) do
                if k == crewName then
                    ReturnCrewExp = v
                end
            end
        end
        Wait(500)
        if ReturnCrewExp < ExpLevel[2] then
            ReturnCrewLevel = 1
        elseif ReturnCrewExp >= ExpLevel[2] and ReturnCrewExp < ExpLevel[3] then
            ReturnCrewLevel = 2
        elseif ReturnCrewExp >= ExpLevel[3] and ReturnCrewExp < ExpLevel[4] then
            ReturnCrewLevel = 3
        elseif ReturnCrewExp >= ExpLevel[4] and ReturnCrewExp < ExpLevel[5] then
            ReturnCrewLevel = 4
        elseif ReturnCrewExp >= ExpLevel[5] then
            ReturnCrewLevel = 5
        end
        return ReturnCrewLevel
    end)
end)

Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(1) end
    RegisterServerCallback("core:GetCrewExp", function(source, toke, crewName)
        local ReturnCrewExp = 0
        while not next(CrewExp) do Wait(0) end
        if CrewExp[crewName] == nil then
            MySQL.Async.fetchAll('SELECT exp FROM crew WHERE name = @crew',{
                ["@crew"] = crewName
            }, function(resultat)
                CrewExp[crewName] = tonumber(resultat[1].exp)
                ReturnCrewExp = tonumber(resultat[1].exp)
            end)
        else
            for k,v in pairs(CrewExp) do
                if k == crewName then
                    ReturnCrewExp = v
                end
            end
        end
        return ReturnCrewExp
    end)
end)

CreateThread(function()
    while not MySQL do
        Wait(1)
    end
    Wait(1500)
    MySQL.Async.fetchAll('SELECT name, exp FROM crew',{}, function(resultat)
        for k,v in pairs(resultat) do
            CrewExp[resultat[k].name] = tonumber(resultat[k].exp)
        end
    end)
end)

-- Save de l'exp toutes les 5 minutes
CreateThread(function()
    while true do
        Wait(300000)
        for k,v in pairs(CrewExp) do
            MySQL.Async.execute('UPDATE `crew` SET `exp` = @newExp WHERE `name` = @name',
                {
                    ["@name"] = k,
                    ["@newExp"] = v,
                }
            )
        end
    end
end)
