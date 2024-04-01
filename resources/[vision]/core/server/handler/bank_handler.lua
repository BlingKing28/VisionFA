local function getCategory(amount)
    amount = tonumber(amount)
    if amount < 5000 then
        return "Vert"
    elseif amount < 20000 then
        return "Jaune"
    elseif amount < 50000 then
        return "Orange"
    else
        return "Rouge"
    end
end

RegisterNetEvent('core:CreatePlayerCommonAccount')
AddEventHandler('core:CreatePlayerCommonAccount', function(token)
    local src = source
    if CheckPlayerToken(src, token) then
        Bank.CreatePlayerCommonAccount(src)
    else
        --todo accore:updateBankPhoneValue
    end
end)

RegisterNetEvent("core:addMoneyAccount")
AddEventHandler("core:addMoneyAccount", function(token, money)
    local src = source
    local amount = tonumber(money)
    if CheckPlayerToken(source, token) then
        local account = Bank.GetAllPlayerAccount(src)
        for k, v in pairs(account) do
            local result = v.balance + amount
            Bank.setMoneyAccount(v.account_number, result)
            TriggerClientEvent("core:updateBankPhoneValue", src, result)

        end
    else

    end
end)

RegisterNetEvent('core:bank_Deposit')
AddEventHandler("core:bank_Deposit", function(time, secu, id, amount)
    local src = source
    local id = id
    if CheckTrigger(source, time, secu, "core:bank_Deposit - ID : "..id.." "..amount.."$") then
        local amount = tonumber(amount)
        local account = Bank.GetAllPlayerAccount(src)
        local bank = Bank.GetAccountSociety(src, GetPlayer(src):getJob())
        if bank ~= nil then
            table.insert(account, table.unpack(Bank.GetAccountSociety(src, GetPlayer(src):getJob())))
        end
        for k, v in pairs(account) do

            if tonumber(v.id) == tonumber(id) then
                local result = v.balance + amount
                if DoesPlayerHaveItemCount(src, "money", tonumber(amount)) then
                    for key, value in pairs(GetPlayer(src):getInventaire()) do
                        if value.name == "money" then
                            if RemoveItemToPlayer(src, "money", tonumber(amount), value.metadatas) then
                                Bank.setMoneyAccount(v.account_number, result)
                                TriggerClientEvent('core:GetAllInformation', src, Bank.GetAllPlayerAccount(src),
                                    GetPlayer(src):getId(), GetPlayer(src):getLastname(),
                                    GetPlayer(src):getFirstname())

                                --[[ Ancienne notification
                                TriggerClientEvent("core:ShowAdvancedNotification", src, "Banque", "Conseiller",
                                    "Vous venez de déposer~g~ " .. tonumber(amount) .. "~s~$ sur votre compte !",
                                    "CHAR_BANK_FLEECA", "CHAR_BANK_FLEECA")
                                --]]

                                -- New notif
                                TriggerClientEvent("__vision::createNotification", src, {
                                    type = 'VERT',
                                    -- duration = 5, -- In seconds, default:  4
                                    content = "Vous venez de déposer ~s " .. tonumber(amount) .. "$ ~c sur votre compte !"
                                })

                                
                                TriggerClientEvent("core:updateBankPhoneValue", src, result)
                                SendDiscordLog("deposit", src, string.sub(GetDiscord(src), 9, -1),
                                    GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(),
                                    v.account_number, tonumber(amount), getCategory(amount))
                                if amount >= 50000 then
                                    SendDiscordLog("depositIRS", src, string.sub(GetDiscord(src), 9, -1),
                                        GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(),
                                        v.account_number, tonumber(amount), getCategory(amount))
                                end
                            end
                        end

                    end

                else
                    -- TriggerClientEvent("core:ShowNotification", src, "Vous n'avez ~r~pas assez d'argent~s~.")

                    -- New notif
                    TriggerClientEvent("__vision::createNotification", src, {
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Vous n'avez pas assez d'argent"
                    })
                end
            end
        end

    else
        -- TODO: Ac detection
    end
end)


