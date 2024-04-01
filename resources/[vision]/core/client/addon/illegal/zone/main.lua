local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local zoneData = {}

local policeMans = 0
local lockedList = {}
local sold = false
local closestNPC = nil

local prices = {
    weed = function()
        return RealRandom(60, 70)
    end,
    heroine = function()
        return RealRandom(90, 100)
    end,
    coke = function()
        return RealRandom(110, 120)
    end,
    meth = function()
        return RealRandom(140, 160)
    end
}

local function sell_drug(drug)
    closeUI()
    local zoneId = GetZoneAtCoords(p:pos())
    zoneData = TriggerServerCallback("core:GetZoneDataDrugs", tostring(zoneId))
    Wait(300)
    local data = {}
    local crew = p:getCrew()
    local zoneName = GetNameOfZone(p:pos())
    if zoneData == nil then
        data[crew] = 1
        TriggerServerEvent("core:CreateZoneData", token, tostring(zoneId), zoneName, data)
    end
    Wait(500)
    zoneData = TriggerServerCallback("core:GetZoneDataDrugs", tostring(zoneId))
    data = zoneData.data
    local value = {}
    for key, values in pairs(data) do
        if key ~= "None" then
            table.insert(value, { name = key, v = values })
        end
    end
    table.sort(value, function(a, b) return a.v > b.v end)
    if value[1] ~= nil then
        if p:getCrew() == value[1].name then
            leader = true
        end
    end
    --Vente
    local ramdom = RealRandom(1, 4)
    if ramdom == 1 then                                  
        if coordsIsInSouth(p:pos()) then
            TriggerServerEvent('core:makeCall', "lspd", p:pos(), true, "Trafic de drogue", false, "illegal")
        else
            TriggerServerEvent('core:makeCall', "lssd", p:pos(), true, "Trafic de drogue", false, "illegal")
        end
        -- ShowNotification("Desolé je ne suis pas intéressé")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "Desolé je ne suis pas intéressé"
        })

        local closestNPCId = NetworkGetNetworkIdFromEntity(closestNPC)
        TriggerServerEvent("drug:pedLock", closestNPCId)
    else
        local closestNPCId = NetworkGetNetworkIdFromEntity(closestNPC)
        sold = false
        for k, v in pairs(lockedList) do
            if v == closestNPCId then
                sold = true
            end
        end
        TriggerServerEvent("drug:pedLock", closestNPCId)
        if sold then
            -- ShowNotification("Desolé je ne suis pas intéressé")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Desolé je ne suis pas intéressé"
            })
            
        else
            local selling = false

            local count = p:getItemCount(drug)

            if not count then
                if coordsIsInSouth(p:pos()) then
                    TriggerServerEvent('core:makeCall', "lspd", p:pos(), true, "Trafic de drogue", false, "illegal")
                else
                    TriggerServerEvent('core:makeCall', "lssd", p:pos(), true, "Trafic de drogue", false, "illegal")
                end
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Desolé je ne suis pas intéressé"
                })
                return
            end

            if count > 4 then
                count = 4
            end

            count = RealRandom(1, count)

            local price = prices[drug]()
            local total = count * price

            local totalPrice = price * count

            if leader then
                totalPrice = totalPrice * 1.07
            end

            AnimAndLoad(closestNPC)
            SellDrugs(drug, count, Round(totalPrice))
            selling = true

            if value[1] ~= nil then
                if p:getCrew() ~= value[1].name then
                    TriggerServerEvent("drugs:notifDrugs", value[1].name, zoneData.label)
                end
            end
        end
    end
end

