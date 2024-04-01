local glassMenu = RageUI.CreateMenu("", "~b~Achat de chapeau", 0.0, 0.0, "shopui_title_lowendfashion2",
    "shopui_title_lowendfashion2")
local glassVariance = RageUI.CreateSubMenu(glassMenu, "", "~b~Achat de chapeau", 0.0, 0.0, "shopui_title_lowendfashion2"
    , "shopui_title_lowendfashion2")
local open = false
local cached = {}
local oldSkin
local selectedGlass = {}
local token = nil
glassMenu.Closed = function()
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
        "glass_shop", -- Nom
        vector3(461.91659545898, -773.05877685547, 27.357805252075), -- Position
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le magasin de lunettes", -- Text afficher
        function() -- Action qui seras fait
            OpenGlassShop()
        end,
        true, -- Avoir un marker ou non
        0, -- Id / type du marker
        0.5, -- La taille
        { 255, 255, 255 }, -- RGB
        170-- Alpha
    )
end)




function OpenGlassShop()
    if open then
        open = false
        RageUI.Visible(glassMenu, false)
        return
    else
        open = true
        RageUI.Visible(glassMenu, true)
        local glass = {}
        if p:isMale() then
            glass = GetMaleGlass()
        else
            glass = GetFemaleGlass()
        end

        local glassData = {}
        oldSkin = p:skin()

        for k, v in pairs(glass) do


            glassData[tonumber(k)] = {}
            glassData[tonumber(k)].label = GetLabelText(glass[k]["0"].GXT)
            if glassData[tonumber(k)].label == "NULL" then
                glassData[tonumber(k)].label = "Lunette #" .. k
            end
            glassData[tonumber(k)].defaultData = tonumber(k)
            glassData[tonumber(k)].data = {}
            for i, j in pairs(v) do
                local label = GetLabelText(j.GXT)
                if label == "NULL" then
                    label = "Variante #" .. i
                end
                table.insert(glassData[tonumber(k)].data, { label = label, glass1 = tonumber(k), glass2 = tonumber(i) })
            end


        end

        glass = {}
        cached = {}

        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(glassMenu, function()
                    for k, v in ipairs(glassData) do
                        RageUI.Button(v.label, nil, { RightLabel = ">" }, true, {
                            onSelected = function()
                                selectedGlass = v.data
                            end,
                            onActive = function()
                                if cached["glasses_1"] == nil then
                                    cached["glasses_1"] = v.defaultData
                                end

                                if cached["glasses_1"] ~= v.defaultData then
                                    p:setCloth("glasses_1", v.defaultData)
                                    p:setCloth("glasses_2", 0)
                                    cached["glasses_1"] = v.defaultData
                                end

                            end,
                        }, glassVariance)
                    end
                end)

                RageUI.IsVisible(glassVariance, function()
                    for k, v in pairs(selectedGlass) do
                        RageUI.Button(v.label, nil, { RightLabel = ">" }, true, {
                            onSelected = function()
                                if p:haveEnoughMoney(50) then
                                    p:pay(50)
                                    TriggerServerEvent("core:AddCloth", token, "Lunette: " .. v.label,
                                        { ["glasses_1"] = v.glass1, ["glasses_2"] = v.glass2 })
                                    
                                    --[[ Ancienne notification
                                    -- ShowNotification("Les lunettes ~o~" .. v.label ..
                                        "~s~ à été ajouté à votre inventaire")
                                    --]]

                                    -- New notif
                                    exports['vNotif']:createNotification({
                                        type = 'JAUNE',
                                        -- duration = 5, -- In seconds, default:  4
                                        content = "Les lunettes ~s" .. v.label .. "~c à été ajouté à votre inventaire"
                                    })

                                end
                            end,
                            onActive = function()
                                if cached["glasses_1"] == nil then
                                    cached["glasses_1"] = v.glass1
                                end

                                if cached["glasses_2"] == nil then
                                    cached["glasses_2"] = v.glass2
                                end

                                if cached["glasses_1"] ~= v.glass1 then
                                    p:setCloth("glasses_1", v.glass1)
                                    cached["glasses_1"] = v.glass1
                                end

                                if cached["glasses_2"] ~= v.glass2 then
                                    p:setCloth("glasses_2", v.glass2)
                                    cached["glasses_2"] = v.glass2
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
