local hatsMenu = RageUI.CreateMenu("", "~b~Achats de chapeau", 0.0, 0.0, "shopui_title_lowendfashion2",
    "shopui_title_lowendfashion2")
local hatsVariance = RageUI.CreateSubMenu(hatsMenu, "", "~b~Achats de chapeau", 0.0, 0.0, "shopui_title_lowendfashion2",
    "shopui_title_lowendfashion2")
local open = false
local cached = {}
local oldSkin
local selectedHats = {}
local token = nil
hatsMenu.Closed = function()
    open = false
    p:setSkin(oldSkin)
    collectgarbage("collect")
end
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

Citizen.CreateThread(function()
    while zone == nil do Wait(1) end

    zone.addZone(
        "hats_shop", -- Nom
        vector3(460.70251464844, -761.60540771484, 27.357774734497), -- Position
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le magasin de chapeau", -- Text afficher
        function() -- Action qui seras fait
            OpenHatsShop()
        end,
        true, -- Avoir un marker ou non
        0, -- Id / type du marker
        0.5, -- La taille
        { 255, 255, 255 }, -- RGB
        170-- Alpha
    )
end)




function OpenHatsShop()
    if open then
        open = false
        RageUI.Visible(hatsMenu, false)
        return
    else
        open = true
        RageUI.Visible(hatsMenu, true)
        local hats = {}
        if p:isMale() then
            hats = GetMaleHats()
        else
            hats = GetFemaleHats()
        end

        local hatsData = {}
        oldSkin = p:skin()

        for k, v in pairs(hats) do


            hatsData[tonumber(k)] = {}
            hatsData[tonumber(k)].label = GetLabelText(hats[k]["0"].GXT)
            if hatsData[tonumber(k)].label == "NULL" then
                hatsData[tonumber(k)].label = "Chapeau #" .. k
            end
            hatsData[tonumber(k)].defaultData = tonumber(k)
            hatsData[tonumber(k)].data = {}
            for i, j in pairs(v) do
                local label = GetLabelText(j.GXT)
                if label == "NULL" then
                    label = "Variante #" .. i
                end
                table.insert(hatsData[tonumber(k)].data, { label = label, hats1 = tonumber(k), hats2 = tonumber(i) })
            end


        end

        hats = {}
        cached = {}

        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(hatsMenu, function()
                    for k, v in ipairs(hatsData) do
                        RageUI.Button(v.label, nil, { RightLabel = ">" }, true, {
                            onSelected = function()
                                selectedHats = v.data
                            end,
                            onActive = function()
                                if cached["helmet_1"] == nil then
                                    cached["helmet_1"] = v.defaultData
                                end

                                if cached["helmet_1"] ~= v.defaultData then
                                    p:setCloth("helmet_1", v.defaultData)
                                    p:setCloth("helmet_2", 0)
                                    cached["helmet_1"] = v.defaultData
                                end

                            end,
                        }, hatsVariance)
                    end
                end)

                RageUI.IsVisible(hatsVariance, function()
                    for k, v in pairs(selectedHats) do
                        RageUI.Button(v.label, nil, { RightLabel = ">" }, true, {
                            onSelected = function()
                                if p:haveEnoughMoney(50) then
                                    p:pay(50)
                                    TriggerServerEvent("core:AddCloth", token, "Chapeau: " .. v.label,
                                        { ["helmet_1"] = v.hats1, ["helmet_2"] = v.hats2 })
                                    -- ShowNotification("Le chapeau ~o~" .. v.label .. "~s~ à été ajouté à votre inventaire")

                                    -- New notif
                                    exports['vNotif']:createNotification({
                                        type = 'JAUNE',
                                        -- duration = 5, -- In seconds, default:  4
                                        content = "Le chapeau ~s " .. v.label .. "~c à été ajouté à votre inventaire"
                                    })

                                end
                            end,
                            onActive = function()
                                if cached["helmet_1"] == nil then
                                    cached["helmet_1"] = v.hats1
                                end

                                if cached["helmet_2"] == nil then
                                    cached["helmet_2"] = v.hats2
                                end

                                if cached["helmet_1"] ~= v.hats1 then
                                    p:setCloth("helmet_1", v.hats1)
                                    cached["helmet_1"] = v.hats1
                                end

                                if cached["helmet_2"] ~= v.hats2 then
                                    p:setCloth("helmet_2", v.hats2)
                                    cached["helmet_2"] = v.hats2
                                end
                            end,
                        })
                    end
                end)
                Wait(1)
            end
        end)
    end
end
