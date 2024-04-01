local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local sonnettePos = {
    ["ltdsud"] = {
        pos = vector3(-55.0919, -1756.1848, 28.4396)
    },
    ["ltdmirror"] = {
        pos = vector3(1161.7680664063, -327.13562011719, 68.212242126465)
    },
    ["weazelnews"] = {
        pos = vector3(-599.33380126953, -934.11938476563, 22.864675521851)
    },
    ["lspd"] = {
        pos = vector3(-1097.4617919922, -843.46569824219, 18.001041412354)
    },
    ["lssdbp"] = {
        pos = vector3(2826.3767089844, 4727.4345703125, 47.627346038818)
    },
    ["sunshine"] = {
        pos = vector3(869.53057861328, -2110.1025390625, 29.490036010742)
    },
    ["bean"] = {
        pos = vector3(-627.65533447266, 241.42178344727, 80.894142150879)
    },
    ["bahamas"] = {
        pos = vector3(-1391.5441894531, -587.97424316406, 29.246072769165)
    },
    ["burgershot"] = {
        pos = vector3(1576.8975, 3747.5122, 33.5000)
    },
    ["barber2"] = {
        pos = vector3(-826.01300048828, -186.25535583496, 36.6393699646)
    },
    ["cardealerSud"] = {
        pos = vector3(164.11524963379, -1105.2321777344, 28.2)
    },
    ["unicorn"] = {
        pos = vector3(130.53582763672, -1298.1751708984, 28.233039855957)
    },
    ["bennys"] = {
        pos = vector3(-231.91149902344, -1331.7314453125, 30.29610824585)
    },
    ["hayes"] = {
        pos = vector3(-1431.9050292969, -445.98962402344, 34.660949707031) 
    },
    ["beekers"] = {
        pos = vector3(10000, 10000, 10000) -- pos à mettre
    },
    ["ems"] = {
        pos = vector3(1126.9697265625, -1530.3892822266, 34.032711029053)
    },
    ["bcms"] = {
        pos = vector3(-251.80661010742, 6334.7329101563, 31.451942443848)
    },
    ["pawnshop"] = {
        pos = vector3(-296.70660400391, -104.05701446533, 46.049446105957)
    },
    ["gouv"] = {
        pos = vector3(-552.57592773438, -191.12492370605, 37.219661712646)
    },
    ["tattooSud"] = {
        pos = vector3(319.36679077148, 177.61192321777, 102.62548065186)
    },
    ["tattooNord"] = {
        pos = vector3(-290.14837646484, 6201.5659179688, 30.467575073242)
    },
    ["mirror"] = {
        pos = vector3(1123.2768554688, -642.95764160156, 55.704177856445)
    },
    ["yellowJack"] = {
        pos = vector3(1989.9291992188, 3055.1481933594, 46.215152740479)
    },
    ["domaine"] = {
        pos = vector3(-1877.1770019531, 2043.1041259766, 139.48985290527)
    },
    ["blackwood"] = {
        pos = vector3(-298.56344604492, 6257.333984375, 30.507244110107)
    },
    ["lst"] = {
        pos = vector3(435.18951416016, -649.47186279297, 27.7396068573)
    },
    ["rockford"] = {
        pos = vector3(-1007.3261108398, -269.92852783203, 38.04061126709)
    },
    ["casse"] = {
        pos = vector3(2337.4365234375, 3131.85546875, 47.203121185303)
    },
    ["pizzeria"] = {
        pos = vector3(792.20806884766, -759.81439208984, 25.761432647705)
    },
    ["hornys"] = {
        pos = vector3(1241.8441162109, -368.22219848633, 68.082252502441)
    },
    ["pearl"] = {
        pos = vector3(-1817.412109375, -1192.7767333984, 13.3033771514)
    },
    ["don"] = {
        pos = vector3(162.46067810059, 6635.2553710938, 30.57886886596714)
    },
    ["tacosrancho"] = {
        pos = vector3(410.89453125, -1907.5825195313, 24.460599899292)
    },
}

function callEntreprise(k)
    if k ~= "lspd" and k ~= "ems" and k ~= "bcms" and k ~= "g6" and k ~= "lssd"  and k ~= "bp" then
        TriggerServerEvent('core:makeCall', k, sonnettePos[k].pos, false, "Un client sonne à votre boutique", true)
    elseif k == 'ems' or k == "bcms" then
        TriggerServerEvent('core:makeCall', k, sonnettePos[k].pos, false, "Un patient sonne à l'acceuil", true)
    else
        TriggerServerEvent('core:makeCall', k, sonnettePos[k].pos, false, "Un agent est demandé à l’accueil du poste", true)
    end
end

local char = "menu_title_choicelssdbp"
local open = false
local main = RageUI.CreateMenu("", "Choix de la sonette", 0.0, 0.0, "vision", char)
function ChoiceLSSDUSBPSonette()
    if open then
        open = false
        RageUI.Visible(main, false)
    else
        open = true

        RageUI.Visible(main, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(main, function()
                    RageUI.Button("~y~Los Santos County Sheriff", false, {}, true, {
                        onSelected = function()
                            k = 'lssdbp'
                            TriggerServerEvent('core:makeCall', 'lssd', sonnettePos[k].pos, false, "Un agent est demandé à l’accueil du poste", true)
                        end
                    })
                    RageUI.Button("~g~United States Border Patrol", false, {}, true, {
                        onSelected = function()
                            k = 'lssdbp'
                            TriggerServerEvent('core:makeCall', 'bp', sonnettePos[k].pos, false, "Un agent est demandé à l’accueil du poste", true)
                        end
                    })
                end)
                Wait(1)
            end
        end)
    end
end

CreateThread(function()
    while p == nil do Wait(1) end

    for k, v in pairs(sonnettePos) do
        zone.addZone(
            "sonnette_job_" .. k,
            v.pos,
            "Appuyer sur ~INPUT_CONTEXT~ pour appeler l'entreprise",
            function()
                print(k)
                if k == 'lssdbp' then
                    
                    char = "menu_title_choicelssdbp"
                    main = RageUI.CreateMenu("", "Choix de la sonette", 0.0, 0.0, "vision", char)
                    ChoiceLSSDUSBPSonette()
                else  
                    callEntreprise(k)
                end    
            end,
            true, -- Avoir un marker ou non
            25, -- Id / type du marker
            0.6, -- La taille
            { 51, 204, 255 }, -- RGB
            170-- Alpha
        )
    end
end)
