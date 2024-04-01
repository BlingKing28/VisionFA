function GiveItemToPlayer(source, item, count, metadata)
    local added = AddItemToInventory(source, item, count, metadata)
    if added then
        --RefreshPlayerData(source)
        MarkPlayerDataAsNonSaved(source)
    else
        -- TriggerClientEvent("core:ShowNotification", source, "~r~Vous n'avez pas assez de place dans votre inventaire")

        TriggerClientEvent("__vision::createNotification", source, {
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Vous n'avez plus de place. ~s" -- Phrase trop longue donc modif 2e idée "Inventaire plein"
        })
    end
    return added
end

exports("GiveItemToPlayer", function(source, item, count, metadata)
    return GiveItemToPlayer(source, item, count, metadata)
end)

function GiveItemToPlayerStaff(source, item, count, metadata)
    local added = AddItemToInventoryStaff(source, item, count, metadata)
    if added then
        --RefreshPlayerData(source)
        MarkPlayerDataAsNonSaved(source)
    else
        --TriggerClientEvent("core:ShowNotification", source, "~r~Vous n'avez pas assez de place dans votre inventaire")
        
        TriggerClientEvent("__vision::createNotification", source, {
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Cet item n'existe pas ou vous n'avez plus de place dans votre inventaire. ~s"
        })

    end
    return added
end

function RemoveItemToPlayer(source, item, count, metadata)
    -- print(json.encode(item))
    local removed = false
    if item == "identitycard" then
        removed = RemoveIdentityCardFromInventory(source, item, count, metadata)
    elseif item == "bike" then
        removed = RemoveBikeFromInventory(source, item, count, metadata)
    elseif item == "outfit" then
        removed = RemoveClothFromInventory(source, item, count, metadata)
    elseif items[item].type == "weapons" then
        removed = RemoveWeaponFromInventory(source, item, count, metadata)
        TriggerClientEvent("core:RemoveWeapon", source, item)
    else
        removed = RemoveItemFromInventory(source, item, count, metadata)
    end
    if removed then
        --RefreshPlayerData(source)
        MarkPlayerDataAsNonSaved(source)
    end
    return removed
end

exports("RemoveItemToPlayer", function(source, item, count, metadata)
    return RemoveItemToPlayer(source, item, count, metadata)
end)

function DoesPlayerHaveItemCount(source, item, count)
    if not GetPlayer(source) then 
        return false
    end
    for key, value in pairs(GetPlayer(source):getInventaire()) do
        if value.name == item then
            if value.count >= count then
                return true
            else
                return false
            end
        end
    end
    return false
end

function GetItemCount(source, item)
    if not GetPlayer(source) then 
        return false
    end
    for key, value in pairs(GetPlayer(source):getInventaire()) do
        if value.name == item then
            return value.count
        end
    end
    return 0
end

exports("DoesPlayerHaveItemCount", function(source, item, count)
    return DoesPlayerHaveItemCount(source, item, count)
end)

exports("GetItemCount", function(source, item)
    return GetItemCount(source, item)
end)
-- Events
local countTriggerMoney = {}

CreateThread(function()
    while true do 
        Wait(10000)
        countTriggerMoney = {}
    end
end)

