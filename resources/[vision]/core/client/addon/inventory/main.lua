local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local open = false
Weapons = {}
local clothes = {}
throwableWeapons = {
    "weapon_ball", --
    "weapon_flare", --
    "weapon_snowball", --
    "weapon_molotov", --
    "weapon_canette", --
    "weapon_smokelspd", --
    "weapon_bouteille", --
    "weapon_bzgas", --
    "weapon_grenade", --
    "weapon_poxmine", --
    "weapon_stickybomb", --
}

local items = {}
local keys = { 157, 158, 160, 164 }
weaponOut = false

function OpenInventory()
    Weapons = TriggerServerCallback("core:GetWeaponSave", token)
    if p:skin().pants_1 ~= nil then
        pant = "Pantalon #" .. p:skin().pants_1
    end
    if p:skin().shoes_1 ~= nil then
        feet = "Chaussures #" .. p:skin().shoes_1
    end
    if p:skin().helmet_1 ~= nil then
        hat = "Chapeau #" .. p:skin().helmet_1
    end
    if p:skin().bags_1 ~= nil then
        access = "Accessoires #" .. p:skin().bags_1
    end
    if p:skin().glasses_1 ~= nil then
        glasses = "Lunettes #" .. p:skin().glasses_1
    end
    if p:skin().torso_1 ~= nil then
        tshirt = "Haut #" .. p:skin().torso_1
    end

    if p:skin().pants_1 ~= nil and p:skin().pants_1 ~= 61 and p:skin().pants_1 ~= 0 then
        clothes.pant = {
            name = "pant",
            quantity = 1
        }
    elseif p:skin().shoes_1 ~= nil and p:skin().shoes_1 ~= 34 and p:skin().shoes_1 ~= 0 then
        clothes.feet = {
            name = "feet",
            quantity = 1
        }
    elseif p:skin().helmet_1 ~= nil and p:skin().helmet_1 ~= -1 then
        clothes.hat = {
            name = "hat",
            quantity = 1
        }
    elseif p:skin().bags_1 ~= nil and p:skin().bags_1 ~= 30 and p:skin().bags_1 ~= 0 then
        clothes.access = {
            name = "access",
            quantity = 1
        }
    elseif p:skin().glasses_1 ~= nil and p:skin().glasses_1 ~= 0 then
        clothes.glasses = {
            name = "glasses",
            quantity = 1
        }
    elseif p:skin().torso_1 ~= nil and p:skin().torso_1 ~= 15 and p:skin().torso_1 ~= 0 then
        clothes.tshirt = {
            name = "tshirt",
            quantity = 1
        }
    end

    if not open then
        open = true

        --local inv = TriggerServerCallback("core:GetInventory", token)
        local inv = p:getInventaire()
        local weightInv = TriggerServerCallback("core:GetInventoryWeight", token)
        CreateThread(function()
            while open do
                Wait(0)
                DisableControlAction(0, 24, true) -- disable attack
                DisableControlAction(0, 25, true) -- disable aim
                DisableControlAction(0, 1, true) -- LookLeftRight
                DisableControlAction(0, 2, true) -- LookUpDown
                DisableControlAction(0, 142, open)
                DisableControlAction(0, 18, open)
                DisableControlAction(0, 322, open)
                DisableControlAction(0, 106, open)
                DisableControlAction(0, 263, true) -- disable melee
                DisableControlAction(0, 264, true) -- disable melee
                DisableControlAction(0, 257, true) -- disable melee
                DisableControlAction(0, 140, true) -- disable melee
                DisableControlAction(0, 141, true) -- disable melee
                DisableControlAction(0, 142, true) -- disable melee
                DisableControlAction(0, 143, true) -- disable melee
            end
        end)
        SetNuiFocusKeepInput(true)
        SetNuiFocus(true, true)
        forceHideRadar()
        items = {}
        for k, v in pairs(inv) do
            if v.item == "money" then
                v.count = Round(v.count)
            end
            if v.type == "items" or v.type == "weapons" or v.type == "clothes" then
                table.insert(items, {
                    name = v.name,
                    count = Round(v.count),
                    label = v.label,
                    cols = v.cols,
                    rows = v.rows,
                    type = v.type,
                    metadatas = v.metadatas,
                    weight = v.weight
                })
            end
        end
        Citizen.CreateThread(function()
            SendNUIMessage({
                type = "openWebview",
                name = "inventory",
                data = {
                    items = items,
                    clothes = clothes,
                    weapons = Weapons,
                    hud = {
                        hunger = p:getStatus().hunger / 100,
                        thirst = p:getStatus().thirst / 100,
                        maxWeight = 35.0
                    }
                }
            })
        end)
        p:setInventaire(inv)

    else
        open = false
        SetNuiFocusKeepInput(false)
        EnableControlAction(0, 1, true)
        EnableControlAction(0, 24, true)
        EnableControlAction(0, 25, true)
        EnableControlAction(0, 2, true)
        EnableControlAction(0, 142, true)
        EnableControlAction(0, 18, true)
        EnableControlAction(0, 322, true)
        EnableControlAction(0, 106, true)
        SetNuiFocus(false, false)
        openRadarProperly()
        SendNuiMessage(json.encode({
            type = 'closeWebview'
        }))
        return
    end
end

RegisterNetEvent("core:CloseInv")
AddEventHandler("core:CloseInv", function()
    open = false
    SetNuiFocusKeepInput(false)
    EnableControlAction(0, 1, true)
    EnableControlAction(0, 24, true)
    EnableControlAction(0, 25, true)
    EnableControlAction(0, 2, true)
    EnableControlAction(0, 142, true)
    EnableControlAction(0, 18, true)
    EnableControlAction(0, 322, true)
    EnableControlAction(0, 106, true)
    SetNuiFocus(false, false)
    openRadarProperly()
    SendNuiMessage(json.encode({
        type = 'closeWebview'
    }))
end)

function updateInventoryNui()
    Wait(250)
    local inv = p:getInventaire()
    print("updateInventoryNui", json.encode(inv))
    SendNUIMessage({
        type = "updateInventory",
        data = {
            items = inv,
            clothes = clothes,
            weapons = Weapons,
            hud = {
                hunger = p:getStatus().hunger / 100,
                thirst = p:getStatus().thirst / 100,
                maxWeight = 35.0
            }
        }
    })
end

RegisterNUICallback('inventory-rename', function(data, cb)
    if data.item.name ~= "money" then
        if data.rename ~= nil and data.rename ~= data.item.label then
            TriggerServerEvent("core:ChangeItemName", token, data.item.type, data.item.name, data.rename, data.item.metadatas)
            updateInventoryNui()
        end
    else
        -- ShowNotification("N'essaie pas mon reuf")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s La verite touche pas le fric"
        })

    end
end)


local currentOutfit = {}
local oldSkin = {}

function getMetadataOutfit(outfit)
    if type(currentOutfit) == "table" and next(currentOutfit) then
        if currentOutfit.renamed == outfit.renamed then
            for k, v in pairs(currentOutfit.data) do
                if v ~= outfit.data[k] then
                    return false
                end
            end
            return true
        else
            return false
        end
    else
        return false
    end
end