function SellDrugs(drugs, count, price)
    local crew = p:getCrew()
    local zoneId = GetZoneAtCoords(p:pos())
    local zoneName = GetNameOfZone(p:pos())
    zoneData = TriggerServerCallback("core:GetZoneDataDrugs", tostring(zoneId))
    Wait(500)
    local data = {}
    if zoneData ~= nil then
        data = zoneData.data
        if data[crew] ~= nil then
            data[crew] = data[crew] + 1
            TriggerServerEvent("core:UpdateZoneDrugs", token, tostring(zoneId), zoneName, data)
            for key, value in pairs(p:getInventaire()) do
                if value.name == drugs then
                    TriggerServerEvent("core:RemoveItemToInventory", token, drugs, count, value.metadatas)
                    TriggerSecurGiveEvent("core:addItemToInventory", token, "money", price, {})
                    TriggerServerEvent("core:addCrewExp",p:getCrew(), 5, "sell Drugs")

                    --[[ Ancienne notification
                    -- ShowNotification("Vous avez vendu ~g~" .. count .. " " .. items[drugs].label .. "~s~ pour ~g~" ..
                        price .. "~s~$")
                    --]]

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'VERT',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous avez vendu ~s " .. count .. " " .. items[drugs].label .. "~c pour ~s " .. price .. "$"
                    })

                    return
                end
            end

        else
            data[crew] = 1
            TriggerServerEvent("core:UpdateZoneDrugs", token, tostring(zoneId), zoneName, data)
            for key, value in pairs(p:getInventaire()) do
                -- body
                if value.name == drugs then
                    TriggerServerEvent("core:RemoveItemToInventory", token, drugs, count, value.metadatas)
                    TriggerSecurGiveEvent("core:addItemToInventory", token, "money", price, {})
                    TriggerServerEvent("core:addCrewExp",p:getCrew(), count, "updtade zone")
                    
                    --[[ Ancienne notification
                    -- ShowNotification("Vous avez vendu ~g~" .. count .. " " .. items[drugs].label .. "~s~ pour ~g~" ..
                        price .. "~s~$")
                    --]]

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'VERT',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous avez vendu ~s " .. count .. " " .. items[drugs].label .. "~c pour ~s " .. price .. "$"
                    })

                    return
                end
            end


        end
    else
        data[crew] = 1
        TriggerServerEvent("core:CreateZoneData", token, tostring(zoneId), zoneName, data)
        for key, value in pairs(p:getInventaire()) do
            if value.name == drugs then
                TriggerServerEvent("core:RemoveItemToInventory", token, drugs, count, value.metadatas)
                TriggerSecurGiveEvent("core:addItemToInventory", token, "money", price, {})
                TriggerServerEvent("core:addCrewExp",p:getCrew(), count, "createzone")

                --[[ Ancienne notification
                -- ShowNotification("Vous avez vendu ~g~" ..
                    count .. " " .. items[drugs].label .. "~s~ pour ~g~" .. price .. "~s~$")
                --]]

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'VERT',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Vous avez vendu ~s " .. count .. " " .. items[drugs].label .. "~c pour ~s " .. price .. "$"
                })

                return
            end
        end
    end

end

function AnimAndLoad(closestNPC)
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'Progressbar',
        data = {
            text = "Vente en cours...",
            time = 4,
        }
    }))

    local coords = GetEntityCoords(GetPlayerPed(-1))
    TaskTurnPedToFaceEntity(closestNPC, p:ped(), -1)
    -- make the ped not flee
    SetPedFleeAttributes(closestNPC, 0, 0)
    TaskStandStill(closestNPC, 1000000)
    SetEntityAsMissionEntity(closestNPC)
    TriggerServerEvent('drug:SellDrugs')
    local pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.7, 0.0)
    local heading = GetEntityHeading(p:ped())
    SetEntityCoords(closestNPC, pos.x, pos.y, pos.z - 1)
    SetEntityHeading(closestNPC, heading - 180.0)
    FreezeEntityPosition(closestNPC, true)
    FreezeEntityPosition(p:ped(), true)

    Modules.UI.RealWait(500)
    -- anim
    local pid = p:ped()
    RequestAnimDict("mp_ped_interaction")
    while not HasAnimDictLoaded("mp_ped_interaction") do Wait(0) end

    TaskPlayAnim(closestNPC, "mp_ped_interaction", "handshake_guy_b", 2.0, 2.0, -1, 120, 0, false, false, false)
    TaskPlayAnim(pid, "mp_ped_interaction", "handshake_guy_a", 2.0, 2.0, -1, 120, 0, false, false, false)
    Modules.UI.RealWait(4000)
    StopAnimTask(pid, "mp_ped_interaction", "handshake_guy_b", 1.0)
    StopAnimTask(closestNPC, "mp_ped_interaction", "handshake_guy_a", 1.0)
    FreezeEntityPosition(closestNPC, false)
    TaskWanderStandard(closestNPC, 10.0, 10)
    FreezeEntityPosition(p:ped(), false)
    SetEntityAsNoLongerNeeded(closestNPC)