RegisterNetEvent("core:addItemToInventory")
AddEventHandler("core:addItemToInventory", function(timeC, token, secu, item, count, metadata)
    local source = source
    TriggerEvent("ratelimit", source)
    --if CheckPlayerToken(source, token) then
        if CheckGiveTrigger(source, timeC, secu, item, count, "core:addItemToInventory") then
            if item and item == "money" then 
                if count > 500000 then 
                    SendDiscordLog("addmoney", source, string.sub(GetDiscord(source), 9, -1), GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(),
                    count)
                end
                if countTriggerMoney[source] == nil then 
                    countTriggerMoney[source] = {count = 1}
                else
                    countTriggerMoney[source].count = countTriggerMoney[source].count + 1
                    if countTriggerMoney[source].count > 5 then 
                        SendDiscordLog("addmoney", source, string.sub(GetDiscord(source), 9, -1), GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(),
                        "Executed event core:addItemToInventory count : " .. count .. " for money " .. countTriggerMoney[source].count .. " times in less than 10 seconds")
                        countTriggerMoney[source] = nil
                    end
                end
            end
            for k, v in pairs(GetPlayer(source):getInventaire()) do
                if not DoesPlayerHaveItemCount(source, item, count) then
                    GiveItemToPlayer(source, item, count, metadata)
                    return
                elseif items[item].type == "weapons" then
                    GiveItemToPlayer(source, item, count, metadata)
                    return
                elseif v.name == "bike" and v.name == item and v.metadatas.props ~= nil and v.metadatas.props ~= metadata then
                    GiveItemToPlayer(source, item, count, metadata)
                    return
                elseif v.name == "identitycard" and v.name == item and v.metadatas.identity ~= nil and
                    v.metadatas.identity.id ~= metadata.identity.id then
                        GiveItemToPlayer(source, item, count, metadata)
                    return
                elseif v.name == "identitycard" and v.name == item and v.metadatas.identity ~= nil and
                    v.metadatas.identity.id == metadata.identity.id then
                        GiveItemToPlayer(source, item, count, v.metadatas)
                    return
                elseif v.name == "identitycard" and v.name == item then
                    if json.encode(metadata) == "[]" or metadata == nil then
                        v.metadata = {}
                    end
                    GiveItemToPlayer(source, item, count, v.metadatas)
    
                    return
                elseif v.name == "money" and v.name == item then
                    GiveItemToPlayer(source, item, count, v.metadatas)
                    return
                elseif item == "outfit" or item == 'tshirt' or item == 'ptshirt' or item == 'pglasses' or item == 'phat' or
                    item == 'ppant' or item == 'paccs' or item == 'mask' or item == 'pant' or
                    item == 'hat' or item == 'access' or item == 'glasses' or item == 'feet' or item == "montre" or item == "bague" or item == "bracelet" or
                    item == "bouclesoreilles" or item == "collier" and item ~= "ongle" and item ~= "piercing" then
                    GiveItemToPlayer(source, item, count, metadata)
                    return
                elseif v.name == item and v.metadatas ~= nil and item ~= "outfit" and item ~= 'tshirt' and item ~= 'ptshirt' and
                    item ~= 'pglasses' and item ~= 'phat' and item ~= 'paccs' and item ~= 'ppant' and item ~= 'ppant' and item ~= 'mask' and
                    item ~= 'pant' and item ~= 'hat' and item ~= 'access' and item ~= 'glasses' and item ~= 'feet' and item ~= "montre" and
                    item ~= "bracelet" and item ~= "bague" and item ~= "bouclesoreilles" and item ~= "collier" and item ~= "ongle" and item ~= "piercing" then
                    if items[item].notStackable then
                        GiveItemToPlayer(source, item, count, metadata)
                    else
                        GiveItemToPlayer(source, item, count, v.metadatas)
                    end
                    return
                elseif v.name == item and v.metadatas == nil and item ~= "outfit" and item ~= 'tshirt' and item ~= 'ptshirt' and
                    item ~= 'pglasses' and item ~= 'phat' and item ~= 'paccs' and item ~= 'ppant' and item ~= 'mask' and
                    item ~= 'pant' and item ~= 'hat' and item ~= 'access' and item ~= 'glasses' and item ~= 'feet' and item ~= "montre" and
                    item ~= "bracelet" and item ~= "bague" and item ~= "bouclesoreilles" and item ~= "collier" and item ~= "ongle" and item ~= "piercing" then
                    if json.encode(metadata) == "[]" or metadata == nil then
                        metadata = {}
                    end
                    GiveItemToPlayer(source, item, count, metadata)
                    return
                end
            end
            --RefreshPlayerData(source)
            MarkPlayerDataAsNonSaved(source)
        end
    -- else
    --     if item and count then
    --         SunWiseKick(source, "Unauthorized Give Item. Item : " .. item .. ". Count : " .. count)
    --     else
    --         SunWiseKick(source, "Unauthorized Give Item.")
    --     end
    -- end
end)