local lastMeta = {}
local lastMaskMeta = {}
RegisterNUICallback('inventory-use-item', function(data, cb)
    if data.item.name ~= "outfit" and data.item.name ~= "identitycard" and data.item.name ~= 'mask' then
        TriggerServerEvent("core:UseItem", token, data.item.name, data.item.metadatas)
    elseif data.item.name == "outfit" then
        if json.encode(data.item.metadatas) == json.encode(lastMeta) then
            if p:skin().sex == 0 then
                TriggerEvent("skinchanger:change", "arms", 15)
                TriggerEvent("skinchanger:change", "torso_1", 15)
                TriggerEvent("skinchanger:change", "tshirt_1", 15)
                TriggerEvent("skinchanger:change", "pants_1", 61)
                TriggerEvent("skinchanger:change", "pants_2", 4)
                TriggerEvent("skinchanger:change", "shoes_1", 34)
                TriggerEvent("skinchanger:change", "glasses_1", -1)
                TriggerEvent("skinchanger:change", "bags_1", 0)
                TriggerEvent("skinchanger:change", "decals_1", -1)
                TriggerEvent("skinchanger:change", "helmet_1", -1)
                TriggerEvent("skinchanger:change", "mask_1", -1)
                TriggerEvent("skinchanger:change", "chain_1", -1)
                TriggerEvent("skinchanger:change", "bproof_1", -1)

            else
                TriggerEvent("skinchanger:change", "arms", 15)
                TriggerEvent("skinchanger:change", "torso_1", 15)
                TriggerEvent("skinchanger:change", "tshirt_1", 2)
                TriggerEvent("skinchanger:change", "pants_1", 15)
                TriggerEvent("skinchanger:change", "pants_2", 0)
                TriggerEvent("skinchanger:change", "shoes_1", 35)
                TriggerEvent("skinchanger:change", "glasses_1", -1)
                TriggerEvent("skinchanger:change", "bags_1", 0)
                TriggerEvent("skinchanger:change", "decals_1", -1)
                TriggerEvent("skinchanger:change", "helmet_1", -1)
                TriggerEvent("skinchanger:change", "mask_1", -1)
                TriggerEvent("skinchanger:change", "chain_1", -1)
                TriggerEvent("skinchanger:change", "bproof_1", -1)

            end
            p:saveSkin()
            lastMeta = {}
            currentOutfit = {}
            -- ShowNotification("Vous avez enlevé votre tenue")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'JAUNE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s enlevé ~c votre tenue"
            })

        else
            lastMeta = data.item.metadatas
            p:setSkin(data.item.metadatas.data)
            p:saveSkin()
            -- ShowNotification("~g~Vous avez changé votre tenue")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'JAUNE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s changé ~c votre tenue"
            })

        end
    elseif data.item.name == "mask" then
        if not IsPedInAnyVehicle(PlayerPedId()) then
            p:PlayAnim("clothingspecs", "try_glasses_negative_c", 51)
            Wait(1000)
            if IsEntityPlayingAnim(PlayerPedId(), "clothingspecs", "try_glasses_negative_c", 51) then 
                StopAnimTask(PlayerPedId(), "clothingspecs", "try_glasses_negative_c", 1.0)
            end
        end
        if json.encode(data.item.metadatas) == json.encode(lastMaskMeta) then
            if p:skin().sex == 0 then
                p:setCloth("mask_1", 0)
                p:setCloth("mask_2", 0)
                p:saveSkin()
                lastMaskMeta = {}
            else
                p:setCloth("mask_1", 0)
                p:setCloth("mask_2", 0)
                p:saveSkin()
                lastMaskMeta = {}
            end
        else
            lastMaskMeta = data.item.metadatas

            p:setCloth("mask_1", data.item.metadatas.drawableId)
            p:setCloth("mask_2", data.item.metadatas.variationId)
            if p:skin().sex == 0 then
                --MAsk
                if data.item.metadatas.drawableId ~= 11 and data.item.metadatas.drawableId ~= 12 and
                    data.item.metadatas.drawableId ~= 27 and data.item.metadatas.drawableId ~= 36
                    and data.item.metadatas.drawableId ~= 109 and data.item.metadatas.drawableId ~= 114 and
                    data.item.metadatas.drawableId ~= 121 and data.item.metadatas.drawableId ~= 122
                    and data.item.metadatas.drawableId ~= 145 and data.item.metadatas.drawableId ~= 148 and
                    data.item.metadatas.drawableId ~= 164 and data.item.metadatas.drawableId ~= 166
                    and data.item.metadatas.drawableId ~= 175 and data.item.metadatas.drawableId ~= 198 and
                    data.item.metadatas.drawableId ~= 199 and data.item.metadatas.drawableId ~= 200
                    and data.item.metadatas.drawableId ~= 201 and data.item.metadatas.drawableId ~= 202 and
                    data.item.metadatas.drawableId ~= 203 and data.item.metadatas.drawableId ~= 204
                    and data.item.metadatas.drawableId ~= 207 and data.item.metadatas.drawableId ~= 213 and
                    data.item.metadatas.drawableId ~= 214 and data.item.metadatas.drawableId ~= 215
                    and data.item.metadatas.drawableId ~= 215 and data.item.metadatas.drawableId ~= 216 and
                    data.item.metadatas.drawableId ~= 217 
                    and data.item.metadatas.drawableId ~= 219 and data.item.metadatas.drawableId ~= 220 and
                    data.item.metadatas.drawableId ~= 221 and data.item.metadatas.drawableId ~= 222
                    and data.item.metadatas.drawableId ~= 223 and data.item.metadatas.drawableId ~= 231 and 
                    data.item.metadatas.drawableId ~= 233 
                    and data.item.metadatas.drawableId ~= 235 and data.item.metadatas.drawableId ~= 237 and 
                    data.item.metadatas.drawableId ~= 238 and data.item.metadatas.drawableId ~= 239 
                    and data.item.metadatas.drawableId ~= 240 and data.item.metadatas.drawableId ~= 241 and 
                    data.item.metadatas.drawableId ~= 242 and data.item.metadatas.drawableId ~= 243 
                    and data.item.metadatas.drawableId ~= 244 and data.item.metadatas.drawableId ~= 245 and 
                    data.item.metadatas.drawableId ~= 246 and data.item.metadatas.drawableId ~= 247 
                    and data.item.metadatas.drawableId ~= 248 and data.item.metadatas.drawableId ~= 249 and 
                    data.item.metadatas.drawableId ~= 250 and data.item.metadatas.drawableId ~= 251
                    and data.item.metadatas.drawableId ~= 252 and data.item.metadatas.drawableId ~= 224 and 
                    data.item.metadatas.drawableId ~= 225 and data.item.metadatas.drawableId ~= 226 
                    and data.item.metadatas.drawableId ~= 216 and data.item.metadatas.drawableId ~= 217 and
                    data.item.metadatas.drawableId ~= 219 and data.item.metadatas.drawableId ~= 220
                    and data.item.metadatas.drawableId ~= 222 and data.item.metadatas.drawableId ~= 227 and
                    data.item.metadatas.drawableId ~= 258 and data.item.metadatas.drawableId ~= 259 
                    and data.item.metadatas.drawableId ~= 260 and data.item.metadatas.drawableId ~= 261
                    then
                    oldSkin = p:skin()
                    ApplySkinFake(oldSkin, "mask", true, true)
                end
                if data.item.metadatas.drawableId ~= 11 and data.item.metadatas.drawableId ~= 12 and
                    data.item.metadatas.drawableId ~= 14 and data.item.metadatas.drawableId ~= 15
                    and data.item.metadatas.drawableId ~= 16 and data.item.metadatas.drawableId ~= 30 and
                    data.item.metadatas.drawableId ~= 29 and data.item.metadatas.drawableId ~= 33
                    and data.item.metadatas.drawableId ~= 36 and data.item.metadatas.drawableId ~= 38 and
                    data.item.metadatas.drawableId ~= 43 and data.item.metadatas.drawableId ~= 44
                    and data.item.metadatas.drawableId ~= 45 and data.item.metadatas.drawableId ~= 50 and
                    data.item.metadatas.drawableId ~= 51 and data.item.metadatas.drawableId ~= 74
                    and data.item.metadatas.drawableId ~= 75 and data.item.metadatas.drawableId ~= 90 and
                    data.item.metadatas.drawableId ~= 101 and data.item.metadatas.drawableId ~= 105
                    and data.item.metadatas.drawableId ~= 107 and data.item.metadatas.drawableId ~= 108 and
                    data.item.metadatas.drawableId ~= 111 and data.item.metadatas.drawableId ~= 121
                    and data.item.metadatas.drawableId ~= 124 and data.item.metadatas.drawableId ~= 127 and
                    data.item.metadatas.drawableId ~= 128 and data.item.metadatas.drawableId ~= 133
                    and data.item.metadatas.drawableId ~= 148 and data.item.metadatas.drawableId ~= 160 and
                    data.item.metadatas.drawableId ~= 161 and data.item.metadatas.drawableId ~= 164
                    and data.item.metadatas.drawableId ~= 165 and data.item.metadatas.drawableId ~= 166 and
                    data.item.metadatas.drawableId ~= 168 and data.item.metadatas.drawableId ~= 169
                    and data.item.metadatas.drawableId ~= 175 and data.item.metadatas.drawableId ~= 179 and
                    data.item.metadatas.drawableId ~= 183 and data.item.metadatas.drawableId ~= 186
                    and data.item.metadatas.drawableId ~= 187 and data.item.metadatas.drawableId ~= 198
                    and data.item.metadatas.drawableId ~= 200 and data.item.metadatas.drawableId ~= 201 and
                    data.item.metadatas.drawableId ~= 202 and data.item.metadatas.drawableId ~= 223
                    and data.item.metadatas.drawableId ~= 203 and data.item.metadatas.drawableId ~= 208 and
                    data.item.metadatas.drawableId ~= 209 and data.item.metadatas.drawableId ~= 213
                    and data.item.metadatas.drawableId ~= 214 and data.item.metadatas.drawableId ~= 215 and
                    data.item.metadatas.drawableId ~= 216 and data.item.metadatas.drawableId ~= 217
                    and data.item.metadatas.drawableId ~= 219 and data.item.metadatas.drawableId ~= 220 and 
                    data.item.metadatas.drawableId ~= 221 and data.item.metadatas.drawableId ~= 222 
                    and data.item.metadatas.drawableId ~= 0 and data.item.metadatas.drawableId ~= 237 and                    
                    data.item.metadatas.drawableId ~= 238 and data.item.metadatas.drawableId ~= 239 
                    and data.item.metadatas.drawableId ~= 240 and data.item.metadatas.drawableId ~= 241 and 
                    data.item.metadatas.drawableId ~= 242 and data.item.metadatas.drawableId ~= 243 
                    and data.item.metadatas.drawableId ~= 244 and data.item.metadatas.drawableId ~= 245 and 
                    data.item.metadatas.drawableId ~= 246 and data.item.metadatas.drawableId ~= 247 
                    and data.item.metadatas.drawableId ~= 248 and data.item.metadatas.drawableId ~= 249 and 
                    data.item.metadatas.drawableId ~= 250 and data.item.metadatas.drawableId ~= 251
                    and data.item.metadatas.drawableId ~= 252 and data.item.metadatas.drawableId ~= 235 and
                    data.item.metadatas.drawableId ~= 232 and data.item.metadatas.drawableId ~= 233 
                    and data.item.metadatas.drawableId ~= 224 and data.item.metadatas.drawableId ~= 225 and 
                    data.item.metadatas.drawableId ~= 226
                    and data.item.metadatas.drawableId ~= 216 and data.item.metadatas.drawableId ~= 217 and
                    data.item.metadatas.drawableId ~= 219 and data.item.metadatas.drawableId ~= 220
                    and data.item.metadatas.drawableId ~= 222 and data.item.metadatas.drawableId ~= 227 and
                    data.item.metadatas.drawableId ~= 258 and data.item.metadatas.drawableId ~= 259 
                    and data.item.metadatas.drawableId ~= 260 and data.item.metadatas.drawableId ~= 261

                    then
                    SkinChangeFake("hair_1", 1, true)
                end
            elseif p:skin().sex == 1 then
                --MAsk
                if data.item.metadatas.drawableId ~= 11 and data.item.metadatas.drawableId ~= 12 and
                    data.item.metadatas.drawableId ~= 27 and data.item.metadatas.drawableId ~= 36
                    and data.item.metadatas.drawableId ~= 109 and data.item.metadatas.drawableId ~= 114 and
                    data.item.metadatas.drawableId ~= 121 and data.item.metadatas.drawableId ~= 122
                    and data.item.metadatas.drawableId ~= 145 and data.item.metadatas.drawableId ~= 148 and
                    data.item.metadatas.drawableId ~= 164 and data.item.metadatas.drawableId ~= 166
                    and data.item.metadatas.drawableId ~= 175 and data.item.metadatas.drawableId ~= 199 and
                    data.item.metadatas.drawableId ~= 200 and data.item.metadatas.drawableId ~= 201
                    and data.item.metadatas.drawableId ~= 202 and data.item.metadatas.drawableId ~= 204 and
                    data.item.metadatas.drawableId ~= 205 and data.item.metadatas.drawableId ~= 208 
                    and data.item.metadatas.drawableId ~= 218 and data.item.metadatas.drawableId ~= 235 and 
                    data.item.metadatas.drawableId ~= 236 and data.item.metadatas.drawableId ~= 237
                    and data.item.metadatas.drawableId ~= 238
                    
                    then
                    oldSkin = p:skin()
                    ApplySkinFake(oldSkin, "mask", true)
                end
                --Hair
                if data.item.metadatas.drawableId ~= 11 and data.item.metadatas.drawableId ~= 12 and
                    data.item.metadatas.drawableId ~= 14 and data.item.metadatas.drawableId ~= 15
                    and data.item.metadatas.drawableId ~= 16 and data.item.metadatas.drawableId ~= 30 and
                    data.item.metadatas.drawableId ~= 29 and data.item.metadatas.drawableId ~= 33
                    and data.item.metadatas.drawableId ~= 36 and data.item.metadatas.drawableId ~= 38 and
                    data.item.metadatas.drawableId ~= 43 and data.item.metadatas.drawableId ~= 44
                    and data.item.metadatas.drawableId ~= 45 and data.item.metadatas.drawableId ~= 50 and
                    data.item.metadatas.drawableId ~= 51 and data.item.metadatas.drawableId ~= 74
                    and data.item.metadatas.drawableId ~= 75 and data.item.metadatas.drawableId ~= 90 and
                    data.item.metadatas.drawableId ~= 101 and data.item.metadatas.drawableId ~= 105
                    and data.item.metadatas.drawableId ~= 107 and data.item.metadatas.drawableId ~= 108 and
                    data.item.metadatas.drawableId ~= 111 and data.item.metadatas.drawableId ~= 121
                    and data.item.metadatas.drawableId ~= 124 and data.item.metadatas.drawableId ~= 127 and
                    data.item.metadatas.drawableId ~= 128 and data.item.metadatas.drawableId ~= 133
                    and data.item.metadatas.drawableId ~= 148 and data.item.metadatas.drawableId ~= 160 and
                    data.item.metadatas.drawableId ~= 161 and data.item.metadatas.drawableId ~= 164
                    and data.item.metadatas.drawableId ~= 165 and data.item.metadatas.drawableId ~= 166 and
                    data.item.metadatas.drawableId ~= 168 and data.item.metadatas.drawableId ~= 169
                    and data.item.metadatas.drawableId ~= 175 and data.item.metadatas.drawableId ~= 179 and
                    data.item.metadatas.drawableId ~= 183 and data.item.metadatas.drawableId ~= 186
                    and data.item.metadatas.drawableId ~= 187 and data.item.metadatas.drawableId ~= 199 and
                    data.item.metadatas.drawableId ~= 201 and data.item.metadatas.drawableId ~= 202
                    and data.item.metadatas.drawableId ~= 203 and data.item.metadatas.drawableId ~= 204 and
                    data.item.metadatas.drawableId ~= 209 and data.item.metadatas.drawableId ~= 210 
                    and data.item.metadatas.drawableId ~= 230 and data.item.metadatas.drawableId ~= 231 and 
                    data.item.metadatas.drawableId ~= 234 and data.item.metadatas.drawableId ~= 235 
                    and data.item.metadatas.drawableId ~= 236 and data.item.metadatas.drawableId ~= 237 and
                    data.item.metadatas.drawableId ~= 238
                    
                    then
                    SkinChangeFake("hair_1", 1, true)
                end
            end

            p:saveSkin()
            --ShowNotification("~g~Vous avez mis votre tenue")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'JAUNE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s mis ~c votre tenue"
            })

        end
    elseif data.item.name == "identitycard" then
        local player = GetAllPlayersInArea(p:pos(), 3.0)
        if player ~= nil then
            ExecuteCommand("e card")
            SetTimeout(7000, function()
                ExecuteCommand("e c")
            end)
            if next(player) then
                for k, v in pairs(player) do

                    -- Data for new carte d'identité 
                    TriggerServerEvent("core:UseIdentityCard", token, data.item.metadatas.identity.dl,
                        data.item.metadatas.identity.exp,
                        data.item.metadatas.identity.ln,
                        data.item.metadatas.identity.fn,
                        data.item.metadatas.identity.dob,
                        data.item.metadatas.identity.id,
                        data.item.metadatas.identity.class,
                        data.item.metadatas.identity.sex,
                        data.item.metadatas.identity.hair,
                        data.item.metadatas.identity.eyes,
                        data.item.metadatas.identity.hgt,
                        data.item.metadatas.identity.wgt,
                        data.item.metadatas.identity.iss, GetPlayerServerId(v))
                end
            end
        end
    end
    updateInventoryNui()
