function Sitbench(entity)
    local pPed = p:ped()
    local pPos = p:pos()
    local entityCoords = GetEntityCoords(entity)
    local offset = 0.5
    local heading = 180.0
    if GetEntityModel(entity) == -634790943 then
        heading = -40.0
    end
    if GetEntityModel(entity) == -171943901 or GetEntityModel(entity) == -829283643 or
        GetEntityModel(entity) == -634790943 or GetEntityModel(entity) == 1580642483 or 
        GetEntityModel(entity) == -110460483 then
        offset = 0.0
    end
    if GetEntityModel(entity) == -552026043 then
        offset = 0.9
    end
    if entity ~= nil then
        if IsPedActiveInScenario(pPed) then
            ClearPedTasks(pPed)
            TaskStartScenarioAtPosition(p:ped(), "PROP_HUMAN_SEAT_BENCH", entityCoords.x, entityCoords.y,
                entityCoords.z + offset,
                GetEntityHeading(entity) + heading, 0, true, true)
        else
            TaskStartScenarioAtPosition(p:ped(), "PROP_HUMAN_SEAT_BENCH", entityCoords.x, entityCoords.y,
                entityCoords.z + offset,
                GetEntityHeading(entity) + heading, 0, true, true)
        end
    end
end

function SitbenchMBA(entity)
    local pPed = p:ped()
    local pPos = p:pos()
    local entityCoords = GetEntityCoords(entity)
    local offset = 0
    local heading = 180.0
    if GetEntityModel(entity) == -634790943 then
        heading = -40.0
    end
    if GetEntityModel(entity) == -171943901 or GetEntityModel(entity) == -829283643 or
        GetEntityModel(entity) == -634790943 or GetEntityModel(entity) == 1580642483 then
        offset = 0.0
    end
    if entity ~= nil then
        if IsPedActiveInScenario(pPed) then
            ClearPedTasks(pPed)
            TaskStartScenarioAtPosition(p:ped(), "PROP_HUMAN_SEAT_BENCH", entityCoords.x, entityCoords.y,
                entityCoords.z + offset,
                GetEntityHeading(entity) + heading, 0, true, true)
        else
            TaskStartScenarioAtPosition(p:ped(), "PROP_HUMAN_SEAT_BENCH", entityCoords.x, entityCoords.y,
                entityCoords.z + offset,
                GetEntityHeading(entity) + heading, 0, true, true)
        end
    end
end

function SitbenchBeauF(entity)
    local pPed = p:ped()
    local pPos = p:pos()
    local entityCoords = GetEntityCoords(entity)
    local offset = 0.5
    local heading = 180.0
    if GetEntityModel(entity) == -634790943 then
        heading = -40.0
    end
    if GetEntityModel(entity) == -171943901 or GetEntityModel(entity) == -829283643 or
        GetEntityModel(entity) == -634790943 or GetEntityModel(entity) == 1580642483 then
        offset = 0.0
    end
    if entity ~= nil then
        if IsPedActiveInScenario(pPed) then
            ClearPedTasks(pPed)
            TaskStartScenarioAtPosition(p:ped(), "PROP_HUMAN_SEAT_DECKCHAIR", entityCoords.x, entityCoords.y,
                entityCoords.z + offset,
                GetEntityHeading(entity) + heading, 0, true, true)
        else
            TaskStartScenarioAtPosition(p:ped(), "PROP_HUMAN_SEAT_DECKCHAIR", entityCoords.x, entityCoords.y,
                entityCoords.z + offset,
                GetEntityHeading(entity) + heading, 0, true, true)
        end
    end
end

