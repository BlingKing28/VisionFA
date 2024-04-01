local braqued = false

RegisterNetEvent("core:globalObject")
AddEventHandler("core:globalObject", function(obj, random)
    TriggerClientEvent('core:globalObjectStock', -1, obj, random)
end)

RegisterNetEvent("core:insideLoop")
AddEventHandler("core:insideLoop", function()
    TriggerClientEvent('core:playerInsideLoop', -1)
end)

RegisterNetEvent("core:lootSync")
AddEventHandler("core:lootSync", function(type, index)
    braqued = true
    TriggerClientEvent('core:lootSyncObj', -1, type, index)
end)

RegisterNetEvent("core:smashSync")
AddEventHandler("core:smashSync", function(sceneCfg)
    TriggerClientEvent('core:smashSyncObj', -1, sceneCfg)
end)

RegisterNetEvent("core:vangelico_removeBlips")
AddEventHandler("core:vangelico_removeBlips", function(blip)
    TriggerClientEvent('core:playerVangelico_removeBlips', -1, blip)
end)

Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(1) end

    RegisterServerCallback("core:getIfAlrdyRobbed", function()
        return braqued
    end)
end) 