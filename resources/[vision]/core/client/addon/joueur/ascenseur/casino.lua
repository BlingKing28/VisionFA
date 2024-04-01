local posbas = vector3(967.10650634766, 7.5780334472656, 80.2)
local poshaut = vector3(964.92034912109, 58.62455368042, 111.55307006836)

Citizen.CreateThread(function()
    while zone == nil do Wait(0) end
    zone.addZone(
        "casino_bas",
        posbas,
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
        function()
            SetEntityCoords(p:ped(), poshaut)
            Wait(1000)
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    zone.addZone(
        "casino_haut",
        poshaut,
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
        function()
            SetEntityCoords(p:ped(), posbas)
            Wait(1000)
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
end)
