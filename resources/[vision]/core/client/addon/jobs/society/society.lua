local societyInventory = {}
societyInventory.item = {}
societyInventory.cloths = {}
local societyEmployee = {}
local selectedEmployee = {}
local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)


RegisterNetEvent("core:RefreshSocietyInventory")
AddEventHandler("core:RefreshSocietyInventory", function(inventory)
    societyInventory = inventory
end)

RegisterNetEvent("core:GetEmployeeList")
AddEventHandler("core:GetEmployeeList", function(list)
    societyEmployee = list
end)

local society = RageUI.CreateMenu("", "~r~Menu de gestion sociÉtÉ", 0.0, 0.0, "vision", "gestion")
local societyGestion = RageUI.CreateSubMenu(society, "", "~rGestion de sociÉtÉ", 0.0, 0.0, "vision", "gestion")
local societyGestionList = RageUI.CreateSubMenu(societyGestion, "", "~r~Gestion de sociÉtÉ", 0.0, 0.0, "vision",
    "gestion")
local societyGestionEmployee = RageUI.CreateSubMenu(societyGestionList, "", "~r~Gestion de sociÉtÉ", 0.0, 0.0, "vision"
    , "gestion")
local societyListGrade = RageUI.CreateSubMenu(societyGestionEmployee, "", "~r~Gestion de sociÉtÉ", 0.0, 0.0, "vision",
    "gestion")

local open = false
society.Closed = function()
    open = false
    RageUI.Visible(society, false)
end
society.societyInv = function()
    TriggerServerEvent("core:CloseSocietyInventory", pJob)
end

function OpenSocietyMenu()
    if open then
        open = false
        RageUI.Visible(society, false)
        return
    else
        open = true
        RageUI.Visible(society, true)
        TriggerServerEvent("core:GetEmployeeList", token, pJob)
        if loadedJob ~= nil then
            Citizen.CreateThread(function()
                while open do
                    RageUI.IsVisible(society, function()
                        RageUI.Button("Ouvrir la gestion d'entreprise", nil, { RightLabel = ">>" },
                            loadedJob.grade[pJobGrade].gestion, {}, societyGestion);
                    end)

                    RageUI.IsVisible(societyGestion, function()
                        RageUI.Button("Liste des employés", nil, { RightLabel = ">>" }, true, {
                            onSelected = function()
                                TriggerServerEvent("core:GetEmployeeList", token, pJob)
                            end,
                        }, societyGestionList);
                    end)

                    RageUI.IsVisible(societyGestionList, function()
                        for k, v in pairs(societyEmployee) do
                            RageUI.Button(tostring(v.prenom) ..
                                " " ..
                                tostring(v.nom) ..
                                " - (" .. tostring(v.grade) .. ") " .. tostring(loadedJob.grade[v.grade].label), nil,
                                { RightLabel = ">" }, true, {
                                    onSelected = function()
                                        selectedEmployee = v
                                    end,
                                }, societyGestionEmployee)
                        end
                    end)

                    RageUI.IsVisible(societyGestionEmployee, function()
                        RageUI.Separator(selectedEmployee.prenom ..
                            " " ..
                            selectedEmployee.nom ..
                            " - (" .. selectedEmployee.grade ..
                            ") " .. tostring(loadedJob.grade[selectedEmployee.grade].label))
                        RageUI.Button("Virer la personne", nil, {}, true, {
                            onSelected = function()
                                TriggerServerEvent("core:KickPlayerFromJob", token, selectedEmployee.license, pJob)
                                RageUI.GoBack()
                            end,
                        })
                        RageUI.Button("Promouvoir la personne", nil, {}, true, {
                            onSelected = function()
                            end,
                        }, societyListGrade)
                    end)
                    RageUI.IsVisible(societyListGrade, function()
                        for k, v in pairs(loadedJob.grade) do
                            RageUI.Button("(" .. k .. ") " .. v.label, nil, {}, true, {
                                onSelected = function()
                                    TriggerServerEvent("core:PromotePlayer", token, selectedEmployee.license, pJob, k)
                                    RageUI.GoBack2()
                                end,
                            })
                        end
                    end)
                    Wait(1)
                end
            end)
        end
    end
end

local inChoice = false
local selectedPlayer = nil



RegisterCommand("recruter", function()
    if loadedJob ~= nil then
        print(json.encode(loadedJob.grade[pJobGrade]))
        if loadedJob.grade[pJobGrade].gestion ~= nil and loadedJob.grade[pJobGrade].gestion then
            local player = GetAllPlayersInArea(p:pos(), 1.5)
            for k, v in pairs(player) do
                if v == PlayerId() then
                    table.remove(player, k)
                end
            end
            if player ~= nil then
                if next(player) then
                    inChoice = true
                    StartChoiceRecruter(player)
                    if selectedPlayer ~= nil then
                        TriggerServerEvent("core:RecruitPlayer", token, GetPlayerServerId(selectedPlayer), pJob, 1)
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
        end
    end
end)

function StartChoiceRecruter(players)
    -- ShowNotification("Appuyer sur ~g~E~s~ pour valider\nAppuyer sur ~b~L~s~ pour changer de cible\nAppuyer sur ~r~X~s~ pour annuler")

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
            DrawMarker(20, mCoors.x, mCoors.y, mCoors.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255
                , 120, 0, 1, 2, 0, nil, nil, 0)
            if GetGameTimer() > timer then
                --  ShowNotification("~r~Le délai est dépassé")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Le délai a été dépassé"
                })

                inChoice = false
                return
            elseif IsControlJustPressed(0, 51) then -- E
                selectedPlayer = players[1]
                inChoice = false
                return
            elseif IsControlJustPressed(0, 182) then -- C
                table.remove(players, 1)
                if next(players) then
                    timer = GetGameTimer() + 10000
                end
            elseif IsControlJustPressed(0, 73) then -- X
                -- ShowNotification("~r~Vous avez annulé")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'JAUNE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Vous avez ~s annulé"
                })

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

            inChoice = false
            return
        end
        Wait(0)
    end
end
