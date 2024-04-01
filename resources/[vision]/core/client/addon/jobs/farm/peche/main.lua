local token = nil
local service = false
local veh = nil
local missionStart = false

local blips = nil
local posGreen = nil

local posRed = nil
local blipsred = nil

local inPeche = false
local good = 0
local first = false
local limit = 0
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)
local lucky = 0
local inOut = true
local touche = { {
    touch = "D",
    number = 9
}, {
    touch = "C",
    number = 319
}, {
    touch = "A",
    number = 44
}, {
    touch = "L",
    number = 182
}, {
    touch = "Z",
    number = 32
}, {
    touch = "S",
    number = 33
} }

local greenZone = { {
    item = "carpe",
    price = 4
}, {
    item = "bar",
    price = 4
}, {
    item = "merlan",
    price = 10
}, {
    item = "saumon",
    price = 11
}, {
    item = "calamar",
    price = 17
} }

local redZone = {
    {
        price = 60,
        name = "dauphin",
        label = "Dauphin",
        chance = 8,
    },
    {
        price = 30,
        name = "Esturgeon",
        label = "Esturgeon",
        chance = 12,
    },
    {
        price = 55,
        name = "orc",
        label = "Orque",
        chance = 6,
    },

    {
        price = 25,
        name =  "PoissonNapoleon",
        label = "Poisson Napoleon",
        chance = 20,
    },
    {
        price = 35,
        name =  "PoissonScie",
        label = "Poisson Scie",
        chance = 15,
    },
    {
        price = 150,
        name =  "Baleine",
        label = "Baleine",
        chance = 2,
    },

    {
        price = 20,
        name =  "raie",
        label = "Raie",
        chance = 30,
    },
    {
        price = 65,
        name =  "requin",
        label = "Requin",
        chance = 6,
    },

    {
        price = 25,
        name =  "Murene",
        label = "Murène",
        chance = 20,
    },

    {
        price = 0,
        name =  "algues",
        label = "Algues",
        chance = 70,
    },
}

local items = {
    headerImage = 'assets/MenuMetier/header_peche.jpg',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'PÊCHE',
    callbackName = 'sellFishIllegal',
    showTurnAroundButtons = false,
    elements = {
        {
            price = 140,
            image = "./assets/inventory/items/dauphin.png",
            name = "dauphin",
            label = "Dauphin",
            chance = 8,
        },
        {
            price = 120,
            image = "./assets/inventory/items/Esturgeon.png",
            name = "Esturgeon",
            label = "Esturgeon",
            chance = 12,
        },
        {
            price = 200,
            image = "./assets/inventory/items/orc.png",
            name = "orc",
            label = "Orque",
            chance = 6,
        },

        {
            price = 90,
            image = "./assets/inventory/items/PoissonNapoleon.png",
            name =  "PoissonNapoleon",
            label = "Poisson Napoleon",
            chance = 20,
        },
        {
            price = 110,
            image = "./assets/inventory/items/PoissonScie.png",
            name =  "PoissonScie",
            label = "Poisson Scie",
            chance = 15,
        },
        {
            price = 500,
            image = "./assets/inventory/items/Baleine.png",
            name =  "Baleine",
            label = "Baleine",
            chance = 2,
        },

        {
            price = 80,
            image = "./assets/inventory/items/raie.png",
            name =  "raie",
            label = "Raie",
            chance = 30,
        },
        {
            price = 200,
            image = "./assets/inventory/items/requin.png",
            name =  "requin",
            label = "Requin",
            chance = 6,
        },

        {
            price = 90,
            image = "./assets/inventory/items/Murene.png",
            name =  "Murene",
            label = "Murène",
            chance = 20,
        },
    }
}