function SitbenchWait(entity)
    local pPed = p:ped()
    local pPos = p:pos()
    local entityCoords = GetEntityCoords(entity)
    local offset = 0.5
    local heading = 180.0
    if GetEntityModel(entity) == -634790943 then
        heading = -40.0
    end
    if GetEntityModel(entity) == -171943901 or GetEntityModel(entity) == -829283643 or
        GetEntityModel(entity) == -634790943 or GetEntityModel(entity) == 1580642483 or 
        GetEntityModel(entity) == -110460483 then
        offset = 0.0
    end
    if GetEntityModel(entity) == -552026043 then
        offset = 0.9
    end
    if entity ~= nil then
        if IsPedActiveInScenario(pPed) then
            ClearPedTasks(pPed)
            TaskStartScenarioAtPosition(p:ped(), "PROP_HUMAN_SEAT_BUS_STOP_WAIT", entityCoords.x, entityCoords.y,
                entityCoords.z + offset,
                GetEntityHeading(entity) + heading, 0, true, true)
        else
            TaskStartScenarioAtPosition(p:ped(), "PROP_HUMAN_SEAT_BUS_STOP_WAIT", entityCoords.x, entityCoords.y,
                entityCoords.z + offset,
                GetEntityHeading(entity) + heading, 0, true, true)
        end
    end
end

function SitbenchWaitMBA(entity)
    local pPed = p:ped()
    local pPos = p:pos()
    local entityCoords = GetEntityCoords(entity)
    local offset = 0
    local heading = 180.0
    if GetEntityModel(entity) == -634790943 then
        heading = -40.0
    end
    if GetEntityModel(entity) == -171943901 or GetEntityModel(entity) == -829283643 or
        GetEntityModel(entity) == -634790943 or GetEntityModel(entity) == 1580642483 then
        offset = 0.0
    end
    if entity ~= nil then
        if IsPedActiveInScenario(pPed) then
            ClearPedTasks(pPed)
            TaskStartScenarioAtPosition(p:ped(), "PROP_HUMAN_SEAT_BUS_STOP_WAIT", entityCoords.x, entityCoords.y,
                entityCoords.z + offset,
                GetEntityHeading(entity) + heading, 0, true, true)
        else
            TaskStartScenarioAtPosition(p:ped(), "PROP_HUMAN_SEAT_BUS_STOP_WAIT", entityCoords.x, entityCoords.y,
                entityCoords.z + offset,
                GetEntityHeading(entity) + heading, 0, true, true)
        end
    end
end

function SitbenchWithChill(entity)
    local pPed = p:ped()
    local pPos = p:pos()
    local entityCoords = GetEntityCoords(entity)
    local offset = 0.5
    local heading = 180.0
    if GetEntityModel(entity) == -634790943 then
        heading = 0.0
    end
    if GetEntityModel(entity) == -171943901 or GetEntityModel(entity) == -829283643 or
        GetEntityModel(entity) == -634790943 or GetEntityModel(entity) == 1580642483 then
        offset = 0.0
    end
    if entity ~= nil then
        if IsPedActiveInScenario(pPed) then
            ClearPedTasks(pPed)
            TaskStartScenarioAtPosition(p:ped(), "PROP_HUMAN_SEAT_ARMCHAIR", entityCoords.x, entityCoords.y,
                entityCoords.z + offset,
                GetEntityHeading(entity) + heading, 0, true, true)
        else
            TaskStartScenarioAtPosition(p:ped(), "PROP_HUMAN_SEAT_ARMCHAIR", entityCoords.x, entityCoords.y,
                entityCoords.z + offset,
                GetEntityHeading(entity) + heading, 0, true, true)
        end
    end
end

function StopAnim(entity)
    ClearPedTasks(p:ped())
end

