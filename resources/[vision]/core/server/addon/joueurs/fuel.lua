Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(100) end

    RegisterServerCallback("core:GetAccountMoneyFuel", function(source, token)
        local src = source
        if CheckPlayerToken(src, token) then
            local bank = Bank.GetPlayerCommonAccountBalance(src)
            return bank
        end
    end)

end)
RegisterNetEvent("core:RemoveAccountMoneyFuel")
AddEventHandler("core:RemoveAccountMoneyFuel", function(token, amount)
    local src = source
    if CheckPlayerToken(src, token) then
        local account = Bank.GetPlayerCommonAccount(src)
        local result = account["balance"] - amount
        Bank.setMoneyAccount(account["account_number"], result)
        AddMoneyToSociety(amount, "ltdsud")
    end
end)
