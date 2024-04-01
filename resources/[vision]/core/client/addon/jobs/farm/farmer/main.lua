local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local planting = false
local canPlant = true
local harvesting = false
local plantedField = {}
local plants = 0
local field = nil
local blip = nil
local blip2 = nil
local blipReturn = nil
local veh = nil
local marker = nil
local created_marker = false
local safecoords = nil
local harvest = false
local vehOut = false
local harvested = 0
local amount = 1
local pos = {
    vector3(2135.3208007813, 5159.4609375, 52.31623840332),
    vector3(2304.826171875, 5126.3618164063, 50.152099609375),
    vector3(1954.7097167969, 4792.111328125, 43.510902404785),
    vector3(1915.8273925781, 4762.81640625, 42.809593200684),
}

local vegetables = {
    {
        name = "tomato",
        luck = 25,
        price = 9,
        count = 0,
        index = 1,
    },
    {
        name = "salad",
        luck = 25,
        price = 11,
        count = 0,
        index = 1,
    },
    {
        name = "oignon",
        luck = 18,
        price = 15,
        count = 0,
        index = 1,
    },
    {
        name = "cucumber",
        luck = 18,
        price = 18,
        count = 0,
        index = 1,
    },
    {
        name = "chou",
        luck = 14,
        price = 22,
        count = 0,
        index = 1,
    },
}


local RollTable = {}

for i = 1, #vegetables do
    for j = 1, vegetables[i].luck do
        table.insert(RollTable, vegetables[i].name)
    end
end

local function Roll() --> ObjectName [string]
    math.randomseed(GetGameTimer())
    return RollTable[math.random(1, #RollTable)]
end

function GetItemLabel(item)
    return items[item].label
end

local open = false
local mainMenu = RageUI.CreateMenu("Ferme", "Action disponible")
local subMenu = RageUI.CreateSubMenu(mainMenu, "Ferme", "Action disponible")
mainMenu.Closed = function()
    open = false
    RageUI.Visible(mainMenu, false)
end

local marketMenu = RageUI.CreateMenu("Ferme", "Action disponible")
local subMenu = RageUI.CreateSubMenu(marketMenu, "Ferme", "Action disponible")
marketMenu.Closed = function()
    open = false
    RageUI.Visible(marketMenu, false)
end

local farmItem = {}
for i = 1, 10 do
    table.insert(farmItem, i)
end

function OpenFarmMarket()
    if open then
        open = false
        RageUI.Visible(marketMenu, false)
        return
    else
        open = true
        RageUI.Visible(marketMenu, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(marketMenu, function()
                    for k, v in pairs(vegetables) do
                        RageUI.List(GetItemLabel(v.name), farmItem, v.index, nil,
                            { RightLabel = "~g~" .. v.price .. "$" }
                            , true, {
                            onListChange = function(Index, Item)
                                v.index = Index
                            end,
                            onSelected = function()
                                TriggerServerEvent("core:sellFarmer", token, v.name, v.price, v.index)
                            end
                        })
                    end
                end)
                Wait(1)
            end
        end)
    end
end

local items = {
    headerBanner = 'assets/MenuMetier/ferme.jpg',
    choice = {
        label = 'Location de bateaux',
        isOptional = true,
        choices = {
            {
                id = 1,
                label = 'Plantation',
                img = 'assets/placeholder.png'
            },
            {
                id = 2,
                label = 'Recolte',
                img = 'assets/placeholder.png'
            },
            {
                id = 3,
                label = 'Livraison',
                img = 'assets/placeholder.png'
            },
        },

    },
    callbackName = 'MetierFerme'
}

function OpenFarmMenu()
    if open then
        open = false
        RageUI.Visible(mainMenu, false)
        return
    else
        open = true
        RageUI.Visible(mainMenu, true)
        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    -- RageUI.Button("Tenue (non livrées pour le moment)", "Prendre une tenue", {RightLabel = "→→→"}, true, {
                    --     onSelected = function()
                    --         giveTenue()
                    --     end
                    -- }, nil)
                    RageUI.Button("Planter", "Planter des légumes", { RightLabel = "→→→" }, canPlant, {
                        onSelected = function()
                            startPlant()
                        end
                    }, nil)
                    RageUI.Button("Récolter", "Récolter les légumes", { RightLabel = "→→→" }, harvesting, {
                        onSelected = function()
                            startHarvest()
                        end
                    }, nil)
                    RageUI.Button("Transport", "Louer un speedo", { RightLabel = "~g~200 $" }, true, {
                        onSelected = function()
                            spawnSpeedo()
                        end
                    }, nil)
                end)
                Wait(1)
            end
        end)
    end