local item = ""
local index = 1
local redZoneActive = false
function TakePecheurService(priceofbateau)
    if not service then
        service = true
        missionStart = true

        exports['vNotif']:createNotification({
            type = 'VERT',
            content = "~c Un point sur votre GPS a été placé"
        })

        ---Premiere Phase
        CreateThread(function()
            ---GestionBlips
            while missionStart do
                if blips ~= nil or blipsred ~= nil  then
                    RemoveBlip(blips)
                    RemoveBlip(blipsred)

                    ClearPedTasks(p:ped())
                end

                math.randomseed(GetGameTimer())
                local ramdom = math.random(1, #Pecheur.green)
                posGreen = Pecheur.green[ramdom]
                blips = AddBlipForRadius(posGreen.xyz, 300.0)
                SetBlipSprite(blips, 9)
                SetBlipColour(blips, 2)
                SetBlipAlpha(blips, 100)
                redZoneActive = false
                first = false

                math.randomseed(GetGameTimer())
                local RedPosRdm = math.random(1, #Pecheur.red)

                print(RedPosRdm)

                posRed = Pecheur.red[RedPosRdm]

                print(posRed)
                blipsred = AddBlipForRadius(posRed, 300.0)
                SetBlipSprite(blipsred, 9)
                SetBlipColour(blipsred, 1)
                SetBlipAlpha(blipsred, 100)
                redZoneActive = true
                first = false

                Modules.UI.RealWait(13 * 60000)

            end

        end)
        Wait(1000)

        -- Gestion Peches Green
        CreateThread(function()
            while missionStart do
                CreateThread(function()
                    while #(p:pos() - vector3(-279.58734130859, -2759.8889160156, -1.58142572641373)) <= 50.0 do
                        if IsControlJustPressed(0, 38) and p:isInVeh() then
                            ShowHelpNotification("Appyer sur ~INPUT_CONTEXT~ pour ranger le bateau")
                            if veh ~= nil then
                                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                                DeleteEntity(veh)
                            end

                            if p:isInVeh() then
                                DeleteEntity(veh)
                            end
                            SetEntityCoords(p:ped(), vector3(-290.62707519531, -2768.5500488281, 2.1953010559082))
                            print(blips)
                            RemoveBlip(blips)
                            RemoveBlip(blipsred)
                            TriggerSecurGiveEvent("core:addItemToInventory", token, "money", priceofbateau, {})
                            -- ShowNotification("Merci de ton travail à la prochaine")

                            -- New notif
                            exports['vNotif']:createNotification({
                                type = 'CLOCHE',
                                -- duration = 5, -- In seconds, default:  4
                                content = "~s Merci ~c de ton travail à la prochaine"
                            })
                            

                            service = false
                            veh = nil
                            missionStart = false
                            blips = nil
                            blipsred = nil
                            posGreen = nil
                            posRed = nil
                            inPeche = false
                            service = false
                            RemoveBlip(blips)
                            return
                        end
                        Wait(1)
                    end
                end)
                while #(p:pos().xyz - posGreen.xyz) <= 300 do
                    if not p:isInVeh() then
                        ShowHelpNotification("Appuyer sur ~INPUT_CONTEXT~ pour pêcher")
                        if IsControlJustPressed(0, 38) and not inPeche then
                            inPeche = true
                            TaskStartScenarioInPlace(p:ped(), "WORLD_HUMAN_STAND_FISHING", -1, true)
                            -- Play Scenario
                            good = 0
                            math.randomseed(GetGameTimer())
                            local maths = math.random(15, 30)
                            Wait(maths * 1000)
                            -- ShowNotification("Attention un poisson mord")

                            -- New notif
                            exports['vNotif']:createNotification({
                                type = 'JAUNE',
                                -- duration = 5, -- In seconds, default:  4
                                content = "~s Attention ~c un poisson mord"
                            })

                            CreateThread(function()
                                while inPeche do
                                    local x, y = Modules.UI.ConvertToPixel(90, 90)
                                    Modules.UI.DrawRectangle(vector2(0.48333334922791, 0.1490740776062), vector2(x, y),
                                        { 0, 0, 0, 150 }, true, { 0, 0, 0, 150 }, function()
                                        end, nil, false, false)
                                    Modules.UI.DrawTexts(0.50729167461395, 0.16111110150814, touche[index].touch, true,
                                        0.90, { 255, 255, 255, 255 }, 6, false, false)
                                    Modules.UI.DrawTexts(0.51093751192093, 0.099074073135853,
                                        "Appuyer sur la bonne touche !", true, 0.50, { 255, 255, 255, 255 }, 6, false,
                                        false)

                                    if IsControlJustPressed(0, tonumber(touche[index].number)) then
                                        math.randomseed(GetGameTimer())
                                        index = math.random(1, #touche)
                                        good = good + 1
                                    end

                                    if good == 5 then
                                        math.randomseed(GetGameTimer())
                                        local poisson = math.random(0, 100)
                                        if poisson <= 25 then
                                            -- ShowNotification("vous avez attrapé une carpe")

                                            -- New notif
                                            exports['vNotif']:createNotification({
                                                type = 'JAUNE',
                                                -- duration = 5, -- In seconds, default:  4
                                                content = "Vous avez attrapé ~s une carpe"
                                            })

                                            TriggerSecurGiveEvent("core:addItemToInventory", token, greenZone[1].item,
                                                1, {})
                                        elseif poisson > 25 and poisson <= 50 then
                                            -- ShowNotification("vous avez attrapé un bar")

                                            -- New notif
                                            exports['vNotif']:createNotification({
                                                type = 'JAUNE',
                                                -- duration = 5, -- In seconds, default:  4
                                                content = "Vous avez attrapé ~s un bar"
                                            })

                                            TriggerSecurGiveEvent("core:addItemToInventory", token, greenZone[2].item,
                                                1, {})

                                        elseif poisson > 50 and poisson <= 68 then
                                            -- ShowNotification("vous avez attrapé un merlan")

                                            -- New notif
                                            exports['vNotif']:createNotification({
                                                type = 'JAUNE',
                                                -- duration = 5, -- In seconds, default:  4
                                                content = "Vous avez attrapé ~s un merlan"
                                            })
                                            
                                            TriggerSecurGiveEvent("core:addItemToInventory", token, greenZone[3].item,
                                                1, {})

                                        elseif poisson > 68 and poisson <= 84 then
                                            -- ShowNotification("vous avez attrapé un saumon")

                                            -- New notif
                                            exports['vNotif']:createNotification({
                                                type = 'JAUNE',
                                                -- duration = 5, -- In seconds, default:  4
                                                content = "Vous avez attrapé ~s un saumon"
                                            })

                                            TriggerSecurGiveEvent("core:addItemToInventory", token, greenZone[4].item,
                                                1, {})

                                        elseif poisson > 84 then
                                            -- ShowNotification("vous avez attrapé un calamar")

                                            -- New notif
                                            exports['vNotif']:createNotification({
                                                type = 'JAUNE',
                                                -- duration = 5, -- In seconds, default:  4
                                                content = "Vous avez attrapé ~s un calamar"
                                            })

                                            TriggerSecurGiveEvent("core:addItemToInventory", token, greenZone[5].item,
                                                1, {})

                                        end
                                        inPeche = false
                                        good = 0
                                        ClearPedTasks(p:ped())
                                        local rod = GetClosestObjectOfType(p:pos().xyz, 20.0,
                                            GetHashKey("prop_fishing_rod_01"),
                                            false, false, false)
                                        if rod ~= 0 then
                                            SetEntityAsMissionEntity(rod, 1, 1)
                                            DeleteEntity(rod)
                                        end
                                        return
                                    end
                                    Wait(1)
                                end
                            end)
                        elseif IsControlJustPressed(0, 38) and inPeche then
                            inPeche = false
                            ClearPedTasksImmediately(p:ped(), true)
                        end
                    else
                        ShowHelpNotification("Sortez du bateau pour commencer à pecher")
                    end

                    Wait(1)
                end

                while #(p:pos().xyz - posRed.xyz) <= 300 do
                    if not p:isInVeh() then
                        ShowHelpNotification("Appuyer sur ~INPUT_CONTEXT~ pour pêcher")
                        if IsControlJustPressed(0, 38) and not inPeche then
                            inPeche = true
                            TaskStartScenarioInPlace(p:ped(), "WORLD_HUMAN_STAND_FISHING", -1, true)
                            -- Play Scenario
                            good = 0
                            math.randomseed(GetGameTimer())
                            local maths = math.random(15, 30)
                            Wait(maths * 1000)
                            -- ShowNotification("Attention un poisson mord")

                            -- New notif
                            exports['vNotif']:createNotification({
                                type = 'JAUNE',
                                -- duration = 5, -- In seconds, default:  4
                                content = "~s Attention ~c un poisson mord"
                            })

                            if not first then
                                local streetName = GetStreetNameFromHashKey(
                                    GetStreetNameAtCoord(posRed.x, posRed.y, posRed.z))
                                TriggerServerEvent('core:makeCall', "lspd", posRed.xyz, true,
                                    "Pêche illegal vers "
                                    ..
                                    streetName, false, "illegal")
                                TriggerServerEvent('core:makeCall', "lssd", posRed.xyz, true,
                                    "Pêche illegal vers "
                                    ..
                                    streetName, false, "illegal")
                                CreateThread(function()
                                    Modules.UI.RealWait(3 * 60000)
                                    first = true
                                end)

                            end

                            CreateThread(function()
                                while inPeche do
                                    local x, y = Modules.UI.ConvertToPixel(90, 90)
                                    Modules.UI.DrawRectangle(vector2(0.48333334922791, 0.1490740776062), vector2(x, y),
                                        { 0, 0, 0, 150 }, true, { 0, 0, 0, 150 }, function()
                                        end, nil, false, false)
                                    Modules.UI.DrawTexts(0.50729167461395, 0.16111110150814, touche[index].touch, true,
                                        0.90, { 255, 255, 255, 255 }, 6, false, false)
                                    Modules.UI.DrawTexts(0.51093751192093, 0.099074073135853,
                                        "Appuyer sur la bonne touche !", true, 0.50, { 255, 255, 255, 255 }, 6, false,
                                        false)

                                    if IsControlJustPressed(0, tonumber(touche[index].number)) then
                                        math.randomseed(GetGameTimer())
                                        index = math.random(1, #touche)
                                        good = good + 1
                                    end

                                    if good == 5 then
                                        math.randomseed(GetGameTimer())
                                        local poisson = math.random(0, 100)

                                        local currentChance = 0
                                        for _, fish in ipairs(redZone) do
                                            currentChance = currentChance + fish.chance
                                            if poisson <= currentChance then
                                                -- Le joueur a pêché ce poisson ou cette mauvaise chose (algues)
--[[                                                 TriggerClientEvent("showNotification", source, "Vous avez pêché : " .. fish.name)
 ]]
                                                -- New notif
                                                exports['vNotif']:createNotification({
                                                    type = 'JAUNE',
                                                    -- duration = 5, -- In seconds, default:  4
                                                    content = "Vous avez attrapé ~s un(e) ".. fish.label
                                                })

                                                TriggerSecurGiveEvent("core:addItemToInventory", token, fish.name, 1, {})
                                                
                                                --[[ print("Chance : ".. currentChance .. "| Chance 2 : ".. poisson) ]]

                                                return
                                            end
                                        end

                                        inPeche = false
                                        --[[ good = 0 ]]
                                        ClearPedTasks(p:ped())
                                        return
                                    end
                                    Wait(1)
                                end
                            end)
                        elseif IsControlJustPressed(0, 38) and inPeche then
                            inPeche = false
                            ClearPedTasksImmediately(p:ped(), true)
                        end
                    end

                    Wait(1)
                end
                Wait(500)
            end

        end)

    else
        if veh ~= nil then
            TriggerEvent('persistent-vehicles/forget-vehicle', veh)
            removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
            TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
            DeleteEntity(veh)
        end
        RemoveBlip(blips)
        RemoveBlip(blipsred)
        -- ShowNotification("Merci de ton travail à la prochaine")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'CLOCHE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Merci ~c de ton travail à la prochaine"
        })
        
        service = false
        veh = nil
        missionStart = false
        blips = nil
        blipsred = nil
        posGreen = nil
        posRed = nil
        inPeche = false
        service = false
        RemoveBlip(blips)
        RemoveBlip(blipsred)
        return
    end
end

local open = false
local called = false
---vente

function OpenSellFisherManMenu()
    if open then
        open = false
        return
    else
        print("SOLD")
        if p:haveItem("merlan") or p:haveItem("carpe") or p:haveItem("bar") or p:haveItem("saumon") or
            p:haveItem("calamar") then
                math.randomseed(GetGameTimer())
            local random = math.random(1, 3)
            if p:skin().sex == 1 then
                Visual.Subtitle(Pecheur.dialogue.FemaleGood[random], 4000)
            else
                Visual.Subtitle(Pecheur.dialogue.MaleGood[random], 4000)
            end
            open = true
        else
            if p:haveItem("dauphin") or p:haveItem("requin") or p:haveItem("orc") or p:haveItem("raie")
            or p:haveItem("Esturgeon") or p:haveItem("PoissonNapoleon") or p:haveItem("PoissonScie") or p:haveItem("Baleine") then
                Visual.Subtitle(Pecheur.indice[1], 10000)
            else
                math.randomseed(GetGameTimer())
                local random = math.random(1, 3)
                if p:skin().sex == 1 then
                    Visual.Subtitle(Pecheur.dialogue.FemaleNotGood[random], 4000)
                else
                    Visual.Subtitle(Pecheur.dialogue.MaleNotGood[random], 4000)
                end
            end
            open = false
            return
        end
        CreateThread(function()
            while open do -- TODO REWORK
                if limit >= 234 then
                    open = false
                    Visual.Subtitle(
                        "Merci mon gars ! On se revoit bientot. Après... Si t'as l'amour du risque, file moi ce qu'il te reste. On va voir ce qu'on peut faire mais attention aux snitch !"
                        ,
                        4000)
                    local streetName =
                    GetStreetNameFromHashKey(GetStreetNameAtCoord(posGreen.x, posGreen.y, posGreen.z))
                    return
                elseif p:haveItem("merlan") then
                    TriggerServerEvent("core:SellPecheur", token, "merlan", 1, tonumber(10))
                    limit = TriggerServerCallback("core:addJournalier")
                    Modules.UI.RealWait(1000)
                elseif p:haveItem("carpe") then
                    TriggerServerEvent("core:SellPecheur", token, "carpe", 1, tonumber(4))
                    limit = TriggerServerCallback("core:addJournalier")
                    Modules.UI.RealWait(1000)
                elseif p:haveItem("bar") then
                    TriggerServerEvent("core:SellPecheur", token, "bar", 1, tonumber(4))
                    limit = TriggerServerCallback("core:addJournalier")
                    Modules.UI.RealWait(1000)
                elseif p:haveItem("saumon") then
                    TriggerServerEvent("core:SellPecheur", token, "saumon", 1, tonumber(11))
                    limit = TriggerServerCallback("core:addJournalier")
                    Modules.UI.RealWait(1000)
                elseif p:haveItem("calamar") then
                    TriggerServerEvent("core:SellPecheur", token, "calamar", 1, tonumber(17))
                    limit = TriggerServerCallback("core:addJournalier")
                    Modules.UI.RealWait(1000)
                elseif not p:haveItem("merlan") and not p:haveItem("calamar") and not p:haveItem("saumon") and
                    not p:haveItem("bar") and not p:haveItem("carpe") then
                    if p:haveItem("dauphin") or p:haveItem("requin") or p:haveItem("orc") or p:haveItem("raie")
                    or p:haveItem("Esturgeon") or p:haveItem("PoissonNapoleon") or p:haveItem("PoissonScie") or p:haveItem("Baleine") then
                        Visual.Subtitle(Pecheur.indice[1], 10000)
                    else
                        math.randomseed(GetGameTimer())
                        local random = math.random(1, 3)
                        if p:skin().sex == 1 then
                            Visual.Subtitle(Pecheur.dialogue.FemaleNotGood[random], 4000)
                        else
                            Visual.Subtitle(Pecheur.dialogue.MaleNotGood[random], 4000)
                        end
                    end
                    open = false
                 --   return
                end
                Modules.UI.RealWait(1000)
            end
        end)
    --    open = false
    end
end

local open = false
---vente

RegisterNUICallback("sellFishIllegal", function(data, cb)

    if p:haveItem(data.name) then

        for k, v in pairs(p:getInventaire()) do
            if v.name == data.name then

--[[                 print('Vente de x'.. v.count ..data.name.. " à " .. data.price .. "$")
 ]]
                local totalprice = data.price / 2 * v.count

                exports['vNotif']:createNotification({
                    type = 'DOLLAR',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Vous avez vendu ~sx"..v.count.." "..data.label.. " ~c pour ~s "..totalprice.."$"
                })

                TriggerServerEvent("core:SellPecheur", token, data.name, v.count, totalprice)

                --[[ print("Nombre de ".. v.count) ]]
                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }))
            end
        end

    else
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "Vous ~sn'avez pas ~cde ~s"..data.label
        })

        SendNuiMessage(json.encode({
            type = 'closeWebview',
        }))
        
    end