end)

RegisterNUICallback('inventory-throw-item', function(data, cb)
    local notinstance = TriggerServerCallback("core:CheckInstance", token)
    if notinstance then
        if data.item.type == 'weapons' then
            for k, v in pairs(Weapons) do
                if v.name == data.item.name then
                    if HasPedGotWeapon(p:ped(), GetHashKey(data.item.name), false) then
                        data.item.metadatas.ammo = GetAmmoInPedWeapon(p:ped(), GetHashKey(data.item.name))
                    end
                    RemoveAllPedWeapons(p:ped(), 1)
                    weaponOut = false
                    Weapons[k] = nil
                end
            end
        end
        --TriggerServerCallback("core:RefreshInventory", token, p:getInventaire())
        TriggerServerEvent("core:SetWeaponSave", token, Weapons)
        TriggerServerEvent("core:ThrowItem", token, data, p:pos())

        updateInventoryNui()
    else
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = 'Impossible de jeter un item en instance'
        })
    end
end)

local inChoice = false
local selectedPlayer = nil

local function StartChoiceInventory(players)
    selectedPlayer = nil

    -- New notif
    exports['vNotif']:createNotification({
        type = 'VERT',
        duration = 10, -- In seconds, default:  4
        content = "Appuyer sur ~K E pour ~s valider"
    })

    exports['vNotif']:createNotification({
        type = 'JAUNE',
        duration = 10, -- In seconds, default:  4
        content = "Appuyer sur ~K L pour ~s changer de cible"
    })
        
    exports['vNotif']:createNotification({
        type = 'ROUGE',
        duration = 10, -- In seconds, default:  4
        content = "Appuyez sur ~K X pour ~s annuler"
    })



    local timer = GetGameTimer() + 10000
    while inChoice do
        if next(players) then
            local mCoors = GetEntityCoords(GetPlayerPed(players[1]))
            DrawMarker(20, mCoors.x, mCoors.y, mCoors.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255,
                255, 120, 0, 1, 2, 0, nil, nil, 0)
            if GetGameTimer() > timer then
                -- ShowNotification("~r~Le délai est dépassé")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Le délai est dépassé"
                })

                inChoice = false
                return
            elseif IsControlJustPressed(0, 51) then -- E
                selectedPlayer = players[1]
                inChoice = false
                return
            elseif IsControlJustPressed(0, 182) then -- L
                table.remove(players, 1)
                if next(players) then
                    timer = GetGameTimer() + 10000
                end
            elseif IsControlJustPressed(0, 73) then -- X
                -- ShowNotification("~r~Vous avez annulé")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Vous avez annulé"
                })

                selectedPlayer = nil
                inChoice = false
                return
            end
        else
            -- ShowNotification("~r~Il n'y a personne autour de vous")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Il n'y a personne autour de vous"
            })

            selectedPlayer = nil
            inChoice = false
            return
        end
        Wait(0)
    end