end

function giveTenue()
    -- ShowNotification("TODO :)")

    -- New notif
    exports['vNotif']:createNotification({
        type = 'VERT',
        -- duration = 5, -- In seconds, default:  4
        content = "~s TODO :)"
    })

end

function startPlant()
    -- check if spawnpoint is free
    if vehicle.IsSpawnPointClear(vector3(1967.2694091797, 5176.5483398438, 47.825859069824), 3.0) then
        if not vehOut then
            TriggerServerEvent("TREFSDFD5156FD", "VZEFDSF", 5000)
            RageUI.CloseAll()
            local car = GetHashKey("tractor2")
            local trailer = GetHashKey("raketrailer")
            -- Request the model
            RequestModel(car)
            RequestModel(trailer)
            -- Wait for the model to load
            while not HasModelLoaded(car) or not HasModelLoaded(trailer) do
                Wait(1)
            end
            open = false
            if DoesEntityExist(veh) then
                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                DeleteEntity(veh)
            end
            veh = CreateVehicle(car, 1967.2694091797, 5176.5483398438, 47.825859069824, 167.26759338379, true, false)
            local plate = vehicle.getProps(veh).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, veh, VehToNet(veh), p:getJob())
            createKeys(plate, model)
            TriggerServerEvent("core:GiveVehicleKeyToPlayer", token, GetVehicleNumberPlateText(veh))
            -- Create the trailer
            local trailer = CreateVehicle(trailer, 1967.9958496094, 5182.1762695313, 47.933406829834, 24.786817550659,
                true, false)
            vehOut = true
            SetVehicleOnGroundProperly(veh)
            SetVehicleOnGroundProperly(trailer)

            SetModelAsNoLongerNeeded(car)
            SetModelAsNoLongerNeeded(trailer)
            -- start the planting
            planting = true
            canPlant = false
            math.randomseed(GetGameTimer())
            field = math.random(1, #pos)
            -- create a blip on the center of the field and create a zone inside which the planting points can be spawned
            RemoveBlip(blip)
            RemoveBlip(blip2)
            blip = AddBlipForCoord(pos[field])
            blip2 = AddBlipForRadius(pos[field], 40.0)
            SetBlipSprite(blip, 1)
            SetBlipColour(blip, 2)
            SetBlipRoute(blip, true)
            SetBlipSprite(blip2, 9)
            SetBlipColour(blip2, 2)
            harvesting = false
            harvest = false
            -- ShowNotification("Rendez-vous sur le champ !")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'JAUNE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Rendez-vous sur le champ !"
            })

        else
            -- ShowNotification("Vous avez déjà un véhicule sorti")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Vous avez déjà un véhicule sorti"
            })

        end
    else
        -- ShowNotification("Le point de sortie est occupé")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Le point de sortie est occupé"
        })

    end
end

