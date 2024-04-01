RegisterServerCallback("core:BillingAccept", function(target, society, amount, reason, src, receipt)
    local src = src
    local target = target
    if amount == nil or amount < 0 then
        TriggerClientEvent('core:ShowNotification', src, "montant negatif nt")
        TriggerClientEvent('core:ShowNotification', target, "montant negatif nt")
        return false
    end
    if DoesPlayerHaveItemCount(target, "money", amount) then
        SendDiscordLog("facture", src, string.sub(GetDiscord(src), 9, -1), GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(),
            target, string.sub(GetDiscord(target), 9, -1), GetPlayer(target):getLastname() .. " " .. GetPlayer(target):getFirstname(),
            amount, society)
        if society == 'lspd' or society == 'lssd' then 
            SendDiscordLog("penalty", src, string.sub(GetDiscord(src), 9, -1), GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(),
            target, string.sub(GetDiscord(target), 9, -1), GetPlayer(target):getLastname() .. " " .. GetPlayer(target):getFirstname(),
            amount, society, reason)
        end
        if amount >= 50000 then
            SendDiscordLog("factureIRS", src, string.sub(GetDiscord(src), 9, -1), GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(),
            target, string.sub(GetDiscord(target), 9, -1), GetPlayer(target):getLastname() .. " " .. GetPlayer(target):getFirstname(),
            amount, society)
        end
        for key, value in pairs(GetPlayer(target):getInventaire()) do
            if value.name == "money" then
                if RemoveItemToPlayer(target, "money", amount, value.metadatas) then
                    if society == "justice" or society == "player" then
                        local account = Bank.GetAllPlayerAccount(target)
                        for k, v in pairs(account) do
                            local balance = v.balance
                            local result = balance + amount
                            Bank.setMoneyAccount(v.account_number, result)
                        end
                    else
                        AddMoneyToSociety(amount, society)
                    end
                    --[[TriggerClientEvent('core:ShowNotification', target,
                        "Vous avez payé ~g~$" .. amount .. "~s~ pour ~r~" .. reason .. "~s~.")]]
                    TriggerClientEvent("__vision::createNotification", target, {
                        type = 'DOLLAR',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous avez payé ~s $" .. amount
                    })
                    --[[TriggerClientEvent('core:ShowNotification', src, "La facture a été payée.")]]
                    TriggerClientEvent("__vision::createNotification", src, {
                        type = 'VERT',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s La facture a été payée."
                    })
                    return true
                else
                    --[[TriggerClientEvent('core:ShowNotification', target, "Erreur lors de la transaction.")]]
                    TriggerClientEvent("__vision::createNotification", target, {
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Erreur lors de la transaction."
                    })
                    --[[TriggerClientEvent('core:ShowNotification', src, "La facture n'a pas été payée.")]]
                    TriggerClientEvent("__vision::createNotification", src, {
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s La facture n'a pas été payée."
                    })
                    return false
                end
            end
        end
    else
        local account = Bank.GetAllPlayerAccount(target)
        for k, v in pairs(account) do
            print(v.account_number, v.balance - amount)
            if v.balance - amount > 0 then
                local balance = v.balance
                local result = balance - amount
                if society == "player" then
                    local accounts = Bank.GetAllPlayerAccount(src)
                    for key, value in pairs(accounts) do
                        local balance = value.balance
                        local result = balance + amount
                        Bank.setMoneyAccount(value.account_number, result)
                    end
                else
                    AddMoneyToSociety(amount, society)
                end
                Bank.setMoneyAccount(v.account_number, result)
                
                --[[TriggerClientEvent('core:ShowNotification', target,
                    "Vous avez payé ~g~$" .. amount .. "~s~ pour ~r~" .. reason .. "~s~.")]]
                TriggerClientEvent("__vision::createNotification", target, {
                    type = 'DOLLAR',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Vous avez payé ~s $" .. amount
                })
                --[[TriggerClientEvent('core:ShowNotification', src, "La facture a été payée.")]]
                TriggerClientEvent("__vision::createNotification", src, {
                    type = 'VERT',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s La facture a été payée."
                })
                return true
            else
                --[[TriggerClientEvent('core:ShowNotification', src, "Vous n'avez ~r~pas assez d'argent~s~.")]]
                TriggerClientEvent("__vision::createNotification", target, {
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Vous n'avez pas assez d'argent"
                })
                --[[TriggerClientEvent('core:ShowNotification', src, "Le client n'a pas assez d'argent.")]]
                TriggerClientEvent("__vision::createNotification", src, {
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Le client n'a pas assez d'argent"
                })
                return false
            end
        end
    end
    return false
end)