end

RegisterNUICallback('inventory-give-item', function(data, cb)
    local player = GetAllPlayersInArea(p:pos(), 3.0)
    for k, v in pairs(player) do
        if v == PlayerId() then
            table.remove(player, k)
        end
    end
    if player ~= nil then
        if next(player) then
            inChoice = true
            StartChoiceInventory(player)
            if selectedPlayer ~= nil then
                LoadDict('mp_common')
                p:PlayAnim('mp_common', 'givetake1_a', 50)
                if data.item.type == 'weapons' then
                    for k, v in pairs(Weapons) do
                        if v.name == data.item.name then
                            if HasPedGotWeapon(p:ped(), GetHashKey(data.item.name), false) then
                                data.item.metadatas.ammo = GetAmmoInPedWeapon(p:ped(), GetHashKey(data.item.name))
                            end
                            SetCurrentPedWeapon(p:ped(), 'WEAPON_UNARMED', true)
                            weaponOut = false
                            RemoveAllPedWeapons(p:ped(), 1)
                            Weapons[k] = nil
                        end
                    end
                end
                --TriggerServerCallback("core:RefreshInventory", token, p:getInventaire())
                TriggerServerEvent("core:SetWeaponSave", token, Weapons)
                TriggerSecurEvent("core:GiveItemToPlayer", data.item.name, data.item.metadatas, data.quantity,
                    GetPlayerServerId(selectedPlayer))
                Wait(1000)
                ClearPedTasks(p:ped())
            end
        else
            -- ShowNotification("~r~Il n'y a personne autour de vous")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Il n'y a personne autour de vous"
            })

        end
    else
        -- ShowNotification("~r~Il n'y a personne autour de vous")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Il n'y a personne autour de vous"
        })

    end
    updateInventoryNui()
end)

RegisterNetEvent("core:playeTakeAnim")
AddEventHandler("core:playeTakeAnim", function()
    LoadDict('mp_common')
    p:PlayAnim('mp_common', 'givetake1_a', 50)
    Wait(1000)
    ClearPedTasks(p:ped())
end)

