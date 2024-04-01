local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

-- RegisterCommand("addItem", function()
--     TriggerSecurGiveEvent("core:addItemToInventory", token, "money", 15000, {})
-- end)
-- RegisterCommand("giveitem", function(source, args, rawCommand)
--     TriggerSecurGiveEvent("core:addItemToInventory", token, args[1], args[2], {})
-- end, false)

-- RegisterCommand("addMetaItem", function()
--     TriggerSecurGiveEvent("core:addItemToInventory", token, { renamed = "test" })
-- end)


-- RegisterCommand("addMetaItemS", function()
--     TriggerSecurGiveEvent("core:addItemToInventory", token, { renamed = "connard" })
-- end)


-- RegisterCommand("addMetaItemTruc", function()
--     TriggerSecurGiveEvent("core:addItemToInventory", token, { truc = "test" })
-- end)


-- RegisterCommand("changeName", function()
--     TriggerServerEvent('core:ChangeItemName', token, "water", "name")
-- end)

-- RegisterCommand("retirer", function()
--     TriggerServerEvent('core:RemoveItemToInventory', token, { truc = "test" })
-- end)
