local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

RegisterCommand("dv", function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        local veh, dst = GetClosestVehicle()
        if dst <= 6.0 then
            TriggerServerEvent("core:SetVehicleIn", all_trim(GetVehicleNumberPlateText(veh)))
            TriggerEvent('persistent-vehicles/forget-vehicle', veh)
            TriggerServerEvent("DeleteEntity", token, { VehToNet(veh) })
            TriggerServerEvent("police:SetVehicleInFourriere", token, all_trim(GetVehicleNumberPlateText(veh)), VehToNet(veh))
            -- DeleteEntity(veh)
        else
            -- ShowNotification("Aucun véhicule proche")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Aucun véhicule proche"
            })

        end
    end
end, false)

RegisterCommand("dvr", function(source, args, rawCommand)
    local ped = PlayerPedId()
    local playerCoords = GetEntityCoords(ped)
    local radius = tonumber(args[1])

    local vehicles = {}

    for veh in EnumerateVehicles() do
        local vehCoords = GetEntityCoords(veh)
        local distance = #(playerCoords - vehCoords)
        if distance <= radius then
            table.insert(vehicles, veh)
        end
    end

    for _, veh in ipairs(vehicles) do
        TriggerServerEvent("core:SetVehicleIn", all_trim(GetVehicleNumberPlateText(veh)))
        TriggerEvent('persistent-vehicles/forget-vehicle', veh)
        TriggerServerEvent("DeleteEntity", token, { VehToNet(veh) })
        TriggerServerEvent("police:SetVehicleInFourriere", token, all_trim(GetVehicleNumberPlateText(veh)), VehToNet(veh))
    end

    if #vehicles == 0 then
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            content = "~s Aucun véhicule proche dans la zone"
        })
    end
end, false)


RegisterCommand("car", function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        local vehName = args[1]
        if vehName ~= nil then
            TriggerServerEvent("core:staffActionLog", token, "/car", vehName)
            SpawnCar(vehName)

        end
    end
end, false)

-- RegisterCommand("setcarcolor1", function(source, args)
--     if p:getPermission() >= 3 then
--         local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
--         local paintType, color, pearlescentColor = GetVehicleModColor_2(vehicle)
--         print(paintType, color, pearlescentColor)
--         SetVehicleModKit(vehicle, 0)
--         SetVehicleColours(vehicle, tonumber(args[1]), color)
--     end
-- end)

-- RegisterCommand("setcarcolor2", function(source, args)
--     if p:getPermission() >= 3 then
--         local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
--         local paintType, color, pearlescentColor = GetVehicleModColor_1(vehicle)
--         print(paintType, color, pearlescentColor)
--         SetVehicleModKit(vehicle, 0)
--         SetVehicleColours(vehicle, color, tonumber(args[1]))
--     end
-- end)

RegisterCommand("setcarcolor", function(source, args)
    if p:getPermission() >= 3 then
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        SetVehicleModKit(veh, 0)
        SetVehicleColours(veh, tonumber(args[1]), tonumber(args[1]))
        local props = vehicle.getProps(veh)
        TriggerServerEvent("core:SetPropsVeh", token, props.plate, props)
    end
end)

RegisterCommand("ban", function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        local target = args[1]
        local reason = args[2]
        local time = args[3]
        local typeTime = args[4]
        if target ~= nil and reason ~= nil and time ~= nil then
            TriggerServerEvent("core:staffActionLog", token, "/ban",
                target .. "** - Raison : **" .. reason .. "** - Durée : **" .. time)
            TriggerServerEvent("core:ban:banplayer", token, tonumber(args[1]), args[2], tonumber(args[3]), GetPlayerServerId(PlayerId()), typeTime)
        end
    end
end, false)

RegisterCommand("unban", function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        local target = args[1]
        if target ~= nil then
            TriggerServerEvent("core:staffActionLog", token, "/unban", target)
            TriggerServerEvent("core:ban:unbanplayer", token, tonumber(args[1]))
        end
    end
end, false)

