local blips = {}

local function LoadBlipsFromFile() -- Allow dynamic load
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "/config/blips.json")
    blips = json.decode(loadFile)
end

LoadBlipsFromFile()

local function RefreshBlipsFromFiles() -- Allow dynamic save
    SaveResourceFile(GetCurrentResourceName(), "./config/blips.json", json.encode(blips), -1)
end

function CreateNewBlips(id, name, label, color, pos)
    if id == nil then return end
    if name == nil then return end
    if label == nil then return end
    if color == nil then return end
    if pos == nil then return end

    table.insert(blips,
        { id = id, label = label, name = name, color = color,
            pos = pos })
    RefreshBlipsFromFiles()
    LoadBlipsFromFile()
end

function DeleteBlips(blip)
    for i = 1, #blips do
        if i == blip then
            table.remove(blips, i)
            RefreshBlipsFromFiles()
            LoadBlipsFromFile()

        end
    end
end

RegisterNetEvent("core:DeleteBlipAdmin")
AddEventHandler("core:DeleteBlipAdmin", function(token, blip)
    if CheckPlayerToken(source, token) then
        DeleteBlips(blip)
    else

    end
end)



RegisterNetEvent("core:CreateNewBlipsAdmin")
AddEventHandler("core:CreateNewBlipsAdmin", function(token, id, name, label, color, pos)
    if CheckPlayerToken(source, token) then
        CreateNewBlips(id, name, label, color, pos)
        TriggerClientEvent("core:GetBlipsAdmin", -1, blips)

    else

    end
end)


RegisterNetEvent("core:GetBlipsAdmin")
AddEventHandler("core:GetBlipsAdmin", function(token)
    if CheckPlayerToken(source, token) then
        TriggerClientEvent("core:GetBlipsAdmin", -1, blips)
    else
        --AC Todo
    end
end)
CreateThread(function()
    while RegisterServerCallback == nil do Wait(0) end
    RegisterServerCallback('core:GetBlips', function (source)
        return blips
    end)
end)


local AdminUseBlips = {}
RegisterNetEvent("core:UseBlipsName")
AddEventHandler("core:UseBlipsName", function(statu)
    local src = source
    AdminUseBlips[src] = statu
    for k,v in pairs(AdminUseBlips) do
        TriggerClientEvent("core:UseBlipsNameClient", k, src,statu)
    end
end)