local lastMetapants = {}
local lastMetafeet = {}
local lastMetaMontre = {}
local lastMetaBague = {}
local lastMetaPiercing = {}
local lastMetaOngle = {}
local lastMetaBracelet = {}
local lastMetaBoucles = {}
local lastMetaCollier = {}
local lastMetahat = {}
local lastMetaGlasses = {}
local lastMetaTshirt = {}
local lastMetaBags = {}
local lastMetaDecals = {}
local lastMetaChain = {}
RegisterNUICallback('inventory-put-clothe', function(data, cb)
    if data.item.name == "pant" then
        if not IsPedInAnyVehicle(PlayerPedId()) then
            p:PlayAnim("clothingtrousers", "try_trousers_neutral_c", 51)
            Wait(1000)
            if IsEntityPlayingAnim(PlayerPedId(), "clothingtrousers", "try_trousers_neutral_c", 51) then 
                StopAnimTask(PlayerPedId(), "clothingtrousers", "try_trousers_neutral_c", 1.0)
            end
        end
        if json.encode(data.item.metadatas) ~= json.encode(lastMetapants) then
            if data.item.metadatas.drawableId ~= nil and data.item.metadatas.variationId == nil then
                p:setCloth("pants_1", data.item.metadatas.drawableId, true)
                p:setCloth("pants_2", -1, true)
            elseif data.item.metadatas.variationId ~= nil and data.item.metadatas.drawableId ~= nil then
                p:setCloth("pants_1", data.item.metadatas.drawableId, true)
                p:setCloth("pants_2", data.item.metadatas.variationId, true)
            end
            lastMetapants = data.item.metadatas
            clothes.pant = {
                name = data.item.name,
                quantity = 1
            }
            p:saveSkin()
        else
            if p:skin().sex == 0 then
                TriggerEvent("skinchanger:change", "pants_1", 61, true)
                TriggerEvent("skinchanger:change", "pants_2", 0, true)
            else
                TriggerEvent("skinchanger:change", "pants_1", 15, true)
                TriggerEvent("skinchanger:change", "pants_2", 0, true)
            end
            lastMetapants = {}
            clothes.pant = nil
            p:saveSkin()

        end
    end
    if data.item.name == "feet" then
        if json.encode(data.item.metadatas) ~= json.encode(lastMetafeet) then
            if data.item.metadatas.drawableId ~= nil and data.item.metadatas.variationId == nil then
                p:setCloth("shoes_1", data.item.metadatas.drawableId, true)
                p:setCloth("shoes_2", -1, true)

            elseif data.item.metadatas.variationId ~= nil and data.item.metadatas.drawableId ~= nil then
                p:setCloth("shoes_1", data.item.metadatas.drawableId, true)
                p:setCloth("shoes_2", data.item.metadatas.variationId, true)
            end
            lastMetafeet = data.item.metadatas
            clothes.feet = {
                name = data.item.name,
                quantity = 1
            }
            p:saveSkin()
        else
            if p:skin().sex == 1 then
                TriggerEvent("skinchanger:change", "shoes_1", 35, true)
                TriggerEvent("skinchanger:change", "shoes_2", 0, true)
            else
                TriggerEvent("skinchanger:change", "shoes_1", 34, true)
                TriggerEvent("skinchanger:change", "shoes_2", 0, true)

            end
            p:saveSkin()
            lastMetafeet = {}
            clothes.feet = nil
        end

    end
    if data.item.name == "bague" then
        if json.encode(data.item.metadatas) ~= json.encode(lastMetaBague) then
            if data.item.metadatas.drawableId ~= nil and data.item.metadatas.variationId == nil then
                p:setCloth("bproof_1", data.item.metadatas.drawableId, true)
                p:setCloth("bproof_2", -1, true)
            elseif data.item.metadatas.variationId ~= nil and data.item.metadatas.drawableId ~= nil then
                p:setCloth("bproof_1", data.item.metadatas.drawableId, true)
                p:setCloth("bproof_2", data.item.metadatas.variationId, true)
            end
            lastMetaBague = data.item.metadatas
            clothes.bague = {
                name = data.item.name,
                quantity = 1
            }
            p:saveSkin()
        else
            if p:skin().sex == 1 then
                TriggerEvent("skinchanger:change", "bproof_1", -1, true)
                TriggerEvent("skinchanger:change", "bproof_2", 0, true)
            else
                TriggerEvent("skinchanger:change", "bproof_1", -1, true)
                TriggerEvent("skinchanger:change", "bproof_2", 0, true)

            end
            p:saveSkin()
            lastMetaBague = {}
            clothes.bague = nil
        end
    end
    if data.item.name == "ongle" then
        if json.encode(data.item.metadatas) ~= json.encode(lastMetaOngle) then
            if data.item.metadatas.drawableId ~= nil and data.item.metadatas.variationId == nil then
                p:setCloth("decals_1", data.item.metadatas.drawableId, true)
                p:setCloth("decals_2", -1, true)
            elseif data.item.metadatas.variationId ~= nil and data.item.metadatas.drawableId ~= nil then
                p:setCloth("decals_1", data.item.metadatas.drawableId, true)
                p:setCloth("decals_2", data.item.metadatas.variationId, true)
            end
            lastMetaOngle = data.item.metadatas
            clothes.ongle = {
                name = data.item.name,
                quantity = 1
            }
            p:saveSkin()
        else
            if p:skin().sex == 1 then
                TriggerEvent("skinchanger:change", "decals_1", -1, true)
                TriggerEvent("skinchanger:change", "decals_2", 0, true)
            else
                TriggerEvent("skinchanger:change", "decals_1", -1, true)
                TriggerEvent("skinchanger:change", "decals_2", 0, true)

            end
            p:saveSkin()
            lastMetaOngle = {}
            clothes.ongle = nil
        end
    end
    if data.item.name == "piercing" then
        if json.encode(data.item.metadatas) ~= json.encode(lastMetaPiercing) then
            if data.item.metadatas.drawableId ~= nil and data.item.metadatas.variationId == nil then
                p:setCloth("decals_1", data.item.metadatas.drawableId, true)
                p:setCloth("decals_2", -1, true)
            elseif data.item.metadatas.variationId ~= nil and data.item.metadatas.drawableId ~= nil then
                p:setCloth("decals_1", data.item.metadatas.drawableId, true)
                p:setCloth("decals_2", data.item.metadatas.variationId, true)
            end
            lastMetaPiercing = data.item.metadatas
            clothes.piercing = {
                name = data.item.name,
                quantity = 1
            }
            p:saveSkin()
        else
            if p:skin().sex == 1 then
                TriggerEvent("skinchanger:change", "decals_1", -1, true)
                TriggerEvent("skinchanger:change", "decals_2", 0, true)
            else
                TriggerEvent("skinchanger:change", "decals_1", -1, true)
                TriggerEvent("skinchanger:change", "decals_2", 0, true)

            end
            p:saveSkin()
            lastMetaPiercing = {}
            clothes.piercing = nil
        end
    end
    if data.item.name == "montre" then
        if json.encode(data.item.metadatas) ~= json.encode(lastMetaMontre) then
            if data.item.metadatas.drawableId ~= nil and data.item.metadatas.variationId == nil then
                p:setCloth("watches_1", data.item.metadatas.drawableId, true)
                p:setCloth("watches_2", -1, true)
            elseif data.item.metadatas.variationId ~= nil and data.item.metadatas.drawableId ~= nil then
                p:setCloth("watches_1", data.item.metadatas.drawableId, true)
                p:setCloth("watches_2", data.item.metadatas.variationId, true)
            end
            lastMetaMontre = data.item.metadatas
            clothes.montre = {
                name = data.item.name,
                quantity = 1
            }
            p:saveSkin()
        else
            if p:skin().sex == 1 then
                TriggerEvent("skinchanger:change", "watches_1", -1, true)
                TriggerEvent("skinchanger:change", "watches_2", 0, true)
            else
                TriggerEvent("skinchanger:change", "watches_1", -1, true)
                TriggerEvent("skinchanger:change", "watches_2", 0, true)

            end
            p:saveSkin()
            lastMetaMontre = {}
            clothes.montre = nil
        end
    end
    if data.item.name == "bracelet" then
        if json.encode(data.item.metadatas) ~= json.encode(lastMetaBracelet) then
            if data.item.metadatas.drawableId ~= nil and data.item.metadatas.variationId == nil then
                p:setCloth("bracelets_1", data.item.metadatas.drawableId, true)
                p:setCloth("bracelets_2", -1, true)
            elseif data.item.metadatas.variationId ~= nil and data.item.metadatas.drawableId ~= nil then
                p:setCloth("bracelets_1", data.item.metadatas.drawableId, true)
                p:setCloth("bracelets_2", data.item.metadatas.variationId, true)
            end
            lastMetaBracelet = data.item.metadatas
            clothes.bracelet = {
                name = data.item.name,
                quantity = 1
            }
            p:saveSkin()
        else
            if p:skin().sex == 1 then
                TriggerEvent("skinchanger:change", "bracelets_1", -1, true)
                TriggerEvent("skinchanger:change", "bracelets_2", 0, true)
            else
                TriggerEvent("skinchanger:change", "bracelets_1", -1, true)
                TriggerEvent("skinchanger:change", "bracelets_2", 0, true)

            end
            p:saveSkin()
            lastMetaBracelet = {}
            clothes.bracelet = nil
        end
    end
    if data.item.name == "bouclesoreilles" then
        if json.encode(data.item.metadatas) ~= json.encode(lastMetaBoucles) then
            if data.item.metadatas.drawableId ~= nil and data.item.metadatas.variationId == nil then
                p:setCloth("ears_1", data.item.metadatas.drawableId, true)
                p:setCloth("ears_2", -1, true)
            elseif data.item.metadatas.variationId ~= nil and data.item.metadatas.drawableId ~= nil then
                p:setCloth("ears_1", data.item.metadatas.drawableId, true)
                p:setCloth("ears_2", data.item.metadatas.variationId, true)
            end
            lastMetaBoucles = data.item.metadatas
            clothes.bouclesoreilles = {
                name = data.item.name,
                quantity = 1
            }
            p:saveSkin()
        else
            if p:skin().sex == 1 then
                TriggerEvent("skinchanger:change", "ears_1", -1, true)
                TriggerEvent("skinchanger:change", "ears_2", 0, true)
            else
                TriggerEvent("skinchanger:change", "ears_1", -1, true)
                TriggerEvent("skinchanger:change", "ears_2", 0, true)

            end
            p:saveSkin()
            lastMetaBoucles = {}
            clothes.bouclesoreilles = nil
        end
    end
    if data.item.name == "collier" then
        if json.encode(data.item.metadatas) ~= json.encode(lastMetaCollier) then
            if data.item.metadatas.drawableId ~= nil and data.item.metadatas.variationId == nil then
                p:setCloth("chain_1", data.item.metadatas.drawableId, true)
                p:setCloth("chain_2", -1, true)
            elseif data.item.metadatas.variationId ~= nil and data.item.metadatas.drawableId ~= nil then
                p:setCloth("chain_1", data.item.metadatas.drawableId, true)
                p:setCloth("chain_2", data.item.metadatas.variationId, true)
            end
            lastMetaCollier = data.item.metadatas
            clothes.collier = {
                name = data.item.name,
                quantity = 1
            }
            p:saveSkin()
        else
            if p:skin().sex == 1 then
                TriggerEvent("skinchanger:change", "chain_1", 0, true)
                TriggerEvent("skinchanger:change", "chain_2", 0, true)
            else
                TriggerEvent("skinchanger:change", "chain_1", 0, true)
                TriggerEvent("skinchanger:change", "chain_2", 0, true)

            end
            p:saveSkin()
            lastMetaCollier = {}
            clothes.collier = nil
        end
    end
    if data.item.name == "hat" then
        if not IsPedInAnyVehicle(PlayerPedId()) then
            p:PlayAnim("clothingspecs", "try_glasses_negative_c", 51)
            Wait(1000)
            if IsEntityPlayingAnim(PlayerPedId(), "clothingspecs", "try_glasses_negative_c", 51) then 
                StopAnimTask(PlayerPedId(), "clothingspecs", "try_glasses_negative_c", 1.0)
            end
        end
        if json.encode(data.item.metadatas) ~= json.encode(lastMetahat) then

            if data.item.metadatas.drawableId ~= nil and data.item.metadatas.variationId == nil then
                p:setCloth("helmet_1", data.item.metadatas.drawableId, true)
                p:setCloth("helmet_2", -1, true)
            elseif data.item.metadatas.variationId ~= nil and data.item.metadatas.drawableId ~= nil then

                p:setCloth("helmet_1", data.item.metadatas.drawableId, true)
                p:setCloth("helmet_2", data.item.metadatas.variationId, true)
            end
            p:saveSkin()
            lastMetahat = data.item.metadatas
            clothes.hat = {
                name = data.item.name,
                quantity = 1
            }
        else
            if not p:isMale() then
                TriggerEvent("skinchanger:change", "helmet_1", -1, true)
                TriggerEvent("skinchanger:change", "helmet_2", -1, true)
            else
                TriggerEvent("skinchanger:change", "helmet_1", -1, true)
                TriggerEvent("skinchanger:change", "helmet_2", -1, true)
            end
            lastMetahat = {}
            clothes.hat = nil
            p:saveSkin()
        end
    end
    if data.item.name == "access" then
        if data.item.metadatas.name ~= nil and string.find(data.item.metadatas.name, "badge") ~= nil then
            if json.encode(data.item.metadatas) ~= json.encode(lastMetaDecals) then
                if data.item.metadatas.drawableId ~= nil and data.item.metadatas.variationId == nil then
                    p:setCloth("decals_1", data.item.metadatas.drawableId, true)
                    p:setCloth("decals_2", -1, true)

                elseif data.item.metadatas.variationId ~= nil and data.item.metadatas.drawableId ~= nil then
                    p:setCloth("decals_1", data.item.metadatas.drawableId, true)
                    p:setCloth("decals_2", data.item.metadatas.variationId, true)
                end
                lastMetaDecals = data.item.metadatas
                p:saveSkin()
            else
                if p:isMale() then
                    TriggerEvent("skinchanger:change", "decals_1", 0, true)
                    TriggerEvent("skinchanger:change", "decals_2", -1, true)
                    -- TriggerEvent("skinchanger:change", "chain_1", -1)
                    -- TriggerEvent("skinchanger:change", "chain_2", -1)
                else
                    -- TriggerEvent("skinchanger:change", "chain_1", -1)
                    -- TriggerEvent("skinchanger:change", "chain_2", -1)
                    TriggerEvent("skinchanger:change", "decals_1", -1, true)
                    TriggerEvent("skinchanger:change", "decals_2", -1, true)
                end
                p:saveSkin()
                lastMetaDecals = {}
            end
        end
        if data.item.metadatas.name ~= nil and string.find(data.item.metadatas.name, "chaine") ~= nil then
            if json.encode(data.item.metadatas) ~= json.encode(lastMetaChain) then
                if data.item.metadatas.drawableId ~= nil and data.item.metadatas.variationId == nil then
                    p:setCloth("chain_1", data.item.metadatas.drawableId, true)
                    p:setCloth("chain_2", -1, true)

                elseif data.item.metadatas.variationId ~= nil and data.item.metadatas.drawableId ~= nil then
                    p:setCloth("chain_1", data.item.metadatas.drawableId, true)
                    p:setCloth("chain_2", data.item.metadatas.variationId, true)
                end
                lastMetaChain = data.item.metadatas
                p:saveSkin()
            else
                if p:isMale() then
                    TriggerEvent("skinchanger:change", "chain_1", -1, true)
                    TriggerEvent("skinchanger:change", "chain_2", -1, true)
                else
                    TriggerEvent("skinchanger:change", "chain_1", -1, true)
                    TriggerEvent("skinchanger:change", "chain_2", -1, true)
                end
                lastMetaChain = {}
            end
        end

        if data.item.metadatas.name ~= nil and string.find(data.item.metadatas.name, "sac") ~= nil then
            if json.encode(data.item.metadatas) ~= json.encode(lastMetaBags) then
                if data.item.metadatas.drawableId ~= nil and data.item.metadatas.variationId == nil then
                    p:setCloth("bags_1", data.item.metadatas.drawableId, true)
                    p:setCloth("bags_2", -1, true)

                elseif data.item.metadatas.variationId ~= nil and data.item.metadatas.drawableId ~= nil then
                    p:setCloth("bags_1", data.item.metadatas.drawableId, true)
                    p:setCloth("bags_2", data.item.metadatas.variationId, true)
                end
                lastMetaBags = data.item.metadatas
                p:saveSkin()
            else
                if p:isMale() then
                    TriggerEvent("skinchanger:change", "bags_1", -1, true)
                    TriggerEvent("skinchanger:change", "bags_2", -1, true)
                else
                    TriggerEvent("skinchanger:change", "bags_1", -1, true)
                    TriggerEvent("skinchanger:change", "bags_2", -1, true)
                end
                lastMetaBags = {}
                p:saveSkin()
            end
        end
        clothes.access = {
            name = data.item.name,
            quantity = 1
        }

    end
    if data.item.name == "glasses" then
        if not IsPedInAnyVehicle(PlayerPedId()) then
            p:PlayAnim("clothingspecs", "try_glasses_negative_b", 51)
            Wait(1000)
            if IsEntityPlayingAnim(PlayerPedId(), "clothingspecs", "try_glasses_negative_b", 51) then 
                StopAnimTask(PlayerPedId(), "clothingspecs", "try_glasses_negative_b", 1.0)
            end
        end
        if json.encode(data.item.metadatas) ~= json.encode(lastMetaGlasses) then
            if data.item.metadatas.drawableId ~= nil and data.item.metadatas.variationId == nil then
                p:setCloth("glasses_1", data.item.metadatas.drawableId, true)
                p:setCloth("glasses_2", -1, true)

            elseif data.item.metadatas.variationId ~= nil and data.item.metadatas.drawableId ~= nil then
                p:setCloth("glasses_1", data.item.metadatas.drawableId, true)
                p:setCloth("glasses_2", data.item.metadatas.variationId, true)
            end
            p:saveSkin()

            lastMetaGlasses = data.item.metadatas
            clothes.glasses = {
                name = data.item.name,
                quantity = 1
            }
        else
            if p:isMale() then
                TriggerEvent("skinchanger:change", "glasses_1", -1, true)
            else
                TriggerEvent("skinchanger:change", "glasses_1", 12, true)
            end
            p:saveSkin()
            lastMetaGlasses = {}
            clothes.glasses = nil
        end

    end

    if data.item.name == "tshirt" then
        if not IsPedInAnyVehicle(PlayerPedId()) then
            p:PlayAnim("clothingtie", "try_tie_negative_a", 51)
            Wait(1000)
            if IsEntityPlayingAnim(PlayerPedId(), "clothingtie", "try_tie_negative_a", 51) then 
                StopAnimTask(PlayerPedId(), "clothingtie", "try_tie_negative_a", 1.0)
            end
        end
        if json.encode(data.item.metadatas) ~= json.encode(lastMetaTshirt) then
            if data.item.metadatas.variationTorsoId == nil then
                data.item.metadatas.variationTorsoId = 0
            elseif data.item.metadatas.variationTshirtId == nil then
                data.item.metadatas.variationTshirtId = 0
            elseif data.item.metadatas.variationArmsId == nil then
                data.item.metadatas.variationArmsId = 0
            end
            lastMetaTshirt = data.item.metadatas
            clothes.tshirt = {
                name = data.item.name,
                quantity = 1
            }
            p:setCloth("torso_1", data.item.metadatas.drawableTorsoId, true)
            p:setCloth("torso_2", data.item.metadatas.variationTorsoId, true)
            p:setCloth("tshirt_1", data.item.metadatas.drawableTshirtId, true)
            p:setCloth("tshirt_2", data.item.metadatas.variationTshirtId, true)
            p:setCloth("arms", data.item.metadatas.drawableArmsId, true)
            p:setCloth("arms_2", data.item.metadatas.variationArmsId, true)
            p:saveSkin()

        else
            lastMetaTshirt = {}
            clothes.tshirt = nil
            if not p:isMale() then
                TriggerEvent("skinchanger:change", "arms", 15, true)
                TriggerEvent("skinchanger:change", "arms_2", 0, true)
                TriggerEvent("skinchanger:change", "torso_1", 15, true)
                TriggerEvent("skinchanger:change", "torso_2", 0, true)
                TriggerEvent("skinchanger:change", "tshirt_1", 15, true)
                TriggerEvent("skinchanger:change", "tshirt_2", 0, true)
            else
                TriggerEvent("skinchanger:change", "arms", 15, true)
                TriggerEvent("skinchanger:change", "arms_2", 0, true)
                TriggerEvent("skinchanger:change", "torso_1", 15, true)
                TriggerEvent("skinchanger:change", "torso_2", 0, true)
                TriggerEvent("skinchanger:change", "tshirt_1", 15, true)
                TriggerEvent("skinchanger:change", "tshirt_2", 0, true)
            end
            p:saveSkin()
        end
    end
    if data.item.name == "ptshirt" then
        SetPedComponentVariation(PlayerPedId(), 3, data.item.metadatas.drawableId, data.item.metadatas.variationId)  
    end
    if data.item.name == "ppant" then
        SetPedComponentVariation(PlayerPedId(), 4, data.item.metadatas.drawableId, data.item.metadatas.variationId)  
    end
    if data.item.name == "phat" then
        SetPedPropIndex(PlayerPedId(), 0, data.item.metadatas.drawableId, data.item.metadatas.variationId, true)
    end
    if data.item.name == "pglasses" then
        SetPedPropIndex(PlayerPedId(), 1, data.item.metadatas.drawableId, data.item.metadatas.variationId, true)
    end
    if data.item.name == "paccs" then
        SetPedPropIndex(PlayerPedId(), 2, data.item.metadatas.drawableId, data.item.metadatas.variationId, true)
    end
    if not next(currentOutfit) then
        p:saveSkin()
    end
    SendNUIMessage({
        type = "updateInventory",
        data = {
            items = items,
            clothes = clothes,
            weapons = Weapons,
            hud = {
                hunger = p:getStatus().hunger / 100,
                thirst = p:getStatus().thirst / 100,
                maxWeight = 35.0
            }
        }
    })
end)

