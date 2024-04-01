local playerList = {}
local wait = false
RegisterNetEvent("core:setPlayerATMRobberyGood", function()
    local id = GetPlayer(source):getId()
    if id ~= nil then
        table.insert(playerList, id)
    end
end)

local entityList = {}
RegisterNetEvent("core:BlackListATM", function(netEntity)
    entityList[netEntity] = GetGameTimer() + 600000
end)

Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(100) end

    RegisterServerCallback("core:ATMAlreadyRob", function(source)
        local id = GetPlayer(source):getId()
        if id ~= nil then
            for k, v in pairs(playerList) do
                if v == id then
                    return true
                end
            end
        end
        return false
    end)

    RegisterServerCallback("core:EntityATMAlreadyRob", function(source, token, netEntity)
        if CheckPlayerToken(source, token) then 
            return (entityList[netEntity] and (entityList[netEntity] < GetGameTimer()))
        end
    end)
end)
