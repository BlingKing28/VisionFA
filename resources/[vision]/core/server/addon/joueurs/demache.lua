local demarches = {}
local lastdemarche = {}
function GetDemarche(source)
    local result = MySQL.Sync.fetchAll('SELECT demarche FROM players WHERE id = @id',
        { ['@id'] = GetPlayer(source):getId() })
    demarches[source] = result[1].demarche
    lastdemarche[source] = result[1].demarche
    return demarches[source]
end

function SaveDemarchePlayer(source)
    if demarches[source] ~= nil then
        MySQL.Async.execute("UPDATE players SET demarche = @1 WHERE id = @id",
            {
                ['@1'] = demarches[source],
                ['@id'] = GetPlayer(source):getId(),
            },
            function(affectedRows)
                -- CorePrint("Demarche enregistrée en bdd")
            end)
    end
end

function SetDemarche(source, demarche)
    lastdemarche[source] = demarches[source]
    demarches[source] = demarche
end

RegisterNetEvent("core:SetNewDemarche")
AddEventHandler("core:SetNewDemarche", function(token, demarche)
    local source = source
    if CheckPlayerToken(source, token) then
        SetDemarche(source, demarche)
    end
end)

CreateThread(function()
    while RegisterServerCallback == nil do Wait(1) end
    RegisterServerCallback("core:GetDemarche", function(source)
        local get = GetDemarche(source)
        return get
    end)
end)


CreateThread(function()
    while true do
        Wait(30 * 60000)
        for k, v in pairs(players) do
            if demarches[k] ~= lastdemarche[k] and demarches[k] ~= nil then
                SaveDemarchePlayer(k)
            end
            Wait(1000)
        end
    end
end)