end

local function OpenDrugsRadial()
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'RadialMenu',
        data = { elements = {
            {
                name = "WEED",
                icon = "",
                action = "sell_weed"
            }, 
            {
                name = "METH",
                icon = "",
                action = "sell_meth"
            },
            {
                name = "COKE",
                icon = "",
                action = "sell_coke"
            },
            {
                name = "HEROINE",
                icon = "",
                action = "sell_heroine"
            }
        }, title = "DROGUES" }
    }));
end

function sell_weed()
    sell_drug("weed")
end

function sell_meth()
    sell_drug("meth")
end

function sell_coke()
    sell_drug("coke")
end

function sell_heroine()
    sell_drug("heroine")
end

local function HaveDrugs()
    if p:haveItem("weed") then
        return true
    elseif p:haveItem("coke") then
        return true
    elseif p:haveItem("heroine") then
        return true
    elseif p:haveItem("meth") then
        return true
    else
        return false
    end
end

local function getNumberOfCopsInDuty()
    local service = "lssd"
    if coordsIsInSouth(p:pos()) then
        service = "lspd"
    end
    return TriggerServerCallback("core:getNumberOfDuty", token, service)
end

CreateThread(function()
    while loaded do Wait(1) end
    while p == nil do Wait(1) end

    local leader = false
    while true do
        local pNear = false
        closestNPC = GetClosestNPC(10.0)
        local pedPos = GetEntityCoords(closestNPC)

        if pedPos ~= nil then
            if #(p:pos() - vector3(pedPos.x, pedPos.y, pedPos.z)) <= 2 then
                if IsControlJustPressed(0, 38) then
                    if IsEntityPositionFrozen(closestNPC) or
                        IsPedModel(closestNPC, GetHashKey("mp_m_shopkeep_01")) or
                        IsPedModel(closestNPC, GetHashKey("mp_m_freemode_01")) or
                        IsPedModel(closestNPC, GetHashKey("mp_f_freemode_01"))
                    then
                        --exports['vNotif']:createNotification({
                        --    type = 'ROUGE',
                        --    content = "Vous ne pouvez pas vendre de drogues à cette personne"
                        --})
                    elseif getNumberOfCopsInDuty() < 2 then
                        exports['vNotif']:createNotification({
                            type = 'ROUGE',
                            content = "Il n'y a pas assez de policiers en service"
                        })
                    elseif IsPedInAnyVehicle(PlayerPedId(), true) then
                        exports['vNotif']:createNotification({
                            type = 'ROUGE',
                            content = "Vous ne pouvez pas vendre de drogues en étant dans un véhicule"
                        })
                    elseif IsPedDeadOrDying(closestNPC) then
                        exports['vNotif']:createNotification({
                            type = 'ROUGE',
                            content = "Vous ne pouvez pas vendre de drogues à un mort"
                        })
                    elseif IsPedInAnyVehicle(closestNPC) then
                        exports['vNotif']:createNotification({
                            type = 'ROUGE',
                            content = "Vous ne pouvez pas vendre de drogues à quelqu'un dans un véhicule"
                        })
                    elseif IsPedAPlayer(closestNPC) then
                        exports['vNotif']:createNotification({
                            type = 'ROUGE',
                            content = "Vous ne pouvez pas vendre de drogues à un joueur"
                        })
                    else
                        OpenDrugsRadial()
                    end

                end
                pNear = true
            end
        else
            Wait(500)
        end
        if pNear then
            Wait(1)
        else
            Wait(300)
        end
    end
end)