RegisterNUICallback('inventory-remove-clothe', function(data, cb)
    if data.item.name == "tshirt" then
        clothes.tshirt = nil
        if p:isMale() then
            TriggerEvent("skinchanger:change", "arms", 15, true)
            TriggerEvent("skinchanger:change", "arms_2", 0, true)
            TriggerEvent("skinchanger:change", "torso_1", 15, true)
            TriggerEvent("skinchanger:change", "torso_2", 0, true)
            TriggerEvent("skinchanger:change", "tshirt_1", 15, true)
            TriggerEvent("skinchanger:change", "tshirt_2", 0, true)
        else
            TriggerEvent("skinchanger:change", "arms", 15, true)
            TriggerEvent("skinchanger:change", "arms_2", 0, true)
            TriggerEvent("skinchanger:change", "torso_1", 15, true)
            TriggerEvent("skinchanger:change", "torso_2", 0, true)
            TriggerEvent("skinchanger:change", "tshirt_1", 15, true)
            TriggerEvent("skinchanger:change", "tshirt_2", 0, true)
        end
        p:saveSkin()

    end
    if data.item.name == "pant" then
        clothes.pant = nil
        if p:isMale() then
            TriggerEvent("skinchanger:change", "pants_1", 61, true)
            TriggerEvent("skinchanger:change", "pants_2", 0, true)
        else
            TriggerEvent("skinchanger:change", "pants_1", 15, true)
            TriggerEvent("skinchanger:change", "pants_2", 0, true)
        end
        p:saveSkin()

    end
    if data.item.name == "feet" then
        clothes.feet = nil
        if p:isMale() then
            TriggerEvent("skinchanger:change", "shoes_1", 34, true)
            TriggerEvent("skinchanger:change", "shoes_2", 0, true)
        else
            TriggerEvent("skinchanger:change", "shoes_1", 35, true)
            TriggerEvent("skinchanger:change", "shoes_2", 0, true)
        end
        p:saveSkin()

    end
    if data.item.name == "bague" then
        clothes.bague = nil
        if p:isMale() then
            TriggerEvent("skinchanger:change", "bproof_1", 0, true)
            TriggerEvent("skinchanger:change", "bproof_2", 0, true)
        else
            TriggerEvent("skinchanger:change", "bproof_1", 0, true)
            TriggerEvent("skinchanger:change", "bproof_2", 0, true)
        end
        p:saveSkin()
    end
    if data.item.name == "ongle" then
        clothes.bague = nil
        if p:isMale() then
            TriggerEvent("skinchanger:change", "decals_1", 0, true)
            TriggerEvent("skinchanger:change", "decals_2", 0, true)
        else
            TriggerEvent("skinchanger:change", "decals_1", 0, true)
            TriggerEvent("skinchanger:change", "decals_2", 0, true)
        end
        p:saveSkin()
    end
    if data.item.name == "piercing" then
        clothes.bague = nil
        if p:isMale() then
            TriggerEvent("skinchanger:change", "decals_1", 0, true)
            TriggerEvent("skinchanger:change", "decals_2", 0, true)
        else
            TriggerEvent("skinchanger:change", "decals_1", 0, true)
            TriggerEvent("skinchanger:change", "decals_2", 0, true)
        end
        p:saveSkin()
    end
    if data.item.name == "montre" then
        clothes.montre = nil
        if p:isMale() then
            TriggerEvent("skinchanger:change", "watches_1", 0, true)
            TriggerEvent("skinchanger:change", "watches_2", 0, true)
        else
            TriggerEvent("skinchanger:change", "watches_1", 0, true)
            TriggerEvent("skinchanger:change", "watches_2", 0, true)
        end
        p:saveSkin()

    end
    if data.item.name == "glasses" then
        clothes.glasses = nil
        if p:isMale() then
            TriggerEvent("skinchanger:change", "glasses_1", -1, true)
        else
            TriggerEvent("skinchanger:change", "glasses_1", 12, true)
        end
        p:saveSkin()

    end
    if data.item.name == "access" then
        clothes.access = nil
        if p:isMale() then
            TriggerEvent("skinchanger:change", "decals_1", 0, true)
            TriggerEvent("skinchanger:change", "decals_2", -1, true)
            TriggerEvent("skinchanger:change", "chain_1", -1, true)
            TriggerEvent("skinchanger:change", "chain_2", -1, true)
            TriggerEvent("skinchanger:change", "bags_1", -1, true)
            TriggerEvent("skinchanger:change", "bags_2", -1, true)
        else
            TriggerEvent("skinchanger:change", "bags_1", -1, true)
            TriggerEvent("skinchanger:change", "bags_2", -1, true)
            TriggerEvent("skinchanger:change", "chain_1", -1, true)
            TriggerEvent("skinchanger:change", "chain_2", -1, true)
            TriggerEvent("skinchanger:change", "decals_1", -1, true)
            TriggerEvent("skinchanger:change", "decals_2", -1, true)
        end
        p:saveSkin()
    end
    if data.item.name == "hat" then
        clothes.hat = nil
        if not p:isMale() then
            TriggerEvent("skinchanger:change", "helmet_1", -1, true)
            TriggerEvent("skinchanger:change", "helmet_2", -1, true)
        else
            TriggerEvent("skinchanger:change", "helmet_1", -1, true)
            TriggerEvent("skinchanger:change", "helmet_2", -1, true)
        end
        p:saveSkin()
    end
    if not next(currentOutfit) then
        p:saveSkin()
    end
    SendNUIMessage({
        type = "updateInventory",
        data = {
            items = items,
            clothes = clothes,
            weapons = Weapons,
            hud = {
                hunger = p:getStatus().hunger / 100,
                thirst = p:getStatus().thirst / 100,
                maxWeight = 35.0
            }
        }
    })
end)

