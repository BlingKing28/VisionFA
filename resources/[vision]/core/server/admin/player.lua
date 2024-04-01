local function WipePlayer(player)
    if GetPlayer(player) ~= nil then
        local license = GetPlayer(player):getLicense()
        local id = GetPlayer(player):getId()
        local src = source
        print("WipePlayer", id)
        MySQL.Async.execute("DELETE FROM bank WHERE player = @playerId", { ['@playerId'] = id })
        MySQL.Async.execute("DELETE FROM crew_members WHERE player_id = @player_id", { ['@player_id'] = id })
        MySQL.Async.execute("DELETE FROM license WHERE id_player = @player_id", { ['@player_id'] = id })
        MySQL.Async.execute("DELETE FROM vehicles WHERE owner = @player_id", { ['@player_id'] = id })
        MySQL.Async.execute("DELETE FROM players WHERE id = @player_id", { ['@player_id'] = id })
        MySQL.Async.execute("DELETE FROM phone_phones WHERE id = @player_id", { ['@player_id'] = id })
        -- update property for owner and co-owner by the column license - the co owner lose the property also check with wiped player before
        MySQL.Async.execute("UPDATE property SET owner = @1, co_owner = @2, rentedAt = @3, rentalEnd = @4, type = @5 WHERE owner = @player_id and type = @type"
        , {
            ["@1"] = nil,
            ["@2"] = nil,
            ["@3"] = nil,
            ["@4"] = nil,
            ["@5"] = nil,
            ["@player_id"] = id,
            ["@type"] = "Individuel"
        })
        --useless
        -- update property where wiped player is co-owner by the column license - the co owner lose the property also check with wiped player before
        -- MySQL.Async.fetchAll("SELECT * FROM property WHERE co_owner LIKE @player_id", {
        --     ["@player_id"] = '%' .. id .. '%'
        -- }, function(result)
        --     local objToReturn
        --     local simpleLicense = true
        --     if result ~= nil then
        --         for i, line in ipairs(result) do
        --             for key, value in pairs(line) do
        --                 if key == 'co_owner' then
        --                     if json.decode(value) ~= nil then
        --                         objToReturn = json.decode(value)
        --                         for k, val in pairs(objToReturn) do
        --                             if val["license"] == id then
        --                                 table.remove(objToReturn, k);
        --                                 simpleLicense = false
        --                             end
        --                         end
        --                     end
        --                 end
        --             end
        --             if simpleLicense then
        --                 MySQL.Async.execute("UPDATE property SET co_owner = @1 WHERE co_owner = @player_id"
        --                 , {
        --                     ["@1"] = nil,
        --                     ["@player_id"] = id
        --                 })
        --             else
        --                 MySQL.Async.execute("UPDATE property SET co_owner = @1 WHERE id = @obj"
        --                 , {
        --                     ["@1"] = json.encode(objToReturn),
        --                     ["@obj"] = line['id']
        --                 })
        --                 simpleLicense = true
        --             end
        --         end
        --     end
        -- end)
        SendDiscordLog("wipe", src, string.sub(GetDiscord(player), 9, -1),
        GetPlayer(player):getLastname() .. " " .. GetPlayer(player):getFirstname(),
        GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(),
        string.sub(GetDiscord(src), 9, -1))
        
        DropPlayer(player, "Wipe :)")
    end
end

RegisterNetEvent("core:wipePlayer")
AddEventHandler("core:wipePlayer", function(token, player)
    if CheckPlayerToken(source, token) then
        if GetPlayer(source):getPermission() >= 3 then
            WipePlayer(player)
        end
    end
end)

RegisterNetEvent("core:setPermAdmin")
AddEventHandler("core:setPermAdmin", function(token, player, id)
    local source = source
    if CheckPlayerToken(source, token) then
        if GetPlayer(source):getPermission() >= 4 then
            GetPlayer(player):setPermission(id)
        else
            DropPlayer(source, "Red is kinda sus")
        end
    end
end)

