local open = false
local cloths = RageUI.CreateMenu("", "~b~Changer ses vêtements", 0.0, 0.0, "shopui_title_lowendfashion2",
    "shopui_title_lowendfashion2")
cloths.Closed = function()
    open = false
    RageUI.Visible(cloths, false)
end

function OpenChangeWorkClothMenu()
    if open then
        open = false
        RageUI.Visible(cloths, false)
        return
    else
        open = true
        RageUI.Visible(cloths, true)

        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(cloths, function()
                    RageUI.Button("Tenue civile", nil, {}, true, {
                        onSelected = function()
                            local civil = p:getCloths().skin
                            for k, v in pairs(civil) do
                                p:setCloth(k, v)
                                Wait(0)
                            end
                        end,
                    })
                    for k, v in pairs(loadedJob.cloths) do
                        if p:isMale() then
                            if v.women == false then
                                RageUI.Button(v.label, nil, {}, v.grade <= p:getJobGrade(), {
                                    onSelected = function()
                                        for i, j in pairs(v.cloths) do
                                            p:setCloth(i, j)
                                            Wait(0)
                                        end
                                    end,
                                })
                            end
                        else
                            if v.women == true then
                                RageUI.Button(v.label, nil, {}, v.grade <= p:getJobGrade(), {
                                    onSelected = function()
                                        for i, j in pairs(v.cloths) do
                                            p:setCloth(i, j)
                                            Wait(0)
                                        end
                                    end,
                                })
                            end
                        end
                    end
                end)
                Wait(1)
            end
        end)
    end
end
