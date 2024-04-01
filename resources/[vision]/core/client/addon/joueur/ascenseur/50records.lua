local pos_ile = vector3(-1021.7836914063, -92.488265991211, -100.40307617188)
-- local tp_ile = vector3(4040.9150390625, 8008.1875, 117.14750671387)
local pos_ls = vector3(479.03967285156, -106.90042114258, 62.157886505127)
-- local tp_ls = vector3(-725.7529296875, -1444.4907226563, 5.4611053466797)

Citizen.CreateThread(function()
    while zone == nil do Wait(0) end
    zone.addZone(
        "50records_tp",
        pos_ile,
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
        function()
            SetEntityCoords(p:ped(), pos_ls)
            Wait(1000)
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    zone.addZone(
        "50records_ls",
        pos_ls,
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
        function()
            SetEntityCoords(p:ped(), pos_ile)
            Wait(1000)
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
end)