-----

RegisterServerCallback("core:SendMoneyFromEnterpriseToEntreprise", function(target, society, amount, src, receipt)
    local src = src
    local target = target

    -- print(GetPlayer(target):getJob())

    local targetsociety = GetPlayer(target):getJob()

    local account = Bank.GetSocietyAccountWithName(society)
	local societyAccount = Bank.GetSocietyAccountWithName(targetsociety)

    if targetsociety == society then
        
        TriggerClientEvent("__vision::createNotification", src, {
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Une facture a ta propre entreprise ?"
        })

        return true

    elseif targetsociety ~= society then

        for key, valueS in pairs(societyAccount) do
            if valueS.balance - amount > 0 then
                local SBalance = valueS.balance
                local result = SBalance - amount

                -- print('Argent entreprise avant : '..SBalance.. ' | Après : '..result)

                Bank.setMoneyAccount(valueS.account_number, result)

                for key, valueC in pairs(account) do
                    local balance = valueC.balance
                    local client = balance + amount
                    Bank.setMoneyAccount(valueC.account_number, client)

                    print('Argent entreprise avant : '..balance.. ' | Après : '..client)

                    --[[TriggerClientEvent('core:ShowNotification', src,
                        "Vous avez payé ~g~$" .. amount .. "~s~ pour ~r~" .. reason .. "~s~.")]]
                    TriggerClientEvent("__vision::createNotification", src, {
                        type = 'DOLLAR',
                        -- duration = 5, -- In seconds, default:  4
                        content = "L'entreprise a payé ~s $" .. amount
                    })
                    --[[TriggerClientEvent('core:ShowNotification', target, "Vous avez recu ~g~$" .. amount .. "~s~ pour ~r~" .. reason .. "~s~.")]]
                    TriggerClientEvent("__vision::createNotification", target, {
                        type = 'DOLLAR',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Votre entreprise a payé ~s $" .. amount
                    })
                end
            else
                --[[TriggerClientEvent('core:ShowNotification', src, "Vous n'avez ~r~pas assez d'argent~s~.")]]
                TriggerClientEvent("__vision::createNotification", src, {
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s La societé n'a pas assez d'argent"
                })
                --[[TriggerClientEvent('core:ShowNotification', target, "La societé n'a pas assez d'argent.")]]
                TriggerClientEvent("__vision::createNotification", target, {
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Votre societé n'a pas assez d'argent"
                })
            end
        end
        return true
    end
end)

-----