local open = false
local main = RageUI.CreateMenu("Zone", "Zone")

main.Closed = function()
    open = false
    RageUI.Visible(main, false)
end

function OpenZoneMenu()
    if open then
        open = false
        RageUI.Visible(main, false)
        return
    else
        open = true
        local leader = false
        RageUI.Visible(main, true)
        local zoneId = GetZoneAtCoords(p:pos())
        zoneData = TriggerServerCallback("core:GetZoneDataDrugs", tostring(zoneId))
        local data = {}
        if zoneData == nil then
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Aucune zone n'existe à cet emplacement, reprenez-la en vendant ici."
            }) 
            return 
        end
        data = zoneData.data
        local label = zoneData.label
        local value = {}
        for key, values in pairs(data) do
            if key ~= "None" then
                table.insert(value, { name = key, v = values })
            end
        end
        table.sort(value, function(a, b) return a.v > b.v end)
        local crewInfo, crewMembers, crewGrade = TriggerServerCallback("core:getCrewInfo", token, p:getCrew())

        if p:getCrew() == value[1].name and p:getCrew() ~= "None" then
            if crewInfo.rank == 1 then
                leader = true
            end
        end
        CreateThread(function()
            while open do
                RageUI.IsVisible(main, function()
                    RageUI.Separator("Zone: ~b~ " .. label)
                    for _, v in pairs(value) do
                        if _ == 1 then
                            RageUI.Button(v.name .. ": " .. v.v .. " points", nil, { RightLabel = "~o~LEADER" }, true,
                                {})

                        else
                            RageUI.Button(v.name .. ": " .. v.v .. " points", nil, {}, true, {})
                        end
                    end
                    if leader then
                        RageUI.Separator("GESTION")
                        RageUI.Button("Changer le nom de la zone", nil, {}, true, {
                            onSelected = function()
                                local name = KeyboardImput("Nom")
                                if name ~= nil then
                                    label = name

                                    local changed = TriggerServerCallback("core:ChangeNameZone", zoneId, name)
                                    if changed then
                                        -- ShowNotification("Changement fais avec succes")

                                        -- New notif
                                        exports['vNotif']:createNotification({
                                            type = 'VERT',
                                            -- duration = 5, -- In seconds, default:  4
                                            content = "Changement fais avec ~s succès"
                                        })

                                    else
                                        -- ShowNotification("Erreur lors du changement")

                                        -- New notif
                                        exports['vNotif']:createNotification({
                                            type = 'ROUGE',
                                            -- duration = 5, -- In seconds, default:  4
                                            content = "~s Erreur lors du changement"
                                        })

                                    end
                                end
                            end
                        })
                    end

                end)

                Wait(1)
            end
        end)
    end
end

RegisterCommand('zones', function()
    OpenZoneMenu()
end, false)

RegisterNetEvent("drug:pedLock", function(newLockedPed)
    table.insert(lockedList, newLockedPed)
end)

RegisterNetEvent("drug:loadPedLock", function(lockList)
    lockedList = lockList
end)

RegisterNetEvent("drugs:notifDrugs")
AddEventHandler("drugs:notifDrugs", function(lieux)
    -- ShowNotification("Quelqu'un est entrain de vendre sur votre zones (" .. lieux .. ")")

    -- New notif
    exports['vNotif']:createNotification({
        type = 'JAUNE',
        -- duration = 5, -- In seconds, default:  4
        content = "Quelqu'un est entrain de vendre sur votre zone ~s (" .. lieux .. ")"
    })

end)