RegisterCommand("revive", function(source, args, rawCommand)
    if p:getPermission() >= 2 then
        if args[1] ~= nil then
            local player = tonumber(args[1])
            TriggerServerEvent("core:staffActionLog", token, "/revive", player)
            TriggerServerEvent("core:RevivePlayer", token, player)
        else
            local player = GetPlayerServerId(PlayerId())
            TriggerServerEvent("core:staffActionLog", token, "/revive", "Soi-même")
            TriggerServerEvent("core:RevivePlayer", token, player)
        end
    end
end, false)

RegisterCommand("repair", function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        TriggerServerEvent("core:staffActionLog", token, "/repair", "Véhicule")
        SetVehicleFixed(p:currentVeh())
        SetVehicleBodyHealth(p:currentVeh(), 1000.0)
        SetVehicleEngineHealth(p:currentVeh(), 1000.0)
        SetVehicleDirtLevel(p:currentVeh(), 0.0)
    end
end, false)

RegisterCommand('tp', function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        if args[1] ~= nil and args[2] ~= nil and args[3] ~= nil then
            local pPed = GetPlayerPed(-1)
            TriggerServerEvent("core:staffActionLog", token, "/tp", args[1] .. " " .. args[2] .. " " .. args[3])
            TeleportPlayer(vector3(tonumber(args[1]), tonumber(args[2]), tonumber(args[3])))
        else
            -- ShowNotification("~r~Mauvaise Coords.")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Mauvaise Coords"
            })

        end
    end
end, false)

RegisterCommand('upgrade', function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        TriggerServerEvent("core:staffActionLog", token, "/upgrade", "Véhicule")
        local pVeh = p:currentVeh()
        SetVehicleModKit(pVeh, 0)
        for i = 0, 49 do
            if i ~= 11 and i ~= 12 and i ~= 13 and i ~= 14 and i ~= 15 and i ~= 18 and i ~= 22 then
                local max = GetNumVehicleMods(pVeh, i) - 1
                if max > 0 then
                    SetVehicleMod(pVeh, i, math.random(0, max), true)
                end
            end
        end
        for i = 11, 15 do
            local max = GetNumVehicleMods(pVeh, i) - 1
            SetVehicleMod(pVeh, i, max, true)
        end
        -- SetVehicleMod(pVeh, 11, GetNumVehicleMods(pVeh, 11), true)
        -- SetVehicleMod(pVeh, 12, GetNumVehicleMods(pVeh, 12), true)
        -- SetVehicleMod(pVeh, 13, GetNumVehicleMods(pVeh, 13), true)
        -- SetVehicleMod(pVeh, 14, GetNumVehicleMods(pVeh, 14), true)
        -- SetVehicleMod(pVeh, 15, GetNumVehicleMods(pVeh, 15), true)
        ToggleVehicleMod(pVeh, 18, true)
        ToggleVehicleMod(pVeh, 22, true)
        local props = vehicle.getProps(pVeh)
        TriggerServerEvent("core:SetPropsVeh", token, props.plate, props)
    end
end, false)

RegisterCommand('testprop', function(source, args, rawCommand)
    if p:getPermission() >= 4 then
        StartPropTestMenu()
    end
end, false)

RegisterCommand('setjob', function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        local player = args[1]
        local job = args[2]
        local grade = args[3]
        if grade == nil or grade == "" then
            -- ShowNotification("~r~Commande incomplète (setjob ID job grade)")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Commande incomplète (setjob ID job grade)"
            })

            return
        end
        TriggerServerEvent("core:staffActionLog", token, "/setjob",
            player .. " - Job : " .. job .. " - Grade : " .. grade)
        policeDuty = false
        TriggerEvent("jobs:unloadcurrent")
        TriggerServerEvent("core:StaffRecruitPlayer", token, tonumber(player), job, tonumber(grade))
    end
end, false)

RegisterCommand('setcrew', function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        local player = args[1]
        local crew = args[2]
        local rang = args[3]
        if rang == nil or rang == "" then
            -- ShowNotification("~r~Commande incomplète (setcrew ID job rang)")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Commande incomplète (setcrew ID crew rang)"
            })

            return
        end
        TriggerServerEvent("core:staffActionLog", token, "/setcrew",
            player .. " - Crew : " .. crew .. " - Rang : " .. rang)
       -- print("token, tonumber(player), crew, rang", token, tonumber(player), crew, rang)
        TriggerServerEvent("core:setCrew", token, tonumber(player), crew, rang)
    end