RegisterNetEvent("core:addItemToInventoryStaffButNoStaff")
AddEventHandler("core:addItemToInventoryStaffButNoStaff", function(token, player, item, count, metadata)
    local source = source
    if CheckPlayerToken(source, token) then
        if count == nil or count == 0 then
            count = 1
        end
        if item == "keys" or item == "letter" then
            local target = GetPlayer(player)
            if target ~= nil then
                SendDiscordLog("additem", source, string.sub(GetDiscord(source), 9, -1),
                    GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(), item, count,
                    target:getLastname() .. " " .. target:getFirstname(), string.sub(GetDiscord(player), 9, -1))
                for k, v in pairs(target:getInventaire()) do
                    if not DoesPlayerHaveItemCount(player, item, count) then
                        GiveItemToPlayerStaff(player, item, count, metadata)

                        return
                    elseif items[item].type == "weapons" then
                        GiveItemToPlayerStaff(source, item, count, metadata)
                        return
                    elseif v.name == "identitycard" and v.name == item and v.metadatas.identity ~= nil and
                        v.metadatas.identity.id ~= metadata.identity.id then
                        GiveItemToPlayerStaff(player, item, count, metadata)
                        return
                    elseif v.name == "identitycard" and v.name == item and v.metadatas.identity ~= nil and
                        v.metadatas.identity.id == metadata.identity.id then
                        GiveItemToPlayerStaff(player, item, count, v.metadatas)
                        return
                    elseif v.name == "money" and v.name == item then
                        GiveItemToPlayerStaff(player, item, count, v.metadatas)
                        return
                    elseif v.name == item and v.name == "outfit" then
                        GiveItemToPlayerStaff(player, item, count, metadata)
                    elseif v.name == item and v.metadatas ~= nil and item ~= "outfit" and item ~= 'tshirt' and item == 'ptshirt' and item == 'pglasses' and item == 'phat' and item == 'paccs' and item == 'ppant' and
                        item ~= 'mask'
                        and item ~= 'pant' and item ~= 'hat' and item ~= 'access' and item ~= 'glasses' and
                        item ~= 'feet' and item ~= "montre" and item ~= "bracelet" and item ~= "bague" and item ~= "bouclesoreilles" and item ~= "collier" 
                        and item ~= "ongle" and item ~= "piercing" then
                        GiveItemToPlayerStaff(player, item, count, v.metadatas)
                        return
                    elseif v.name == item and v.metadatas == nil and item ~= "outfit" and item ~= 'tshirt' and item == 'ptshirt' and item == 'pglasses' and item == 'phat' and item == 'paccs' and item == 'ppant' and
                        item ~= 'mask'
                        and item ~= 'pant' and item ~= 'hat' and item ~= 'access' and item ~= 'glasses' and
                        item ~= 'feet' and item ~= "montre" and item ~= "bague" and item ~= "bracelet" and item ~= "bouclesoreilles" and item ~= "collier" 
                        and item ~= "ongle" and item ~= "piercing" then
                        if json.encode(metadata) == "[]" or metadata == nil then
                            metadata = {}
                        end
                        GiveItemToPlayerStaff(player, item, count, metadata)
                        return
                    elseif v.name ~= item then
                        if json.encode(metadata) == "[]" or metadata == nil then
                            metadata = {}
                        end
                        GiveItemToPlayerStaff(player, item, count, metadata)
                        return
                    end
                end
                --RefreshPlayerData(source)
                MarkPlayerDataAsNonSaved(source)
            else
                --TriggerClientEvent("core:ShowNotification", source, "Le joueur n'est pas connecté")
                TriggerClientEvent("__vision::createNotification", source, {
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Le joueur n'est pas connecté"
                })
            end
        else
            if item and count then
                SunWiseKick(source, "Exec event core:addItemToInventoryStaffButNoStaff for item " .. item .. ". Count : " .. count)
            else
                SunWiseKick(source, "Exec event core:addItemToInventoryStaffButNoStaff")
            end
        end
    end
end)