RegisterNUICallback('inventory-bind-weapon', function(data, cb)
    if Weapons[data.bind + 1] == nil then
        Weapons[data.bind + 1] = data.item

    else
        Weapons[data.bind + 1] = data.item
    end

    TriggerServerEvent("core:SetWeaponSave", token, Weapons)
    SendNUIMessage({
        type = "updateInventory",
        data = {
            items = items,
            clothes = clothes,
            weapons = Weapons,
            hud = {
                hunger = p:getStatus().hunger / 100,
                thirst = p:getStatus().thirst / 100,
                maxWeight = 35.0
            }
        }
    })

end)

RegisterNUICallback('inventory-unbind-weapon', function(data, cb)
    if data.bind ~= nil then
        if data.item ~= nil then
            RemoveWeaponFromPed(PlayerPedId(), GetHashKey(data.item.name))
            Weapons[data.bind + 1] = nil
        end
    end
    TriggerServerEvent("core:SetWeaponSave", token, Weapons)

    SendNUIMessage({
        type = "updateInventory",
        data = {
            items = items,
            clothes = clothes,
            weapons = Weapons,
            hud = {
                hunger = p:getStatus().hunger / 100,
                thirst = p:getStatus().thirst / 100,
                maxWeight = 35.0
            }
        }
    })

end)

RegisterNUICallback("focusOut", function(data, cb)
    if open then
        open = false
        EnableControlAction(0, 24, true)
        EnableControlAction(0, 25, true)
        EnableControlAction(0, 1, true)
        EnableControlAction(0, 2, true)
        EnableControlAction(0, 142, true)
        EnableControlAction(0, 18, true)
        EnableControlAction(0, 322, true)
        EnableControlAction(0, 106, true)
        openRadarProperly()
    end
    cb({})
end)
IndexAmmooooooo = nil