end)

function OpenSellFisherManIllegalMenu()
    if open then
        open = false
        return
    else
        if p:haveItem("dauphin") or p:haveItem("requin") or p:haveItem("Murene") or p:haveItem("orc") or p:haveItem("raie")
        or p:haveItem("Esturgeon") or p:haveItem("PoissonNapoleon") or p:haveItem("PoissonScie") or p:haveItem("Baleine") then
            math.randomseed(GetGameTimer())
            local random = math.random(1, 3)
            if p:skin().sex == 1 then
                Visual.Subtitle(Pecheur.illegal.FemaleGood[random], 4000)
            else
                Visual.Subtitle(Pecheur.illegal.MaleGood[random], 4000)
            end
            open = true
        else
            if p:skin().sex == 1 then
                Visual.Subtitle(Pecheur.illegal.FemaleNotGood[1], 4000)
            else
                Visual.Subtitle(Pecheur.illegal.MaleNotGood[1], 4000)
            end
            open = false
            return
        end
        
        
        if open then
            if p:haveItem("dauphin") or p:haveItem("requin") or p:haveItem("Murene") or p:haveItem("orc") or p:haveItem("raie")
            or p:haveItem("Esturgeon") or p:haveItem("PoissonNapoleon") or p:haveItem("PoissonScie") or p:haveItem("Baleine") then

                FreezeEntityPosition(PlayerPedId(), true)
                SendNuiMessage(json.encode({
                    type = 'openWebview',
                    name = 'MenuCatalogueAchat',
                    data = items
                }));

            elseif not p:haveItem("dauphin") or not p:haveItem("requin") or not p:haveItem("Murene") or not p:haveItem("orc") or not p:haveItem("raie")
            or not p:haveItem("Esturgeon") or not p:haveItem("PoissonNapoleon") or not p:haveItem("PoissonScie") or not p:haveItem("Baleine") then
                if p:skin().sex == 1 then
                    Visual.Subtitle(Pecheur.illegal.FemaleNotGood[1], 4000)
                else
                    Visual.Subtitle(Pecheur.illegal.MaleNotGood[1], 4000)
                end
                open = false
                return
            end
            Modules.UI.RealWait(1000)
        end
    end