end, false)

RegisterCommand("addItem", function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        local player = args[1]
        local item = args[2]
        local amount = args[3]
        if amount == nil or amount == "" then
            -- ShowNotification("~r~Commande incomplète (addItem ID item amount)")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Commande incomplète (addItem ID item amount)"
            })
            
            return
        end
        TriggerServerEvent("core:addItemToInventoryStaff", token, tonumber(player), item, tonumber(amount), {})
    end
end)

RegisterCommand("addItemData", function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        local player = args[1]
        local item = args[2]
        local amount = args[3]
        local dataid = args[4]
        local variation = args[5]
        if amount == nil or amount == "" or dataid == nil or variation == nil then
            -- ShowNotification("~r~Commande incomplète (addItem ID item amount)")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Commande incomplète (addItemData ID item amount dataid variation)"
            })
            
            return
        end
        TriggerEvent("core:tempgiveiditem", tonumber(args[1]), args[4], args[2], args[5])
    end
end)

RegisterCommand("addExpcrew", function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        local crewId = args[1]
        local count = args[2]
        if crewId == nil or count == nil then
            -- ShowNotification("~r~Commande incomplète (addItem ID item amount)")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Commande incomplète (addExpcrew 'IDcrew' 'nombre exp à ajouter')"
            })
            
            return
        end
        TriggerServerEvent("core:addCrewExpStaff", tonumber(args[1]), tonumber(args[2]))
    end
end)

RegisterCommand("rmvExpcrew", function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        local crewId = args[1]
        local count = args[2]
        if crewId == nil or count == nil then
            -- ShowNotification("~r~Commande incomplète (addItem ID item amount)")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Commande incomplète (rmvExpcrew 'IDcrew' 'nombre exp à retirer')"
            })
            
            return
        end
        TriggerServerEvent("core:rmvCrewExpStaff", tonumber(args[1]), tonumber(args[2]))
    end
end)

RegisterCommand("wipe", function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        local player = args[1]
        TriggerServerEvent("core:wipePlayer", token, tonumber(player))
    end
end)

RegisterNetEvent("core:ReturnPlayer", function(coord)
    SetEntityCoords(PlayerPedId(), coord)
end)

RegisterCommand("goto", function(source, args, rawCommand)
    if p:getPermission() == 2 then
        local player = args[1]
        TriggerServerEvent("core:acteurLog", token, "/goto", player)
        TriggerServerEvent("core:GotoBring", token, nil, tonumber(player))
    elseif p:getPermission() >= 3 then
        local player = args[1]
        TriggerServerEvent("core:staffActionLog", token, "/goto", player)
        TriggerServerEvent("core:GotoBring", token, nil, tonumber(player))
    end
end)

RegisterCommand("return", function(source, args, rawCommand)
    if p:getPermission() >= 3 and tonumber(IdBring) == tonumber(args[1]) then
        TriggerServerEvent("core:staffActionLog", token, "/return", args[1])
        TriggerServerEvent("core:ReturnPositionPlayer", token, args[1], coordsLastBring)
        coordsLastBring = nil
        CanReturn = false
        IdBring = nil
    end
end)

RegisterCommand("bring", function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        local player = args[1]
        CanReturn = true
        IdBring = tonumber(player)
        coordsLastBring = TriggerServerCallback("core:CoordsOfPlayer", token, player)
        TriggerServerEvent("core:staffActionLog", token, "/bring", player)
        TriggerServerEvent("core:GotoBring", token, tonumber(player), nil)
    end
end)

RegisterCommand("setped", function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        local player = args[1]
        local ped = args[2]
        TriggerServerEvent("core:staffActionLog", token, "/setped", player .. " - Ped : " .. ped)
        TriggerServerEvent("core:setPedStaff", token, tonumber(player), ped)
    elseif p:getPermission() == 2 then
        if args[2] ~= nil then
            -- ShowNotification("~r~Vous n'avez pas la permission de changer le skin d'un joueur")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Vous n'avez pas la permission de changer le skin d'un joueur"
            })

            return
        end
        local ped = args[1]
        local player = GetPlayerServerId(PlayerId())
        TriggerServerEvent("core:acteurLog", token, "/setped", "Soi-même ** - Ped : **" .. ped)
        TriggerServerEvent("core:setPedStaff", token, player, ped)
    end
