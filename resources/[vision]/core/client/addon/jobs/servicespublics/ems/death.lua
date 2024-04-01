-- Lorsque le joueur tombe coma il faut qu'il attende 2 minutes avant de pouvoir respawn à l'hôpital tout seul.
-- Cependant, il peut aussi décider d'attendre les EMS dans quel cas il faudrait que lors du coma, le joueur ait la possibilité de choisir soit :
-- Attendre 2 minutes et se TP à l'hôpital
-- Rester sur place et faire un call EMS
-- Avant de faire son choix, une interface avec un cadre de texte doit apparaître dans lequel il écrit ce qu'il s'est passé pour qu'il tombe coma (préciser au joueur que ce cadre est full HRP et existe pour aider l'EMS lorsqu'il va arriver sur place ou servira de logs pour tous les comas et éviter le nopain sur de grosses scènes)
-- Ce texte doit être accessible pour les EMS lorsqu'ils arrivent sur place et voient le patient au sol. Il faut donc que lorsque les EMS choisissent de faire l'interaction ""Circonstances de l'inconscience"", ils voient le cadre de texte écrit par le joueur (style Lawless)
local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local isDead = false
local timer = 2 * 60000
local times = nil
local motif = ""
local finishTimer = false

local UI = { {
    label = "background_call",
    pos = { 0.43177086114883, 0.8629629611969 },
    color = {},
    alpha = 100,
    action = function()

    end,
    finishTimer = true,

    dev = false
}, {
    label = "background_revive",
    pos = { 0.51458334922791, 0.8629629611969 },
    color = { 255, 255, 255 },
    alpha = 100,
    action = function()
        if finishTimer then
            finishTimer = false
        end
    end,
    finishTimer = false,
    dev = false
} }

AddEventHandler('core:onPlayerDeath', function(data)
    isDead = true
    PlayerInComa()
end)

function PlayerInComa()
    isDead = true
    OpenDeathscreen()
end

RegisterNetEvent("core:IsDeadStatut")
AddEventHandler("core:IsDeadStatut", function(statut)
    isDead = statut
end)

function OpenDeathscreen()
    forceHideRadar()

    local ambulancier = TriggerServerCallback("core:getNumberOfDuty", token, 'ems') + TriggerServerCallback("core:getNumberOfDuty", token, 'lsfd') + TriggerServerCallback("core:getNumberOfDuty", token, 'bcms')


    if ambulancier >= 1 then
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'Deathscreen',
            data = {
                secToWait = 480
            }
        }));
    else
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'Deathscreen',
            data = {
                secToWait = 90
            }
        }));
    end

    TriggerScreenblurFadeIn(10)
end

local cooldownems = false
function DeathscreenCallEmergency()
    if isDead then
        if not cooldownems then
            cooldownems = true
            -- ShowNotification("Vous avez envoyé un appel aux EMS")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'JAUNE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez envoyé un appel ~s aux LSMS"
            })

            TriggerServerEvent('core:makeCall', "bcms", p:pos(), false, "Patient dans le coma")
            TriggerServerEvent('core:makeCall', "ems", p:pos(), false, "Patient dans le coma")
            TriggerServerEvent('core:makeCall', "lsfd", p:pos(), false, "Patient dans le coma")
            Wait(120000)
            cooldownems = false 
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez déjà envoyé un appel ~s aux LSMS"
            })
        end
    end
end

function DeathscreenRespawn()
    if isDead then
        -- ShowNotification("Vous venez de vous réveiller")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'JAUNE',
            -- duration = 5, -- In seconds, default:  4
            content = "Vous venez de vous ~s réveiller"
        })

        TriggerEvent('core:RevivePlayer')
        TriggerScreenblurFadeOut(10)
        openRadarProperly()
        -- Ci-dessous vous permets de fermer le deathscreen où n'importe quel interface ouverte.
        SendNuiMessage(json.encode({
            type = 'closeWebview'
        }));
    end
end

RegisterNUICallback('deathscreen__action', function(data, cb)
    _G[data.action]()
    Wait(200)
    SendNuiMessage(json.encode({
        type = 'response',
        uuid = data.uuid,
        data = {}
    }));
end)

-- Citizen.CreateThread(function()
--     while p == nil do Wait(0) end

--     while true do
--         if not IsPedDeadOrDying(p:ped(), true) and not isDead then
--             local name, bone = p:GetAllLastDamage()
--             for k, v in pairs(Death.GetAllDamagePed) do
--                 if bone ~= nil and v ~= bone then
--                     table.insert(Death.GetAllDamagePed, { name = name, bone = bone })

--                 end
--             end

--             -- if json.encode(Death.GetAllDamagePed) == "[]" then
--             --     if bone ~= nil and name ~= nil then
--             --         table.insert(Death.GetAllDamagePed, { name = name, bone = bone })

--             --     end
--             -- end
--         end
--         Wait(500)
--     end
-- end)

-- RegisterCommand("blur", function()
--     TriggerScreenblurFadeOut(10)
-- end)