RegisterNetEvent("core:addItemToInventoryStaff")
AddEventHandler("core:addItemToInventoryStaff", function(token, player, item, count, metadata)
    local source = source
    if CheckPlayerToken(source, token) then
        if count == nil or count == 0 then
            count = 1
        end
        if GetPlayer(source):getPermission() >= 3 then
            local target = GetPlayer(player)
            if target ~= nil then
                SendDiscordLog("additem", source, string.sub(GetDiscord(source), 9, -1),
                    GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(), item, count,
                    target:getLastname() .. " " .. target:getFirstname(), string.sub(GetDiscord(player), 9, -1))
                for k, v in pairs(target:getInventaire()) do
                    if not DoesPlayerHaveItemCount(player, item, count) then
                        GiveItemToPlayerStaff(player, item, count, metadata)

                        return
                    elseif items[item].type == "weapons" then
                        GiveItemToPlayerStaff(source, item, count, metadata)
                        return
                    elseif v.name == "identitycard" and v.name == item and v.metadatas.identity ~= nil and
                        v.metadatas.identity.id ~= metadata.identity.id then
                        GiveItemToPlayerStaff(player, item, count, metadata)
                        return
                    elseif v.name == "identitycard" and v.name == item and v.metadatas.identity ~= nil and
                        v.metadatas.identity.id == metadata.identity.id then
                        GiveItemToPlayerStaff(player, item, count, v.metadatas)
                        return
                    elseif v.name == "money" and v.name == item then
                        GiveItemToPlayerStaff(player, item, count, v.metadatas)
                        return
                    elseif v.name == item and v.name == "outfit" then
                        GiveItemToPlayerStaff(player, item, count, metadata)
                    elseif v.name == item and v.metadatas ~= nil and item ~= "outfit" and item ~= 'tshirt' and item == 'ptshirt' and item == 'pglasses' and item == 'phat' and item == 'paccs' and item == 'ppant' and
                        item ~= 'mask'
                        and item ~= 'pant' and item ~= 'hat' and item ~= 'access' and item ~= 'glasses' and
                        item ~= 'feet' and item ~= "montre" and item ~= "bracelet" and item ~= "bague" and item ~= "bouclesoreilles" and item ~= "collier" 
                        and item ~= "ongle" and item ~= "piercing" then
                        GiveItemToPlayerStaff(player, item, count, v.metadatas)
                        return
                    elseif v.name == item and v.metadatas == nil and item ~= "outfit" and item ~= 'tshirt' and item == 'ptshirt' and item == 'pglasses' and item == 'phat' and item == 'paccs' and item == 'ppant' and
                        item ~= 'mask'
                        and item ~= 'pant' and item ~= 'hat' and item ~= 'access' and item ~= 'glasses' and
                        item ~= 'feet' and item ~= "montre" and item ~= "bague" and item ~= "bracelet" and item ~= "bouclesoreilles" and item ~= "collier" 
                        and item ~= "ongle" and item ~= "piercing" then
                        if json.encode(metadata) == "[]" or metadata == nil then
                            metadata = {}
                        end
                        GiveItemToPlayerStaff(player, item, count, metadata)
                        return
                    elseif v.name ~= item then
                        if json.encode(metadata) == "[]" or metadata == nil then
                            metadata = {}
                        end
                        GiveItemToPlayerStaff(player, item, count, metadata)
                        return
                    end
                end
                --RefreshPlayerData(source)
                MarkPlayerDataAsNonSaved(source)
            else
                --TriggerClientEvent("core:ShowNotification", source, "Le joueur n'est pas connecté")
                TriggerClientEvent("__vision::createNotification", source, {
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Le joueur n'est pas connecté"
                })
            end
        end
    end
end)

RegisterNetEvent("core:ChangeItemName")
AddEventHandler("core:ChangeItemName", function(token, type, item, name, metadata)
    local source = source
    if CheckPlayerToken(source, token) then
        if type ~= "clothes" then
            renameItem(source, item, name, metadata)
            triggerEventPlayer("core:renameItemPlayer", source, item, name, metadata)
            --RefreshPlayerData(source)
            MarkPlayerDataAsNonSaved(source)
        else
            ChangeItemNameCloths(source, item, name, metadata)
            triggerEventPlayer("core:renameClothPlayer", source, item, name, metadata)
            --RefreshPlayerData(source)
            MarkPlayerDataAsNonSaved(source)
        end
    end
end)

