local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local items = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_location.webp',
    headerIcon = 'assets/icons/voiture-icon.png',
    headerIconName = 'LOCATION',
    callbackName = 'BuyVehLocation',
    showTurnAroundButtons = false,
    elements = {
        {
            price = 200,
            image = "./assets/Location/Vehicule/blista.png",
            name = "blista",
            label = "Blista - 200$",
        },
        {
            price = 200,
            image = "./assets/Location/Vehicule/brioso.png",
            name = "brioso",
            label = "Brioso - 200$",
        },
        {
            price = 200,
            image = "./assets/Location/Vehicule/asbo.png",
            name = "asbo",
            label = "Asbo - 200$",
        },

        {
            price = 200,
            image = "./assets/Location/Vehicule/club.png",
            name =  "club",
            label = "Club - 200$",
        },
        {
            price = 200,
            image = "./assets/Location/Vehicule/rhapsody.png",
            name =  "rhapsody",
            label = "Rhapsody - 200$",
        },
        {
            price = 200,
            image = "./assets/Location/Vehicule/prairie.png",
            name =  "prairie",
            label = "Prairie - 200$",
        },

        {
            price = 200,
            image = "./assets/Location/Vehicule/panto.png",
            name =  "panto",
            label = "Panto - 200$",
        },
        {
            price = 200,
            image = "./assets/Location/Vehicule/dilettante.png",
            name =  "dilettante",
            label = "Dilettante - 200$",
        },
        {
            price = 200,
            image = "./assets/Location/Vehicule/kanjo.png",
            name =  "kanjo",
            label = "Kanjo - 200$",
        },
    }
}

local table = {
    DELPE = {
        vector4(-1437.0112, -496.9525, 33.4963, 216.0244),
        vector4(-1433.7963, -501.4621, 33.2462, 216.6195),
        vector4(-1431.1079, -505.4099, 33.0068, 215.0955),
        vector4(-1427.9198, -509.8933, 32.7272, 215.6325),
        vector4(-1424.4481, -514.9545, 32.4229, 214.1794),
        vector4(-1420.744, -520.3422, 32.0925, 214.5594),
        vector4(-1417.6947, -524.9446, 31.789, 214.1664),
    },
    HILLS = {
        vector4(-257.8496, -320.8489, 29.8745, 9.8607),
        vector4(-257.0188, -327.9733, 29.8024, 12.2795),
        vector4(-256.3687, -332.4111, 29.8043, 10.4971),
    },
    SANDY = {
        vector4(1517.3329, 3762.459, 34.0291, 197.3129),
        vector4(1511.4301, 3760.8152, 34.0049, 201.3339),
        vector4(1523.5548, 3767.0293, 34.0496, 222.14),
        vector4(1503.5197, 3763.5046, 33.9948, 210.7353),
        vector4(1498.0338, 3759.759, 33.9243, 216.3349),
    },
    PALETO = {
        vector4(71.9516, 6403.7368, 31.2258, 132.8327),
        vector4(75.0419, 6401.0342, 31.2258, 131.4641),
        vector4(77.9431, 6398.4878, 31.2258, 136.9694),
        vector4(80.6675, 6395.5918, 31.2258, 142.4419),
        vector4(65.0249, 6405.6895, 31.2258, 206.1968),
    },
}

local points = { -- POINTS DES PNJ
    ['DELPE']     = vector3(-1414.51, -533.98, 30.43),
    ['HILLS']   = vector3(-251.45, -324.68, 28.97),
    ['SANDY']   = vector3(1512.97, 3766.20, 33.17),
    ['PALETO']   = vector3(82.91, 6419.62, 30.54),
}

-- local pedCoords = vector4(-1413.3939, -533.4514, 30.2718, 301.1954)

local pedCoords = {
    {pos = vector4(-1413.3939, -533.4514, 30.2718, 301.1954)},
    {pos = vector4(-251.45, -324.68, 28.97, 98.2463)},
    {pos = vector4(1512.9713, 3766.2007, 33.1698, 200.1523)},
    {pos = vector4(82.91, 6419.62, 30.54, 132.94)},
}

local DELPE = vector4(-1413.3939, -533.4514, 30.2718, 301.1954)
local HILLS   = vector4(-251.45, -324.68, 28.97, 98.2463)
local SANDY = vector4(1512.9713, 3766.2007, 33.1698, 200.1523)
local PALETO  = vector4(82.91, 6419.62, 30.54, 132.94)

local requiredDistance = 10 --Meters

