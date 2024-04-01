local playerList = {}
local wait = false
RegisterNetEvent("core:setPlayerRobberyGood")
AddEventHandler("core:setPlayerRobberyGood", function()
    local id = GetPlayer(source):getId()
    if id ~= nil then
        table.insert(playerList, id)
    end
end)

-- RegisterNetEvent("core:SetRobberyInLive")
-- AddEventHandler("core:SetRobberyInLive", function(bool)
--     TriggerClientEvent("core:SetRobberyInLive", -1, true)
--     Wait(15*60000)
--     TriggerClientEvent("core:SetRobberyInLive", -1, false)

-- end)
Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(100) end

    RegisterServerCallback("core:getIfPlayerAlrdyRobbe", function(source)
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
end)