function SleepOnHospital(entity)
    local pPed = p:ped()
    local pPos = p:pos()
    local entityCoords = GetEntityCoords(entity)
    local offset = 0.5
    local heading = 180.0
    local rot = GetEntityRotation(entity)
    if GetEntityModel(entity) == -171943901 or GetEntityModel(entity) == -829283643 or
        GetEntityModel(entity) == -634790943 or GetEntityModel(entity) == 1580642483 then
        offset = 0.0
    end
    if entity ~= nil then
        if IsEntityPlayingAnim(pPed, "combat@damage@writheidle_c", "writhe_idle_g") then
            ClearPedTasks(pPed)

            RequestAnimDict("combat@damage@writheidle_c")
            while not HasAnimDictLoaded("combat@damage@writheidle_c") do Wait(1) end

            SetEntityCoords(p:ped(), entityCoords.x, entityCoords.y, entityCoords.z + 0.5)
            SetEntityHeading(p:ped(), (GetEntityHeading(entity) + 180.0))

            TaskPlayAnim(p:ped(), 'combat@damage@writheidle_c', "writhe_idle_g", 8.0, -8.0, -1, 1, 0, false, false, false)
        else
            RequestAnimDict("combat@damage@writheidle_c")
            while not HasAnimDictLoaded("combat@damage@writheidle_c") do Wait(1) end

            SetEntityCoords(p:ped(), entityCoords.x, entityCoords.y, entityCoords.z + 0.5)
            SetEntityHeading(p:ped(), (GetEntityHeading(entity) + 180.0))

            TaskPlayAnim(p:ped(), 'combat@damage@writheidle_c', "writhe_idle_g", 8.0, -8.0, -1, 1, 0, false, false, false)
            -- TaskStartScenarioAtPosition(p:ped(), "PROP_HUMAN_SEAT_ARMCHAIR", entityCoords.x, entityCoords.y,
            --     entityCoords.z + offset,
            --     GetEntityHeading(entity) + heading, 0, true, true)
        end
    end
end

function SleepOnHospitalDos(entity)
    local pPed = p:ped()
    local pPos = p:pos()
    local entityCoords = GetEntityCoords(entity)
    local offset = 0.5
    local heading = 180.0
    local rot = GetEntityRotation(entity)
    if GetEntityModel(entity) == -171943901 or GetEntityModel(entity) == -829283643 or
        GetEntityModel(entity) == -634790943 or GetEntityModel(entity) == 1580642483 then
        offset = 0.0
    end
    if entity ~= nil then
        if IsEntityPlayingAnim(pPed, "switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_girl") then
            ClearPedTasks(pPed)

            RequestAnimDict("switch@trevor@annoys_sunbathers")
            while not HasAnimDictLoaded("switch@trevor@annoys_sunbathers") do Wait(1) end

            SetEntityCoords(p:ped(), entityCoords.x, entityCoords.y, entityCoords.z + 0.5)
            SetEntityHeading(p:ped(), (GetEntityHeading(entity) + 180.0))

            TaskPlayAnim(p:ped(), 'switch@trevor@annoys_sunbathers', "trev_annoys_sunbathers_loop_girl", 8.0, -8.0, -1, 1
                , 0, false, false, false)
        else
            RequestAnimDict("switch@trevor@annoys_sunbathers")
            while not HasAnimDictLoaded("switch@trevor@annoys_sunbathers") do Wait(1) end

            SetEntityCoords(p:ped(), entityCoords.x, entityCoords.y, entityCoords.z + 0.5)
            SetEntityHeading(p:ped(), (GetEntityHeading(entity) + 180.0))

            TaskPlayAnim(p:ped(), 'switch@trevor@annoys_sunbathers', "trev_annoys_sunbathers_loop_girl", 8.0, -8.0, -1, 1
                , 0, false, false, false)
            -- TaskStartScenarioAtPosition(p:ped(), "PROP_HUMAN_SEAT_ARMCHAIR", entityCoords.x, entityCoords.y,
            --     entityCoords.z + offset,
            --     GetEntityHeading(entity) + heading, 0, true, true)
        end
    end
end