RegisterNetEvent("core:SendMessage")
AddEventHandler("core:SendMessage", function(token, player, msg)
    local source = source
    if CheckPlayerToken(source, token) then
        if GetPlayer(source):getPermission() >= 3 then
            SendDiscordLog("messadmin", source, string.sub(GetDiscord(source), 9, -1),
                GetPlayer(source):getFirstname() .. " " .. GetPlayer(source):getLastname(), msg,
                GetPlayer(player):getFirstname() .. " " .. GetPlayer(player):getLastname(),
                string.sub(GetDiscord(player), 9, -1))
--[[             TriggerClientEvent("core:ShowAdvancedNotification", player, "Vision", "Administration", msg, "CHAR_VISION",
                "VISION") ]]

            TriggerClientEvent("__vision::createNotification", player, {
                type  = 'VISION',
                name  = "VISION",
                content = msg,
                typeannonce = "ADMINISTRATION",
                labeltype = "ADMINISTRATION",
                duration = 10,
            })
            
        end
    end
end)

RegisterNetEvent("core:TakeScreenBiatch")
AddEventHandler("core:TakeScreenBiatch", function(token, id)
    local source = source
    if CheckPlayerToken(source, token) then
        if GetPlayer(source):getPermission() >= 3 then
            TriggerClientEvent("core:TakeScreenBiatch", id,
                GetPlayer(source):getFirstname() .. " " .. GetPlayer(source):getLastname() .. " (" .. GetPlayerName(source) .. ") ")
        end
    end
end)

RegisterNetEvent("testlog")
AddEventHandler("testlog", function(img, identity)
    local src = source
    SendDiscordLogImage("screenshot", source, img,
        GetPlayer(src):getFirstname() .. " " .. GetPlayer(src):getLastname(),
        GetPlayer(src):getLicense(), img, identity)
end)

RegisterNetEvent("core:MaKeAnnounceVision")
AddEventHandler("core:MaKeAnnounceVision", function(token, message)
    if CheckPlayerToken(source, token) then
        if GetPlayer(source):getPermission() >= 3 then
            print("Announce : " .. message)
--[[             TriggerClientEvent('core:ShowAdvancedNotification', -1, "Administration", "~r~Annonce", message,
                "CHAR_VISION", "VISION") ]]


            TriggerClientEvent("__vision::createNotification", -1, {
                type  = 'VISION',
                name  = "VISION",
                content = message,
                typeannonce = "ADMINISTRATION",
                labeltype = "ANNONCE",
                duration = 10,
            })

            SendDiscordLog("announceModo", source, string.sub(GetDiscord(source), 9, -1),
                GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(), message)
        end
    end
end)

RegisterNetEvent("core:loadCreator")
AddEventHandler("core:loadCreator", function(token, player)
    if CheckPlayerToken(source, token) then
        if GetPlayer(source):getPermission() >= 2 then
            TriggerClientEvent("core:loadCreator", player)
        end
    end
end)

RegisterNetEvent("core:hooklog")
AddEventHandler("core:hooklog", function(pos, model, plate)
    SendDiscordLog("hook", source, string.sub(GetDiscord(source), 9, -1),
        GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(), pos, model, plate)
end)

local StaffInStaffMode = {}
local Reports = {}
local LastReport = 0
local NumberOfReports = 0

RegisterNetEvent("core:SendReport")
AddEventHandler("core:SendReport", function(token, tableReport)
    if CheckPlayerToken(source, token) then
        LastReport = LastReport + 1
        NumberOfReports = NumberOfReports + 1
        tableReport["time"] = os.date("%Hh %Mmin %Ss")
        Reports[LastReport] = {}
        Reports[LastReport] = tableReport
        if StaffInStaffMode ~= nil then
            for k,v in pairs(StaffInStaffMode) do
                TriggerClientEvent("__vision::createNotification", k, {
                    type  = 'VISION',
                    name  = "REPORT N°"..LastReport,
                    content = "Nouveau report de " .. tableReport["name"] .. " ( " .. tableReport["id"] .. " / ".. tableReport["uniqueID"] .." )",
                    typeannonce = "ADMINISTRATION",
                    labeltype = "ANNONCE",
                    duration = 5,
                })
                TriggerClientEvent("core:NbReportsForStaff", k, NumberOfReports)
            end
        end
    end
end)

