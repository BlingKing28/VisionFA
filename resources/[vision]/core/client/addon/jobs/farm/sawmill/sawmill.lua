local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local hasChar = false
local hasBagToSell = false
local hasPlancheToSell = false
local propsChar = 'prop_wheelbarrow01a'
local nbrSacCopaux = 0
local nbrPlanches = 0
local runPossible = true
local blipCoupe = nil
local blipsSell = nil
local blipKeepCopaux = nil
local blipKeepPlanche = nil

local ped = nil
local created = false
if not created then
    ped = entity:CreatePedLocal("a_f_y_eastsa_03", vector3(-606.65930175781, 5294.3725585938, 69.341659545898),
        264.49014282227)
    created = true
end
SetEntityInvincible(ped.id, true)
ped:setFreeze(true)
TaskStartScenarioInPlace(ped.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
SetEntityAsMissionEntity(ped.id, 0, 0)
SetBlockingOfNonTemporaryEvents(ped.id, true)

zone.addZone("sawmill:keepWood",
    vector3(-545.65313720703, 5383.580078125, 69.471969604492),
    "Appuyer sur ~INPUT_CONTEXT~ pour récupérer le bois",
    function()
        if hasChar then
            return
        else
            keepCharWithWood()
            blipCoupe = AddBlipForCoord(-568.30249023438, 5309.6069335938, 72.600059509277)
            exports['vNotif']:createNotification({
                type = 'JAUNE',
                content = "Allez déposer les planches sur le point GPS"
            })
        end
    end
)

function keepCharWithWood()
    hasChar = true
    ExecuteCommand('e pallet2')
    --sawmill_stopRun()
end

local char = "menu_title_choiceWood"
local open = false
local main = RageUI.CreateMenu("", "Type de coupe", 0.0, 0.0, "vision", char)
function openWoodTransfSelection()
    if open then
        open = false
        RageUI.Visible(main, false)
    else
        open = true

        RageUI.Visible(main, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(main, function()
                    RageUI.Button("~r~Copaux de bois", false, {}, true, {
                        onSelected = function()
                            if hasChar then
                                cutCopaux()
                            end
                        end
                    })
                    RageUI.Button("~r~Planches de bois", false, {}, true, {
                        onSelected = function()
                            if hasChar then
                                cutPlanche()
                            end
                        end
                    })
                end)
                Wait(1)
            end
        end)
    end
end

zone.addZone("transformWood",
    vector3(-568.30249023438, 5309.6069335938, 72.600059509277),
    "Appuyer sur ~INPUT_CONTEXT~ pour transformer le bois",
    function()
        if hasChar then
            char = "menu_title_choiceWood"
            open = false
            openWoodTransfSelection()
            ExecuteCommand('e c')
            runPossible = true
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous n'avez pas de bois"
            })
        end
    end
)

zone.addZone("keepCopaux",
    vector3(-580.04693603516, 5276.2626953125, 69.26530456543),
    "Appuyer sur ~INPUT_CONTEXT~ pour récupérer le sac de copaux",
    function()
        if nbrSacCopaux == 0 then
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Il n'y a aucun sac à récupérer"
            })
        else
            p:PlayAnim('custom@pickfromground', 'pickfromground', 0)
            Wait(6500)
            nbrSacCopaux=nbrSacCopaux-1
            ExecuteCommand('e gbag')
            hasBagToSell = true
            blipsSell = AddBlipForCoord(-606.15734863281, 5294.3686523438, 69.340370178223)
            RemoveBlip(blipKeepCopaux)
            exports['vNotif']:createNotification({
                type = 'JAUNE',
                content = "Allez vendre les planches sur le point GPS"
            })
        end
    end
)

zone.addZone("keepPlanche",
    vector3(-517.23675537109, 5257.38671875, 79.649429321289),
    "Appuyer sur ~INPUT_CONTEXT~ pour récupérer les planches",
    function()
        if nbrPlanches == 0 then
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Il n'y a aucune planche à récupérer"
            })
        else
            nbrPlanches=nbrPlanches-1
            hasPlancheToSell = true
            ExecuteCommand("e palletc1")
            blipsSell = AddBlipForCoord(-606.15734863281, 5294.3686523438, 69.340370178223)
            exports['vNotif']:createNotification({
                type = 'JAUNE',
                content = "Allez vendre les planches sur le point GPS"
            })
            --sawmill_stopRun()
        end
    end
)

zone.addZone("sawmill.sellWood",
    vector3(-606.15734863281, 5294.3686523438, 69.340370178223),
    "Appuyer sur ~INPUT_CONTEXT~ pour récupérer les planches",
    function()
        sawmill_startSell()
    end
)

function cutCopaux()
    RemoveBlip(blipCoupe)
    ClearPedTasksImmediately(PlayerPedId())
    DeleteEntity(propCharWood)
    hasChar = false
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'Progressbar',
        data = {
            text = "Mise en coupe des rondins de bois (copaux)",
            time = 10,
        }
    }))
    Modules.UI.RealWait(4000)
    blipKeepCopaux = AddBlipForCoord(-580.04693603516, 5276.2626953125, 69.26530456543)
    exports['vNotif']:createNotification({
        type = 'JAUNE',
        content = "Allez sur le point GPS"
    })
    nbrSacCopaux = nbrSacCopaux + 1
end

function cutPlanche()
    RemoveBlip(blipCoupe)
    ClearPedTasksImmediately(PlayerPedId())
    DeleteEntity(propCharWood)
    hasChar = false
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'Progressbar',
        data = {
            text = "Mise en coupe des rondins de bois (planches)",
            time = 30,
        }
    }))
    Modules.UI.RealWait(4000)
    blipKeepPlanche = AddBlipForCoord(-517.23675537109, 5257.38671875, 79.649429321289)
    exports['vNotif']:createNotification({
        type = 'JAUNE',
        content = "Allez déposer les planches sur le point GPS"
    })
    nbrPlanches = nbrPlanches + 1
end

function sawmill_startSell()
    if hasBagToSell then
        ExecuteCommand("e c")
        TriggerSecurGiveEvent("core:addItemToInventory", token, "money", 35, {})
        exports['vNotif']:createNotification({
            type = 'DOLLAR',
            content = "Vous avez gagné ~s 35$"
        })
        RemoveBlip(blipKeepCopaux)
        RemoveBlip(blipsSell)
        hasBagToSell = false
    elseif hasPlancheToSell then
        ExecuteCommand("e c")
        runPossible = true
        TriggerSecurGiveEvent("core:addItemToInventory", token, "money", 55, {})
        exports['vNotif']:createNotification({
            type = 'DOLLAR',
            content = "Vous avez gagné ~s 55$"
        })
        RemoveBlip(blipKeepPlanche)
        RemoveBlip(blipsSell)
        hasPlancheToSell = false
    
    else
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "Vous n'avez rien à vendre."
        })
    end
end

function sawmill_stopRun()
    runPossible = false
    CreateThread(function()
        while runPossible == false do
            Wait(1)
            DisableControlAction(0, 21, true)
            DisableControlAction(0, 22, true)
        end
    end)
end