function SleepOnHospitalVentre(entity)
    local pPed = p:ped()
    local pPos = p:pos()
    local entityCoords = GetEntityCoords(entity)
    local offset = 0.5
    local heading = 180.0
    local rot = GetEntityRotation(entity)
    if GetEntityModel(entity) == -171943901 or GetEntityModel(entity) == -829283643 or
        GetEntityModel(entity) == -634790943 then
        offset = 0.0
    end
    if entity ~= nil then
        if IsEntityPlayingAnim(pPed, "missheist_jewel", "2b_guard_onfloor_loop") then
            ClearPedTasks(pPed)

            RequestAnimDict("missheist_jewel")
            while not HasAnimDictLoaded("missheist_jewel") do Wait(1) end

            SetEntityCoords(p:ped(), entityCoords.x, entityCoords.y, entityCoords.z + 0.5)
            SetEntityHeading(p:ped(), (GetEntityHeading(entity) - 40.0))

            TaskPlayAnim(p:ped(), "missheist_jewel", "2b_guard_onfloor_loop", 8.0, -8.0, -1, 1, 0, false, false, false)
        else
            RequestAnimDict("missheist_jewel")
            while not HasAnimDictLoaded("missheist_jewel") do Wait(1) end

            SetEntityCoords(p:ped(), entityCoords.x, entityCoords.y, entityCoords.z + 0.5)
            SetEntityHeading(p:ped(), (GetEntityHeading(entity) - 40.0))

            TaskPlayAnim(p:ped(), "missheist_jewel", "2b_guard_onfloor_loop", 8.0, -8.0, -1, 1, 0, false, false, false)
            -- TaskStartScenarioAtPosition(p:ped(), "PROP_HUMAN_SEAT_ARMCHAIR", entityCoords.x, entityCoords.y,
            --     entityCoords.z + offset,
            --     GetEntityHeading(entity) + heading, 0, true, true)
        end
    end
end

function SleepOnHospitalHeartAttack(entity)
    local pPed = p:ped()
    local pPos = p:pos()
    local entityCoords = GetEntityCoords(entity)
    local offset = 0.5
    local heading = 180.0
    local rot = GetEntityRotation(entity)
    if GetEntityModel(entity) == -171943901 or GetEntityModel(entity) == -829283643 or
        GetEntityModel(entity) == -634790943 then
        offset = 0.0
    end
    if entity ~= nil then
        if IsEntityPlayingAnim(pPed, "anim@heists@prison_heistig_5_p1_rashkovsky_idle", "idle_180") then
            ClearPedTasks(pPed)

            RequestAnimDict("anim@heists@prison_heistig_5_p1_rashkovsky_idle")
            while not HasAnimDictLoaded("anim@heists@prison_heistig_5_p1_rashkovsky_idle") do Wait(1) end

            SetEntityCoords(p:ped(), entityCoords.x, entityCoords.y, entityCoords.z + 0.5)
            SetEntityHeading(p:ped(), (GetEntityHeading(entity) + 180.0))

            TaskPlayAnim(p:ped(), "anim@heists@prison_heistig_5_p1_rashkovsky_idle", "idle_180", 8.0, -8.0, -1, 1, 0,
                false, false, false)
        else
            RequestAnimDict("anim@heists@prison_heistig_5_p1_rashkovsky_idle")
            while not HasAnimDictLoaded("anim@heists@prison_heistig_5_p1_rashkovsky_idle") do Wait(1) end

            SetEntityCoords(p:ped(), entityCoords.x, entityCoords.y, entityCoords.z + 0.5)
            SetEntityHeading(p:ped(), (GetEntityHeading(entity) + 180.0))

            TaskPlayAnim(p:ped(), "anim@heists@prison_heistig_5_p1_rashkovsky_idle", "idle_180", 8.0, -8.0, -1, 1, 0,
                false, false, false)
            -- TaskStartScenarioAtPosition(p:ped(), "PROP_HUMAN_SEAT_ARMCHAIR", entityCoords.x, entityCoords.y,
            --     entityCoords.z + offset,
            --     GetEntityHeading(entity) + heading, 0, true, true)
        end
    end
end