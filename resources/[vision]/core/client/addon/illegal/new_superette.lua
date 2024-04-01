local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local isPlayerAlrdyBraked = false
local policemanCheck = false
local totalMoney = 0
local timer = 0
local policeMans = 0
local peds = {}
CreateThread(function()
    while p == nil do Wait(1000) end
    isPlayerAlrdyBraked = TriggerServerCallback("core:getIfPlayerAlrdyRobbe")

    for k, v in pairs(superette_robbery) do
        peds[k] = entity:CreatePedLocal("mp_m_shopkeep_01", v.pos.xyz, v.pos.w)
        peds[k]:setFreeze(true)
        SetEntityInvincible(peds[k].id, true)
        SetEntityAsMissionEntity(peds[k].id, 0, 0)
        SetBlockingOfNonTemporaryEvents(peds[k].id, true)
        SetPedFleeAttributes(peds[k].id, 0, 0)
        SetPedCombatAttributes(peds[k].id, 46, true)
        SetPedFleeAttributes(peds[k].id, 0, 0)

        zone.addZone( "ltd_item" .. k,
            v.pos.xyz,
            "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le magasin",
            function()
                openStore(peds[k].id, v.job) --TODO: fini le menu society
            end,
            false, -- Avoir un marker ou non
            -1, -- Id / type du marker
            0.6, -- La taille
            { 0, 0, 0 }, -- RGB
            0, -- Alpha
            2.5
        )
    end
    
    while (not isPlayerAlrdyBraked) do
        for k, v in pairs(superette_robbery) do
            local pDist = #(p:pos() - v.pos.xyz)
            if pDist <= 35 then
                if not (v.job and (TriggerServerCallback("core:getNumberOfDuty", token, v.job) > 0)) then
                    if not DoesEntityExist(peds[k].id) then
                        peds[k] = entity:CreatePedLocal("mp_m_shopkeep_01", v.pos.xyz, v.pos.w)
                        peds[k]:setFreeze(true)
                        SetEntityInvincible(peds[k].id, true)
                        SetEntityAsMissionEntity(peds[k].id, 0, 0)
                        SetBlockingOfNonTemporaryEvents(peds[k].id, true)
                        SetPedFleeAttributes(peds[k].id, 0, 0)
                        SetPedCombatAttributes(peds[k].id, 46, true)
                        SetPedFleeAttributes(peds[k].id, 0, 0)
                    end

                    if p:getJob() == "lspd" or p:getJob() == "lssd" then
                        return
                    elseif (pDist <= 3) and ((IsPedArmed(p:ped(), 1) and IsPedInMeleeCombat(p:ped()) == 1) or IsPlayerFreeAiming(PlayerId())) and 
                        (not IsPedDeadOrDying(peds[k].id)) and HasEntityClearLosToEntityInFront(p:ped(), peds[k].id) then

                        if not policemanCheck then
                            policemanCheck = true
                            policeMans = TriggerServerCallback("core:getNumberOfDuty", token,'lspd') + TriggerServerCallback("core:getNumberOfDuty", token,'lssd')
                        end

                        if policeMans >= 4 then
                            if not v.done then
                                local first = true
                                v.done = true
                                
                                peds[k]:setFreeze(false)
                                SetEntityInvincible(peds[k].id, false)

                                zone.removeZone("ltd_item" .. k)

                                TriggerServerEvent("core:addCrewExp", p:getCrew(), 400, "superette")

                                if v.location == "sud" then
                                    TriggerServerEvent('core:makeCall', "lspd",
                                        v.pos.xyz, true,
                                        "Braquage de superette", false, "illegal")
                                else
                                    TriggerServerEvent('core:makeCall', "lssd",
                                        v.pos.xyz, true,
                                        "Braquage de superette", false, "illegal")
                                end

                                LoadAnimDict('missheist_agency2ahands_up')
                                TaskPlayAnim(peds[k].id, "missheist_agency2ahands_up",
                                    "handsup_anxious", 8.0, -8.0, -1, 1, 0, false,
                                    false, false)
                                Wait(5000)
                                if IsPedDeadOrDying(peds[k].id) then
                                    return
                                end
                                timer = GetGameTimer() + (60000 * 6)
                                
                                Citizen.CreateThread(function()
                                    while (not isPlayerAlrdyBraked) do
                                        Wait(300)

                                        if GetGameTimer() > timer then
                                            isPlayerAlrdyBraked = true
                                            TriggerServerEvent("core:superette", totalMoney, v.name, "Fin du temps")
                                            break
                                        end

                                        if IsPedDeadOrDying(peds[k].id) then
                                            isPlayerAlrdyBraked = true
                                            exports['vNotif']:createNotification({
                                                type = 'ROUGE',
                                                content = "~s Apu est mort !!"
                                            })

                                            TriggerServerEvent("core:superette", totalMoney, v.name, "apu mort")
                                            break
                                        end
                                        if #(p:pos() - v.pos.xyz) >= 30 then
                                            isPlayerAlrdyBraked = true
                                            
                                            exports['vNotif']:createNotification({
                                                type = 'ROUGE',
                                                content = "Vous avez quitté la zone, ~s braquage annulé"
                                            })

                                            TriggerServerEvent("core:addCrewExp", p:getCrew(), 400, "superette")
                                            TriggerServerEvent("core:superette", totalMoney, v.name, "quitté la zone")
                                            break
                                        end
                                    end

                                    ClearPedTasks(peds[k].id)
                                    SetEntityCoords(peds[k].id, v.pos.xyz)
                                    SetEntityHeading(peds[k].id, v.pos.w)
                                    peds[k]:setFreeze(true)
                                    ResurrectPed(peds[k].id)
                                    SetEntityInvincible(peds[k].id, true)
                                end)

                                while (not isPlayerAlrdyBraked) do
                                    LoadAnimDict('mp_am_hold_up')
                                    TaskPlayAnim(peds[k].id, "mp_am_hold_up",
                                        "holdup_victim_20s", 8.0, -8.0, -1, 2, 0,
                                        false, false, false)

                                    Modules.UI.RealWait(11000)

                                    local cashRegister = GetClosestObjectOfType(GetEntityCoords(peds[k]
                                        .id), 5.0, GetHashKey('prop_till_01'))
                                    if DoesEntityExist(cashRegister) then
                                        CreateModelSwap(GetEntityCoords(cashRegister)
                                            , 0.5, GetHashKey('prop_till_01'),
                                            GetHashKey('prop_till_01_dam'), false)
                                    end

                                    local model = GetHashKey('prop_poly_bag_01')
                                    RequestModel(model)
                                    LoadModel('prop_poly_bag_01')
                                    TriggerServerEvent("TREFSDFD5156FD", "IOAPP", 5000)
                                    bag = CreateObject(model,
                                        GetEntityCoords(peds[k].id),
                                        false, false)
                                    AttachEntityToEntity(bag, peds[k].id,
                                        GetPedBoneIndex(peds[k].id, 60309), 0.1,
                                        -0.11, 0.08, 0.0, -75.0, -75.0, 1, 1, 0, 0, 2
                                        , 1)

                                    Modules.UI.RealWait(10000)

                                    if not IsPedDeadOrDying(peds[k].id) then
                                        DetachEntity(bag, true, false)
                                        Wait(75)
                                        SetEntityHeading(bag, v.pos.w)
                                        ApplyForceToEntity(bag, 3,
                                            vector3(0.0, 50.0, 0.0), 0.0,
                                            0.0, 0.0, 0, true, true, false, false,
                                            true)
                                    end
                                    if #(p:pos() - GetEntityCoords(bag)) <= 1.5 then
                                        SetEntityAsMissionEntity(bag, true, true)
                                        DeleteEntity(bag)
                                        if first then
                                            local money = 400 + math.random(-50, 50)
                                            TriggerSecurGiveEvent("core:addItemToInventory"
                                                , token, "money", money, {})

                                            exports['vNotif']:createNotification({
                                                type = 'DOLLAR',
                                                content = ("Vous avez récupéré ~s %s$"):format(money)
                                            })

                                            first = false
                                            totalMoney = totalMoney+money
                                        else
                                            local money = 250 + math.random(-50, 50)
                                            TriggerSecurGiveEvent("core:addItemToInventory"
                                                , token, "money", money, {})

                                            exports['vNotif']:createNotification({
                                                type = 'DOLLAR',
                                                content = ("Vous avez récupéré ~s %s$"):format(money)
                                            })

                                            totalMoney = totalMoney+money
                                        end
                                        if totalMoney >= 3600 then
                                            isPlayerAlrdyBraked = true
                                            exports['vNotif']:createNotification({
                                                type = 'JAUNE',
                                                content = "La caisse est ~s vide"
                                            })
                                            break
                                        end
                                    end
                                end

                                TriggerServerEvent("core:superette", totalMoney)
                                totalMoney = 0
                                ClearPedTasks(peds[k].id)
                                SetEntityCoords(peds[k].id, v.pos.xyz)
                                SetEntityHeading(peds[k].id, v.pos.w)
                                peds[k]:setFreeze(true)
                                SetEntityInvincible(peds[k].id, true)

                                TriggerServerEvent('core:setPlayerRobberyGood')
                                policemanCheck = false
                                isPlayerAlrdyBraked = true
                                
                                zone.addZone( "ltd_item" .. k,
                                    v.pos.xyz,
                                    "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le magasin",
                                    function()
                                        openStore(peds[k].id, v.job) --TODO: fini le menu society
                                    end,
                                    false, -- Avoir un marker ou non
                                    -1, -- Id / type du marker
                                    0.6, -- La taille
                                    { 0, 0, 0 }, -- RGB
                                    0, -- Alpha
                                    2.5
                                )
                                
                                v.done = false
                            end
                        else
                            exports['vNotif']:createNotification({
                                type = 'ROUGE',
                                content = "~s Reviens plus tard"
                            })

                        end
                    end
                else
                    DeletePed(peds[k].id)
                    zone.removeZone("ltd_item" .. k)
                end
            end
        end
        Wait(500)
    end

    while true do
        for k, v in pairs(superette_robbery) do
            if not (v.job and (TriggerServerCallback("core:getNumberOfDuty", token, v.job) > 0)) then
                if not DoesEntityExist(peds[k].id) then
                    peds[k] = entity:CreatePedLocal("mp_m_shopkeep_01", v.pos.xyz, v.pos.w)
                    peds[k]:setFreeze(true)
                    SetEntityInvincible(peds[k].id, true)
                    SetEntityAsMissionEntity(peds[k].id, 0, 0)
                    SetBlockingOfNonTemporaryEvents(peds[k].id, true)
                    SetPedFleeAttributes(peds[k].id, 0, 0)
                    SetPedCombatAttributes(peds[k].id, 46, true)
                    SetPedFleeAttributes(peds[k].id, 0, 0)
                end
            else
                DeletePed(peds[k].id)
                zone.removeZone("ltd_item" .. k)
            end
        end
        Wait(2500)
    end
end)