end)

--RegisterCommand("spFreq", function(source, args, rawCommand)
--    if p:getPermission() >= 3 then
--        local job = args[1]
--        local freq = tonumber(args[2])
--        local alrdSet = false
--
--        TriggerServerEvent('updatespFreq', job, freq)
--    end
--end)

RegisterCommand("creator", function(source, args, rawCommand)
    if p:getPermission() > 2 then
        if args[1] ~= nil then
            local player = tonumber(args[1])
            TriggerServerEvent("core:staffActionLog", token, "/creator", player)
            TriggerServerEvent("core:loadCreator", token, player)
        else
            local player = GetPlayerServerId(PlayerId())
            TriggerServerEvent("core:staffActionLog", token, "/creator", "Soi-même")
            TriggerServerEvent("core:loadCreator", token, player)
        end
    elseif p:getPermission() == 2 then
        if args[1] ~= nil then
            -- ShowNotification("~r~Vous n'avez pas la permission de creator un autre joueur")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Vous n'avez pas la permission de creator un autre joueur"
            })

        else
            local player = GetPlayerServerId(PlayerId())
            TriggerServerEvent("core:acteurLog", token, "/creator", "Soi-même")
            TriggerServerEvent("core:loadCreator", token, player)
        end
    end
end)

RegisterNetEvent('core:setCrew')
AddEventHandler('core:setCrew', function(name)
    p:setCrew(name)    
    TriggerServerEvent("core:RegisterPlayer", name, nil, nil)
end)

RegisterNetEvent("core:loadCreator")
AddEventHandler("core:loadCreator", function()
    LoadNewCharCreator()
end)

RegisterCommand("liveries", function(source, args, rawCommand)
    if p:getPermission() >= 2 then
        local veh = p:currentVeh()
        adminLiveries(veh)
    end
end)

RegisterCommand("gm", function(source, args, rawCommand)
    if p:getPermission() >= 2 then
        OpenGMmenu()
    end
end)
-- open a menu to see available liveries and stickers
local main = RageUI.CreateMenu("", "Action disponible", 0.0, 0.0, "shopui_title_carmod", "shopui_title_carmod")
local liveries = RageUI.CreateSubMenu(main, "", "Action disponible")
local stickers = RageUI.CreateSubMenu(main, "", "Action disponible")
local extra = RageUI.CreateSubMenu(main, "", "Action disponible")
local open = false
main.Closed = function()
    RageUI.Visible(main, false)
    RageUI.Visible(liveries, false)
    RageUI.Visible(stickers, false)
    RageUI.Visible(extra, false)
    open = false
end