RegisterNetEvent('core:RemoveItemToInventory')
AddEventHandler('core:RemoveItemToInventory', function(token, item, count, metadata)
    local source = source
    if CheckPlayerToken(source, token) then
        RemoveItemToPlayer(source, item, count, metadata)
        --RefreshPlayerData(source)
        MarkPlayerDataAsNonSaved(source)
    end
end)

RegisterNetEvent("core:UseItem")
AddEventHandler("core:UseItem", function(token, item, metadatas)
    if CheckPlayerToken(source, token) then
        if item == "radio" then
            return
        end

        if item == "money" then
            return
        end

        if IsItemUsable(item) then
            if UseItemIfCan(source, item, metadatas) then
                local itemName = getItemLabel(item)

                if item == "can" then
                    return
                end
                
                if item == "water" or item == "banana" or item == "saladeco" or item == "saladece" or
                    item == "bread" or item == "tapas" or item == "litchi" or item == "maki" or
                    item == "sushic" or item == "donutc" or item == "donutn" or item == "wrapb" or item == "wrapp" or item == "fishburger" or
                    item == "juice" or item == "soda" or item == "coffee" or item == "tea" or
                    item == "caprisun" or item == "sprunk" or item == "ecola" then
                    itemName = " " .. getItemLabel(item)
                end

                TriggerClientEvent("__vision::createNotification", source, {
                    type = 'JAUNE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Vous avez utilisé ~s " .. itemName
                })

                --RefreshPlayerData(source)
                MarkPlayerDataAsNonSaved(source)
            end
        else
            --TriggerClientEvent("core:ShowNotification", source,
            --    "~o~" .. getItemLabel(item) .. "~s~ n'est pas utilisable.")
                
            TriggerClientEvent("__vision::createNotification", source, {
                type = 'JAUNE',
                -- duration = 5, -- In seconds, default:  4
                content =  "Vous avez utilisé ~s" .. getItemLabel(item)
            })    
        end
    end
end)

