local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)


local open = false
local main = RageUI.CreateMenu("", "Action disponible", 0.0, 0.0, "vision", "Banner_Chasse")
main.Closed = function()
    open = false
    RageUI.Visible(main, false)
end

local meatCfg = {
    {
        item = "lapin",
        price = 12,
        index = 1,
    },
    {
        item = "puma",
        price = 38,
        index = 1,
    },
    {
        item = "orc_v",
        price = 75,
        index = 1,
    },
    {
        item = "requin_v",
        price = 42,
        index = 1,
    },
    {
        item = "sanglier",
        price = 32,
        index = 1,
    },
    {
        item = "coyote",
        price = 16,
        index = 1,
    },
    {
        item = "biche",
        price = 16,
        index = 1,
    },
    {
        item = "oiseau",
        price = 10,
        index = 1,
    },
}

local meatItem = {}
for i = 1, 10 do
    table.insert(meatItem, i)
end


function GetItemLabel(item)
    return items[item].label
end

function OpenChasseMarket()
    if open then
        RageUI.Visible(main, false)
    else
        open = true
        RageUI.Visible(main, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(main, function()
                    for k, v in pairs(meatCfg) do
                        RageUI.List(GetItemLabel(v.item), meatItem, v.index, nil, { RightLabel = "~g~" .. v.price .. "$" }
                            , true, {
                            onListChange = function(Index, Item)
                                v.index = Index
                            end,
                            onSelected = function()
                                TriggerServerEvent("core:sellHunt", token, v.item, v.price, v.index)
                            end
                        })
                    end
                end)
                Wait(1)
            end
        end)
    end
end

Citizen.CreateThread(function()
    local ped = entity:CreatePedLocal("s_m_m_linecook", vector3(-1097.2944335938, -2056.5053710938, 12.291390419006),
        315.9245300293)
    SetEntityInvincible(ped.id, true)
    ped:setFreeze(true)
    TaskStartScenarioInPlace(ped.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
    SetEntityAsMissionEntity(ped.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped.id, true)
end)

CreateThread(function()
    while zone == nil do
        Wait(0)
    end
    zone.addZone("chasse", -- Nom
        vector3(-1097.2944335938, -2056.5053710938, 13.291390419006), -- Position
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le marché de chasse", -- Text afficher
        function() -- Action qui seras fait
            OpenChasseMarket()
        end, false)

end)