RegisterNetEvent('core:bank_WithDraw')
AddEventHandler("core:bank_WithDraw", function(time, secu, id, amount)
    local src = source
    local id = id
    if CheckTrigger(source, time, secu, "core:bank_WithDraw - ID : "..id.." "..amount.."$") then
        local amount = tonumber(amount)
        local account = Bank.GetAllPlayerAccount(src)
        local bank = Bank.GetAccountSociety(src, GetPlayer(src):getJob())
        if bank ~= nil then
            table.insert(account, table.unpack(Bank.GetAccountSociety(src, GetPlayer(src):getJob())))
        end
        for k, v in pairs(account) do
            if tonumber(v.id) == tonumber(id) then
                if v.balance >= amount then
                    local balance = v.balance
                    local result = balance - amount
                    Bank.setMoneyAccount(v.account_number, result)
                    for key, value in pairs(GetPlayer(src):getInventaire()) do
                        if value.name == "money" then
                            GiveItemToPlayer(src, "money", tonumber(amount), value.metadatas)
                            TriggerClientEvent('core:GetAllInformation', src, Bank.GetAllPlayerAccount(src),
                                GetPlayer(src):getId(), GetPlayer(src):getLastname(),
                                GetPlayer(src):getFirstname())
                            --[[ Ancienne notification
                            TriggerClientEvent("core:ShowAdvancedNotification", src, "~g~Fleeca Bank", "Conseiller",
                                "Vous venez de retirer~g~ " .. tonumber(amount) .. "~s~$ de votre compte !",
                                "CHAR_BANK_FLEECA"
                                , "CHAR_BANK_FLEECA")
                            --]]

                            -- New notif
                            TriggerClientEvent("__vision::createNotification", src, {
                                type = 'VERT',
                                -- duration = 5, -- In seconds, default:  4
                                content = "Vous venez de retirer ~s " .. tonumber(amount) .. "$ ~c de votre compte !"
                            })

                            SendDiscordLog("withdraw", src, string.sub(GetDiscord(src), 9, -1),
                                GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(),
                                v.account_number, tonumber(amount), getCategory(amount))
                            if amount >= 50000 then
                                SendDiscordLog("withdrawIRS", src, string.sub(GetDiscord(src), 9, -1),
                                    GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(),
                                    v.account_number, tonumber(amount), getCategory(amount))
                            end
                            TriggerClientEvent("core:updateBankPhoneValue", src, result)

                            return
                        elseif not DoesPlayerHaveItemCount(src, "money", 0) then
                            GiveItemToPlayer(src, "money", tonumber(amount), {})
                            TriggerClientEvent('core:GetAllInformation', src, Bank.GetAllPlayerAccount(src),
                                GetPlayer(src):getId(), GetPlayer(src):getLastname(),
                                GetPlayer(src):getFirstname())

                            --[[ Ancienne notification
                            TriggerClientEvent("core:ShowAdvancedNotification", src, "~g~Fleeca Bank", "Conseiller",
                                "Vous venez de retirer~g~ " .. tonumber(amount) .. "~s~$ de votre compte !",
                                "CHAR_BANK_FLEECA"
                                , "CHAR_BANK_FLEECA")
                            --]]

                            -- New notif
                            TriggerClientEvent("__vision::createNotification", src, {
                                type = 'VERT',
                                -- duration = 5, -- In seconds, default:  4
                                content = "Vous venez de retirer ~s " .. tonumber(amount) .. "$ ~c de votre compte !"
                            })

                            SendDiscordLog("withdraw", src, string.sub(GetDiscord(src), 9, -1),
                                GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(),
                                v.account_number, tonumber(amount), getCategory(amount))
                            SendDiscordLog("irsWithdraw", src, string.sub(GetDiscord(src), 9, -1),
                                GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(),
                                v.account_number, tonumber(amount), getCategory(amount))
                            TriggerClientEvent("core:updateBankPhoneValue", src, result)

                            return
                        end
                    end


                else
                    -- TriggerClientEvent("core:ShowNotification", src, "Tu n'as pas assez d'argent sur ton compte !")

                    -- New notif
                    TriggerClientEvent("__vision::createNotification", src, {
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Tu n'as ~s pas assez d'argent ~c sur ton compte !"
                    })
                end
            end
        end

    else
        -- TODO: Ac detection
    end
end)

