local function objectToTable(obj)
    local tbl = {}
    for k, v in pairs(obj) do
        table.insert(tbl, v)
    end
    return tbl
end

local function OpenJobCenter()
    SendNUIMessage({
        type = "openWebview",
        name = "JobCenter",
        data = objectToTable(GetVariable("jobcenter"))
    })
end

CreateThread(function()
    -- Wait for player to be loaded
    while not p do Wait(10) end
    while not zone do Wait(10) end

    local ped = entity:CreatePedLocal("cs_bankman", vector3(-269.1, -955.56, 30.22), 206.2)
    SetEntityInvincible(ped.id, true)
    ped:setFreeze(true)
    TaskStartScenarioInPlace(ped.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
    SetEntityAsMissionEntity(ped.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped.id, true)

    -- Draw a blip
    local blip = AddBlipForCoord(-268.6, -956.9, 30.4)
    SetBlipSprite(blip, 407)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 3)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Job Center")
    EndTextCommandSetBlipName(blip)

    zone.addZone(
        "jobcenter",
        vector3(-268.6, -956.9, 30.4),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le menu jobcenter",
        function()
            exports['tuto-fa']:GotoStep(7)
            OpenJobCenter()
        end,
        false,
        25,                 -- Id / type du marker
        0.6,                -- La taille
        { 51, 204, 255 },   -- RGB
        170                 -- Alpha
    )
end)

RegisterNUICallback("selectJob", function(jobname, cb)
    cb({})
    local jobs = GetVariable("jobcenter")
    -- find the job with the name then print it
    for _, job in pairs(jobs) do
        if job.name == jobname then
            -- Place a waypoint to job.position
            SetNewWaypoint(job.position.x, job.position.y)
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "La position a été ajoutée à votre GPS"
            })
            break
        end
    end
    closeUI()
end)