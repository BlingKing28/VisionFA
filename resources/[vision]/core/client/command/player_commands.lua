local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)
RegisterCommand("debug", function()
    EnableControlAction(0, 1, true)
    EnableControlAction(0, 2, true)
    EnableControlAction(0, 142, true)
    EnableControlAction(0, 18, true)
    EnableControlAction(0, 322, true)
    EnableControlAction(0, 106, true)
    SetNuiFocus(false, false)
    TriggerEvent("debug")
    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))
end)

RegisterCommand("stuck", function()
    RemoveLoadingPrompt()
    ClearPedTasksImmediately(PlayerPedId())
    DisableScreenblurFade()
    RequestCollisionAtCoord(GetEntityCoords(PlayerPedId()))
    SetEntityCoords(PlayerPedId(), -300.85, -883.92, 30.1, 0.0, 0.0, 0.0, false)
    SetFocusPosAndVel(0.0,0.0,0.0)
    Wait(150)
    SetFocusPosAndVel(GetEntityCoords(PlayerPedId()))
end)

RegisterCommand("focus", function()
    SetNuiFocus(false, false)
end)

RegisterCommand("id", function()
    -- ShowNotification("Votre id est: ~o~" .. GetPlayerServerId(PlayerId()))
    print(GetPlayerServerId(PlayerId()))
    -- New notif
    exports['vNotif']:createNotification({
        type = 'JAUNE',
        -- duration = 5, -- In seconds, default:  4
        content = "Votre id est : ~s " .. GetPlayerServerId(PlayerId())
    })

end)
RegisterCommand("license", function()
    -- ShowNotification("Votre licence est: ~o~" .. p:getLicense())

    -- New notif
    exports['vNotif']:createNotification({
        type = 'JAUNE',
        -- duration = 5, -- In seconds, default:  4
        content = "Votre licence est : ~s " .. p:getLicense()
    })

end)
RegisterCommand("idbdd", function()
    -- ShowNotification("Votre id bdd est: ~o~" .. p:getId())
    exports['vNotif']:createNotification({
        type = 'JAUNE',
        duration = 5, -- In seconds, default:  4
        content = "Votre id bdd est : ~s" .. p:getId()
    })
end)

--RegisterCommand("infocrew", function()
--    local crewLevel, crewExp = nil , nil 
--    crewLevel = TriggerServerCallback("core:GetCrewLevel", p:getCrew())
--    print("1",crewLevel)
--    Wait(1200)
--    crewExp = TriggerServerCallback("core:GetCrewExp", p:getCrew())
--    while crewLevel == nil or crewExp == nil do Wait(1) end
--    exports['vNotif']:createNotification({
--        type = 'JAUNE',
--        duration = 5, -- In seconds, default:  4
--        content = "Votre crew est niveau : ~s" ..crewLevel.."~c avec ~s" ..crewExp.."~c d'expérience"
--    })
--end)

local mePed = {}
local display = false
-- local function displayText(ped, text)
--     local pPed = PlayerPedId()
--     local pPos = GetEntityCoords(pPed)
--     local tPos = GetEntityCoords(ped)
--     local dst = #(pPos - tPos)
--     local los = HasEntityClearLosToEntity(pPed, ped, 17)

--     if dst ~= 1 and dst <= 200 and los then
--         local exists = mePed[ped] ~= nil

--         mePed[ped] = {
--             time = GetGameTimer() + 5000,
--             text = text
--         }

--         if not exists then
--             display = true

--             while display do
--                 Wait(0)
--                 local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 1.0)
--                 DrawText3D(vector3(pos.x, pos.y, pos.z + 0.03), mePed[ped].text, 0.7)
--                 display = GetGameTimer() <= mePed[ped].time
--             end

--             mePed[ped] = nil
--         end
--     end
-- end

-- RegisterCommand("me", function(source, args)
--     local text = "* l'individu " .. table.concat(args, " ") .. " *"
--     TriggerServerEvent("core:show3dme", token, text)
-- end)

RegisterCommand("me", function(source, args)
    local text = "* l'individu " .. table.concat(args, " ") .. " *"
    local players = {}
    for i,v in ipairs(GetActivePlayers()) do 
        table.insert(players, GetPlayerServerId(v))
    end
    TriggerServerEvent("core:sendtext", players, text)
end)


-- RegisterNetEvent("core:show3dme")
-- AddEventHandler("core:show3dme", function(text, player)
--     local target = GetPlayerFromServerId(player)
--     if target ~= 1 or player == GetPlayerServerId(PlayerId()) then
--         local ped = GetPlayerPed(target)
--         displayText(ped, text)
--     end
-- end)

local lastPos = nil
CreateThread(function()
    while p == nil do Wait(1) end
    lastPos = p:pos()
    while true do
        lastPos = p:pos()
        Wait(5000)
    end
end)

RegisterCommand("lastPos", function()
    SetEntityCoords(p:ped(), lastPos)
end)

RegisterCommand("sync", function ()
    local coords = vector4(p:pos(), p:heading())
    TriggerServerEvent("core:UpdatePlayerPosition", coords)
    -- ShowNotification("~g~Votre position a été synchronisée")

    -- New notif
    exports['vNotif']:createNotification({
        type = 'SYNC',
        -- duration = 5, -- In seconds, default:  4
        content = "~sSynchronisation de la position"
    })

end)

local idle = false
RegisterCommand('idle', function ()
    idle = not idle
    DisableIdleCamera(idle)
    -- show notification depending on whether idle is on or off
    -- ShowNotification(idle and 'Vous avez désactivé la caméra AFK' or 'Vous avez activé la caméra AFK')

    -- New notif
    exports['vNotif']:createNotification({
        type = 'JAUNE',
        -- duration = 5, -- In seconds, default:  4
        content = idle and 'Vous avez ~s désactivé ~c la caméra AFK' or 'Vous avez ~s activé ~c la caméra AFK'
    })

    while idle do 
        Wait(5000)
        InvalidateIdleCam()
		InvalidateVehicleIdleCam()
    end
end)

RegisterCommand("service", function()
    local onDuty = TriggerServerCallback("core:getOnDutyNames", token, p:getJob())
    if #onDuty == 0 then
        -- ShowNotification("Aucun employé en service")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Aucun employé en service"
        })
    else
        -- ShowNotification("Liste des employés en service dans le F8")
        -- New notif
        exports['vNotif']:createNotification({
            type = 'VERT',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Liste des employés en service dans le F8"
        })
        print("Liste des employés en service :")
        print(json.encode(onDuty))
    end

end)

RegisterCommand("resetCatalogue", function()
    if p:getJob() == "cardealerSud" then
        TriggerServerEvent("core:resetCatalogue", 'sud')
    elseif p:getJob() == "cardealerNord" then
        TriggerServerEvent("core:resetCatalogue", 'nord')
    end
end)

RegisterCommand("tryDebug", function()
    if p:getJob() == "cardealerSud" then
        TriggerServerEvent("core:tryDebug", 'sud')
    elseif p:getJob() == "cardealerNord" then
        TriggerServerEvent("core:tryDebug", 'nord')
    end
end)