function startHarvest()
    -- check if spawnpoint is free
    if vehicle.IsSpawnPointClear(vector3(1965.6278076172, 5173.873046875, 47.826145172119), 3.0) then
        if not vehOut then
            TriggerServerEvent("TREFSDFD5156FD", "VZEFDSF", 5000)
            RageUI.CloseAll()
            local car = GetHashKey("tractor2")
            local trailer = GetHashKey("graintrailer")
            -- Request the model
            RequestModel(car)
            RequestModel(trailer)
            -- Wait for the model to load
            while not HasModelLoaded(car) or not HasModelLoaded(trailer) do
                Wait(1)
            end
            open = false
            if DoesEntityExist(veh) then
                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                DeleteEntity(veh)
            end
            veh = CreateVehicle(car, 1965.6278076172, 5173.873046875, 47.826145172119, 162.05107116699, true, false)
            local plate = vehicle.getProps(veh).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, veh, VehToNet(veh), p:getJob())
            createKeys(plate, model)
            TriggerServerEvent("core:GiveVehicleKeyToPlayer", token, GetVehicleNumberPlateText(veh))
            -- Create the trailer
            local trailer = CreateVehicle(trailer, 1968.2830810547, 5181.6782226563, 47.924205780029, 10.54908674955368,
                true, false)
            -- Attach the trailer to the vehicle
            Wait(100)
            AttachVehicleToTrailer(veh, trailer, 4.0)
            SetVehicleOnGroundProperly(veh)
            SetVehicleOnGroundProperly(trailer)

            SetModelAsNoLongerNeeded(car)
            SetModelAsNoLongerNeeded(trailer)
            -- start the planting
            harvest = true
            math.randomseed(GetGameTimer())
            field = math.random(1, #pos)
            -- create a blip on the center of the field and create a zone inside which the planting points can be spawned
            RemoveBlip(blip)
            RemoveBlip(blip2)
            blip = AddBlipForCoord(pos[field])
            blip2 = AddBlipForRadius(pos[field], 40.0)
            SetBlipSprite(blip, 1)
            SetBlipColour(blip, 2)
            SetBlipRoute(blip, true)
            SetBlipSprite(blip2, 9)
            SetBlipColour(blip2, 2)
            planting = false
            -- ShowNotification("Rendez-vous sur le champ !")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'JAUNE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Rendez-vous sur le champ !"
            })

        else
            -- ShowNotification("Vous avez déjà un véhicule sorti")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Vous avez déjà un véhicule sorti"
            })

        end
    else
        -- ShowNotification("Le point de sortie est occupé")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Le point de sortie est occupé"
        })

    end
end

function spawnSpeedo()
    -- for 200$ you can rent a speedo
    if not vehOut then
        if p:pay(200) then
            RageUI.CloseAll()
            local car = GetHashKey("speedo")
            TriggerServerEvent("TREFSDFD5156FD", "VZEFDSF", 5000)
            -- Request the model
            RequestModel(car)
            -- Wait for the model to load
            while not HasModelLoaded(car) do
                Wait(1)
            end
            open = false
            if DoesEntityExist(veh) then
                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                DeleteEntity(veh)
            end
            veh = CreateVehicle(car, 1967.2694091797, 5176.5483398438, 47.825859069824, 167.26759338379, true, false)
            local plate = vehicle.getProps(veh).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, veh, VehToNet(veh), p:getJob())
            createKeys(plate, model)
            TriggerServerEvent("core:GiveVehicleKeyToPlayer", token, GetVehicleNumberPlateText(veh))
            vehOut = true
            SetVehicleOnGroundProperly(veh)
            SetModelAsNoLongerNeeded(car)
            -- ShowNotification("Vous avez loué un speedo pour 200$")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'JAUNE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s loué un speedo ~c pour ~s 200$"
            })

        else
            -- ShowNotification("Vous n'avez pas assez d'argent")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Vous n'avez pas assez d'argent"
            })

        end
    else
        -- ShowNotification("Vous avez déjà un véhicule sorti")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Vous avez déjà un véhicule sorti"
        })

    end
end

