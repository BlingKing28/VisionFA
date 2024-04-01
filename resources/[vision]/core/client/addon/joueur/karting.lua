function LoadKarting()
    local ped = nil
    local created = false
    if not created then
        ped = entity:CreatePedLocal("s_m_y_xmech_01", vector3(880.72644042969, -2153.18359375, 29.486375808716),
            177.63665771484)
        created = true
    end
    SetEntityInvincible(ped.id, true)
    ped:setFreeze(true)
    SetEntityAsMissionEntity(ped.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped.id, true)

    local vehicleOut = nil
    local currentVeh = nil

    zone.addZone(
        "karting_garage_vehicle",
        vector3(880.72644042969, -2153.18359375, 31.486381530762),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le menu Karting",
        function()
            openKartingMenu()
        end,
        false
    )

    zone.addZone(
        "karting_garage",
        vector3(886.47302246094, -2157.8969726563, 30.498098373413),
        "Appuyer sur ~INPUT_CONTEXT~ pour ranger le kart",
        function()
            if IsPedInAnyVehicle(p:ped(), false) then
                local veh = GetVehiclePedIsIn(p:ped(), false)
                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                DeleteEntity(veh)

            end
        end,
        true,
        36, 0.5, { 255, 0, 0 }, 255
    )

    local open = false
    local karting_main = RageUI.CreateMenu("", "Louer un Kart", 0.0, 0.0, "vision", "Banner_Karting")
    local karting_vehicle = RageUI.CreateSubMenu(karting_main, "", "Louer un Kart", 0.0, 0.0, "vision", "Banner_Karting")
    karting_main.Closed = function()
        open = false
    end

    local allVehicleList = {}
    local selected_vehicle = nil

    local veh = {
        { name = "Kart", model = "veto", price = 20 }
        -- {name = "Petit Kart", model = "veto"}
    }
    local vehs = nil
    ---OpenVeh
    local pos = {
        vector4(885.18743896484, -2164.1730957031, 30.498104095459, 79.453094482422),
        vector4(885.49713134766, -2162.0910644531, 30.498104095459, 89.135879516602),
        vector4(887.75634765625, -2164.3149414063, 30.498104095459, 87.68864440918),
        vector4(887.92834472656, -2162.248046875, 30.498104095459, 83.71452331543),
        vector4(889.93469238281, -2164.4057617188, 30.498104095459, 84.042427062988),
        vector4(890.22320556641, -2162.5270996094, 30.498104095459, 81.528144836426),
        vector4(892.07080078125, -2164.6970214844, 30.498104095459, 79.129165649414),
        vector4(892.29479980469, -2162.5869140625, 30.498104095459, 89.162727355957)
    }

    function openKartingMenu()
        if open then
            open = false
            RageUI.Visible(karting_main, false)
            return
        else
            open = true
            RageUI.Visible(karting_main, true)
            Citizen.CreateThread(function()
                while open do
                    RageUI.IsVisible(karting_main, function()
                        for k, v in pairs(veh) do
                            RageUI.Button(v.name, "Appuyer sur entrer pour sortir le véhicule",
                                { RightLabel = "~g~" .. v.price .. "$" }, true, { onSelected = function()
                                    for key, value in pairs(pos) do
                                        if vehicle.IsSpawnPointClear(vector3(value.x, value.y, value.z), 3.0) then
                                            if p:pay(v.price) then
                                                vehs = vehicle.create(v.model, vector4(value), {})
                                                return
                                            end
                                        end
                                    end
                                end,
                                }, nil)
                        end
                    end)
                    Wait(1)
                end
            end)
        end
    end
end

Citizen.CreateThread(function()
    while p == nil do Wait(1000) end
    Wait(1000)
    LoadKarting()
    print("[INFO] L'activité karting à été chargé correctement")
end)
