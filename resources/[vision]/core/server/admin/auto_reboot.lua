-- AddEventHandler('onResourceStart', function(resource)
--     time = os.time()
--     startWhile = os.date("%S", time)
--     Wait(60000-(startWhile*1000))
--     while true do
--         time = os.time()
--         actualTime = tonumber(os.date("%H%M", time))
--         if actualTime == 1620 or actualTime == 420 then
--             -- TriggerClientEvent('core:ShowAdvancedNotification', -1, "Administration", "~r~Annonce", "Le serveur va redémarrer dans 10 minutes.", "CHAR_VISION", "VISION")

--             TriggerClientEvent("__vision::createNotification", -1, {
--                 type  = 'VISION',
--                 name  = "VISION",
--                 content = "Le serveur va redémarrer dans 10 minutes.",
--                 typeannonce = "ADMINISTRATION",
--                 labeltype = "ANNONCE",
--                 duration = 10,
--             })

--         elseif actualTime == 1625 or actualTime == 425 then
-- --[[             TriggerClientEvent('core:ShowAdvancedNotification', -1, "Administration", "~r~Annonce", "Le serveur va redémarrer dans 5 minutes."
--             , "CHAR_VISION", "VISION") ]]

--             TriggerClientEvent("__vision::createNotification", -1, {
--                 type  = 'VISION',
--                 name  = "VISION",
--                 content = "Le serveur va redémarrer dans 5 minutes.",
--                 typeannonce = "ADMINISTRATION",
--                 labeltype = "ANNONCE",
--                 duration = 10,
--             })

--         elseif actualTime == 1629 or actualTime == 429 then
--             -- TriggerClientEvent('core:ShowAdvancedNotification', -1, "Administration", "~r~Annonce", "Le serveur va redémarrer dans 1 minutes.", "CHAR_VISION", "VISION")
--             TriggerClientEvent("__vision::createNotification", -1, {
--                 type  = 'VISION',
--                 name  = "VISION",
--                 content = "Le serveur va redémarrer dans 1 minute.",
--                 typeannonce = "ADMINISTRATION",
--                 labeltype = "ANNONCE",
--                 duration = 10,
--             })
--         end
--         Wait(60000)
--     end
-- end)
