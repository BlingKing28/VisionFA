players = {} ---@type player
function CreatePlayerData(src, perm)
    if GetPlayer(src) == nil then
        local license = GetLicense(src)

        local obj = player:new({}, true, src, perm) ---@return player
        players[src] = obj

        MySQL.Async.insert("INSERT INTO players (cloths, license, firstname, lastname, age, sex, size, birthplaces, inventaire, banque, pos, permission, job, job_grade, crew, active) VALUES (@1, @key, @12, @13, @14, @15, @16, @17, @3, @4, @5, @6, @7, @8, @9, @11)"
            , {
                ["1"] = json.encode(obj:getCloths()),
                ["3"] = json.encode(obj:getInventaire()),
                ["4"] = obj:getBanque(),
                ["5"] = json.encode(obj:getPos()),
                ["6"] =  obj:getPermission(),
                ["7"] = obj:getJob(),
                ["8"] = obj:getJobGrade(),
                ["9"] = obj:getCrew(),
                ["10"] = json.encode(obj:getStatus()),
                ["11"] = obj:getActive(),
                ["key"] = obj:getLicense(),
                ["12"] = obj:getFirstname(),
                ["13"] = obj:getLastname(),
                ["14"] = obj:getAge(),
                ["15"] = obj:getSex(),
                ["16"] = obj:getSize(),
                ["17"] = obj:getBirthplaces(),

            }, function(result)
            GetPlayer(src):setId(result)
            -- CorePrint("Player " .. src .. " saved.")
            GiveItemToPlayer(src, "bread", 5, {})
            GiveItemToPlayer(src, "money", 3000, {})
            GiveItemToPlayer(src, "water", 5, {})
            GiveItemToPlayer(src, "gps", 1, {})
            GiveItemToPlayer(src, "phone", 1, {})
            RefreshPlayerData(src)
            TriggerClientEvent("core:InitPlayer", src, GetImportantInfo())
            Bank.CreatePlayerCommonAccount(result)
        end)
    end
end

function LoadPlayerData(source, data, id)
    if GetPlayer(source) == nil then
        local data = data
        print("dt", data.permission)
        local obj = player:new(data, false, source) ---@return player
        players[source] = obj
        obj:setIdPerso(id)
        local pCrew = crew.getPlayerCrew(obj:getId())
        if pCrew then
            obj:setCrew(pCrew)
        else
            obj:setCrew("None")
        end
        RefreshPlayerData(source)
        TriggerEvent("core:playerLoaded", source)
        TriggerClientEvent("core:updateBankPhoneValue", source, Bank.GetPlayerCommonAccount(tonumber(source)).balance)
        TriggerClientEvent("core:InitPlayer", source, GetImportantInfo())
        obj:setActive(1)
        Wait(8000)
        SavePlayerData(source)
    end
end

local Answer = {}
RegisterNetEvent("core:PersonnageSelected")
AddEventHandler("core:PersonnageSelected", function(data)
    Answer[source] = data
end)