local ComponentsWeapon = {
    [GetHashKey('WEAPON_PISTOL')] = { wpnname = "weapon_pistol", suppressor = GetHashKey('component_at_pi_supp_02'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE') },
    [GetHashKey('WEAPON_PISTOL50')] = { wpnname = "weapon_pistol50", suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE') },
    [GetHashKey('WEAPON_COMBATPISTOL')] = { wpnname = "weapon_combatpistol", suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = nil },
    [GetHashKey('WEAPON_APPISTOL')] = { wpnname = "weapon_appistol", suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE') },
    [GetHashKey('WEAPON_HEAVYPISTOL')] = { wpnname = "weapon_heavypistol", suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE') },
    [GetHashKey('WEAPON_VINTAGEPISTOL')] = { wpnname = "weapon_vintagepistol", suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), flashlight = nil, grip = nil, skin = nil },
    [GetHashKey('WEAPON_SMG')] = { wpnname = "weapon_smg", suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_SMG_VARMOD_LUXE') },
    [GetHashKey('WEAPON_MICROSMG')] = { wpnname = "weapon_microsmg", suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE') },
    [GetHashKey('WEAPON_ASSAULTSMG')] = { wpnname = "weapon_assaultsmg", suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = nil, skin = nil },
    [GetHashKey('WEAPON_ASSAULTRIFLE')] = { wpnname = "weapon_assaultrifle", suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE') },
    [GetHashKey('WEAPON_CARBINERIFLE')] = { wpnname = "weapon_carbinerifle", suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE') },
    [GetHashKey('WEAPON_ADVANCEDRIFLE')] = { wpnname = "weapon_advancedrifle", suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE') },
    [GetHashKey('WEAPON_SPECIALCARBINE')] = { wpnname = "weapon_specialcarbine", suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_BULLPUPRIFLE')] = { wpnname = "weapon_bullpuprifle", suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_ASSAULTSHOTGUN')] = { wpnname = "weapon_assaultshotgun", suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_HEAVYSHOTGUN')] = { wpnname = "weapon_heavyshotgun", suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_BULLPUPSHOTGUN')] = { wpnname = "weapon_bullpupshotgun", suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_PUMPSHOTGUN')] = { wpnname = "weapon_pumpshotgun", suppressor = GetHashKey('COMPONENT_AT_SR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = nil, skin = nil },
    [GetHashKey('WEAPON_SNIPERRIFLE')] = { wpnname = "weapon_sniperrifle", suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = nil, grip = nil, skin = nil },
}


function EquipWeapon(index)
    local weapon = Weapons[index + 1]
    IndexAmmooooooo = index
    if weapon then
        LoadAnimDict("reaction@intimidation@1h")
        LoadAnimDict("weapons@pistol_1h@gang")
        LoadAnimDict("rcmjosh4")
        LoadAnimDict("reaction@intimidation@cop@unarmed")
        LoadAnimDict("weapons@pistol@")
        if weaponOut then
            if weapon.name == "gadget_parachute" then
                -- ShowNotification("Vous avez rangé votre parachute")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'JAUNE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Vous avez ~s rangé ~c votre parachute"
                })

                RemoveAllPedWeapons(p:ped(), 1)
                SetCurrentPedWeapon(p:ped(), 'WEAPON_UNARMED', true)
                weaponOut = false
            else
                if policeDuty or lssdDuty or usssDuty or boiDuty or bpDuty then
                    TaskPlayAnim(p:ped(), "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
                    Wait(500)
                    TaskPlayAnim(p:ped(), "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
                    Wait(60)
                    ClearPedTasks(p:ped())
                else
                    TaskPlayAnim(p:ped(), "reaction@intimidation@1h", "outro", 8.0, 3.0, -1, 50, 0, 0, 0.125, 0)
                    local timer = GetGameTimer() + 1500
                    while GetGameTimer() < timer do
                        DisablePlayerFiring(p:ped(), true)
                        Wait(0)
                    end
                    ClearPedTasks(p:ped())
                end
                if GetHashKey(weapon.name) == GetSelectedPedWeapon(p:ped()) then
                    Weapons[IndexAmmooooooo + 1].metadatas.ammo = GetAmmoInPedWeapon(p:ped(), weapon.name)
                end
                for k, v in pairs(Weapons) do
                    if GetHashKey(Weapons[k].name) == GetSelectedPedWeapon(p:ped()) then
                        Weapons[k].metadatas.ammo = GetAmmoInPedWeapon(p:ped(), GetHashKey(Weapons[k].name))
                    end
                end
                SetCurrentPedWeapon(p:ped(), 'WEAPON_UNARMED', true)
                weaponOut = false
                for k, v in pairs(p:getInventaire()) do
                    if v.name == Weapons[IndexAmmooooooo + 1].name then
                        v.metadatas.ammo = Weapons[IndexAmmooooooo + 1].metadatas.ammo
                    end
                end
                RemoveAllPedWeapons(p:ped(), 1)
                TriggerServerEvent("core:SetWeaponSave", token, Weapons)
                TriggerSecurEvent("core:RefreshInventory", nil, p:getInventaire())
            end
        else
            if weapon.name == "gadget_parachute" then
                TriggerServerEvent("TREFSDFD5156FD", "AESDAZDS", 2000)
                -- ShowNotification("Vous avez équipé votre parachute")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'JAUNE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Vous avez ~s équipé ~c votre parachute"
                })

                GiveWeaponToPed(p:ped(), GetHashKey(weapon.name), 20, 0, true)
                SetCurrentPedWeapon(p:ped(), weapon.name, true)
                weaponOut = true
            else
                if policeDuty or lssdDuty or usssDuty or boiDuty or bpDuty then
                    TaskPlayAnim(p:ped(), "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
                    Wait(100)
                    SetPedCurrentWeaponVisible(p:ped(), 1, 1, 1, 1)
                    TaskPlayAnim(p:ped(), "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
                    Wait(400)
                    ClearPedTasks(p:ped())
                else
                    TaskPlayAnim(p:ped(), "reaction@intimidation@1h", "intro", 5.0, 1.0, -1, 50, 0, 0, 0, 0 )
                    DisablePlayerFiring(p:ped(), true)
                    Wait(1250)
                    SetPedCurrentWeaponVisible(p:ped(), 1, 1, 1, 1)
                    DisablePlayerFiring(p:ped(), false)
                    ClearPedTasks(p:ped())
                end
                weaponOut = true
                local ammo = nil
                local saved = false
                Weapons = TriggerServerCallback("core:GetWeaponSave", token)
                ammo = Weapons[IndexAmmooooooo + 1].metadatas.ammo
                for key, value in pairs(p:getInventaire()) do
                    if value.name == Weapons[IndexAmmooooooo + 1].name and
                        Weapons[IndexAmmooooooo + 1].metadatas.renamed == value.metadatas.renamed then
                        if value.metadatas.ammo ~= nil and not true then
                            value.metadatas.ammo = ammo
                            saved = true
                        end
                        --[[ print("TEST 40 :)") ]]
                    end
                end
                local contains = false
                for k, v in pairs(throwableWeapons) do
                    if v == weapon.name then
                        contains = true
                    end
                end
                TriggerServerEvent("TREFSDFD5156FD", "AESDAZDS", 7000)
                if contains then
                    Weapons[IndexAmmooooooo + 1].metadatas.ammo = 1
                    GiveWeaponToPed(p:ped(), GetHashKey(weapon.name), 1, 0, true)
                    SetCurrentPedWeapon(p:ped(), weapon.name, true)
                    TriggerSecurEvent("core:RefreshInventory", nil, p:getInventaire())

                    for key, value in pairs(p:getWeapons()) do
                        if value.name == Weapons[IndexAmmooooooo + 1].name and
                            Weapons[IndexAmmooooooo + 1].metadatas.renamed == value.metadatas.renamed then    
                            if value.metadatas.suppressor and not nil then

                                local ComponentsType = "suppressor"
                                GiveWeaponComponentToPed(p:ped(), GetSelectedPedWeapon(p:ped()), ComponentsWeapon[GetSelectedPedWeapon(p:ped())][ComponentsType])
    
                                --[[ print('TEST SUPPRESSOR') ]]
                            end

                            if value.metadatas.flashlight and not nil then

                                local ComponentsType = "flashlight"

                                GiveWeaponComponentToPed(p:ped(), GetSelectedPedWeapon(p:ped()), ComponentsWeapon[GetSelectedPedWeapon(p:ped())][ComponentsType])
    
                                --[[ print('TEST FLASHLIGHT') ]]
                            end

                            if value.metadatas.grip and not nil then

                                local ComponentsType = "grip"

                                GiveWeaponComponentToPed(p:ped(), GetSelectedPedWeapon(p:ped()), ComponentsWeapon[GetSelectedPedWeapon(p:ped())][ComponentsType])
    
                                --[[ print('TEST GRIP') ]]
                            end
                        end
                    end

                else
                    if ammo ~= nil then
                        GiveWeaponToPed(p:ped(), GetHashKey(weapon.name), tonumber(ammo), 0, true)
                        SetCurrentPedWeapon(p:ped(), weapon.name, true)
                        TriggerSecurEvent("core:RefreshInventory", nil, p:getInventaire())
                        for key, value in pairs(p:getWeapons()) do
                            if value.name == Weapons[IndexAmmooooooo + 1].name and
                                Weapons[IndexAmmooooooo + 1].metadatas.renamed == value.metadatas.renamed then        
                                if value.metadatas.suppressor and not nil then

                                    local ComponentsType = "suppressor"
                                    GiveWeaponComponentToPed(p:ped(), GetSelectedPedWeapon(p:ped()), ComponentsWeapon[GetSelectedPedWeapon(p:ped())][ComponentsType])
        
                                    --[[ print('TEST SUPPRESSOR') ]]
                                end

                                if value.metadatas.flashlight and not nil then

                                    local ComponentsType = "flashlight"

                                    GiveWeaponComponentToPed(p:ped(), GetSelectedPedWeapon(p:ped()), ComponentsWeapon[GetSelectedPedWeapon(p:ped())][ComponentsType])
        
                                    --[[ print('TEST FLASHLIGHT') ]]
                                end

                                if value.metadatas.grip and not nil then

                                    local ComponentsType = "grip"

                                    GiveWeaponComponentToPed(p:ped(), GetSelectedPedWeapon(p:ped()), ComponentsWeapon[GetSelectedPedWeapon(p:ped())][ComponentsType])
        
                                    --[[ print('TEST GRIP') ]]
                                end
                            end
                        end
                    else
                        Weapons[IndexAmmooooooo + 1].metadatas.ammo = 30
                        GiveWeaponToPed(p:ped(), GetHashKey(weapon.name), 30, 0, true)
                        SetCurrentPedWeapon(p:ped(), weapon.name, true)
                        TriggerSecurEvent("core:RefreshInventory", nil, p:getInventaire())
                        for key, value in pairs(p:getWeapons()) do
                            if value.name == Weapons[IndexAmmooooooo + 1].name and
                                Weapons[IndexAmmooooooo + 1].metadatas.renamed == value.metadatas.renamed then        
                                if value.metadatas.suppressor and not nil then

                                    local ComponentsType = "suppressor"
                                    print('Inventory : '.. ComponentsWeapon[GetSelectedPedWeapon(p:ped())][ComponentsType])
                                    GiveWeaponComponentToPed(p:ped(), GetSelectedPedWeapon(p:ped()), ComponentsWeapon[GetSelectedPedWeapon(p:ped())][ComponentsType])
        
                                    --[[ print('TEST SUPPRESSOR') ]]
                                end

                                if value.metadatas.flashlight and not nil then

                                    local ComponentsType = "flashlight"

                                    print('Inventory : '.. ComponentsWeapon[GetSelectedPedWeapon(p:ped())][ComponentsType])

                                    GiveWeaponComponentToPed(p:ped(), GetSelectedPedWeapon(p:ped()), ComponentsWeapon[GetSelectedPedWeapon(p:ped())][ComponentsType])
        
                                    --[[ print('TEST FLASHLIGHT') ]]
                                end

                                if value.metadatas.grip and not nil then

                                    local ComponentsType = "grip"

                                    print('Inventory : '.. ComponentsWeapon[GetSelectedPedWeapon(p:ped())][ComponentsType])

                                    GiveWeaponComponentToPed(p:ped(), GetSelectedPedWeapon(p:ped()), ComponentsWeapon[GetSelectedPedWeapon(p:ped())][ComponentsType])
        
                                    --[[ print('TEST GRIP') ]]
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

CreateThread(function()
    while RegisterClientCallback == nil do
        Wait(1)
    end

    RegisterClientCallback("core:getAllClosestVeh", function()
        local vehicle, dst = GetClosestVehicle(p:pos())
        return vehicle, dst
    end)
end)

Keys.Register("TAB", "TAB", "Ouvrir l'inventaire", function()
    OpenInventory()
end)