CreateThread(function()
    while true do
        local pNear = false

        if planting then
            pNear = true
            local playerCoords = GetEntityCoords(PlayerPedId())
            -- when the vehicle is in the fiel, generate random planting points in the field
            local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, pos[field].x,
                pos[field].y, pos[field].z, true)
            if distance < 40 then
                if IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), GetHashKey("tractor2")) then
                    RemoveBlip(blip)
                    RemoveBlip(blip2)
                    math.randomseed(GetGameTimer())
                    local x = pos[field].x + math.random(-17, 17)
                    math.randomseed(GetGameTimer())
                    local y = pos[field].y + math.random(-17, 17)
                    local ground, z = GetGroundZFor_3dCoord(x, y, pos[field].z, 1)
                    while not ground do
                        math.randomseed(GetGameTimer())
                        x = pos[field].x + math.random(-17, 17)
                        math.randomseed(GetGameTimer())
                        y = pos[field].y + math.random(-17, 17)
                        ground, z = GetGroundZFor_3dCoord(x, y, pos[field].z, 1)
                        Wait(2)
                    end
                    -- generate random planting points in the field
                    while plants < 5 and distance <= 80.0 do
                        -- set a marker on the planting point
                        if not created_marker then
                            marker = AddBlipForCoord(x, y, z)
                            SetBlipSprite(marker, 1)
                            SetBlipColour(marker, 2)
                            SetBlipRoute(marker, true)
                            created_marker = true
                        end
                        DrawMarker(1, x, y, z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 255, 0, 0, 0, 0, 0, 0, 0)
                        -- if the player is near the planting point, plant the seed
                        if #(GetEntityCoords(PlayerPedId()) - vector3(x, y, z)) < 2 and
                            IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), GetHashKey("tractor2")) then
                            plants = plants + 1
                            SendNuiMessage(json.encode({
                                type = 'openWebview',
                                name = 'Progressbar',
                                data = {
                                    text = "Vous plantez la graine...",
                                    time = 30,
                                }
                            }))
                            Wait(30000)
                            -- ShowNotification("Vous avez planté une graine")

                            -- New notif
                            exports['vNotif']:createNotification({
                                type = 'JAUNE',
                                -- duration = 5, -- In seconds, default:  4
                                content = "Vous avez ~s planté une graine"
                            })

                            math.randomseed(GetGameTimer())
                            x = pos[field].x + math.random(-17, 17)
                            math.randomseed(GetGameTimer())
                            y = pos[field].y + math.random(-17, 17)
                            ground, z = GetGroundZFor_3dCoord(x, y, pos[field].z, 1)
                            while not ground do
                                math.randomseed(GetGameTimer())
                                x = pos[field].x + math.random(-17, 17)
                                math.randomseed(GetGameTimer())
                                y = pos[field].y + math.random(-17, 17)
                                ground, z = GetGroundZFor_3dCoord(x, y, pos[field].z, 1)
                                Wait(2)
                            end
                            RemoveBlip(marker)
                            created_marker = false
                        end
                        distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, pos[field].x
                            , pos[field].y, pos[field].z, true)
                        Wait(0)
                    end
                    if plants == 5 then
                        -- show a notification
                        -- ShowNotification("Vous avez planté toutes les graines, vous pourrez récolter dans 10 minutes")

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez ~s planté toutes les graines, ~c vous pourrez récolter ~s dans 10 minutes"
                        })

                        -- ShowNotification("Ramenez moi le tracteur")

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Ramenez moi le tracteur"
                        })

                        -- set a blip on the npc menu
                        blipReturn = AddBlipForCoord(1971.4141845703, 5162.6064453125, 47.639122009277)
                        SetBlipSprite(blipReturn, 1)
                        SetBlipColour(blipReturn, 2)
                        SetBlipRoute(blipReturn, true)
                        -- set a timer to 5 minutes
                        planting = false
                        plants = 0
                        Wait(300000)
                        -- ShowNotification("Plus que 5 minutes avant de pouvoir récolter")

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'CLOCHE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Plus que ~s 5 minutes ~c avant de pouvoir récolter"
                        })

                        Wait(240000)
                        -- ShowNotification("Plus que 1 minute avant de pouvoir récolter")

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'CLOCHE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Plus que ~s 1 minutes ~c avant de pouvoir récolter"
                        })

                        Wait(60000)
                        -- ShowNotification("Vous pouvez maintenant récolter")

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'CLOCHE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous pouvez ~s maintenant ~c récolter"
                        })

                        harvesting = true
                    else
                        -- ShowNotification("Vous vous êtes trop éloigné du champ")

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'ROUGE',
                            duration = 5, -- In seconds, default:  4
                            content = "~s Vous vous êtes trop éloigné du champ"
                        })

                        RemoveBlip(marker)
                        RemoveBlip(blip)
                        RemoveBlip(blip2)
                        planting = false
                        harvesting = false
                        plants = 0
                    end
                else
                    -- show a notification
                    -- ShowNotification("Vous n'êtes pas dans le bon véhicule")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Vous n'êtes pas dans le bon véhicule"
                    })

                end
            end
        elseif harvest then
            pNear = true
            local playerCoords = GetEntityCoords(PlayerPedId())
            -- when the vehicle is in the fiel, generate random planting points in the field
            local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, pos[field].x,
                pos[field].y, pos[field].z, true)
            if distance < 40 then
                vehs = GetVehiclePedIsUsing(GetPlayerPed(-1))
                _, trailer_model = GetVehicleTrailerVehicle(vehs)
                if IsVehicleModel((vehs), GetHashKey("tractor2")) and
                    IsVehicleModel((trailer_model), GetHashKey("graintrailer")) then
                    RemoveBlip(blip)
                    RemoveBlip(blip2)
                    math.randomseed(GetGameTimer())
                    local x = pos[field].x + math.random(-17, 17)
                    math.randomseed(GetGameTimer())
                    local y = pos[field].y + math.random(-17, 17)
                    local ground, z = GetGroundZFor_3dCoord(x, y, pos[field].z, 1)
                    while not ground do
                        math.randomseed(GetGameTimer())
                        x = pos[field].x + math.random(-17, 17)
                        math.randomseed(GetGameTimer())
                        y = pos[field].y + math.random(-17, 17)
                        ground, z = GetGroundZFor_3dCoord(x, y, pos[field].z, 1)
                        Wait(2)
                    end
                    -- generate random planting points in the field
                    while harvested < 5 and distance <= 80.0 do
                        -- set a marker on the planting point
                        if not created_marker then
                            marker = AddBlipForCoord(x, y, z)
                            SetBlipSprite(marker, 1)
                            SetBlipColour(marker, 2)
                            SetBlipRoute(marker, true)
                            created_marker = true
                        end
                        DrawMarker(1, x, y, z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 255, 0, 0, 0, 0, 0, 0, 0)
                        vehs = GetVehiclePedIsUsing(GetPlayerPed(-1))
                        _, trailer_model = GetVehicleTrailerVehicle(vehs)
                        if #(GetEntityCoords(PlayerPedId()) - vector3(x, y, z)) < 2 and
                            IsVehicleModel(vehs, GetHashKey("tractor2")) and
                            IsVehicleModel((trailer_model), GetHashKey("graintrailer")) then
                            math.randomseed(GetGameTimer())
                            amount = math.floor(math.random(5, 10))
                            SendNuiMessage(json.encode({
                                type = 'openWebview',
                                name = 'Progressbar',
                                data = {
                                    text = "Vous récoltez les pousses...",
                                    time = 30,
                                }
                            }))
                            for i = 1, amount do
                                loot = Roll()
                                -- add 1 to the item count variable
                                for k, v in pairs(vegetables) do
                                    if v.name == loot then
                                        v.count = v.count + 1
                                    end
                                end
                            end
                            -- wait 30 seconds
                            Wait(30000)
                            for k, v in pairs(vegetables) do
                                if v.count > 0 then
                                    TriggerSecurGiveEvent("core:addItemToInventory", token, v.name, v.count, {})
                                    -- ShowNotification("Tu as récolté ~o~" .. v.count .. "x " .. GetItemLabel(v.name))

                                    -- New notif
                                    exports['vNotif']:createNotification({
                                        type = 'JAUNE',
                                        -- duration = 5, -- In seconds, default:  4
                                        content = "Tu as récolté ~s " .. v.count .. "x " .. GetItemLabel(v.name)
                                    })

                                    v.count = 0
                                end
                            end
                            math.randomseed(GetGameTimer())
                            x = pos[field].x + math.random(-17, 17)
                            math.randomseed(GetGameTimer())
                            y = pos[field].y + math.random(-17, 17)
                            ground, z = GetGroundZFor_3dCoord(x, y, pos[field].z, 1)
                            while not ground do
                                math.randomseed(GetGameTimer())
                                x = pos[field].x + math.random(-17, 17)
                                math.randomseed(GetGameTimer())
                                y = pos[field].y + math.random(-17, 17)
                                ground, z = GetGroundZFor_3dCoord(x, y, pos[field].z, 1)
                                Wait(2)
                            end
                            RemoveBlip(marker)
                            created_marker = false
                            harvested = harvested + 1
                        end
                        distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, pos[field].x
                            , pos[field].y, pos[field].z, true)
                        Wait(0)
                    end
                    if harvested == 5 then
                        -- show a notification
                        -- ShowNotification("Vous avez récolté tous les légumes, rendez votre véhicule et allez vendre vos légumes")

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez ~s récolté tous les légumes,~c rendez votre véhicule et allez vendre vos légumes"
                        })

                        -- set a blip on the npc menu
                        blipReturn = AddBlipForCoord(1971.4141845703, 5162.6064453125, 47.639122009277)
                        SetBlipSprite(blipReturn, 1)
                        SetBlipColour(blipReturn, 2)
                        SetBlipRoute(blipReturn, true)
                        -- set a timer to 5 minutes
                        planting = false
                        harvested = 0
                        harvesting = false
                        canPlant = true
                        harvest = false
                    else
                        -- ShowNotification("Vous vous êtes trop éloigné du champ")

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'ROUGE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "~s Vous vous êtes trop éloigné du champ"
                        })

                        RemoveBlip(marker)
                        RemoveBlip(blip)
                        RemoveBlip(blip2)
                        planting = false
                        harvesting = false
                        harvested = 0
                        harvest = false
                    end
                else
                    -- show a notification
                    -- ShowNotification("Vous n'êtes pas dans le bon véhicule ou vous n'avez pas de remorque")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Vous n'êtes pas dans le bon véhicule ou vous n'avez pas de remorque"
                    })

                end
            end
        end
        if pNear then
            Wait(1)
        else
            Wait(500)
        end

    end
