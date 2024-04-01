local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local lockedAnimalList = {}
local isSkinning = false
local hunterservice = false
local missionStart = false
local sold = false
local huntingAnimals = {
    { ped = "a_c_boar", meat = "sanglier" },
    { ped = "a_c_deer", meat = "biche" },
    { ped = "a_c_rabbit_01", meat = "lapin" },
    { ped = "a_c_pigeon", meat = "oiseau" },
    { ped = "a_c_seagull", meat = "oiseau" },
    { ped = "a_c_chickenhawk", meat = "oiseau" },
}
function LoadChasse()
    local ped = nil
    local created = false
    if not created then
        ped = entity:CreatePedLocal("s_m_m_linecook", vector3(-1492.4255371094, 4979.1196289063, 62.418014526367),
            87.082588195801)
        created = true
    end
    SetEntityInvincible(ped.id, true)
    ped:setFreeze(true)
    TaskStartScenarioInPlace(ped.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
    SetEntityAsMissionEntity(ped.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped.id, true)

    zone.addZone("serviceHunt", -- Nom
        vector3(-1492.4255371094, 4979.1196289063, 63.418014526367), -- Position
        "Appuyer sur ~INPUT_CONTEXT~ pour prendre votre service", -- Text afficher
        function() -- Action qui seras fait
            StartHunting()
        end,
        false
    )
end

RegisterNetEvent("hunt:animalLock")
AddEventHandler("hunt:animalLock", function(lockedAnimal)
    table.insert(lockedAnimalList, lockedAnimal)
end)

local function SpawnChasseAnimals()
    TriggerServerEvent("TREFSDFD5156FD", "ADSFDF", 2*60000)
    TriggerServerEvent("TREFSDFD5156FD", "IOAPP", 30000)
    Wait(3000)
    CreateThread(function()
        for i = 1, 20, 1 do
            math.randomseed(GetGameTimer())
            local animal = huntingAnimals[math.random(1, #huntingAnimals)]
            -- randomly chooses a index from the Chasseur table
            math.randomseed(GetGameTimer())
            local random = math.random(1, #Chasseur)
            -- spawns the animal
            local animalPed = entity:CreatePed(animal.ped, Chasseur[random], 0.0)
            SetEntityAsMissionEntity(animalPed.id, 0, 0)
            --make the animal move around
            TaskWanderStandard(animalPed.id, 10.0, 10)
            Wait(1500)
        end
    end)
end

function StartHunting()
    if hunterservice then
        hunterservice = false
        RemoveBlip(blips)
        missionStart = false
        blips = nil
        service = false
        -- TriggerEvent("core:ShowNotification", "~r~Vous avez quitté votre service de chasse")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "Vous avez ~s quitté votre service ~c de chasse"
        })

    else
        hunterservice = true
        missionStart = true
        -- show on screen notification
        -- ShowNotification("Vous pouvez commencer à chasser")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'JAUNE',
            -- duration = 5, -- In seconds, default:  4
            content = "Vous pouvez ~s commencer ~c à chasser"
        })

        -- set the hunting area on the players map
        CreateThread(function()
            while missionStart do
                if blips ~= nil then
                    RemoveBlip(blips)
                end
                blips = AddBlipForRadius(-1073.3568115234, 4376.8896484375, 12.356980323792, 600.0)
                SetBlipSprite(blips, 9)
                SetBlipColour(blips, 1)
                SetBlipAlpha(blips, 100)
                Wait(15 * 60000)
            end
        end)
        TriggerServerEvent("TREFSDFD5156FD", "ADSFDF", 2*60000)
        Wait(1000)
        -- spawn the animals in the area
        SpawnChasseAnimals()
        CreateThread(function()
            while missionStart do
                while #(p:pos().xyz - vector3(-1073.3568115234, 4376.8896484375, 12.356980323792)) <= 600 do
                    Wait(500)
                    local playerPed = PlayerPedId()
                    local playerCoords = GetEntityCoords(playerPed)
                    -- find the closest dead animal
                    local random, animal = FindFirstPed()
                    repeat
                        if not IsPedAPlayer(animal) and not IsPedInAnyVehicle(playerPed) and
                            not IsPedInAnyVehicle(animal) then
                            -- check if animal model is in the huntingAnimals table
                            for k, v in pairs(huntingAnimals) do
                                if GetEntityModel(animal) == GetHashKey(v.ped) then
                                    -- check if the player is close enough to the animal
                                    local animalCoords = GetEntityCoords(animal)
                                    local distance = #(playerCoords - animalCoords)
                                    while distance <= 3.0 and IsPedDeadOrDying(animal) do
                                        Wait(1)
                                        distance = #(p:pos() - GetEntityCoords(animal))
                                        DrawLine(p:pos(), vector3(animalCoords.x, animalCoords.y, animalCoords.z), 255,
                                            255, 255, 170);
                                        Modules.UI.Draw3DText(animalCoords.x, animalCoords.y, animalCoords.z,
                                            "Appuyer sur ~g~G~s~ pour dépecer l'animal", 4, 0.05, 0.05)
                                        if IsControlJustPressed(0, 47) then
                                            -- check if the player has a knife
                                            if HasPedGotWeapon(playerPed, GetHashKey("WEAPON_KNIFE"), false) then
                                                -- check if the player is not already skinning an animal
                                                if not isSkinning then
                                                    local animalId = NetworkGetNetworkIdFromEntity(animal)
                                                    sold = false
                                                    for k, v in pairs(lockedAnimalList) do
                                                        if v == animalId then
                                                            sold = true
                                                        end
                                                    end
                                                    if sold == false then
                                                        isSkinning = true
                                                        -- load the skinning animation
                                                        RequestAnimDict("amb@world_human_gardener_plant@male@base")
                                                        while not
                                                            HasAnimDictLoaded("amb@world_human_gardener_plant@male@base") do Wait(0) end
                                                        -- play the animation
                                                        TaskPlayAnim(playerPed,
                                                            "amb@world_human_gardener_plant@male@base", "base", 1.0, 1.0
                                                            , 0.7, 120, 0.2, 1, 1, 1)
                                                        Wait(5000)
                                                        StopAnimTask(pid, "amb@world_human_gardener_plant@male@base",
                                                            "base", 1.0)
                                                        -- give item depending on the animal
                                                        for _, animals in pairs(huntingAnimals) do
                                                            if GetEntityModel(animal) == GetHashKey(animals.ped) then
                                                                TriggerSecurGiveEvent("core:addItemToInventory", token,
                                                                    animals.meat, 1, {})

                                                                --[[ Ancienne notification
                                                                -- ShowNotification("~g~Tu as récupéré 1x ~o~ Viande de "
                                                                    .. animals.meat)
                                                                ---]]

                                                                -- New notif
                                                                exports['vNotif']:createNotification({
                                                                    type = 'JAUNE',
                                                                    -- duration = 5, -- In seconds, default:  4
                                                                    content = "Tu as récupéré ~s 1x Viande de ".. animals.meat
                                                                })

                                                            end
                                                        end
                                                        -- can't skin the animal again
                                                        TriggerServerEvent("hunt:animalLock", animalId)
                                                        SetEntityAsNoLongerNeeded(animal)
                                                        ClearPedTasksImmediately(playerPed)
                                                        isSkinning = false
                                                    else
                                                        -- ShowNotification("~r~Cet animal a déja été dépecé")

                                                        -- New notif
                                                        exports['vNotif']:createNotification({
                                                            type = 'ROUGE',
                                                            -- duration = 5, -- In seconds, default:  4
                                                            content = "~s Cet animal a déja été dépecé"
                                                        })

                                                    end
                                                end
                                            else
                                                -- ShowNotification("~r~Vous n'avez pas de couteau")

                                                -- New notif
                                                exports['vNotif']:createNotification({
                                                    type = 'ROUGE',
                                                    -- duration = 5, -- In seconds, default:  4
                                                    content = "~s Vous n'avez pas de couteau en main"
                                                })

                                            end
                                        end
                                    end
                                end
                            end
                        end
                        success, animal = FindNextPed(random)
                    until not success
                    EndFindPed(random)
                end
                Wait(500)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while p == nil do Wait(1000) end
    Wait(1000)
    LoadChasse()
    print("[INFO] La chasse a été chargée correctement")
end)
