Citizen.CreateThread(function()

    RequestIpl("gabz_biker_milo_")
    RequestIpl("gabz_import_milo_")

    interiorID = GetInteriorAtCoords(994.47870000, -122.99490000, 73.11467000)
    interiorID = GetInteriorAtCoords(941.00840000, -972.66450000, 39.14678000)

    if IsValidInterior(interiorID) then
        EnableInteriorProp(interiorID, "walls_02")
        SetInteriorPropColor(interiorID, "walls_02", 8)
        EnableInteriorProp(interiorID, "Furnishings_02")
        SetInteriorPropColor(interiorID, "Furnishings_02", 8)
        EnableInteriorProp(interiorID, "decorative_02")
        EnableInteriorProp(interiorID, "mural_03")
        EnableInteriorProp(interiorID, "lower_walls_default")
        SetInteriorPropColor(interiorID, "lower_walls_default", 8)
        EnableInteriorProp(interiorID, "mod_booth")
        DisableInteriorProp(interiorID, "gun_locker")
        EnableInteriorProp(interiorID, "cash_small")
        EnableInteriorProp(interiorID, "id_small")
        EnableInteriorProp(interiorID, "weed_small")
        EnableInteriorProp(interiorID, "branded_style_set")
        EnableInteriorProp(interiorID, "car_floor_hatch")

        RefreshInterior(interiorID)

    end

end)