end

Citizen.CreateThread(function()
    local ped = entity:CreatePedLocal("a_m_m_salton_02", vector3(-290.00582885742, -2769.6403808594, 1.195300579071),
        8.9478597640991)
    SetEntityInvincible(ped.id, true)
    ped:setFreeze(true)
    TaskStartScenarioInPlace(ped.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
    SetEntityAsMissionEntity(ped.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped.id, true)
    local peds2 = entity:CreatePedLocal("a_m_m_salton_02", vector3(-330.64041137695, -2778.9379882813, 4.1450777053833),
        83.05534362793)
    SetEntityInvincible(peds2.id, true)
    peds2:setFreeze(true)
    TaskStartScenarioInPlace(peds2.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
    SetEntityAsMissionEntity(peds2.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(peds2.id, true)
    local peds3 = entity:CreatePedLocal("mp_m_weed_01", vector3(1524.2238769531, 1709.9182128906, 109.01895141602),
        193.53335571289)
    SetEntityInvincible(peds3.id, true)
    peds3:setFreeze(true)
    TaskStartScenarioInPlace(peds3.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
    SetEntityAsMissionEntity(peds3.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(peds3.id, true)
end)

CreateThread(function()
    while zone == nil do
        Wait(0)
    end
    zone.addZone("pecheur_job", -- Nom
        vector3(-290.00582885742, -2769.6403808594, 1.195300579071), -- Position
        "Appuyer sur ~INPUT_CONTEXT~ pour prendre/arrêter votre service", -- Text afficher
        function() -- Action qui seras fait
            Openpeche()
        end, false)

    zone.addZone("sellpecheur_job", -- Nom
        vector3(-330.61737060547, -2778.9426269531, 5.1450777053833), -- Position
        "Appuyer sur ~INPUT_CONTEXT~ pour vendre", -- Text afficher
        function() -- Action qui seras fait
            called = false
            OpenSellFisherManMenu()
        end, false)
    zone.addZone("SellIllegalPecheur_job", -- Nom
        vector3(1524.2238769531, 1709.9182128906, 109.01895141602), -- Position
        "Appuyer sur ~INPUT_CONTEXT~ pour vendre", -- Text afficher
        function() -- Action qui seras fait
            OpenSellFisherManIllegalMenu()
        end, false)


    zone.addZone("pecheur_DelVeh", vector3(-279.58734130859, -2759.8889160156, 3.58142572641373),   
    "Appuyer sur ~INPUT_CONTEXT~ pour ranger le bateaux", function()
        if IsPedInAnyVehicle(p:ped(), false) then
            if GetVehicleBodyHealth(p:currentVeh()) / 10 < 80 or
                GetVehicleEngineHealth(p:currentVeh()) / 10 <
                80 then
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Votre véhicule est trop abimé"
                    })
            end
        end
    end, true, 35, 1.5, { 255, 0, 0 }, 255)

end)

local PecheOuvert = false
local itemcall = {
    headerBanner = 'assets/MenuMetier/peche.jpg',
    choice = {
        label = 'Location de bateaux',
        isOptional = true,
        choices = {
            {
                id = 1,
                label = 'Tug 500$',
                name = 'tug',
                price = 500,
                img= "https://assets-vision-fa.cdn.purplemaze.net/assets/Farm/Peche/tug.webp",
            },            
            {
                id = 2,
                label = 'Suntrap 500$',
                name = 'suntrap',
                price = 500,
                img= "https://assets-vision-fa.cdn.purplemaze.net/assets/Farm/Peche/suntrap.webp",
            },      
            {
                id = 3,
                label = 'Dinghy 500$',
                name = 'dinghy',
                price = 500,
                img= "https://assets-vision-fa.cdn.purplemaze.net/assets/Farm/Peche/dinghy.webp",
            },
        }
    },
    callbackName = 'MetierPeche',
}

function Openpeche()
    SendNUIMessage({
        type = "openWebview",
        name = "MenuMetier",
        data = itemcall
    })
    PecheOuvert = true 
    forceHideRadar()
    SetNuiFocusKeepInput(true)
    CreateThread(function()
        while PecheOuvert do 
            Wait(1)
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 18, true)
            DisableControlAction(0, 322, true)
            DisableControlAction(0, 106, true)
            DisableControlAction(0, 24, true) 
            DisableControlAction(0, 25, true) 
            DisableControlAction(0, 263, true) 
            DisableControlAction(0, 264, true) 
            DisableControlAction(0, 257, true) 
            DisableControlAction(0, 140, true) 
            DisableControlAction(0, 141, true) 
            DisableControlAction(0, 142, true) 
            DisableControlAction(0, 143, true)
            DisableControlAction(0, 38, true)
            DisableControlAction(0, 44, true)
        end
    end)
end

RegisterNUICallback("focusOut", function (data, cb)
    if PecheOuvert then 
        openRadarProperly()
        PecheOuvert = false
    end
end)

RegisterNUICallback("MetierPeche", function(data)
    if data.selected then 
        print("price, name", data.selected.price, data.selected.name)
        if p:haveEnoughMoney(data.selected.price) then
            if vehicle.IsSpawnPointClear(vector3(-279.58734130859, -2759.8889160156, 0.58142572641373), 15.0) then
                local outPos = vector4(-279.58734130859, -2759.8889160156, 0.58142572641373,277.40927124023)
                veh = vehicle.create(data.selected.name, outPos, {})
                TaskWarpPedIntoVehicle(p:ped(), veh, -1)
                p:pay(data.selected.price)
                PecheOuvert = false
                SendNuiMessage(json.encode({
                    type = 'closeWebview'
                }))
                if not missionStart then
                    TakePecheurService(data.selected.price)
                end
            else
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Un bateau est déjà de sortie"
                })
            end
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Vous n'avez pas assez d'argent"
            })
        end
    elseif data.button == "start" then 
        if not service then
            exports['vNotif']:createNotification({
                type = 'JAUNE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous pouvez ~s commencer ~c à pêcher"
            })
            PecheOuvert = false
            SendNuiMessage(json.encode({
                type = 'closeWebview'
            }))
            TakePecheurService(data.selected.price)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous êtes déjà en service de pêche"
            })
        end
    elseif data.button == "stop" then
        if service then
            exports['vNotif']:createNotification({
                type = 'JAUNE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s arrêté ~c de pêcher"
            })
            PecheOuvert = false

            RemoveBlip(blips)
            RemoveBlip(blipsred)
            service = false
            veh = nil
            missionStart = false
            blips = nil
            blipsred = nil
            posGreen = nil
            posRed = nil
            inPeche = false
            service = false


            SendNuiMessage(json.encode({
                type = 'closeWebview'
            }))
            TakePecheurService(data.selected.price)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous n'êtes pas en service de pêche"
            })
        end
    end
end)