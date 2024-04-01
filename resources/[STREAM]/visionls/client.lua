Citizen.CreateThread(function()
    RequestIpl("k4mb1_artgallery_milo_")
    RemoveIpl("po1_occl_01")
    RemoveIpl("hei_po1_occl_01")

    -- Vault
    local interiorid = GetInteriorAtCoords(27.478, 143.0223, 97.945)

    -- ROOF WINWDOWS
    ActivateInteriorEntitySet(interiorid, "set_windows_normal")
    -- ActivateInteriorEntitySet(interiorid, "set_windows_cut")

    -- PAINTINGS
    ActivateInteriorEntitySet(interiorid, "set_painting_1")
    ActivateInteriorEntitySet(interiorid, "set_painting_2")
    ActivateInteriorEntitySet(interiorid, "set_painting_3")
    ActivateInteriorEntitySet(interiorid, "set_painting_4")
    ActivateInteriorEntitySet(interiorid, "set_painting_5")
    ActivateInteriorEntitySet(interiorid, "set_painting_6")
    ActivateInteriorEntitySet(interiorid, "set_painting_7")
    ActivateInteriorEntitySet(interiorid, "set_painting_8")
    ActivateInteriorEntitySet(interiorid, "set_painting_9")
    ActivateInteriorEntitySet(interiorid, "set_painting_10")

    -- SHUTTERS
    -- ActivateInteriorEntitySet(interiorid, "set_shutters")

    -- EGGS
    ActivateInteriorEntitySet(interiorid, "egg1") -- (Default with egg)
    -- ActivateInteriorEntitySet(interiorid, "egg2") -- (Egg with hole in glass)
    -- ActivateInteriorEntitySet(interiorid, "egg3") -- (No egg)

    -- SEC ROOM KEYPAD
    ActivateInteriorEntitySet(interiorid, "keypad_01")
    -- ActivateInteriorEntitySet(interiorid, "keypad_error")
    -- ActivateInteriorEntitySet(interiorid, "keypad_destroyed")

    -- ActivateInteriorEntitySet(interiorid, "slidedoors_open")
    ActivateInteriorEntitySet(interiorid, "slidedoors_unlocked") -- (door slide animation when near door)
    -- ActivateInteriorEntitySet(interiorid, "slidedoors_locked") 

    RefreshInterior(interiorid)

end)

--Config = {}

--Config.car = {
--    ['coords'] = vector4(125.1466293335, -3041.2607421875, 9.4086522293091, 270.51739501953),
--    ['car'] = 'zr380c',
--    ['plate'] = '2F4ST4YU' -- Make sure only 8 characters
--}
--Config.bike1 = {
--    ['coords'] = vector4(-1180.8, -1179.61, 5.47, 76.24),
--    ['bike1'] = 'spirit1',
--    ['plate'] = 'MONGRELS' -- Make sure only 8 characters
--}
--Config.bike = {
--   ['coords'] = vector4(-1181.11, -1177.56, 5.47, 76.45),
--    ['bike'] = 'softail1',
--    ['plate'] = 'MONGRELS' -- Make sure only 8 characters
--}
--r, g, b = 0, 16, 75 -- RGB Colour
--r2, g2, b2 = 255, 255, 255 -- RGB Colour

--CreateThread(function()
--    local model = GetHashKey(Config.car['car'])
--    RequestModel(model)
--    while not HasModelLoaded(model) do
--        Wait(0)
--    end
--    local veh = CreateVehicle(model, Config.car['coords'].x, Config.car['coords'].y, Config.car['coords'].z - 0.5,
--        false, false)
--    SetModelAsNoLongerNeeded(model)
--    SetEntityAsMissionEntity(veh, true, true)
--    SetVehicleOnGroundProperly(veh)
--    SetEntityInvincible(veh, true)
--    SetVehicleDirtLevel(veh, 0.0)
--    SetVehicleDoorsLocked(veh, 3)
--    SetEntityHeading(veh, Config.car['coords'].w)
--    SetVehicleCustomPrimaryColour(veh, r, g, b) -- car colour
--    SetVehicleCustomSecondaryColour(veh, r, g, b) -- car colour
--    SetVehicleExtraColours(veh, 1, 1) -- car colour
--    FreezeEntityPosition(veh, true)
--    SetVehicleNumberPlateText(veh, Config.car['plate'])
--end)
--CreateThread(function()
--    local model = GetHashKey(Config.bike1['bike1'])
--    RequestModel(model)
--    while not HasModelLoaded(model) do
--        Wait(0)
--    end
--    local veh = CreateVehicle(model, Config.bike1['coords'].x, Config.bike1['coords'].y, Config.bike1['coords'].z - 0.5,
--        false, false)
--    SetModelAsNoLongerNeeded(model)
--    SetEntityAsMissionEntity(veh, true, true)
--    SetVehicleOnGroundProperly(veh)
--    SetEntityInvincible(veh, true)
--    SetVehicleDirtLevel(veh, 0.0)
--    SetVehicleDoorsLocked(veh, 3)
--    SetEntityHeading(veh, Config.bike1['coords'].w)
--    SetVehicleCustomPrimaryColour(veh, r, g, b) -- bike1 colour
--    SetVehicleCustomSecondaryColour(veh, r, g, b) -- bike1 colour
--    SetVehicleExtraColours(veh, 1, 1) -- bike1 colour
--    FreezeEntityPosition(veh, true)
--    SetVehicleNumberPlateText(veh, Config.bike1['plate'])
--end)
--CreateThread(function()
--    local model = GetHashKey(Config.bike['bike'])
--    RequestModel(model)
--    while not HasModelLoaded(model) do
--        Wait(0)
--    end
--    local veh = CreateVehicle(model, Config.bike['coords'].x, Config.bike['coords'].y, Config.bike['coords'].z - 0.5,
--        false, false)
--    SetModelAsNoLongerNeeded(model)
--    SetEntityAsMissionEntity(veh, true, true)
--    SetVehicleOnGroundProperly(veh)
--    SetEntityInvincible(veh, true)
--    SetVehicleDirtLevel(veh, 0.0)
--    SetVehicleDoorsLocked(veh, 3)
--    SetEntityHeading(veh, Config.bike['coords'].w)
--    SetVehicleCustomPrimaryColour(veh, x, y, z) -- bike colour
--    SetVehicleCustomSecondaryColour(veh, x, y, z) -- bike colour
--    SetVehicleExtraColours(veh, 1, 1) -- bike colour
--    FreezeEntityPosition(veh, true)
--    SetVehicleNumberPlateText(veh, Config.bike['plate'])
--end)