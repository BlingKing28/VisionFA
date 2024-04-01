local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

function loadPawnshop()
    local ped = nil
    local created = false
    if not created then
        ped = entity:CreatePedLocal("mp_m_shopkeep_01", vector3(-322.23556518555, -100.54807281494, 46.047378540039), 332.63122558594)
        created = true
    end
    SetEntityInvincible(ped.id, true)
    ped:setFreeze(true)
    SetEntityAsMissionEntity(ped.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped.id, true)

    zone.addZone("pawnshop",
        vector3(-322.23556518555, -100.54807281494, 46.047378540039),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le pawnshop",
        function()
            openPawnshop()
        end,
        false
    )
end

local open = false
local pawnshop_main = RageUI.CreateMenu("Produits", "Yallah t'a quoi à vendre la verité")
local pawnshop_sub = RageUI.CreateSubMenu(pawnshop_main, "", "Produits", 0.0, 0.0, "root_cause", "Banner-PanShop")
pawnshop_main.Closed = function()
    open = false
end

local pawnshopCfg = {
    {
        item = "consolejv",
        price_min = 500,
        price_max = 1000,
    },
    {
        item = "tv",
        price_min = 1500,
        price_max = 3000,
    },
    {
        item = "tv2",
        price_min = 1000,
        price_max = 2000,
    },
    --{
    --    item = "laptop",
    --    price_min = 1400,
    --    price_max = 1900,
    --},
    {
        item = "jewel",
        price_min = 1000,
        price_max = 2000,
    },
    {
        item = "perfume",
        price_min = 500,
        price_max = 1000,
    },
    {
        item = "camera",
        price_min = 500,
        price_max = 1000,
    },
    {
        item = "enceinte",
        price_min = 1000,
        price_max = 2000,
    },
    {
        item = "manettejv",
        price_min = 500,
        price_max = 1000,
    },
    {
        item = "weapon_bouteille",
        price_min = 500,
        price_max = 1000,
    },
    {
        item = "guitar",
        price_min = 1000,
        price_max = 2000,
    },
    {
        item = "bouteille2",
        price_min = 1000,
        price_max = 2000,
    },
    {
        item = "champagne_pack",
        price_min = 500,
        price_max = 1000,
    },
    {
        item = "golf_bag",
        price_min = 500,
        price_max = 1000,
    }, 
    {
        item = "champagne",
        price_min = 500,
        price_max = 1000,
    },
    {
        item = "champ",
        price_min = 500,
        price_max = 1000,
    },
    {
        item = "diamond",
        price_min = 8000,
        price_max = 16000,
    },
    {
        item = "phone",
        price_min = 150,
        price_max = 300,
    },
    {
        item = "boombox",
        price_min = 150,
        price_max = 300,
    },
    {
        item = "weapon_bouteille",
        price_min = 500,
        price_max = 1000,
    },
    {
        item = "weapon_poolcue",
        price_min = 500,
        price_max = 1000,
    },
    {
        item = "weapon_dagger",
        price_min = 3000,
        price_max = 6000,
    },
}

local pawnshopItem = {}
for i = 1, 10 do
    table.insert(pawnshopItem, i)
end

function GetItemLabel(item)
    return items[item].label
end

function openPawnshop()
    if open then
        open = false
        RageUI.Visible(pawnshop_main, false)
        return
    else
        open = true
        RageUI.Visible(pawnshop_main, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(pawnshop_main, function()
                    for k, v in pairs(pawnshopCfg) do
                        RageUI.Button(GetItemLabel(v.item), false,
                            { RightLabel = "~g~Prix : " .. v.price_min .. "$", }, true,
                            {
                                onSelected = function()
                                    -- randomly choose a price between the min and max
                                    local price = v.price_max
                                    TriggerServerEvent("core:pawnshopSell", token, v.item, price)
                                end
                            }, nil)
                    end
                end)
                Wait(1)
            end
        end)
    end
end