end)

CreateThread(function()
    local ped = entity:CreatePedLocal("a_m_m_farmer_01", vector3(1969.5881347656, 5168.365234375, 46.63907623291),
        135.3509979248)
    SetEntityInvincible(ped.id, true)
    ped:setFreeze(true)
    TaskStartScenarioInPlace(ped.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
    SetEntityAsMissionEntity(ped.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped.id, true)

    local ped2 = entity:CreatePedLocal("a_m_m_hillbilly_01", vector3(416.86071777344, 6520.732421875, 26.712577819824),
        272.66473388672)
    SetEntityInvincible(ped2.id, true)
    ped2:setFreeze(true)
    TaskStartScenarioInPlace(ped2.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
    SetEntityAsMissionEntity(ped2.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped2.id, true)
end)

CreateThread(function()
    while zone == nil do
        Wait(0)
    end
    zone.addZone("service_farm",
        vector3(1969.5881347656, 5168.365234375, 47.63907623291),
        "Appuyer sur ~INPUT_CONTEXT~ pour accéder au menu Ferme",
        function()
            OpenFarmMenu()
        end,
        false
    )
    zone.addZone("sell_farm",
        vector3(416.86071777344, 6520.732421875, 27.712577819824),
        "Appuyer sur ~INPUT_CONTEXT~ pour accéder au marché",
        function()
            OpenFarmMarket()
        end,
        false
    )
    zone.addZone("delete_vehicle",
        vector3(1971.3869628906, 5162.828125, 47.639137268066),
        "Appuyer sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        function()
            -- get the vehicle and trailer and delete them
            if IsPedInAnyVehicle(p:ped(), false) then
                local veh_d = GetVehiclePedIsIn(PlayerPedId(), false)
                local _, trailer_d = GetVehicleTrailerVehicle(veh)
                -- check if veh_d is tractor2
                if IsVehicleModel(veh_d, GetHashKey("tractor2")) then
                    if trailer_d == 0 then
                        -- ShowNotification("Tu as oublié ta remorque")

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'ROUGE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "~s Tu as oublié ta remorque"
                        })

                    else
                        DeleteVehicle(veh_d)
                        DeleteVehicle(trailer_d)
                        -- ShowNotification("Tu as rangé ton véhicule")

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Tu as ~s rangé ~c ton véhicule"
                        })

                        RemoveBlip(blipReturn)
                        blipReturn = nil
                        RemoveBlip(blip)
                        blip = nil
                        RemoveBlip(blip2)
                        blip2 = nil
                        vehOut = false
                    end
                elseif IsVehicleModel(veh_d, GetHashKey("speedo")) then
                    DeleteVehicle(veh_d)
                    -- ShowNotification("Tu as rangé ton véhicule")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'JAUNE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Tu as ~s rangé ~c ton véhicule"
                    })

                    RemoveBlip(blipReturn)
                    blipReturn = nil
                    RemoveBlip(blip)
                    blip = nil
                    RemoveBlip(blip2)
                    blip2 = nil
                    vehOut = false
                else
                    -- ShowNotification("Tu n'es pas dans le bon véhicule")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Tu n'es pas dans le bon véhicule"
                    })

                end
            else
                -- ShowNotification("Vous n'êtes pas dans un véhicule")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Vous n'êtes pas dans un véhicule"
                })
                
            end
        end,
        true,
        36, 0.5, { 255, 0, 0 }, 255
    )
end)