function GetPlayerData(source)
    local source = source
    local license = GetLicense(source)
    local FinalSend, charlist = nil, nil

    MySQL.Async.fetchAll("SELECT * FROM players WHERE license = @license", {
        ["@license"] = license
    }, function(result)
        if result[1] == nil then
            print(license, "1")
            CreatePlayerData(source, 0)
            FinalSend = 1
        elseif result[1].lastname == "" then
            print(license, "2")
            MySQL.Async.execute("DELETE FROM players WHERE id = @id", {
                ["@id"] = result[1].id
            }, function(result)
            end)
            CreatePlayerData(source, 0)
            FinalSend = 1
        else
            local tables = {}
            tables.characterList = {}
            local activeIndex = 1
            for k, v in pairs(result) do
                if v.active == 1 then
                    activeIndex = k
                end
                table.insert(tables.characterList, {id = v.id, name =  v.lastname .. " " .. v.firstname})
            end
            charlist = tables
            TriggerClientEvent("core:SpawnMenu", source, #GetPlayers())
            while Answer[source] == nil do Wait(10) end
            FinalSend = result[Answer[source]]
            Answer[source] = nil
        end
    end)

    while FinalSend == nil do Wait(1) end

    if FinalSend ~= 1 then
        MySQL.Async.fetchAll("SELECT permission, balance, subscription FROM players_unique WHERE license = @license", {
            ["@license"] = license
        }, function(result)
            if (result[1] == nil) then
                MySQL.Async.insert("INSERT INTO players_unique (license, permission, balance, subscription) VALUES (@license, @permission, @balance, @subscription)"
                , {
                    ["license"] = license,
                    ["permission"] = 0,
                    ["balance"] = 0,
                    ["subscription"] = 0,
                }, function(result)
                    table.insert(FinalSend, {permission = 0, balance = 0, subscription = 0})
                end)
            else
                print(json.encode(result[1]))
                FinalSend.balance=result[1].balance
                FinalSend.subscription=result[1].subscription
                FinalSend.permission=result[1].permission
            end
        end)
        Wait(250)
        LoadPlayerData(source, FinalSend, charlist)
    end
end

function SavePlayerData(source, isnewpersonnage)
    if GetPlayer(source) ~= nil then
        local obj = GetPlayer(source)
        if isnewpersonnage then
            MySQL.Async.execute("UPDATE players SET cloths = @1, tattoos = @2, degrader = @3, firstname = @15, lastname = @16, age = @17, sex = @18, size = @19, birthplaces = @20, inventaire = @5 , banque = @6 , permission = @7, job = @8, job_grade = @9, crew = @10, status = @12, active = @13, weapons = @14 WHERE license = @license AND id = @id"
                ,{
                    ["@1"] = json.encode(obj:getCloths()),
                    ["@2"] = json.encode(obj:getTattoos()),
                    ["@3"] = json.encode(obj:getDegrader()),
                    ["@5"] = json.encode(obj:getInventaire()),
                    ["@6"] = obj:getBanque(),
                    ["@7"] = obj:getPermission(),
                    ["@8"] = obj:getJob(),
                    ["@9"] = obj:getJobGrade(),
                    ["@10"] = obj:getCrew(),
                    ["@12"] = json.encode(obj:getStatus()),
                    ["@13"] = json.encode(obj:getActive()),
                    ["@14"] = json.encode(obj:getWeapons()),
                    ["@license"] = obj:getLicense(),
                    ["@id"] = obj:getId(),
                    ["@15"] = obj:getFirstname(),
                    ["@16"] = obj:getLastname(),
                    ["@17"] = obj:getAge(),
                    ["@18"] = obj:getSex(),
                    ["@19"] = obj:getSize(),
                    ["@20"] = obj:getBirthplaces(),
                },
            function(affectedRows)
                obj:setNeedSave(false)
            end)
        else
            MySQL.Async.execute("UPDATE players SET cloths = @1, tattoos = @2, degrader = @3, inventaire = @5 , banque = @6 , permission = @7, job = @8, job_grade = @9, crew = @10, status = @12, active = @13, weapons = @14, pos = @15 WHERE license = @license AND id = @id"
            ,{
                ["@1"] = json.encode(obj:getCloths()),
                ["@2"] = json.encode(obj:getTattoos()),
                ["@3"] = json.encode(obj:getDegrader()),
                ["@5"] = json.encode(obj:getInventaire()),
                ["@6"] = obj:getBanque(),
                ["@7"] = obj:getPermission(),
                ["@8"] = obj:getJob(),
                ["@9"] = obj:getJobGrade(),
                ["@10"] = obj:getCrew(),
                ["@12"] = json.encode(obj:getStatus()),
                ["@13"] = json.encode(obj:getActive()),
                ["@14"] = json.encode(obj:getWeapons()),
                ["@15"] = json.encode(obj:getPos()),
                ["@license"] = obj:getLicense(),
                ["@id"] = obj:getId(),
            },
            function(affectedRows)
                obj:setNeedSave(false)
            end)

            MySQL.Async.execute("UPDATE players_unique SET permission = @perm, balance = @balance, subscription = @subscription WHERE license = @license",
            {
                ["@license"] = obj:getLicense(),
                ["@perm"] = obj:getPermission(),
                ["@balance"] = obj:getBalance(),
                ["@subscription"] = obj:getSubscription(),
            },
            function(affectedRows)
                obj:setNeedSave(false)
            end)

        end
    end
end

function SavePlayerPos(source)
    if GetPlayer(source) ~= nil then
        local obj = GetPlayer(source)
        sql.update("players", { { column = "pos", data = json.encode(obj:getPos()) } },
            { "license = '" .. obj:getLicense() .. "'", 'id = ' .. obj:getId() })
        -- CorePrint("Player " .. source .. " pos saved.")
        obj:setNeedSave(false)
    end
end

function MarkPlayerPosAsNonSaved(source)
    if GetPlayer(source) ~= nil then
        local player = GetPlayer(source)
        if not player:getNeedSave() then
            player:setNeedSave(true)
        end
    end
end

function MarkPlayerDataAsNonSaved(source)
    if GetPlayer(source) ~= nil then
        local player = GetPlayer(source)
        if not player:getNeedSave() then
            player:setNeedSave(true)
        end
    end
end

function RefreshPlayerData(source)
    local player = GetPlayer(source)
    TriggerLatentClientEvent("core:RefreshPlayerData", source, 25000, player)
    RefreshPlayerKeys(source)
    RefreshCarJob(source, player:getJob())
end

function GetImportantInfo()
    local infoToSend = {}
    infoToSend.jobs = jobs
    return infoToSend
end

RegisterNetEvent("core:InitPlayer")
AddEventHandler("core:InitPlayer", function()
    local src = source
    GetPlayerData(src)
    Citizen.Wait(2000)
    local obj = GetPlayer(src)
    local discord = GetDiscord(src)
    local identifiers = PlayersIdentifierToString(src)
    if obj ~= nil and discord ~= nil and identifiers ~= nil then
        SendDiscordLog("connexion", src, string.sub(discord, 9, -1), obj:getFirstname() .. " " .. obj:getLastname()
            , string.sub(identifiers, 1, string.find(identifiers, "ip:") - 1))
        givekeytmp(obj:getId(), obj:getCrew(), obj:getJob(), src)
    end
end)

function triggerEventPlayer(eventName, source, ...)
    --print(eventName)
	TriggerClientEvent(eventName, source, ...)
end

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        CorePrint("Resource stopping, saving players.")
        for k, v in pairs(casier) do
            for key, value in pairs(casier[k]) do
                if casier[k][key].needSave then
                    SaveCasier(k, key)
                end
            end
        end
        for k, v in pairs(players) do
            -- for j, i in pairs(GetAllVehiclesClass()) do
            --     if i.stored ~= nil then
            --         if i.stored >= 1 then
            --             i.stored = 2
            --         end
            --         i:saveVehicle()
            --     end
            -- end
            SavePlayerData(k)
        end
    end
end)

