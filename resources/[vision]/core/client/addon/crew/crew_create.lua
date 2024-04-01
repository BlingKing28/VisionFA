local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local open = false
local crewMenu_main = RageUI.CreateMenu("", "Crew", 0.0, 0.0, "vision", "menu_title_crew")
local crewMenu_grade = RageUI.CreateSubMenu(crewMenu_main, "", "Crew", 0.0, 0.0, "vision", "menu_title_crew")
crewMenu_main.Closed = function()
    open = false
end

local crew_cfg = {
    name = "",
    tag = "",
    grade = {
        { name = "Chef", id = 1 },
    }
}

function openCreationCrewMenu()
    if open then
        open = false
        RageUI.Visible(crewMenu_main, false)
    else
        open = true
        RageUI.Visible(crewMenu_main, true)

        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(crewMenu_main, function()
                    RageUI.Button("Nom du crew", nil, { RightLabel = "~o~" .. crew_cfg.name }, true, {
                        onSelected = function()
                            local name = KeyboardImput("Saisissez le nom du crew")
                            if type(name) == "string" and name ~= nil then
                                crew_cfg.name = name
                            end
                        end
                    }, nil)
                    RageUI.Button("Tag du crew", nil, { RightLabel = "~o~" .. crew_cfg.tag }, true, {
                        onSelected = function()
                            local tag = KeyboardImput("Saisissez le tag du crew (4 caractères max)")
                            if type(tag) == "string" and tag ~= nil then
                                if GetLengthOfString(tag) <= 4 then
                                    crew_cfg.tag = tag
                                else
                                    -- ShowNotification("~r~Vous devez saisir un tag de 4 caractères maximum")

                                    -- New notif
                                    exports['vNotif']:createNotification({
                                        type = 'ROUGE',
                                        -- duration = 5, -- In seconds, default:  4
                                        content = "~s Vous devez saisir un tag de 4 caractères maximum"
                                    })

                                end
                            end
                        end
                    }, nil)
                    RageUI.Button("Modifier le rang", nil, {}, true, {}, crewMenu_grade)
                    RageUI.Button("Créer le crew", nil, { RightLabel = ">" }, true, {
                        onSelected = function()
                            if crew_cfg.name ~= "" and crew_cfg.tag ~= "" then
                                for k, v in pairs(crew_cfg.grade) do
                                    if v.name == "" then
                                        -- ShowNotification("~r~Vous devez saisir un nom pour chaque rang")

                                        -- New notif
                                        exports['vNotif']:createNotification({
                                            type = 'ROUGE',
                                            -- duration = 5, -- In seconds, default:  4
                                            content = "~s Vous devez saisir un nom pour chaque rang"
                                        })

                                        return
                                    end
                                end
                                TriggerServerEvent('core:CreateCrew', token, crew_cfg)
                                RageUI.CloseAll()
                                open = false
                            else
                                -- ShowNotification("~r~Vous devez saisir un nom et un tag")

                                -- New notif
                                exports['vNotif']:createNotification({
                                    type = 'ROUGE',
                                    -- duration = 5, -- In seconds, default:  4
                                    content = "~s Vous devez saisir un nom et un tag"
                                })

                            end
                        end
                    }, nil)
                end)
                RageUI.IsVisible(crewMenu_grade, function()
                    RageUI.Button("~g~Créer d'autres rangs", nil, { RightLabel = ">" }, true, {
                        onSelected = function()
                            if #crew_cfg.grade < 5 then
                                local newGrade = KeyboardImput("Saissisez le nom du rang")
                                if type(newGrade) == "string" and newGrade ~= nil then
                                    table.insert(crew_cfg.grade, { name = newGrade, id = #crew_cfg.grade + 1 })
                                end
                            else
                                -- ShowNotification("~r~Vous ne pouvez pas créer plus de 5 rangs")

                                -- New notif
                                exports['vNotif']:createNotification({
                                    type = 'ROUGE',
                                    -- duration = 5, -- In seconds, default:  4
                                    content = "~s Vous ne pouvez pas créer plus de 5 rangs"
                                })

                            end
                        end
                    }, nil)
                    for k, v in pairs(crew_cfg.grade) do
                        RageUI.Button(v.name, nil, { RightLabel = "~o~" .. v.id }, true, {
                            onSelected = function()
                                local gradeName = KeyboardImput("Saissisez le nom du rang")
                                if type(gradeName) == "string" and gradeName ~= nil then
                                    crew_cfg.grade[k].name = gradeName
                                end
                            end
                        }, nil)
                    end
                end)
                Wait(1)
            end
        end)
    end
end

-- RegisterCommand("createcrew", function()
--     if p:getCrew() == "None" then
--         openCreationCrewMenu()
--     else
--         -- ShowNotification("Vous êtes déja dans un crew")

--         -- New notif
--         exports['vNotif']:createNotification({
--             type = 'ROUGE',
--             -- duration = 5, -- In seconds, default:  4
--             content = "~s Vous êtes déja dans un crew"
--         })

--     end
-- end)