RegisterNetEvent('core:bank_Transfer')
AddEventHandler("core:bank_Transfer", function(token, id, account_number, amount)
    local src = source
    local id = id
    if CheckPlayerToken(src, token) then
        local account = Bank.GetAllPlayerAccount(src)
        local bank = Bank.GetAccountSociety(src, GetPlayer(src):getJob())
        if bank ~= nil then
            table.insert(account, table.unpack(Bank.GetAccountSociety(src, GetPlayer(src):getJob())))
        end
        for k, v in pairs(account) do
            if tonumber(v.id) == tonumber(id) then
                if v.account_number ~= account_number then
                    if tonumber(v.balance) >= tonumber(amount) then
                        local target = Bank.GetPlayerAccountNumber(account_number)
                        if target == nil then
                            target = Bank.GetAccountSocietyNumber(account_number)
                        end
                        local balance = v.balance
                        local targetBalance = target.balance + amount
                        local result = balance - amount
                        Bank.setMoneyAccount(v.account_number, result)
                        Bank.setMoneyAccount(account_number, targetBalance)
                        TriggerClientEvent('core:GetAllInformation', src, Bank.GetAllPlayerAccount(src), GetPlayer(src):getId(), GetPlayer(src):getLastname(), GetPlayer(src):getFirstname())
                        --TriggerClientEvent("core:ShowAdvancedNotification", src, "~g~Fleeca Bank", "Conseiller", "Vous venez de faire un virement de ~g~ " .. tonumber(amount) .. "~s~$ sur le compte n°" .. account_number .. "!", "CHAR_BANK_FLEECA","CHAR_BANK_FLEECA")
                        
                        -- New notif
                        TriggerClientEvent("__vision::createNotification", src, {
                            type = 'VERT',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Virement de ~s " .. tonumber(amount) .. "$ ~c effectué sur le compte n° ~s" .. account_number
                        })

                        local target = nil
                        for k, value in pairs(players) do
                            if value.id == v.player then
                                target = k
                            end
                        end
                        local phonenumber = exports["lb-phone"]:GetPhoneNumber(target)
                        exports["lb-phone"]:AddTransactions(src, function() end,
                            { phoneNumber = phonenumber, amount = amount },
                            GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname())

                        -- Todo repair transfer for bad account number
                        SendDiscordLog("transfer", src, string.sub(GetDiscord(src), 9, -1),
                            GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(),
                            v.account_number, account_number, tonumber(amount))
                        if tonumber(amount) >= 50000 then
                            SendDiscordLog("transferIRS", src, string.sub(GetDiscord(src), 9, -1),
                                GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(),
                                v.account_number, account_number, tonumber(amount))
                        end
                        return
                    else
                        -- TriggerClientEvent("core:ShowNotification", src, "Tu n'as pas assez d'argent sur ton compte !")
                        
                        -- New notif
                        TriggerClientEvent("__vision::createNotification", src, {
                            type = 'ROUGE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Tu n'as pas assez d'argent sur ton compte !"
                        })
                    end
                else
                    -- TriggerClientEvent("core:ShowNotification", src, "Veuillez saisir un bon numéro de compte !")

                    -- New notif
                    TriggerClientEvent("__vision::createNotification", src, {
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Veuillez saisir un bon numéro de compte !"
                    })
                end
            end
        end
    else
        -- TODO: Ac detection
    end
end)


RegisterNetEvent('core:bank_TransferById')
AddEventHandler("core:bank_TransferById", function(token, account_id, amount)
    local src = source
    if token == "ahouaisicionfaisdestrucimprovisercarbontucococestunpeulagalerepasdetokenaexportgigaflemme" then
        if src ~= account_id then
            local account = Bank.GetAllPlayerAccount(src)
            local bank = Bank.GetAccountSociety(src, GetPlayer(src):getJob())
            if bank ~= nil then
                table.insert(account, table.unpack(Bank.GetAccountSociety(src, GetPlayer(src):getJob())))
            end
            for k, v in pairs(account) do
                if tonumber(v.balance) >= tonumber(amount) then
                    local target = Bank.GetPlayerCommonAccount(tonumber(account_id))
                    local balance = v.balance
                    local targetBalance = target.balance + amount
                    local result = balance - amount
                    Bank.setMoneyAccount(v.account_number, result)
                    Bank.setMoneyAccount(target.account_number, targetBalance)
                    TriggerClientEvent('core:GetAllInformation', src, Bank.GetAllPlayerAccount(src),
                        GetPlayer(src):getId(), GetPlayer(src):getLastname(), GetPlayer(src):getFirstname())

                    --[[ Ancienne notification
                    TriggerClientEvent("core:ShowAdvancedNotification", src, "~g~Fleeca Bank", "Conseiller",
                        "Vous venez de faire un virement de ~g~" ..
                        tonumber(amount) .. "~s~$", "CHAR_BANK_FLEECA", "CHAR_BANK_FLEECA")

                    --]]

                    -- New notif
                    TriggerClientEvent("__vision::createNotification", src, {
                        type = 'VERT',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Virement de ~s " .. tonumber(amount) .. "$ ~c effectué."
                    })

                    TriggerClientEvent("core:updateBankPhoneValue", src, result)
                    TriggerClientEvent("core:updateBankPhoneValue", account_id, targetBalance)
                    --return-- Todo repair transfer for bad account number
                    SendDiscordLog("transfer", src, string.sub(GetDiscord(src), 9, -1),
                        GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(), v.account_number,
                        target.account_number, tonumber(amount))
                    if amount >= 50000 then
                        SendDiscordLog("transferIRS", src, string.sub(GetDiscord(src), 9, -1),
                            GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(), v.account_number,
                            target.account_number, tonumber(amount))
                    end
                else
                    -- TriggerClientEvent("core:ShowNotification", src, "Tu n'as pas assez d'argent sur ton compte !")

                    -- New notif
                    TriggerClientEvent("__vision::createNotification", src, {
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Tu n'as pas assez d'argent sur ton compte !"
                    })

                end
            end
        else
            --[[ Ancienne notification
            TriggerClientEvent("core:ShowNotification", src,
                "Comment ça tu te fais un virement à toi même, t'es chelou frérot")
            --]]
            
            -- New notif
            TriggerClientEvent("__vision::createNotification", src, {
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Comment ça tu te fais un virement à toi même, t'es chelou frérot !"
            })

        end
    else
        -- TODO: Ac detection
    end
end)