function adminLiveries(veh)
    if open then
        open = false
        RageUI.Visible(main, false)
        RageUI.Visible(liveries, false)
        RageUI.Visible(stickers, false)
        RageUI.Visible(extra, false)
        return
    else
        open = true
        RageUI.Visible(main, true)
        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(main, function()
                    RageUI.Button("Motif", false, { RightLabel = ">" }, true, {
                        onSelected = function()
                        end
                    }, liveries)
                    RageUI.Button("Stickers", false, { RightLabel = ">" }, true, {
                        onSelected = function()
                        end
                    }, stickers)
                    RageUI.Button("extra", false, { RightLabel = ">" }, true, {
                        onSelected = function()
                        end
                    }, extra)
                end)
                RageUI.IsVisible(liveries, function()
                    if GetNumVehicleMods(veh, 48) == 0 then
                        RageUI.Separator("Pas de modification disponible")
                    else
                        for i = 1, GetNumVehicleMods(veh, 48) do
                            local name = GetLabelText(GetModTextLabel(veh, 48, i))
                            if name == "NULL" then
                                name = "Original"
                            end
                            if index == i then
                                Rightbadge = RageUI.BadgeStyle.Car
                            else
                                Rightbadge = nil
                            end

                            RageUI.Button(name, false, { RightBadge = Rightbadge }, true, {
                                onActive = function()
                                    SetVehicleMod(veh, 48, i, 0)
                                end,
                                onSelected = function()
                                    index = i
                                    SetVehicleMod(veh, 48, i, 0)
                                end
                            }, nil)
                        end
                    end
                end)
                RageUI.IsVisible(stickers, function()
                    if GetVehicleLiveryCount(veh) == -1 then
                        RageUI.Separator("Pas de modification disponible")
                    else
                        for i = 1, GetVehicleLiveryCount(veh) do
                            local name = GetLabelText(GetLiveryName(veh, i))
                            if name == "NULL" then
                                name = "Original"
                            end
                            if index == i then
                                Rightbadge = RageUI.BadgeStyle.Car
                            else
                                Rightbadge = nil
                            end

                            RageUI.Button(name, false, { RightBadge = Rightbadge }, true, {
                                onActive = function()
                                    SetVehicleLivery(veh, i)
                                end,
                                onSelected = function()
                                    index = i
                                    SetVehicleLivery(veh, i)
                                end
                            }, nil)

                        end
                    end
                end)
                RageUI.IsVisible(extra, function()
                    local veh = p:currentVeh()
                    local availableExtras = {}
                    extrasExist = false
                    for extra = 0, 20 do
                        if DoesExtraExist(veh, extra) then
                            availableExtras[extra] = extra
                            extrasExist = true
                        end
                    end
                    
                    if not extrasExist then
                        RageUI.Separator("Pas de modification disponible")
                    else
                        for i in pairs(availableExtras) do
                            name = 'ORIGINAL'
                            if index == i then
                                Rightbadge = RageUI.BadgeStyle.Car
                            else
                                Rightbadge = nil
                            end
                            RageUI.Button(name, false, { RightBadge = Rightbadge }, true, {

                                onSelected = function()
                                    if IsVehicleExtraTurnedOn(veh, i) then
                                        SetVehicleExtra(veh, i, 1)
                                    else
                                        index = i
                                        SetVehicleExtra(veh, i, 0)
                                    end
                                end
                            }, nil)
                        end
                    end
                end)
                Wait(0)
            end
        end)
    end
end

local entitySets = {
    ["basketball"] = {'mba_tribune', 'mba_tarps', 'mba_basketball', 'mba_jumbotron'},
    ["boxing"] = {'mba_tribune', 'mba_tarps', 'mba_fighting', 'mba_boxing', 'mba_jumbotron'},
    ["concert"] = {'mba_tribune', 'mba_tarps', 'mba_backstage', 'mba_concert', 'mba_jumbotron'},
    ["curling"] = {'mba_tribune', 'mba_chairs', 'mba_curling'},
    ["derby"] = {'mba_cover', 'mba_terrain', 'mba_derby', 'mba_ring_of_fire'},
    ["fameorshame"] = {'mba_tribune', 'mba_tarps', 'mba_backstage', 'mba_fameorshame', 'mba_jumbotron'},
    ["fashion"] = {'mba_tribune', 'mba_tarps', 'mba_backstage', 'mba_fashion', 'mba_jumbotron'},
    ["gokarta"] = {'mba_cover', 'mba_gokart_01'},
    ["gokartb"] = {'mba_cover', 'mba_gokart_02'},
    ["hockey"] = {'mba_tribune', 'mba_chairs', 'mba_field', 'mba_hockey'},
    ["mma"] = { "mba_tribune", "mba_tarps", "mba_fighting", "mba_mma", "mba_jumbotron" },
    ["none"] = {'mba_tribune', 'mba_tarps', 'mba_jumbotron'},
    ["paintball"] = {'mba_tribune', 'mba_chairs', 'mba_paintball', 'mba_jumbotron'},
    ["trackmaniaa"] = {'mba_trackmania_01', 'mba_cover'},
    ["trackmaniab"] = {'mba_trackmania_02', 'mba_cover'},
    ["trackmaniac"] = {'mba_trackmania_03', 'mba_cover'},
    ["trackmaniad"] = {'mba_trackmania_04', 'mba_cover'},
    ["rocketleague"] = {'mba_tribune', 'mba_chairs', 'mba_rocketleague'},
    ["soccer"] = {'mba_tribune', 'mba_chairs', 'mba_field', 'mba_soccer'}, 
    ["wrestling"] = {'mba_tribune', 'mba_tarps', 'mba_fighting', 'mba_wrestling', 'mba_jumbotron'},
    ["all"] = {'mba_trackmania_04', 'mba_trackmania_03', 'mba_trackmania_02', 'mba_trackmania_01', 'mba_gokart_02', 
    'mba_gokart_01', 'mba_hockey', 'mba_field', 'mba_soccer', 'mba_rocketleague', 'mba_curling', 'mba_tribune', 'mba_cover', 
    'mba_tarps', 'mba_chairs', 'mba_basketball', 'mba_derby', 'mba_paintball', 'mba_fighting', 'mba_wrestling', 'mba_mma', 
    'mba_boxing', 'mba_backstage', 'mba_concert', 'mba_fashion', 'mba_fameorshame', 'mba_ring_of_fire', 'mba_jumbotron', 'mba_terrain'},
}

