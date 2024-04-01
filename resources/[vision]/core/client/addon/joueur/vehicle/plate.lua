local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

function ChangePlate()
    local vehicles, dist = GetClosestVehicle(p:pos())
    if #(p:pos() - GetWorldPositionOfEntityBone(vehicles, GetEntityBoneIndexByName(vehicles, "bodyshell"))) <= 3 then
        local newPlate = KeyboardImput("Changement de plaque")
        print('oncar', newPlate, newPlate:match("%W"))
        if newPlate ~= "" and #newPlate <= 8 and newPlate ~= nil then
            if newPlate:match("%W") == nil then
                if not TriggerServerCallback("core:plateExist", newPlate) then
                    local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicles)))
                    local changePlate = TriggerServerCallback("core:ChangePlateVeh", vehicle.getProps(vehicles).plate, string.upper(newPlate), model)
                    print("change", changePlate)
                    RequestAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
                    while not HasAnimDictLoaded('anim@amb@clubhouse@tutorial@bkr_tut_ig3@') do
                        Wait(0)
                    end
                    -- if changePlate then
                    p:PlayAnim('anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1)
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'Progressbar',
                        data = {
                            text = "Changement en cours...",
                            time = 8,
                        }
                    }))
                    Modules.UI.RealWait(8000)
                    ClearPedTasks(p:ped())
                    TriggerServerEvent("core:RemoveItemToInventory", token, "plate", 1, {})
                    vehicle.setProps(vehicles, { plate = string.upper(newPlate) })
                    TriggerServerEvent("core:SetPropsVeh", token, string.upper(newPlate),
                        vehicle.getProps(vehicles))
                    -- ShowNotification("La plaque d'immatriculation a bien été changée")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'VERT',
                        -- duration = 5, -- In seconds, default:  4
                        content = "La plaque d'immatriculation a ~s bien été changée"
                    })

                    -- end
                else
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "La plaque d'immatriculation ~s existe deja"
                    })
                end
            else
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "La plaque d'immatriculation ~s comporte des caractères spéciaux"
                })
            end
        else
            -- ShowNotification("La plaque d'immatriculation doit contenir entre 1 et 8 caractères")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "La plaque d'immatriculation doit contenir ~s entre 1 et 8 caractères"
            })

        end
    end
end

RegisterNetEvent("core:UsePlate")
AddEventHandler("core:UsePlate", function()
    SendNuiMessage(json.encode({
        type = 'closeWebview'
    }))
    ChangePlate()
end)
-- local created = false
-- Citizen.CreateThread(function()
--     local ped = nil
--     if not created then
--         ped = entity:CreatePedLocal("player_two", vector3(1975.1326904297, 3818.6940917969, 32.43628692627),
--             81.998306274414)
--         created = true

--     end
--     SetEntityInvincible(ped.id, true)
--     ped:setFreeze(true)
--     TaskStartScenarioInPlace(ped.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
--     SetEntityAsMissionEntity(ped.id, 0, 0)
--     SetBlockingOfNonTemporaryEvents(ped.id, true)
-- end)

-- zone.addZone(
--     "plate",
--     vector3(1975.098886719, 3818.6213378906, 33.43628692627),
--     "Appuyer sur ~INPUT_CONTEXT~ pour acheter une plaque (~g~50$~s~)",
--     function()
--         if p:pay(50) then
--             TriggerSecurGiveEvent("core:addItemToInventory", token, "plate", 1, {})
--         end
--     end,
--     false,
--     36, 0.5, { 255, 255, 255 }, 255
-- )