RegisterNetEvent("core:GiveItemToPlayer")
AddEventHandler("core:GiveItemToPlayer", function(time, secu, item, metadatas, count, target)
    local src = source
    if CheckTrigger(source, time, secu, "core:GiveItemToPlayer - Item : "..item.." "..count) then
        local itemWeight = GetItemWeightWithCount(item, count)
        if getInventoryWeight(target) + itemWeight <= items.maxWeight then
            local removed = RemoveItemToPlayer(src, item, count, metadatas)
            if removed then
                for k, v in pairs(GetPlayer(src):getInventaire()) do
                    if not DoesPlayerHaveItemCount(target, item, count) then
                        GiveItemToPlayer(target, item, count, metadatas)
                        TriggerClientEvent("core:playeTakeAnim", target)

                        -- New notification
                        TriggerClientEvent("__vision::createNotification", src, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez donné ~s x"  .. count .. " " .. getItemLabel(item)
                        })

                        TriggerClientEvent("__vision::createNotification", target, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez reçu ~s x"  .. count .. " " .. getItemLabel(item)
                        })
                        
                        --RefreshPlayerData(src)
                        MarkPlayerDataAsNonSaved(src)
                        --RefreshPlayerData(target)
                        MarkPlayerDataAsNonSaved(target)
                        SendDiscordLog("give", src, string.sub(GetDiscord(src), 9, -1),
                            GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(), target,
                            string.sub(GetDiscord(target), 9, -1),
                            GetPlayer(target):getLastname() .. " " .. GetPlayer(target):getFirstname(), item,
                            count)
                        return
                    elseif items[item].type == "weapons" then
                        GiveItemToPlayer(target, item, count, metadatas)
                        TriggerClientEvent("core:playeTakeAnim", target)

                        -- New notification
                        TriggerClientEvent("__vision::createNotification", src, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez donné ~s x"  .. count .. " " .. getItemLabel(item)
                        })
                        TriggerClientEvent("__vision::createNotification", target, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez reçu ~s x"  .. count .. " " .. getItemLabel(item)
                        })

                        --RefreshPlayerData(src)
                        MarkPlayerDataAsNonSaved(src)
                        --RefreshPlayerData(target)
                        MarkPlayerDataAsNonSaved(target)
                        SendDiscordLog("give", src, string.sub(GetDiscord(src), 9, -1),
                            GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(), target,
                            string.sub(GetDiscord(target), 9, -1),
                            GetPlayer(target):getLastname() .. " " .. GetPlayer(target):getFirstname(), item,
                            count)
                        return
                    elseif v.name == item or item == 'tshirt' or item == 'ptshirt' and item == 'pglasses' or item == 'phat' or item == 'paccs' or item == 'ppant' or item == 'mask' or item == 'pant' or
                        item == 'hat' or item == 'access' or item == 'glasses' or item == "bague" or item == 'feet' or item == "montre" 
                        or item == "bracelet" or item == "bouclesoreilles" or item == "collier" or item == "ongle" or item == "piercing" then
                        GiveItemToPlayer(target, item, count, metadatas)
                        TriggerClientEvent("core:playeTakeAnim", target)

                        -- New notification
                        TriggerClientEvent("__vision::createNotification", src, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez donné ~s x"  .. count .. " " .. getItemLabel(item)
                        })
                        TriggerClientEvent("__vision::createNotification", target, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez reçu ~s x"  .. count .. " " .. getItemLabel(item)
                        })

                        --RefreshPlayerData(src)
                        MarkPlayerDataAsNonSaved(src)
                        --RefreshPlayerData(target)
                        MarkPlayerDataAsNonSaved(target)
                        SendDiscordLog("give", src, string.sub(GetDiscord(src), 9, -1),
                            GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(), target,
                            string.sub(GetDiscord(target), 9, -1),
                            GetPlayer(target):getLastname() .. " " .. GetPlayer(target):getFirstname(), item,
                            count)
                        return
                    elseif v.name == "identitycard" and v.name == item and v.metadatas.identity ~= nil and
                        v.metadatas.identity.id ~= metadatas.identity.id then
                        GiveItemToPlayer(target, item, count, metadatas)
                        TriggerClientEvent("core:playeTakeAnim", target)

                        -- New notification
                        TriggerClientEvent("__vision::createNotification", src, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez donné ~s x"  .. count .. " " .. getItemLabel(item)
                        })
                        TriggerClientEvent("__vision::createNotification", target, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez reçu ~s x"  .. count .. " " .. getItemLabel(item)
                        })

                        --RefreshPlayerData(src)
                        MarkPlayerDataAsNonSaved(src)
                        --RefreshPlayerData(target)
                        MarkPlayerDataAsNonSaved(target)
                        SendDiscordLog("give", src, string.sub(GetDiscord(src), 9, -1),
                            GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(), target,
                            string.sub(GetDiscord(target), 9, -1),
                            GetPlayer(target):getLastname() .. " " .. GetPlayer(target):getFirstname(), item,
                            count)
                        return
                    elseif v.name == "identitycard" and v.name == item and v.metadatas.identity ~= nil and
                        v.metadatas.identity.id == metadatas.identity.id then
                        GiveItemToPlayer(target, item, count, v.metadatas)
                        TriggerClientEvent("core:playeTakeAnim", target)

                        -- New notification
                        TriggerClientEvent("__vision::createNotification", src, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez donné ~s x"  .. count .. " " .. getItemLabel(item)
                        })
                        TriggerClientEvent("__vision::createNotification", target, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez reçu ~s x"  .. count .. " " .. getItemLabel(item)
                        })

                        --RefreshPlayerData(src)
                        MarkPlayerDataAsNonSaved(src)
                        --RefreshPlayerData(target)
                        MarkPlayerDataAsNonSaved(target)
                        SendDiscordLog("give", src, string.sub(GetDiscord(src), 9, -1),
                            GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(), target,
                            string.sub(GetDiscord(target), 9, -1),
                            GetPlayer(target):getLastname() .. " " .. GetPlayer(target):getFirstname(), item,
                            count)
                        return
                    elseif v.name == "money" and v.name == item then
                        GiveItemToPlayer(target, item, count, v.metadatas)
                        TriggerClientEvent("core:playeTakeAnim", target)

                        -- New notification
                        TriggerClientEvent("__vision::createNotification", src, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez donné ~s x"  .. count .. " " .. getItemLabel(item)
                        })
                        TriggerClientEvent("__vision::createNotification", target, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez reçu ~s x"  .. count .. " " .. getItemLabel(item)
                        })

                        --RefreshPlayerData(src)
                        MarkPlayerDataAsNonSaved(src)
                        --RefreshPlayerData(target)
                        MarkPlayerDataAsNonSaved(target)
                        SendDiscordLog("give", src, string.sub(GetDiscord(src), 9, -1),
                            GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(), target,
                            string.sub(GetDiscord(target), 9, -1),
                            GetPlayer(target):getLastname() .. " " .. GetPlayer(target):getFirstname(), item,
                            count)
                        return
                    elseif v.name == item and v.metadatas ~= nil then
                        GiveItemToPlayer(target, item, count, v.metadatas)
                        TriggerClientEvent("core:playeTakeAnim", target)

                        -- New notification
                        TriggerClientEvent("__vision::createNotification", src, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez donné ~s x"  .. count .. " " .. getItemLabel(item)
                        })
                        TriggerClientEvent("__vision::createNotification", target, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez reçu ~s x"  .. count .. " " .. getItemLabel(item)
                        })

                        --RefreshPlayerData(src)
                        MarkPlayerDataAsNonSaved(src)
                        --RefreshPlayerData(target)
                        MarkPlayerDataAsNonSaved(target)
                        SendDiscordLog("give", src, string.sub(GetDiscord(src), 9, -1),
                            GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(), target,
                            string.sub(GetDiscord(target), 9, -1),
                            GetPlayer(target):getLastname() .. " " .. GetPlayer(target):getFirstname(), item,
                            count)
                        return
                    elseif v.name == item and v.metadatas == nil then
                        if json.encode(metadatas) == "[]" or metadatas == nil then
                            metadatas = {}
                        end
                        GiveItemToPlayer(target, item, count, metadatas)
                        TriggerClientEvent("core:playeTakeAnim", target)

                        -- New notification
                        TriggerClientEvent("__vision::createNotification", src, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez donné ~s x"  .. count .. " " .. getItemLabel(item)
                        })
                        TriggerClientEvent("__vision::createNotification", target, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez reçu ~s x"  .. count .. " " .. getItemLabel(item)
                        })

                        --RefreshPlayerData(src)
                        MarkPlayerDataAsNonSaved(src)
                        --RefreshPlayerData(target)
                        MarkPlayerDataAsNonSaved(target)
                        SendDiscordLog("give", src, string.sub(GetDiscord(src), 9, -1),
                            GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(), target,
                            string.sub(GetDiscord(target), 9, -1),
                            GetPlayer(target):getLastname() .. " " .. GetPlayer(target):getFirstname(), item,
                            count)
                        return
                    elseif v.name ~= item then
                        if json.encode(metadatas) == "[]" then
                            metadatas = {}
                        end
                        GiveItemToPlayer(target, item, count, metadatas)
                        TriggerClientEvent("core:playeTakeAnim", target)

                        -- New notification
                        TriggerClientEvent("__vision::createNotification", src, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez donné ~s x"  .. count .. " " .. getItemLabel(item)
                        })
                        TriggerClientEvent("__vision::createNotification", target, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez reçu ~s x"  .. count .. " " .. getItemLabel(item)
                        })

                        --RefreshPlayerData(src)
                        MarkPlayerDataAsNonSaved(src)
                        --RefreshPlayerData(target)
                        MarkPlayerDataAsNonSaved(target)
                        SendDiscordLog("give", src, string.sub(GetDiscord(src), 9, -1),
                            GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(), target,
                            string.sub(GetDiscord(target), 9, -1),
                            GetPlayer(target):getLastname() .. " " .. GetPlayer(target):getFirstname(), item,
                            count)
                        return
                    end
                end
            end
        end
    end