RegisterCommand("save", function(source)
    SavePlayerData(source)
    --RefreshPlayerData(source)

    -- New notif
    TriggerClientEvent("__vision::createNotification", source, {
        type = 'SYNC',
        -- duration = 5, -- In seconds, default:  4
        content = "~sSauvegarde de vos données"
    })

end)

AddEventHandler("playerDropped", function(reason)
    local source = source
    local obj = GetPlayer(source)
    CorePrint("Player " .. source .. " dropped (" .. reason .. ").")
    if obj ~= nil then
        local discord = GetDiscord(source)
        local identifiers = PlayersIdentifierToString(source)
        SendDiscordLog("deconnexion", source, string.sub(discord, 9, -1), obj:getFirstname() .. " " .. obj:getLastname(), reason, string.sub(identifiers, 1, string.find(identifiers, "ip:") - 1))
        SaveDemarchePlayer(source)

        local ped = GetPlayerPed(source)
        obj:setPos(vector4(GetEntityCoords(ped), GetEntityHeading(ped)))

        --SavePlayerPos(source)
        SavePlayerData(source)
        RemovePlayer(source)
    end

    players[source] = nil
end)

Citizen.CreateThread(function()
    while true do
        Wait(5 * 60000)
        for k, v in pairs(players) do
            local obj = v
            if obj:getNeedSave() then
                SavePlayerData(k)
                if GetPlayerPing(k) == 0 then
                    players[k] = nil
                    RemovePlayer(k)
                end
                Wait(1000)
            end
        end
    end
end)

