casier = {}
--n°casier job inv
local function LoadAllCasier()
    MySQL.Async.fetchAll('SELECT * FROM casier', {}, function(result)
        for k, v in pairs(result) do
            if casier[result[k].job] == nil then
                casier[result[k].job] = {}
                casier[result[k].job][result[k].num] = {}
                casier[result[k].job][result[k].num].inv = json.decode(result[k].inventory)
                casier[result[k].job][result[k].num].needSave = false
                -- CorePrint('^7 Load Casier ^2' .. result[k].job .. '^7 n°' .. result[k].num)
            elseif casier[result[k].job][result[k - 1].num] ~= casier[result[k].job][result[k].num] then
                casier[result[k].job][result[k].num] = {}
                casier[result[k].job][result[k].num].inv = json.decode(result[k].inventory)
                casier[result[k].job][result[k].num].needSave = false
                -- CorePrint('^7 Load Casier ^2' .. result[k].job .. '^7 n°' .. result[k].num)
            end
            Wait(50)
        end
    end)
    CorePrint("Tous les casiers de la bdd ont été load.")
end

MySQL.ready(function()
    Wait(1000)
    LoadAllCasier()
end)

local function NewCasier(job, id)
    if casier[job] == nil then
        casier[job] = {}
    end
    if casier[job][id] == nil then
        casier[job][id] = {}
        casier[job][id].inv = {}
        casier[job][id].needSave = false
        MySQL.Async.execute("INSERT INTO casier (num, job, inventory) VALUES (@1, @2, @3)",
            {
                ['1'] = id,
                ['2'] = job,
                ['3'] = json.encode(casier[job][id].inv),
            },
            function(affectedRows)
                CorePrint("Casier " .. job .. " n° " .. id .. " inséré en bdd")
            end)
    end
end

function SaveCasier(job, id)
    MySQL.Async.execute("UPDATE casier SET inventory = @1 WHERE job = @job AND num = @num",
        {
            ['@1'] = json.encode(casier[job][id].inv),
            ['@job'] = job,
            ['@num'] = id,

        },
        function(affectedRows)
            -- CorePrint("Casier " .. job .. " n° " .. id .. " saved (" .. affectedRows .. ")")
        end)
    casier[job][id].needSave = false
end

function MarkCasierAsNotSaved(job, id)
    if casier[job] ~= nil then
        casier[job][id].needSave = true
    end
end

function AddItemInventoryCasier(job, id, item, count, metadatas, src)
    local source = src
    AddItemToCasierInventory(job, id, item, count, metadatas)
    -- RefreshSocietyInventory(societys)
    MarkCasierAsNotSaved(job, id)
    SendDiscordLog("casier", source, string.sub(GetDiscord(source), 9, -1),
    GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(),
    GetPlayer(source):getJob(), "La personne a **ajouté** l'item " .. item .. " du casier n°" .. id .. " pour le job " .. job)
end

function RemoveItemInventoryCasier(job, id, item, count, metadatas, src)
    local source = src
    if item == "bike" then
        RemoveItemFromInventoryCasierBike(job, id, item, count, metadatas)
    elseif item == "identitycard" then
        RemoveItemFromInventoryCasierIdentityCard(job, id, item, count, metadatas)
    elseif item == "outfit" then 
        RemoveItemFromInventoryCasierCloth(job, id, item, count, metadatas)
    else
        RemoveItemFromInventoryCasier(job, id, item, count, metadatas)
    end
    SendDiscordLog("casier", source, string.sub(GetDiscord(source), 9, -1),
        GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(),
        GetPlayer(source):getJob(), "La personne a **retiré** l'item " .. item .. " du casier n°" .. id .. " pour le job " .. job)
    -- RefreshSocietyInventory(societys)
    MarkCasierAsNotSaved(job, id)
end

Citizen.CreateThread(function()
    while true do
        Wait(20 * 60000)
        for k, v in pairs(casier) do
            for key, value in pairs(casier[k]) do
                if casier[k][key].needSave then
                    SaveCasier(k, key)
                    Wait(1000)
                end
            end
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
	for k, v in pairs(casier) do
        for key, value in pairs(casier[k]) do
            if casier[k][key].needSave then
                SaveCasier(k, key)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(1000) end
    RegisterServerCallback("core:GetAllCasierByJob", function(source, name)
        return casier[name]
    end)

    RegisterServerCallback("core:GetInventoryCasierByid", function(source, job, id)
        return casier[job][id].inv
    end)
end)


RegisterNetEvent("core:CreateNewCasier")
AddEventHandler('core:CreateNewCasier', function(token, job, id)
    local src = source
    if CheckPlayerToken(src, token) then
        NewCasier(job, id)
    end
end)


RegisterNetEvent("core:addItemToInventoryCasier")
AddEventHandler("core:addItemToInventoryCasier", function(token, job, id, item, count, metadatas)
    local src = source
    if CheckPlayerToken(src, token) then
        if getInventoryWeightCasier(job, id) + getItemWeight(item) * count <= 500 then
            AddItemInventoryCasier(job, id, item, count, metadatas, src)
        end
    end
end)

RegisterServerCallback("core:addItemToInventoryCasier", function (source, token, job, id, item, count, metadatas)
    if CheckPlayerToken(source, token) then
        if getInventoryWeightCasier(job, id) + getItemWeight(item) * count <= 500 then
            AddItemInventoryCasier(job, id, item, count, metadatas, source)
            return true
        end
        return false
    end
end)
RegisterServerCallback("core:removeItemToInventoryCasier", function (source, token, job, id, item, count, metadatas)
    if CheckPlayerToken(source, token) then
        local itemWeight = GetItemWeightWithCount(item, count)
		if getInventoryWeight(source) + itemWeight <= items.maxWeight then
            RemoveItemInventoryCasier(job, id, item, count, metadatas, source)
            return true
        end
        return false
    end
end)
RegisterNetEvent("core:removeItemToInventoryCasier")
AddEventHandler("core:removeItemToInventoryCasier", function(token, job, id, item, count, metadatas)
    local src = source
    if CheckPlayerToken(src, token) then
        RemoveItemInventoryCasier(job, id, item, count, metadatas, src)
    end
end)