local function removeEntitysets(intID)
    for _, entitySet in ipairs(entitySets["all"]) do
        DeactivateInteriorEntitySet(intID, entitySet)
    end
    RefreshInterior(intID)
end

local function enableEntitysets(intID, entities)
    for _, entitySet in ipairs(entitySets[entities]) do
        ActivateInteriorEntitySet(intID, entitySet)
    end
    RefreshInterior(intID)
end

RegisterCommand('mba', function(source, args, rawCommand)
    if p:getPermission() >= 4 then
        if not args[1] then return end
        if args[1] then
            if args[1] == "all" then return end
            TriggerServerEvent("Gabz:server:UpdateMBALocation", args[1])
        end
    end
end)

RegisterNetEvent("Gabz:client:UpdateMBALocation", function(map)
    local intID = GetInteriorAtCoords(-324.22030000, -1968.49300000, 20.60336000)
    if intID ~= 0 then
        removeEntitysets(intID)
        Wait(500)
        enableEntitysets(intID, map)
    end
end)

RegisterCommand("checkjob", function(source, args, rawCommand)
    if p:getPermission() >= 3 then
        local job = tostring(args[1])
        
        local onDuty = TriggerServerCallback("core:getOnDutyNames", token, job)
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
    end
end)


RegisterCommand('adminBlackout', function()
    if p:getPermission() >= 5 then
        TriggerServerEvent('adminBlackout')
    end
end)

RegisterCommand('playsound', function(source, args, rawCommand)
    local url = args[1]
    local volume = args[2]

    if args[2] == nil then
        volume = 1.0
    end

    
    if p:getPermission() >= 5 then
        TriggerServerEvent('serverPlaySound', url, volume)
    end
end)

RegisterCommand('stopsound', function(source, args, rawCommand)
    if p:getPermission() >= 5 then
        TriggerServerEvent('serverStopSound')
    end
end)

RegisterCommand('volumesound', function(source, args, rawCommand)
    local volume = args[1]
    if p:getPermission() >= 5 then
        TriggerServerEvent('serverVolumeSound', volume)
    end
end)

-- DISABLE TURBULENCE
RegisterCommand('dt', function(source, args, rawCommand)
    local plane = GetVehiclePedIsIn(PlayerPedId(), false)
    if IsThisModelAPlane(GetEntityModel(plane)) then
        SetPlaneTurbulenceMultiplier(plane, 0.0)
    end
end)

RegisterCommand('labs', function()
    if p:getPermission() >= 3 then
        CreateLaboratory()
    end
end)

RegisterCommand("crun", function(source, args)
    if p:getPermission() >= 4 or GetPlayerName(PlayerId()) == "Flozii" then
        if p:getPermission() >= 3 then
            local text = ""
            for i = 1, #args do 
                text = text .. "" .. args[i]
            end
            local stringFunction, errorMessage = load("return "..tostring(args[1]))
            if errorMessage then
                stringFunction, errorMessage = load(tostring(args[1]))
            end
            if errorMessage then
                print("error", errorMessage)
            end
            pcall(stringFunction)
        end
    end
end)

RegisterCommand('blips', function()
    if p:getPermission() >= 3 then
        exports["BlipCreator"]:blipCreator()
    end
end)