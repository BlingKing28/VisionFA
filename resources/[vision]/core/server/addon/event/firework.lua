GetTime = function()
	local timestamp = os.time()
	local d = os.date("*t", timestamp).wday
	local h = tonumber(os.date("%H", timestamp))
	local m = tonumber(os.date("%M", timestamp))

	return {d = d, h = h, m = m}
end

-- CreateThread(function()
--     while true do
--         Wait(0)
--         time = GetTime()
--         if time.h == 0 and time.m == 0 then
--             FireworkShow()
--             break
--         end
--     end
-- end)

-- CreateThread(function()
--     while true do
--         Wait(0)
--         time = GetTime()
--         if time.h == 0 and time.m == 8 then
--             TriggerClientEvent("firework:stopFireworkShow", -1)
--             break
--         end
--     end
-- end)

FireworkShow = function()
    TriggerClientEvent("firework:startFireworkShow", -1)
end

RegisterNetEvent("firework:battery")
AddEventHandler("firework:battery", function(fireworkPos)
    TriggerClientEvent("firework:battery", -1, fireworkPos)
end)

RegisterNetEvent("firework:rocket")
AddEventHandler("firework:rocket", function(fireworkPos)
    TriggerClientEvent("firework:rocket", -1, fireworkPos)
end)


RegisterNetEvent("firework:fountain")
AddEventHandler("firework:fountain", function(fireworkPos)
    TriggerClientEvent("firework:fountain", -1, fireworkPos)
end)

RegisterNetEvent("firework:item")
AddEventHandler("firework:item", function(fireworkPos)
    TriggerClientEvent("firework:item", -1, fireworkPos)
end)