end)

-- Callbacks

Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(100) end

    RegisterServerCallback("inventory:GetOtherPlayerInventory", function(source, target)
        local player = GetPlayer(tonumber(target))
        return { item = player:getInventaire(), weapons = player:getWeapons(), cloths = player:getCloths().cloths }
    end)


    RegisterServerCallback("core:ChangeItemName", function(source, token, type, item, name, metadata)
        -- print(type, token, item, name, metadata)
        if CheckPlayerToken(source, token) then
            -- GiveItemToPlayer(source, 'water', 10, metadata)
            if type ~= "clothes" then
                ChangeItemName(source, item, name)
                --RefreshPlayerData(source)
                MarkPlayerDataAsNonSaved(source)
            else
                ChangeItemNameCloths(source, item, name, metadata)
                --RefreshPlayerData(source)
                MarkPlayerDataAsNonSaved(source)
            end

            return GetPlayer(source):getInventaire()
        end
    end)

    RegisterServerCallback("core:GetInventory", function(source, token)

        if CheckPlayerToken(source, token) then
            return GetPlayer(source):getInventaire()
        end
    end)
    RegisterServerCallback("core:RefreshInventory", function(source, token, inv)

        if CheckPlayerToken(source, token) then
            if inv ~= nil then
                GetPlayer(source):setInventaire(inv)
                return true
            end
        end
        return false
    end)

    RegisterNetEvent("core:RefreshInventory", function(time, secu, token, inv)     
        local src = source   
        --if CheckPlayerToken(src, token) then
            if CheckTrigger(src, time, secu, "core:RefreshInventory") then
                if inv ~= nil then
                    GetPlayer(src):setInventaire(inv)
                end
            end
        --end
    end)

    RegisterServerCallback("core:GetInventoryWeight", function(source, token)

        if CheckPlayerToken(source, token) then
            return getInventoryWeight(source)
        end
    end)

    RegisterServerCallback("core:pay", function(source, token, amount)
        if CheckPlayerToken(source, token) then
            local removed = false
            for key, value in pairs(GetPlayer(source):getInventaire()) do
                if value.name == "money" then
                    removed = RemoveItemFromInventory(source, 'money', tonumber(amount), value.metadatas)
                end
            end
            if removed then
                --RefreshPlayerData(source)
                MarkPlayerDataAsNonSaved(source)
            else
                local account = Bank.GetAllPlayerAccount(source)
                for k, v in pairs(account) do
                    if (v.balance - amount) > 0 then
                        local balance = v.balance
                        local result = balance - amount
                        TriggerClientEvent("core:updateBankPhoneValue", source, result)
                        Bank.setMoneyAccount(v.account_number, result)
                        removed = true
                    else
                        removed = false
                    end
                end
            end
            return removed
        end
    end)

    RegisterServerCallback("core:payLiquide", function(source, token, amount)
        if CheckPlayerToken(source, token) then
            local removed = false
            for key, value in pairs(GetPlayer(source):getInventaire()) do
                if value.name == "money" then
                    removed = RemoveItemFromInventory(source, 'money', tonumber(amount), value.metadatas)
                end
            end
            if removed then
                --RefreshPlayerData(source)
                MarkPlayerDataAsNonSaved(source)
            end
            return removed
        end
    end)
end)


-- RegisterCommand("Secret", function(source)
--     DropPlayer(source, "Coucou j'espère tu vas bien je te fais plein de bisous")
-- end)


function GrosNibard(source, amount)
    local removed = false
    for key, value in pairs(GetPlayer(source):getInventaire()) do
        if value.name == "money" then
            removed = RemoveItemFromInventory(source, 'money', tonumber(amount), value.metadatas)
        end
    end
    if removed then
        --RefreshPlayerData(source)
        MarkPlayerDataAsNonSaved(source)
    else
        local account = Bank.GetAllPlayerAccount(source)
        for k, v in pairs(account) do
            if (v.balance - amount) > 0 then
                local balance = v.balance
                local result = balance - amount
                TriggerClientEvent("core:updateBankPhoneValue", source, result)
                Bank.setMoneyAccount(v.account_number, result)
                removed = true
            else
                removed = false
            end
        end
    end
    return removed
end

exports("GROSNIBARD", function(source, amount)
    return GrosNibard(source, amount)
end)
