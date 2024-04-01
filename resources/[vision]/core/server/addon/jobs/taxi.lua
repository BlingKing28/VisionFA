RegisterNetEvent("core:taxiEndPnj")
AddEventHandler("core:taxiEndPnj", function(token, totalMoney)
    local _totalMoney = tonumber(totalMoney)
    if CheckPlayerToken(source, token) then
        AddMoneyToSociety(totalMoney, "taxi")
        -- TriggerClientEvent('core:ShowNotification', source, "Vous avez livré le client et gagné ~g~" .. _totalMoney .. "$~s~.")

        -- New notif
		TriggerClientEvent("__vision::createNotification", source, {
			type = 'VERT',
			-- duration = 5, -- In seconds, default:  4
			content = "Vous avez livré le client et gagné ~s" .. _totalMoney .. "$"
		})

    else
        --TODO: Ac detection
    end
end)