RegisterNetEvent("core:StaffInAction")
AddEventHandler("core:StaffInAction", function(token, statu)
    local src = source
    if  CheckPlayerToken(src, token) then
        if statu then
            StaffInStaffMode[src] = true
            TriggerClientEvent("core:NbReportsForStaff", src, NumberOfReports)
        else
            StaffInStaffMode[src] = nil
        end
    end
end)

RegisterServerEvent("core:delReport")
AddEventHandler("core:delReport", function(id)
    if Reports[id] ~= nil then
        NumberOfReports = NumberOfReports - 1
        Reports[id] = nil
        if StaffInStaffMode ~= nil then
            for k,v in pairs(StaffInStaffMode) do
                TriggerClientEvent("core:NbReportsForStaff", k, NumberOfReports)
            end
        end
    end
end)


Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(100) end

    RegisterServerCallback("core:GetAllPlayer", function(source, token)
        if CheckPlayerToken(source, token) then
            local players = { count = 0, players = {} }
            local player = GetAllplayer()
            for k, v in pairs(player) do
                players.players[k] = { 
                    id = tonumber(v["source"]), 
                    name = GetPlayerName(v["source"]),
                    firstname = v["firstname"], 
                    lastname = v["lastname"]
                }
                players.count = players.count + 1
            end
            return players
        end
    end)

    RegisterServerCallback("core:GetAllReports", function(source, token)
        if CheckPlayerToken(source, token) then
            return Reports
        end
    end)

    RegisterServerCallback("core:VerifReport", function(source, id)
        local valReturn = false
        if Reports[id] ~= nil then valReturn = true end
        return valReturn
    end)

    RegisterServerCallback("core:GetAllPlayerInfo", function(source, token, id)
        if CheckPlayerToken(source, token) then
            local DataSend = {
                uniqueID = GetPlayer(id):getId(),
                bank = Bank.GetPlayerCommonAccount(id),
                job = GetPlayer(id):getJob(),
                jobGrade = GetPlayer(id):getJobGrade(),
                crew = GetPlayer(id):getCrew(),
                instance = GetPlayerRoutingBucket(id),
                discord = string.sub(GetDiscord(id), 9, -1)
            }
            return DataSend
        end
    end)

    RegisterServerCallback("core:GetInventoryPlayer", function(source, token, id)
        if CheckPlayerToken(source, token) then
            local inv = GetPlayer(id):getInventaire()
            return inv 
        end
    end)
    
    RegisterServerCallback("core:GetAllCrew", function(source, token)
        if CheckPlayerToken(source, token) then
            NameCrew = {}
            for k,v in pairs(allCrews) do 
                NameCrew[k] = {name = v["name"], id = v["id"]}
            end
            return NameCrew
        end
    end)

    RegisterServerCallback("core:CoordsOfPlayer", function(source, token, idSelect)
        local src = source
        if CheckPlayerToken(src, token) then
            if GetPlayer(src):getPermission() >= 3 then
                return GetEntityCoords(GetPlayerPed(idSelect))
            end
        end
    end)

end)

RegisterNetEvent("core:staffActionLog")
AddEventHandler("core:staffActionLog", function(token, action, target)
    if CheckPlayerToken(source, token) then
        SendDiscordLog("staffAction", source, string.sub(GetDiscord(source), 9, -1),
            GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(), action, target,
            reason)
    end
end)

RegisterNetEvent("core:acteurLog")
AddEventHandler("core:acteurLog", function(token, action, target)
    if CheckPlayerToken(source, token) then
        SendDiscordLog("acteur", source, string.sub(GetDiscord(source), 9, -1),
            GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(), action, target,
            reason)
    end
end)

RegisterNetEvent("core:acteurLog")
AddEventHandler("core:acteurLog", function(token, id, nvPerm)
    if CheckPlayerToken(source, token) then
        TriggerClientEvent("core:RefreshPermSTAFFc", id, nvPerm)
    end
end)

RegisterNetEvent("core:ReturnPositionPlayer")
AddEventHandler("core:ReturnPositionPlayer", function(token, id, coords)
    if CheckPlayerToken(source, token) then
        if GetPlayer(source):getPermission() >= 2 then
            TriggerClientEvent("core:GotoBring", tonumber(id), coords)
        end
    end
end)