RegisterNetEvent("core:RestaurationInventaireDeBgplayer")
AddEventHandler("core:RestaurationInventaireDeBgplayer", function()
    local count = nil
    local source = source
    for k, v in pairs(GetPlayer(source):getInventaire()) do
        if v.name == "money" then
            v.count = math.floor(v.count + 0.5)
        end
        if v.metadatas == nil then
            count = v.count
            RemoveItemFromInventoryNil(source, v.name, v.count, v.metadatas)
        end
        if v.name == "money" and v.metadatas == nil then
            count = v.count
            RemoveItemFromInventoryNil(source, v.name, v.count, v.metadatas)
            for key, value in pairs(GetPlayer(source):getInventaire()) do
                if value.name == "money" and value.metadatas ~= nil then
                    AddItemToInventory(source, value.name, count, value.metadatas)
                end
            end
        end
        if v.name == "tshirt" and v.count > 1 then
            RemoveItemFromInventory(source, v.name, v.count, v.metadatas)
            AddItemToInventory(source, v.name, 1, v.metadatas)
        elseif v.name == "outfit" and v.count > 1 then
            RemoveClothFromInventory(source, v.name, v.count, v.metadatas)
            AddItemToInventory(source, v.name, 1, v.metadatas)
        elseif v.name == "pant" and v.count > 1 then
            RemoveItemFromInventory(source, v.name, v.count, v.metadatas)
            AddItemToInventory(source, v.name, 1, v.metadatas)
        elseif v.name == "glasses" and v.count > 1 then
            RemoveItemFromInventory(source, v.name, v.count, v.metadatas)
            AddItemToInventory(source, v.name, 1, v.metadatas)
        elseif v.name == "feet" and v.count > 1 then
            RemoveItemFromInventory(source, v.name, v.count, v.metadatas)
            AddItemToInventory(source, v.name, 1, v.metadatas)
        elseif v.name == "bague" and v.count > 1 then
            RemoveItemFromInventory(source, v.name, v.count, v.metadatas)
            AddItemToInventory(source, v.name, 1, v.metadatas)
        elseif v.name == "ongle" and v.count > 1 then
            RemoveItemFromInventory(source, v.name, v.count, v.metadatas)
            AddItemToInventory(source, v.name, 1, v.metadatas)
        elseif v.name == "piercing" and v.count > 1 then
            RemoveItemFromInventory(source, v.name, v.count, v.metadatas)
            AddItemToInventory(source, v.name, 1, v.metadatas)
        elseif v.name == "montre" and v.count > 1 then
            RemoveItemFromInventory(source, v.name, v.count, v.metadatas)
            AddItemToInventory(source, v.name, 1, v.metadatas)
        elseif v.name == "bracelet" and v.count > 1 then
            RemoveItemFromInventory(source, v.name, v.count, v.metadatas)
            AddItemToInventory(source, v.name, 1, v.metadatas)
        elseif v.name == "bouclesoreilles" and v.count > 1 then
            RemoveItemFromInventory(source, v.name, v.count, v.metadatas)
            AddItemToInventory(source, v.name, 1, v.metadatas)
        elseif v.name == "collier" and v.count > 1 then
            RemoveItemFromInventory(source, v.name, v.count, v.metadatas)
            AddItemToInventory(source, v.name, 1, v.metadatas)
        elseif v.name == "mask" and v.count > 1 then
            RemoveItemFromInventory(source, v.name, v.count, v.metadatas)
            AddItemToInventory(source, v.name, 1, v.metadatas)
        elseif v.name == "hat" and v.count > 1 then
            RemoveItemFromInventory(source, v.name, v.count, v.metadatas)
            AddItemToInventory(source, v.name, 1, v.metadatas)
        elseif v.name == "access" and v.count > 1 then
            RemoveItemFromInventory(source, v.name, v.count, v.metadatas)
            AddItemToInventory(source, v.name, 1, v.metadatas)
        end
    end
end)

RegisterNetEvent("core:getPlayerHealth")
AddEventHandler("core:getPlayerHealth", function(health)
    GetPlayer(source):setHealth(health)
end)

RegisterServerCallback("core:GetAllPersonnage", function(source)
    return GetPlayer(source):getIdPerso()
end)

RegisterNetEvent("core:NewPersonnage")
AddEventHandler("core:NewPersonnage", function()
    local source = source
    GetPlayer(source):setActive(0)
    local perm = GetPlayer(source):getPermission()
    SaveDemarchePlayer(source)
    SavePlayerPos(source)
    SavePlayerData(source, true)
    RemovePlayer(source)
    players[source] = nil

    CreatePlayerData(source, perm)
end)

RegisterNetEvent("core:Switch")
AddEventHandler("core:Switch", function(id)
    local source = source
    GetPlayer(source):setActive(0)
    SaveDemarchePlayer(source)
    SavePlayerPos(source)
    SavePlayerData(source)
    RemovePlayer(source)
    players[source] = nil
    SetPlayerToActive(source, id)
end)

function SetPlayerToActive(source, id)
    MySQL.Async.execute("UPDATE players SET active = @1 WHERE license = @license AND id = @id"
            ,{
                ["@1"] = 1,
                ["@license"] = GetLicense(source),
                ["@id"] = id,
            },
            function(affectedRows)
                switchPlayer(source)
                -- CorePrint("Player " .. source .. " saved.")
            end)
end

function switchPlayer(source)
    local src = source
    GetPlayerData(src)
    Citizen.Wait(2000)
    local obj = GetPlayer(src)
    -- local discord = GetDiscord(src)
    -- local identifiers = PlayersIdentifierToString(src)
    -- SendDiscordLog("switch", src, string.sub(discord, 9, -1), obj:getFirstname() .. " " .. obj:getLastname()
    --     , string.sub(identifiers, 1, string.find(identifiers, "ip:") - 1))
end

function GetPlayerFromId(id)
    for k, v in pairs(players) do
        if v:getId() == id then
            return v
        end
    end
    -- if player not loaded, load it
    return MySQL.Sync.fetchAll("SELECT * FROM players WHERE id = @id LIMIT 1", { ["@id"] = id })[1]
end

Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(1) end

    RegisterServerCallback("core:GetAllPersoFromPlayer", function(source)
        local license = GetLicense(source)
        local finalRes = nil
        MySQL.Async.fetchAll("SELECT firstname, lastname, job, active, cloths, balance FROM players LEFT JOIN bank ON players.id = bank.player WHERE license = @license ", {
            ["@license"] = license
        }, function(result)
            if result == nil then
                finalRes = 0
            else
                finalRes = result
            end
        end)
        while finalRes == nil do Wait(10)  end
        return finalRes
    end)

end)