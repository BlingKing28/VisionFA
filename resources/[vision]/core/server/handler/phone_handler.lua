--MySQL.Async.execute("DELETE FROM bank WHERE player = @playerId", { ['@playerId'] = id })
CreateThread(function()
    MySQL.Async.fetchAll('DELETE FROM `phone_notifications` WHERE timestamp < CURTIME() - INTERVAL 3 DAY') --250k
    MySQL.Async.fetchAll('DELETE FROM `phone_message_messages` WHERE timestamp < CURTIME() - INTERVAL 15 DAY') --340k
    MySQL.Async.fetchAll('DELETE FROM `phone_darkchat_messages` WHERE timestamp < CURTIME() - INTERVAL 15 DAY')
    --MySQL.Async.fetchAll('DELETE FROM `phone_marketplace_posts` WHERE timestamp < CURTIME() - INTERVAL 1 MONTH')
    MySQL.Async.fetchAll('DELETE FROM `phone_phone_calls` WHERE timestamp < CURTIME() - INTERVAL 15 DAY') --158k
    MySQL.Async.fetchAll('DELETE FROM `phone_services_channels` WHERE timestamp < CURTIME() - INTERVAL 7 DAY')--3.5k
    MySQL.Async.fetchAll('DELETE FROM `phone_services_messages` WHERE timestamp < CURTIME() - INTERVAL 7 DAY')--14k
    MySQL.Async.fetchAll('DELETE FROM `players` WHERE lastname = ""')
    --MySQL.Async.fetchAll('DELETE FROM `phone_photos` WHERE timestamp < CURTIME() - INTERVAL 3 MONTH')
end)