RegisterNetEvent("core:SendMoneyFromEnterprise")
AddEventHandler("core:SendMoneyFromEnterprise", function(token, target, society, amount, reason)
    local src = source
    local account = Bank.GetAllPlayerAccount(target)
	local societyAccount = Bank.GetSocietyAccountWithName(society)
    for key, valueS in pairs(societyAccount) do
        if valueS.balance - amount > 0 then
            local SBalance = valueS.balance
            local result = SBalance - amount
            Bank.setMoneyAccount(valueS.account_number, result)
            for key, valueC in pairs(account) do
                local balance = valueC.balance
                local client = balance + amount
                Bank.setMoneyAccount(valueC.account_number, client)
                --[[TriggerClientEvent('core:ShowNotification', src,
                    "Vous avez payé ~g~$" .. amount .. "~s~ pour ~r~" .. reason .. "~s~.")]]
                TriggerClientEvent("__vision::createNotification", src, {
                    type = 'DOLLAR',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Vous avez payé ~s $" .. amount .. "~c pour ~s " .. reason
                })
                --[[TriggerClientEvent('core:ShowNotification', target, "Vous avez recu ~g~$" .. amount .. "~s~ pour ~r~" .. reason .. "~s~.")]]
                TriggerClientEvent("__vision::createNotification", target, {
                    type = 'DOLLAR',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Vous avez recu ~s $" .. amount .. " ~c pour ~s " .. reason
                })
            end
        else
            --[[TriggerClientEvent('core:ShowNotification', src, "Vous n'avez ~r~pas assez d'argent~s~.")]]
            TriggerClientEvent("__vision::createNotification", src, {
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Vous n'avez pas assez d'argent~"
            })
            --[[TriggerClientEvent('core:ShowNotification', target, "La societé n'a pas assez d'argent.")]]
            TriggerClientEvent("__vision::createNotification", target, {
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s La societé n'a pas assez d'argent"
            })
        end
	end
    return true


    -- for k, v in pairs(account) do
    --     if v.balance - amount > 0 then
    --         local balance = v.balance
    --         local result = balance - amount
    --         if society == "justice" or society == "player" then
    --             local accounts = Bank.GetAllPlayerAccount(target)
    --             for key, value in pairs(accounts) do
    --                 local balance = value.balance
    --                 local result = balance + amount
    --                 Bank.setMoneyAccount(value.account_number, result)
    --             end
    --         else
    --             AddMoneyToSociety(amount, society)
    --         end
    --         Bank.setMoneyAccount(v.account_number, result)
    --         TriggerClientEvent('core:ShowNotification', src,
    --             "Vous avez payé ~g~$" .. amount .. "~s~ pour ~r~" .. reason .. "~s~.")
    --         TriggerClientEvent('core:ShowNotification', target, "La facture a été payée.")
    --     else
    --         TriggerClientEvent('core:ShowNotification', src, "Vous n'avez ~r~pas assez d'argent~s~.")
    --         TriggerClientEvent('core:ShowNotification', target, "Le client n'a pas assez d'argent.")
    --     end
    -- end
end)

RegisterNetEvent("core:sendbilling")
AddEventHandler("core:sendbilling", function(token, target, society, amount, reason)
    local source = source
    if CheckPlayerToken(source, token) then
        TriggerClientEvent("__vision::createNotification", target, {
            type = 'DOLLAR',
            -- duration = 5, -- In seconds, default:  4
            content = "Vous avez reçu une facture de ~s " .. amount .. "$ ~c pour ~s " .. reason
        })
        TriggerClientEvent("__vision::createNotification", target, {
            type = 'VERT',
            duration = 10, -- In seconds, default:  4
            content = "Appuyer sur ~K Y pour ~s payer la facture"
        })

        TriggerClientEvent("__vision::createNotification", target, {
            type = 'ROUGE',
            duration = 10, -- In seconds, default:  4
            content = "Appuyer sur ~K K pour ~s refuser de payer"
        })

        TriggerClientEvent('core:sendBillingChoice', target, society, amount, reason, source)
    else

    end
end)


RegisterNetEvent("core:pay")
AddEventHandler("core:pay", function(token, amount)
    local source = source
    if CheckPlayerToken(source, token) then
        for key, value in pairs(GetPlayer(source):getInventaire()) do
            if value.name == "money" then
                if RemoveItemToPlayer(source, "money", amount, value.metadatas) then
                    TriggerClientEvent("__vision::createNotification", source, {
                        type = 'DOLLAR',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous avez payé ~s $" .. amount
                    })
                else
                    TriggerClientEvent("__vision::createNotification", source, {
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Vous n'avez pas assez d'argent"
                    })
                end
            end
        end
    end
end)