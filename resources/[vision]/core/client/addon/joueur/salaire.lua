local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

Citizen.CreateThread(function()
    while p == nil do
        Wait(1)
    end

    while true do
        local job = p:getJob() or "aucun"
        local grade = p:getJobGrade() or 1
        local salaire
        local service = TriggerServerCallback("core:getOnDuty", token, job)
        local hour = TriggerServerCallback("core:GetHoraire", token)
        local double = false
        if tonumber(hour) >= 14 and tonumber(hour) <= 19 then
            double = true
        elseif tonumber(hour) >= 1 and tonumber(hour) <= 4 then
            double = true
        end
        if service ~= nil and job ~= "aucun" then
            for k, v in pairs(service) do
                if v == GetPlayerServerId(PlayerId()) then
                    if loadedJob ~= nil and json.encode(loadedJob) ~= "[]" then
                        salaire = loadedJob.grade[grade].salaire
                        if double then
                            salaire = salaire * 2
                        end
                        TriggerServerEvent("core:addMoneyAccount", token, salaire)
                        -- TriggerSecurGiveEvent("core:addItemToInventory", token, "money", salaire, {})
                        -- ShowNotification("Vous avez été payé ~g~" .. salaire .. "$")

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'DOLLAR',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez été payé ~s " .. salaire .. "$"
                        })

                    end
                end
            end
        end

        Wait(15 * 60000) -- 15 min ( Chiffre avant le *)
    end
end)
