local posaccred = vector3(-36.219619750977, 6382.1298828125, 30.583162307739)
local posroomred = vector3(8.1115674972534, 6408.7729492188, -24.810819625854)

local posaccblue = vector3(-43.198432922363, 6388.7783203125, 30.583166122437)
local posroomblue = vector3(-55.199863433838, 6388.9331054688, -24.810819625854)

Citizen.CreateThread(function()
    while zone == nil do Wait(0) end
    zone.addZone(
        "accrouge",
        posaccred,
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
        function()
            SetEntityCoords(p:ped(), posroomred)
            Wait(1000)
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    zone.addZone(
        "roomrouge",
        posroomred,
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
        function()
            SetEntityCoords(p:ped(), posaccred)
            Wait(1000)
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    zone.addZone(
        "accbleu",
        posaccblue,
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
        function()
            SetEntityCoords(p:ped(), posroomblue)
            Wait(1000)
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    zone.addZone(
        "roombleu",
        posroomblue,
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
        function()
            SetEntityCoords(p:ped(), posaccblue)
            Wait(1000)
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
end)