RegisterNetEvent('core:GetAllInformation')
AddEventHandler('core:GetAllInformation', function(token)
    local src = source
    if CheckPlayerToken(src, token) then
        local account = Bank.GetAllPlayerAccount(src)
        print("Account", src, json.encode(account))
        if jobs[GetPlayer(src):getJob()].grade[GetPlayer(src):getJobGrade()].gestion then
            local bank = Bank.GetAccountSociety(src, GetPlayer(src):getJob())
            if bank ~= nil and GetPlayer(src):getJob() ~= "aucun" and GetPlayer(src):getJob() ~= "Aucun" then
                table.insert(account, table.unpack(Bank.GetAccountSociety(src, GetPlayer(src):getJob())))
            end
        end
        TriggerClientEvent('core:GetAllInformation', src, account, GetPlayer(src):getId(),
            GetPlayer(src):getLastname(), GetPlayer(src):getFirstname())
    else

    end
end)


Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(100) end

    RegisterServerCallback("core:getCompanyBalance", function(source, token)
        if CheckPlayerToken(source, token) then
            local account = Bank.GetAccountSociety(source, GetPlayer(source):getJob())
            if account ~= nil then
                return account[1].balance
            else
                return 0
            end
        else
            -- TODO: Ac detection
        end
    end)
end)

function NibardTaPeur(source)
    return Bank.GetPlayerCommonAccount(source)
end

exports("getMoneyPhone", function(source)
    return NibardTaPeur(source)
end)

RegisterNetEvent("core:addMoneyAccountPhone")
AddEventHandler("core:addMoneyAccountPhone", function(token, source, money)
    local src = source
    local amount = tonumber(money)
    if token == "putaintelephonedemerdeatoutmomentonestbaiser" then
        local account = Bank.GetAllPlayerAccount(src)
        for k, v in pairs(account) do
            local result = v.balance + amount
            Bank.setMoneyAccount(v.account_number, result)
            TriggerClientEvent("core:updateBankPhoneValue", src, result)
        end
    else

    end
end)


RegisterNetEvent("core:removeMoneyAccount")
AddEventHandler("core:removeMoneyAccount", function(token, source, money)
    local src = source
    local amount = tonumber(money)
    if token == "putaintelephonedemerdeatoutmomentonestbaiser" then
        local account = Bank.GetAllPlayerAccount(src)
        for k, v in pairs(account) do
            if (v.balance - amount) >= 0 then
                local result = v.balance - amount
                Bank.setMoneyAccount(v.account_number, result)
                TriggerClientEvent("core:updateBankPhoneValue", src, result)
            else
                -- ShowNotification("ERREUR, Lors de la transaction")

                -- New notif
                TriggerClientEvent("__vision::createNotification", src, {
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Erreur, ~c lors de la transaction !"
                })
                
            end
        end
    else

    end
end)

RegisterNetEvent("core:addMoneyGouv")
AddEventHandler("core:addMoneyGouv", function(token, money)
    local src = source
    local amount = tonumber(money)
    if token == "putaintelephonedemerdeatoutmomentonestbaiser" then
        local account = Bank.GetSocietyAccountWithName("gouv")
        print(json.encode(account))
        for k, v in pairs(account) do
            local result = v.balance + amount
            Bank.setMoneyAccount(v.account_number, result)
        end
    else

    end
end)

CreateThread(function()
    while RegisterServerCallback == nil do Wait(1) end
    RegisterServerCallback("core:getTransaction", function(source)
        return exports["lb-phone"]:GetTransaction(source)
    end)
end)

BankAccountList = {}
function GetAllAccount()
    MySQL.Async.fetchAll('SELECT account_number FROM bank', {}, function(result)
        for k, v in pairs(result) do 
        BankAccountList[k] = result[k].account_number 
        end
        --print(json.encode(result))
        --print(BankAccountList[2])
    end)

end
GetAllAccount()