--[[ 
RegisterCommand("testcopsnbr", function()
    print(TriggerServerCallback("core:getNumberOfDuty", token,'lspd') + TriggerServerCallback("core:getNumberOfDuty", token,'lssd'))
end, false)

-- local isPlayerAlrdyBraked = false
-- local timer = 0
-- local pPeds = nil

-- Citizen.CreateThread(function()
--     while p == nil do Wait(1000) end
--     isPlayerAlrdyBraked = TriggerServerCallback("core:getIfPlayerAlrdyRobbe")

--     while not isPlayerAlrdyBraked do

--         for k,v in pairs(superette_robbery) do
--             local dst = GetDistanceBetweenCoords(p:pos(), vector3(v.pos[1],v.pos[2],v.pos[3]), true)

--             if dst <= 25 then
--                 if not v.create then
--                     pPeds = entity:CreatePedLocal(v.model, vector3(v.pos[1],v.pos[2],v.pos[3]), v.pos[4])
--                     SetEntityAsMissionEntity(pPeds.id, true, true)
--                     SetPedHearingRange(pPeds.id, 0.0)
--                     SetPedSeeingRange(pPeds.id, 0.0)
--                     SetPedAlertness(pPeds.id, 0.0)
--                     SetPedFleeAttributes(pPeds.id, 0, 0)
--                     SetBlockingOfNonTemporaryEvents(pPeds.id, true)
--                     SetPedCombatAttributes(pPeds.id, 46, true)
--                     SetPedFleeAttributes(pPeds.id, 0, 0)
--                     print("ped was created")
--                     v.create = true
--                 end
--             else
--                 if v.create then
--                     if pPeds.id ~= nil then
--                         DeleteEntity(pPeds.id)
--                         print("ped was deleted")
--                     end
--                 end
--                 v.create = false
--             end

--             if pPeds ~= nil and not isPlayerAlrdyBraked then
--                 local policeMans = TriggerServerCallback("core:getNumberOfDuty", token, 'lspd')
--                 if IsPedArmed(p:ped(), 4) then
--                     if IsPlayerFreeAiming(PlayerId()) then
--                         if not IsPedDeadOrDying(pPeds.id) then
--                             if  HasEntityClearLosToEntityInFront(p:ped(), pPeds.id) and not IsPedDeadOrDying(pPeds.id) and dst <= 5 and not isPlayerAlrdyBraked then
--                                 if policeMans >= 1 then

--                                     if not v.done then
--                                         v.done = true
--                                         if v.location == "sud" then
--                                             timer = GetGameTimer() + 10000
--                                             LoadAnimDict('missheist_agency2ahands_up'   )
--                                             TaskPlayAnim(pPeds.id, "missheist_agency2ahands_up", "handsup_anxious", 8.0, -8.0, -1, 1, 0, false, false, false)
--                                             Wait(5000)
--                                             print("timer: " .. timer)
--                                             if IsPedDeadOrDying(pPeds.id) then
--                                                 return
--                                             end
--                                             LoadAnimDict('mp_am_hold_up')
--                                             TaskPlayAnim(pPeds.id, "mp_am_hold_up", "holdup_victim_20s", 8.0, -8.0, -1, 2, 0, false, false, false)
--                                             while  GetGameTimer() < timer do
--                                                 Wait(10000)
--                                                 print("give money")
--                                             end
--                                             TriggerServerEvent('core:setPlayerRobberyGood')
--                                             isPlayerAlrdyBraked = true
--                                             v.done = false
--                                         elseif v.location == "nord" then
--                                             timer = GetGameTimer() + 450000

--                                         end
--                                     end
--                                 end
--                             end
--                         end
--                     end
--                 else
--                     ShowNotification("Reviens plus tard")
--                 end
--             end
--             Wait(500)
--         end
--     end
-- end)

local isPlayerAlrdyBraked = false
local pPeds = nil
local timer = 0
local bag = nil
local first = false
local policemanCheck = false
local policeMans = 0
local finish = false
local totalMoney = 0

CreateThread(function()
    while p == nil do Wait(1000) end
    isPlayerAlrdyBraked = TriggerServerCallback("core:getIfPlayerAlrdyRobbe")
    print('isPlayerAlrdyBraked',isPlayerAlrdyBraked)
    for k, v in pairs(superette_robbery) do

        Citizen.CreateThread(function()
            while not isPlayerAlrdyBraked do
                if v ~= nil then
                    local pDist = #(p:pos() - vector3(v.pos.x, v.pos.y, v.pos.z))
                    if pDist <= 15.5 then
                        if not v.create then
                            v.create = true
                            local dst = GetDistanceBetweenCoords(p:pos(), vector3(v.pos[1], v.pos[2], v.pos[3]), true)
                            pPeds = entity:CreatePedLocal(v.model, vector3(v.pos[1], v.pos[2], v.pos[3]), v.pos[4])
                            SetEntityAsMissionEntity(pPeds.id, true, true)
                            SetPedHearingRange(pPeds.id, 0.0)
                            SetPedSeeingRange(pPeds.id, 0.0)
                            SetPedAlertness(pPeds.id, 0.0)
                            SetPedFleeAttributes(pPeds.id, 0, 0)
                            SetBlockingOfNonTemporaryEvents(pPeds.id, true)
                            SetPedCombatAttributes(pPeds.id, 46, true)
                            SetPedFleeAttributes(pPeds.id, 0, 0)
                        end
                        if p:getJob() == "lspd" or p:getJob() == "lssd" then
                            return
                        elseif pDist <= 3 and pPeds ~= nil then
                            if not isPlayerAlrdyBraked then
                                if IsPedArmed(p:ped(), 4) or
                                    IsPedArmed(p:ped(), 1) and pDist <= 4.5 and not isPlayerAlrdyBraked then
                                    if IsPlayerFreeAiming(PlayerId()) or
                                        IsPedInMeleeCombat(p:ped()) == 1 and not isPlayerAlrdyBraked then
                                        if not IsPedDeadOrDying(pPeds.id) and pDist <= 4.5 and not isPlayerAlrdyBraked then
                                            if HasEntityClearLosToEntityInFront(p:ped(), pPeds.id) and
                                                not IsPedDeadOrDying(pPeds.id) and pDist <= 4.5 and
                                                not isPlayerAlrdyBraked then
                                                if not policemanCheck then
                                                    policemanCheck = true
                                                    policeMans = TriggerServerCallback("core:getNumberOfDuty", token,'lspd') + TriggerServerCallback("core:getNumberOfDuty", token,'lssd')
                                                end
                                                if p:getJob() ~= "lspd" or p:getJob() ~= "lssd" then
                                                    if policeMans >= 0 then
                                                        if not v.done then
                                                            v.done = true
                                                            -- TriggerServerEvent("core:SetRobberyInLive", true)
                                                            if v.location == "sud" then
                                                                local posEntity
                                                                TriggerServerEvent('core:makeCall', "lspd",
                                                                    vector3(v.pos[1], v.pos[2], v.pos[3]), true,
                                                                    "Braquage de superette", false, "illegal")
                                                                TriggerServerEvent('core:makeCall', "lssd",
                                                                    vector3(v.pos[1], v.pos[2], v.pos[3]), true,
                                                                    "Braquage de superette", false, "illegal")
                                                                LoadAnimDict('missheist_agency2ahands_up')
                                                                TaskPlayAnim(pPeds.id, "missheist_agency2ahands_up",
                                                                    "handsup_anxious", 8.0, -8.0, -1, 1, 0, false,
                                                                    false, false)
                                                                Wait(5000)
                                                                if IsPedDeadOrDying(pPeds.id) then
                                                                    return
                                                                end
                                                                timer = GetGameTimer() + (60000 * 6)
                                                                first = false
                                                                --verif
                                                                Citizen.CreateThread(function()
                                                                    while isPlayerAlrdyBraked do
                                                                        Wait(300)
                                                                        if GetGameTimer() > timer then
                                                                            isPlayerAlrdyBraked = false
                                                                            ClearPedTasks(pPeds.id)
                                                                            TriggerServerEvent("core:superette", totalMoney, v.name, "fin du temps")
                                                                            break
                                                                        end
                                                                        if IsPedDeadOrDying(pPeds.id) then
                                                                            isPlayerAlrdyBraked = false
                                                                            -- ShowNotification("Apu est mort !!")

                                                                            -- New notif
                                                                            exports['vNotif']:createNotification({
                                                                                type = 'ROUGE',
                                                                                -- duration = 5, -- In seconds, default:  4
                                                                                content = "~s Apu est mort !!"
                                                                            })

                                                                            TriggerServerEvent("core:addCrewExp", p:getCrew(), 200, "superette")

                                                                            TriggerServerEvent("core:superette", totalMoney, v.name, "apu mort")
                                                                            return
                                                                        end
                                                                        if #
                                                                            (
                                                                            p:pos() -
                                                                                vector3(v.pos[1], v.pos[2], v.pos[3])) >=
                                                                            30 then
                                                                            isPlayerAlrdyBraked = false
                                                                            -- ShowNotification("Vous avez quitté la zone, braquage annulé")

                                                                            -- New notif
                                                                            exports['vNotif']:createNotification({
                                                                                type = 'ROUGE',
                                                                                -- duration = 5, -- In seconds, default:  4
                                                                                content = "Vous avez quitté la zone, ~s braquage annulé"
                                                                            })

                                                                            TriggerServerEvent("core:addCrewExp", p:getCrew(), 200, "superette")

                                                                            TriggerServerEvent("core:superette", totalMoney, v.name, "quitté la zone")
                                                                            return
                                                                        end
                                                                    end
                                                                end)
                                                                Citizen.CreateThread(function()
                                                                    while isPlayerAlrdyBraked do
                                                                        if GetGameTimer() > timer then
                                                                            ClearPedTasks(pPeds.id)
                                                                            break
                                                                        end
                                                                        LoadAnimDict('mp_am_hold_up')
                                                                        TaskPlayAnim(pPeds.id, "mp_am_hold_up",
                                                                            "holdup_victim_20s", 8.0, -8.0, -1, 2, 0,
                                                                            false, false, false)

                                                                        Modules.UI.RealWait(11000)

                                                                        local cashRegister = GetClosestObjectOfType(GetEntityCoords(pPeds
                                                                            .id), 5.0, GetHashKey('prop_till_01'))
                                                                        if DoesEntityExist(cashRegister) then
                                                                            CreateModelSwap(GetEntityCoords(cashRegister)
                                                                                , 0.5, GetHashKey('prop_till_01'),
                                                                                GetHashKey('prop_till_01_dam'), false)
                                                                        end

                                                                        local model = GetHashKey('prop_poly_bag_01')
                                                                        RequestModel(model)
                                                                        LoadModel('prop_poly_bag_01')
                                                                        bag = CreateObject(model,
                                                                            GetEntityCoords(pPeds.id),
                                                                            false, false)
                                                                        AttachEntityToEntity(bag, pPeds.id,
                                                                            GetPedBoneIndex(pPeds.id, 60309), 0.1,
                                                                            -0.11, 0.08, 0.0, -75.0, -75.0, 1, 1, 0, 0, 2
                                                                            , 1)

                                                                        Modules.UI.RealWait(10000)

                                                                        if not IsPedDeadOrDying(pPeds.id) then
                                                                            DetachEntity(bag, true, false)
                                                                            Wait(75)
                                                                            SetEntityHeading(bag, v.pos[4])
                                                                            ApplyForceToEntity(bag, 3,
                                                                                vector3(0.0, 50.0, 0.0), 0.0,
                                                                                0.0, 0.0, 0, true, true, false, false,
                                                                                true)
                                                                        end
                                                                        if IsPedDeadOrDying(pPeds.id) then
                                                                            isPlayerAlrdyBraked = false
                                                                            return
                                                                        end
                                                                        posEntity = GetEntityCoords(bag)
                                                                        if #(p:pos() - posEntity) <= 1.5 then
                                                                            SetEntityAsMissionEntity(bag, true, true)
                                                                            DeleteEntity(bag)
                                                                            finish = true
                                                                            if not first then
                                                                                TriggerSecurGiveEvent("core:addItemToInventory"
                                                                                    , token, "money", 400, {})
                                                                                -- ShowNotification("Vous avez récupéré ~r~400$")

                                                                                -- New notif
                                                                                exports['vNotif']:createNotification({
                                                                                    type = 'DOLLAR',
                                                                                    -- duration = 5, -- In seconds, default:  4
                                                                                    content = "Vous avez récupéré ~s 400$"
                                                                                })

                                                                                first = true
                                                                                totalMoney = totalMoney+400
                                                                            else
                                                                                TriggerSecurGiveEvent("core:addItemToInventory"
                                                                                    , token, "money", 200, {})
                                                                                -- ShowNotification("Vous avez récupéré ~r~200$")

                                                                                -- New notif
                                                                                exports['vNotif']:createNotification({
                                                                                    type = 'DOLLAR',
                                                                                    -- duration = 5, -- In seconds, default:  4
                                                                                    content = "Vous avez récupéré ~s 200$"
                                                                                })

                                                                                totalMoney = totalMoney+200
                                                                            end
                                                                        end
                                                                        -- TriggerServerEvent("core:")
                                                                    end
                                                                end)

                                                                ClearPedTasks(pPeds.id)

                                                                --cv
                                                                TriggerServerEvent('core:setPlayerRobberyGood')
                                                                policemanCheck = false
                                                                isPlayerAlrdyBraked = true
                                                                v.done = false
                                                                
                                                            elseif v.location == "nord" then
                                                                TriggerServerEvent('core:makeCall', "lspd",
                                                                    vector3(v.pos[1], v.pos[2], v.pos[3]), true,
                                                                    "Braquage de superette")
                                                                TriggerServerEvent('core:makeCall', "lssd",
                                                                    vector3(v.pos[1], v.pos[2], v.pos[3]), true,
                                                                    "Braquage de superette")
                                                                local posEntity
                                                                LoadAnimDict('missheist_agency2ahands_up')
                                                                TaskPlayAnim(pPeds.id, "missheist_agency2ahands_up",
                                                                    "handsup_anxious", 8.0, -8.0, -1, 1, 0, false,
                                                                    false, false)
                                                                Wait(5000)
                                                                if IsPedDeadOrDying(pPeds.id) then
                                                                    return
                                                                end
                                                                timer = GetGameTimer() + (60000 * 6)

                                                                --verif
                                                                Citizen.CreateThread(function()
                                                                    while isPlayerAlrdyBraked do
                                                                        Wait(300)
                                                                        if GetGameTimer() > timer then
                                                                            isPlayerAlrdyBraked = false
                                                                            ClearPedTasks(pPeds.id)
                                                                            TriggerServerEvent("core:superette", totalMoney, v.name, "fin du temps")
                                                                            break
                                                                        end
                                                                        if IsPedDeadOrDying(pPeds.id) then
                                                                            isPlayerAlrdyBraked = false
                                                                            -- ShowNotification("Apu est mort !!")

                                                                            -- New notif
                                                                            exports['vNotif']:createNotification({
                                                                                type = 'ROUGE',
                                                                                -- duration = 5, -- In seconds, default:  4
                                                                                content = "~s Apu est mort !!"
                                                                            })
                                                                            TriggerServerEvent("core:addCrewExp", p:getCrew(), 200, "superette")

                                                                            TriggerServerEvent("core:superette", totalMoney, v.name, "apu mort")
                                                                            return
                                                                        end
                                                                        if #
                                                                            (
                                                                            p:pos() -
                                                                                vector3(v.pos[1], v.pos[2], v.pos[3])) >=
                                                                            30 then
                                                                            isPlayerAlrdyBraked = false
                                                                            -- ShowNotification("Vous avez quitté la zone, braquage annulé")

                                                                            -- New notif
                                                                            exports['vNotif']:createNotification({
                                                                                type = 'ROUGE',
                                                                                -- duration = 5, -- In seconds, default:  4
                                                                                content = "Vous avez quitté la zone, ~s braquage annulé"
                                                                            })
                                                                            TriggerServerEvent("core:addCrewExp", p:getCrew(), 200, "superette")

                                                                            TriggerServerEvent("core:superette", totalMoney, v.name, "quitté la zone")
                                                                            return
                                                                        end
                                                                        if DoesEntityExist(bag) then
                                                                            if posEntity ~= nil then
                                                                                if #(p:pos() - posEntity) <= 1.5 then
                                                                                    SetEntityAsMissionEntity(bag, true,
                                                                                        true)
                                                                                    DeleteEntity(bag)
                                                                                    finish = true
                                                                                    if not first then
                                                                                        TriggerSecurGiveEvent("core:addItemToInventory"
                                                                                            , token, "money", 400, {})
                                                                                        -- ShowNotification("Vous avez récupéré ~r~400$")

                                                                                        -- New notif
                                                                                        exports['vNotif']:createNotification({
                                                                                            type = 'DOLLAR',
                                                                                            -- duration = 5, -- In seconds, default:  4
                                                                                            content = "Vous avez récupéré ~s 400$"
                                                                                        })

                                                                                        first = true
                                                                                        totalMoney = totalMoney+400
                                                                                    else
                                                                                        TriggerSecurGiveEvent("core:addItemToInventory"
                                                                                            , token, "money", 200, {})
                                                                                        -- ShowNotification("Vous avez récupéré ~r~200$")

                                                                                        -- New notif
                                                                                        exports['vNotif']:createNotification({
                                                                                            type = 'DOLLAR',
                                                                                            -- duration = 5, -- In seconds, default:  4
                                                                                            content = "Vous avez récupéré ~s 200$"
                                                                                        })

                                                                                        totalMoney = totalMoney+200
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end)
                                                                Citizen.CreateThread(function()
                                                                    while isPlayerAlrdyBraked do
                                                                        if GetGameTimer() > timer then
                                                                            ClearPedTasks(pPeds.id)
                                                                            break
                                                                        end
                                                                        LoadAnimDict('mp_am_hold_up')
                                                                        TaskPlayAnim(pPeds.id, "mp_am_hold_up",
                                                                            "holdup_victim_20s",
                                                                            8.0, -8.0, -1, 2, 0, false, false, false)

                                                                        Modules.UI.RealWait(11000)

                                                                        local cashRegister = GetClosestObjectOfType(GetEntityCoords(pPeds
                                                                            .id), 5.0, GetHashKey('prop_till_01'))
                                                                        if DoesEntityExist(cashRegister) then
                                                                            CreateModelSwap(GetEntityCoords(cashRegister)
                                                                                , 0.5, GetHashKey('prop_till_01'),
                                                                                GetHashKey('prop_till_01_dam'), false)
                                                                        end

                                                                        local model = GetHashKey('prop_poly_bag_01')
                                                                        RequestModel(model)
                                                                        LoadModel('prop_poly_bag_01')
                                                                        bag = CreateObject(model,
                                                                            GetEntityCoords(pPeds.id),
                                                                            false, false)
                                                                        AttachEntityToEntity(bag, pPeds.id,
                                                                            GetPedBoneIndex(pPeds.id, 60309), 0.1,
                                                                            -0.11, 0.08, 0.0, -75.0, -75.0, 1, 1, 0, 0, 2
                                                                            , 1)

                                                                        Modules.UI.RealWait(10000)

                                                                        if not IsPedDeadOrDying(pPeds.id) then
                                                                            DetachEntity(bag, true, false)
                                                                            Wait(75)
                                                                            SetEntityHeading(bag, v.pos[4])
                                                                            ApplyForceToEntity(bag, 3,
                                                                                vector3(0.0, 50.0, 0.0),
                                                                                0.0, 0.0, 0.0, 0, true, true, false,
                                                                                false, true)
                                                                        end
                                                                        if IsPedDeadOrDying(pPeds.id) then
                                                                            isPlayerAlrdyBraked = false
                                                                            return
                                                                        end
                                                                        posEntity = GetEntityCoords(bag)
                                                                        if #(p:pos() - posEntity) <= 1.5 then
                                                                            SetEntityAsMissionEntity(bag, true, true)
                                                                            DeleteEntity(bag)
                                                                            finish = true
                                                                            TriggerSecurGiveEvent("core:addItemToInventory"
                                                                                , token, "money", 111, {})
                                                                            -- ShowNotification("Vous avez récupéré ~r~111$")

                                                                            -- New notif
                                                                            exports['vNotif']:createNotification({
                                                                                type = 'DOLLAR',
                                                                                -- duration = 5, -- In seconds, default:  4
                                                                                content = "Vous avez récupéré ~s 111$"
                                                                            })

                                                                            totalMoney = totalMoney+111
                                                                        end
                                                                        -- TriggerServerEvent("core:")
                                                                    end
                                                                end)

                                                                ClearPedTasks(pPeds.id)

                                                                --cv
                                                                TriggerServerEvent('core:setPlayerRobberyGood')
                                                                isPlayerAlrdyBraked = true
                                                                v.done = false
                                                                print(finish)
                                                            
                                                                print('t', totalMoney)
                                                                TriggerServerEvent("core:superette", totalMoney)
                                                                totalMoney = 0        
                                                                finish = false
                                                            end
                                                        end
                                                    else
                                                        -- ShowNotification("Reviens plus tard")

                                                        -- New notif
                                                        exports['vNotif']:createNotification({
                                                            type = 'ROUGE',
                                                            -- duration = 5, -- In seconds, default:  4
                                                            content = "~s Reviens plus tard"
                                                        })

                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- ShowNotification("Tu m'as deja vendalisé !")

                                -- New notif
                                exports['vNotif']:createNotification({
                                    type = 'ROUGE',
                                    -- duration = 5, -- In seconds, default:  4
                                    content = "~s Tu m'as deja vendalisé !"
                                })
                            end
                        end
                    else
                        if pPeds ~= nil and pDist >= 15.5 and v.create then
                            if DoesEntityExist(pPeds.id) then
                                pPeds:delete()
                                v.create = false
                            end
                        end

                    end
                end
                Wait(500)
            end
        end)

    end
end)

-- RegisterNetEvent("core:SetRobberyInLive")
-- AddEventHandler("core:SetRobberyInLive", function(bool)
--     superette_robbery.Wait = bool
-- end)Get-ExecutionPolicy -List
]]