function openLocationMenu(ped)

    local playerPos = GetEntityCoords(PlayerPedId())

    local shortestDistance = math.huge

    for name,coords in pairs(points) do
        playerPos = GetEntityCoords(PlayerPedId())
        local distance = #(playerPos - coords)
        if distance < shortestDistance then
            shortestDistance = distance
        end
        if distance <= requiredDistance then
            print("Dans le radius du pnj") -- Enter-event name that gets triggered across all client scripts

            playerCoords = GetEntityCoords(PlayerPedId())
            cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
            SetCamActive(cam, 1)
            SetCamCoord(cam, playerCoords.x , playerCoords.y, playerCoords.z + 0.7)
            SetCamFov(cam, 36.0)
            PointCamAtCoord(cam, points[name].x, points[name].y, points[name].z + 1.5)
            RenderScriptCams(true, 0, 3000, 1, 0)   
            FreezeEntityPosition(PlayerPedId(), true)
            SendNuiMessage(json.encode({
                type = 'openWebview',
                name = 'MenuCatalogueAchat',
                data = items
            }));
        else 
            print('Hors champs') -- Exit event that got triggered when leaving the radius
        end

    end
end

RegisterNUICallback("BuyVehLocation", function(data, cb)
    vehs = nil
    local playerPos = GetEntityCoords(PlayerPedId())
    local shortestDistance = math.huge
   
    for name,coords in pairs(points) do
        playerPos = GetEntityCoords(PlayerPedId())
        local distance = #(playerPos - coords)
        if distance < shortestDistance then
            shortestDistance = distance
        end
        if distance <= requiredDistance then
            for k, v in pairs(table[name]) do
                if vehicle.IsSpawnPointClear(vector3(v.x, v.y, v.z), 3.0) then
                    if p:pay(data.price) then
        
                        exports["tuto-fa"]:GotoStep(2)
                        exports['vNotif']:createNotification({
                            type = 'DOLLAR',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous venez de louer ~s une "..data.name
                        })
        
                        vehs = vehicle.create(data.name, vector4(v), {})
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehs, -1)
                        SetVehicleNumberPlateText(vehs, "LOCAT" .. math.random(111, 999))
                        local plate = vehicle.getProps(vehs).plate
                        table.insert(StoredVehsLocation, plate)
                        local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
                        local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), nil)
                        --createKeys(plate, model)
                        SendNuiMessage(json.encode({
                            type = 'closeWebview',
                        }))
        
                        return
                    end
                else
                    -- ShowNotification("Il n'y a pas de place pour le véhicule")
        
                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Il n'y a ~s pas de place ~c pour le véhicule"
                    })
                end
            end
        end
    end
end)

RegisterNUICallback("focusOut", function (data, cb)
    TriggerScreenblurFadeOut(0.5)
    openRadarProperly()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    FreezeEntityPosition(PlayerPedId(), false)
end)


local peds = {}

CreateThread(function()

    while p == nil do Wait(1) end

    for k, v in pairs(pedCoords) do
        peds[k] = entity:CreatePedLocal("ig_thornton", v.pos.xyz, v.pos.w)
        peds[k]:setFreeze(true)
        SetEntityInvincible(peds[k].id, true)
        SetEntityAsMissionEntity(peds[k].id, 0, 0)
        SetBlockingOfNonTemporaryEvents(peds[k].id, true)
        zone.addZone( "vehLocation" .. k,
            v.pos.xyz,
            "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les catalogues",
            function()
                openLocationMenu(peds[k].id) --TODO: fini le menu society
            end,
            false, -- Avoir un marker ou non
            -1, -- Id / type du marker
            0.6, -- La taille
            { 0, 0, 0 }, -- RGB
            0, -- Alpha
            2.5
        )
        local blip = AddBlipForCoord(v.pos.xyz)
        SetBlipSprite(blip, 810)
        SetBlipColour(blip, 2)
        SetBlipScale(blip, 0.70)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Location de véhicules")
        EndTextCommandSetBlipName(blip)
    end
--[[     while true do
        for k, v in pairs(pedCoords) do
            peds[k] = entity:CreatePedLocal("ig_thornton", v.pos.xyz, v.pos.w)
            peds[k]:setFreeze(true)
            SetEntityInvincible(peds[k].id, true)
            SetEntityAsMissionEntity(peds[k].id, 0, 0)
            SetBlockingOfNonTemporaryEvents(peds[k].id, true)
            zone.addZone( "vehLocation" .. k,
                v.pos.xyz,
                "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les catalogues",
                function()
                    openLocationMenu(peds[k].id) --TODO: fini le menu society
                end,
                false, -- Avoir un marker ou non
                -1, -- Id / type du marker
                0.6, -- La taille
                { 0, 0, 0 }, -- RGB
                0, -- Alpha
                2.5
            )
        end
        Wait(5000)
    end

        ped = entity:CreatePedLocal("ig_thornton", pedCoords.xyz, pedCoords.w)
        ped:setFreeze(true)
        SetEntityInvincible(ped.id, true)
        SetEntityAsMissionEntity(ped.id, 0, 0)
        SetBlockingOfNonTemporaryEvents(ped.id, true)
        zone.addZone("vehLocation",
            pedCoords.xyz,
            "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les locations",
            function()
                openLocationMenu(ped.id)
            end,
            false, -- Avoir un marker ou non
            -1, -- Id / type du marker
            0.6, -- La taille
            { 0, 0, 0 }, -- RGB
            0, -- Alpha
            2.5
        )
    end ]]
end)