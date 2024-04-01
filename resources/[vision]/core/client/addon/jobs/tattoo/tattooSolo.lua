local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local translate = {
    ["ZONE_HEAD"] = "Tête",
    ["ZONE_LEFT_ARM"] = "Bras gauche",
    ["ZONE_RIGHT_ARM"] = "Bras droit",
    ["ZONE_LEFT_LEG"] = "Jambe gauche",
    ["ZONE_RIGHT_LEG"] = "Jambe droit",
    ["ZONE_TORSO"] = "Torse/Dos",
}

local TattooZone = {
    ZONE_HEAD = {},
    ZONE_LEFT_ARM = {},
    ZONE_RIGHT_ARM = {},
    ZONE_LEFT_LEG = {},
    ZONE_RIGHT_LEG = {},
    ZONE_TORSO = {},
}

local open = false
local plys = {}
local tattoos_menu = RageUI.CreateMenu("", "Salon de tatouage", 0.0, 0.0, "shopui_title_tattoos4",
    "shopui_title_tattoos4")
local tattoos_zone = RageUI.CreateSubMenu(tattoos_menu, "", "Salon de tatouage", 0.0, 0.0, "shopui_title_tattoos4",
    "shopui_title_tattoos4")
local buy_or_show = RageUI.CreateSubMenu(tattoos_zone, "", "Salon de tatouage", 0.0, 0.0, "shopui_title_tattoos4",
    "shopui_title_tattoos4")
local oldSkin = {}
local index = {}
playerTattoos = {}
local TattooPNJ = nil
local isMale = true
local indexx = nil

local open1 = false
local choose_menu = RageUI.CreateMenu("", "Salon de tatouage", 0.0, 0.0, "shopui_title_tattoos4",
    "shopui_title_tattoos4")
local menu_choosehf = RageUI.CreateSubMenu(choose_menu, "", "Salon de tatouage", 0.0, 0.0, "shopui_title_tattoos4",
"shopui_title_tattoos4")
local menu_deltattoo1 = RageUI.CreateSubMenu(choose_menu, "", "Salon de tatouage", 0.0, 0.0, "shopui_title_tattoos4",
"shopui_title_tattoos4")
local menu_deltattoo2 = RageUI.CreateSubMenu(menu_deltattoo1, "", "Supression de tatouage", 0.0, 0.0, "shopui_title_tattoos4",
"shopui_title_tattoos4")
local chosenPlayer = nil
local plyTattoos = nil

local function tattooGetNameFromZoneSolo(name)
    if name == "ZONE_TORSO" then 
        name = "Torse"
    elseif name == "ZONE_RIGHT_ARM" then 
        name = "Bras droit"
    elseif name == "ZONE_LEFT_ARM" then 
        name = "Bras gauche"
    elseif name == "ZONE_HEAD" then 
        name = "Tête"
    elseif name == "ZONE_LEFT_LEG" then
        name = "Jambe gauche"
    elseif name == "ZONE_RIGHT_LEG" then
        name = "Jambe droite"
    end
    return name
end

function chooseMenuSolo()
    local TattooList = GetTattoos()
    if open1 then
        open1 = false
        RageUI.Visible(choose_menu, false)
    else
        open1 = true
        RageUI.Visible(choose_menu, true)
        CreateThread(function()
            while open1 do
                Wait(1)
                RageUI.IsVisible(choose_menu, function()
                    RageUI.Button("Ajouter un tatouage", nil, { RightLabel = "→→→" }, true, {
                        onSelected = function()
                        end
                    }, menu_choosehf)
                    RageUI.Button("Supprimer un tatouage", nil, { RightLabel = "→→→" }, true, {
                        onSelected = function()
                            GetAllPlayersInAreaWithDatatattooSudSolo()
                        end
                    }, menu_deltattoo1)
                end)
                RageUI.IsVisible(menu_choosehf, function()
                    RageUI.Button("Homme", nil, { RightLabel = "→→→" }, true, {
                        onSelected = function()
                            open1 = false
                            RageUI.CloseAll()
                            starttattooSudSolo(true)
                        end
                    }, nil)
                    RageUI.Button("Femme", nil, { RightLabel = "→→→" }, true, {
                        onSelected = function()
                            open1 = false
                            RageUI.CloseAll()
                            starttattooSudSolo(false)
                        end
                    }, nil)
                end)
                RageUI.IsVisible(menu_deltattoo1, function()
                    if plys then
                        for k, v in pairs(plys) do
                            RageUI.Button("~o~" .. v.player .. "~s~ | ~o~" .. v.name, nil, {}, true, {
                                onSelected = function()
                                    chosenPlayer = v
                                    plyTattoos = TriggerServerCallback("core:getPlayerTattoos", v.player)
                                end
                            }, menu_deltattoo2)
                        end
                    else
                        RageUI.Button("Aucun joueur dans la zone", nil, {}, true, {})
                    end
                end)
                RageUI.IsVisible(menu_deltattoo2, function()
                    if chosenPlayer then
                      --  print("GetPlayerPedDecorations", json.encode(plyTattoos))
                        for k,v in pairs(plyTattoos) do 
                            for z,x in pairs(TattooList) do
                                if x.HashNameMale == v.HashName or x.HashNameFemale == v.HashName then
                                    RageUI.Button(GetLabelText(x.Name), nil, {RightLabel= tattooGetNameFromZoneSolo(x.Zone)}, true, {
                                        onSelected = function()
                                            table.remove(plyTattoos, k)
                                            TriggerServerEvent("core:deleteTattooToPlayer", token, chosenPlayer.player, {HashName = v.HashName, Collection = v.Collection})
                                        end
                                    })
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
end

tattoos_menu.Closed = function()
    -- delete the spawned TattooPNJ
    if TattooPNJ ~= nil then
        DeleteEntity(TattooPNJ.id)
        TattooPNJ = nil
    end
    open = false
    collectgarbage("collect")
end

local function GetClosestDistanceToPedTableIDSolo(ped, tbl)
    local pedCoords = GetEntityCoords(ped)
    local closestDistance = -1
    local tblid = 1

    for i, coords in pairs(tbl) do
        local distance = GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, coords.x, coords.y, coords.z)
        if closestDistance == -1 or distance < closestDistance then
            closestDistance = distance
            tblid = i
        end
    end

    return closestDistance, tblid
end

function starttattooSudSolo(isMale)
    if open then
        open = false
        -- delete the spawned ped
        if TattooPNJ ~= nil then
            DeleteEntity(TattooPNJ.id)
            TattooPNJ = nil
        end
        RageUI.Visible(tattoos_menu, false)
    else
        open = true
        RageUI.Visible(tattoos_menu, true)
        local tattoos = GetTattoos()
        if isMale then
            model = "mp_m_freemode_01"
        else
            model = "mp_f_freemode_01"
        end
        RequestModel(GetHashKey(model))
        while not HasModelLoaded(GetHashKey(model)) do
            Wait(0)
        end
        TriggerServerEvent("TREFSDFD5156FD", "ADSFDF", 10000)

        if p:getJob() == 'tattooSud' then
            local pedscoords = {
                {x=320.53244018555, y=181.13461303711,  z=97.349449157715,  h=171.33345031738},
                {x=316.49572753906, y=182.59222412109,  z=97.349456787109,  h=166.21144104004},
                {x=-2137.8527832031, y=-473.05581665039,  z=3.2003273963928,   h=201.84226989746} --event plage
                --{x=312.66751098633, y=184.11888122559,  z=97.34944152832,   h=168.90376281738}
            }
            local closdist, idtabl = GetClosestDistanceToPedTableIDSolo(PlayerPedId(), pedscoords)
            Wait(50)
            TattooPNJ = entity:CreatePed(model, vector3(pedscoords[idtabl].x, pedscoords[idtabl].y, pedscoords[idtabl].z ), pedscoords[idtabl].h)
        else
            TattooPNJ = entity:CreatePed(model, vector3( -294.60705566406, 6200.3481445313, 30.562995910645 ), 42.8174)
        end
    
        SetEntityAsMissionEntity(TattooPNJ.id, 1, 1)
        -- remove the shirt if the TattooPNJ is male
        SetPedComponentVariation(TattooPNJ.id, 11, 15, 0, 0)
        -- remove the pants
        if isMale then
            SetPedComponentVariation(TattooPNJ.id, 4, 21, 0, 0)
        else
            SetPedComponentVariation(TattooPNJ.id, 4, 15, 0, 0)
        end
        -- remove the shoes
        if isMale then
            SetPedComponentVariation(TattooPNJ.id, 6, 34, 0, 0)
        else
            SetPedComponentVariation(TattooPNJ.id, 6, 35, 0, 0)
        end
        -- set the torso to have full arms
        SetPedComponentVariation(TattooPNJ.id, 3, 15, 0, 0)

        -- set the shirt overlay to have none
        SetPedComponentVariation(TattooPNJ.id, 8, 15, 0, 0)

        SetCanAttackFriendly(TattooPNJ.id, false, false)
        FreezeEntityPosition(TattooPNJ.id, true)
        SetEntityInvincible(TattooPNJ.id, true)
        SetBlockingOfNonTemporaryEvents(TattooPNJ.id, true)

        -- create tattoos list by zone
        for i = 1, #tattoos, 1 do
            if tattoos[i].Zone == "ZONE_HEAD" then
                if isMale and tattoos[i].HashNameMale then
                    table.insert(TattooZone.ZONE_HEAD, tattoos[i])
                elseif not isMale and tattoos[i].HashNameFemale ~= "" then

                    table.insert(TattooZone.ZONE_HEAD, tattoos[i])
                end
            elseif tattoos[i].Zone == "ZONE_LEFT_ARM" then
                if isMale and tattoos[i].HashNameMale ~= "" then
                    table.insert(TattooZone.ZONE_LEFT_ARM, tattoos[i])
                elseif not isMale and tattoos[i].HashNameFemale ~= "" then

                    table.insert(TattooZone.ZONE_LEFT_ARM, tattoos[i])
                end
            elseif tattoos[i].Zone == "ZONE_RIGHT_ARM" then
                if isMale and tattoos[i].HashNameMale ~= "" then
                    table.insert(TattooZone.ZONE_RIGHT_ARM, tattoos[i])
                elseif not isMale and tattoos[i].HashNameFemale ~= "" then

                    table.insert(TattooZone.ZONE_RIGHT_ARM, tattoos[i])
                end
            elseif tattoos[i].Zone == "ZONE_LEFT_LEG" then
                if isMale and tattoos[i].HashNameMale ~= "" then
                    table.insert(TattooZone.ZONE_LEFT_LEG, tattoos[i])
                elseif not isMale and tattoos[i].HashNameFemale ~= "" then

                    table.insert(TattooZone.ZONE_LEFT_LEG, tattoos[i])
                end
            elseif tattoos[i].Zone == "ZONE_RIGHT_LEG" then
                if isMale and tattoos[i].HashNameMale ~= "" then
                    table.insert(TattooZone.ZONE_RIGHT_LEG, tattoos[i])
                elseif not isMale and tattoos[i].HashNameFemale ~= "" then
                    table.insert(TattooZone.ZONE_RIGHT_LEG, tattoos[i])
                end
            elseif tattoos[i].Zone == "ZONE_TORSO" then
                if isMale then
                    if tattoos[i].HashNameMale ~= "" then
                        table.insert(TattooZone.ZONE_TORSO, tattoos[i])
                    end
                elseif not isMale then
                    if tattoos[i].HashNameFemale ~= "" then
                        table.insert(TattooZone.ZONE_TORSO, tattoos[i])
                    end
                end
            end
        end

        CreateThread(function()
            while open do
                RageUI.IsVisible(tattoos_menu, function()
                    for k, v in pairs(TattooZone) do
                        RageUI.Button(translate[k], nil, {}, true, {
                            onSelected = function()
                                index = v
                            end
                        }, tattoos_zone)
                    end
                end)
                RageUI.IsVisible(tattoos_zone, function()
                    for i = 1, #index, 1 do
                        local label = nil
                        label = GetLabelText(index[i].Name)
                        if label == "NULL" then
                            label = "Tatouage " .. i
                        end
                        RageUI.Button(label, nil, { RightLabel = "~g~" .. Round(index[i].Price / 5) .. "$" }, true,
                            {
                                onActive = function()

                                    if isMale then

                                        if GetHashKey(index[i].HashNameMale) ~= last then
                                            last = GetHashKey(index[i].HashNameMale)
                                            ClearPedDecorations(TattooPNJ.id)
                                            SetPedComponentVariation(TattooPNJ.id, 8, 15, 0, 2)
                                            SetPedComponentVariation(TattooPNJ.id, 3, 15, 0, 2)
                                            SetPedComponentVariation(TattooPNJ.id, 11, 15, 0, 2)
                                            SetPedComponentVariation(TattooPNJ.id, 4, 21, 0, 2)
                                            AddPedDecorationFromHashes(TattooPNJ.id, GetHashKey(index[i].Collection)
                                                , GetHashKey(index[i].HashNameMale))
                                        end
                                    else
                                        if GetHashKey(index[i].HashNameFemale) ~= last then
                                            last = GetHashKey(index[i].HashNameMale)
                                            ClearPedDecorations(TattooPNJ.id)
                                            SetPedComponentVariation(TattooPNJ.id, 8, 34, 0, 0)
                                            SetPedComponentVariation(TattooPNJ.id, 3, 15, 0, 0)
                                            SetPedComponentVariation(TattooPNJ.id, 11, 15, 0, 0)
                                            SetPedComponentVariation(TattooPNJ.id, 4, 15, 0, 0)
                                            AddPedDecorationFromHashes(TattooPNJ.id, GetHashKey(index[i].Collection)
                                                , GetHashKey(index[i].HashNameFemale))
                                        end
                                    end

                                end,
                                onSelected = function()
                                    indexx = i
                                end
                            }, buy_or_show)
                    end
                end)

                RageUI.IsVisible(buy_or_show, function()
                    i = indexx
                    RageUI.Button("Acheter le tatouage", nil, { RightLabel = "~g~" .. Round(index[i].Price / 5) .. "$" }, true,
                        {
                            onSelected = function()
                                if isMale then
                                    if index[i].HashNameMale ~= "" then
                                        GetAllPlayersInAreaWithDatatattooSudSolo()
                                        open = false
                                        RageUI.CloseAll()
                                        AddTattooMaleSolo(index[i].Collection, index[i].HashNameMale, Round(index[i].Price / 5))
                                    end
                                else
                                    if index[i].HashNameFemale ~= "" then
                                        GetAllPlayersInAreaWithDatatattooSudSolo()
                                        open = false
                                        RageUI.CloseAll()
                                        AddTattooFemaleSolo(index[i].Collection, index[i].HashNameFemale, Round(index[i].Price / 5))
                                    end
                                end
                            end
                        })
                    RageUI.Button("Montrer le tatouage", nil, {}, true,
                    {
                        onSelected = function()
                            local targets = GetAllPlayersInArea(p:pos(), 25.0)
                            -- create a list of server ids to send to the server
                            local serverIds = {}
                            for i = 1, #targets do
                                table.insert(serverIds, GetPlayerServerId(targets[i]))
                            end
                            if isMale then
                                if index[i].HashNameMale ~= "" then
                                    ClearPedDecorations(TattooPNJ.id)
                                    SetPedComponentVariation(TattooPNJ.id, 8, 15, 0, 2)
                                    SetPedComponentVariation(TattooPNJ.id, 3, 15, 0, 2)
                                    SetPedComponentVariation(TattooPNJ.id, 11, 15, 0, 2)
                                    SetPedComponentVariation(TattooPNJ.id, 4, 21, 0, 2)
                                    TriggerServerEvent("tattoos:update", token, PedToNet(TattooPNJ.id), index[i].Collection, index[i].HashNameMale, serverIds)
                                end
                            else
                                if index[i].HashNameFemale ~= "" then
                                    ClearPedDecorations(TattooPNJ.id)
                                    SetPedComponentVariation(TattooPNJ.id, 8, 34, 0, 0)
                                    SetPedComponentVariation(TattooPNJ.id, 3, 15, 0, 0)
                                    SetPedComponentVariation(TattooPNJ.id, 11, 15, 0, 0)
                                    SetPedComponentVariation(TattooPNJ.id, 4, 15, 0, 0)
                                    TriggerServerEvent("tattoos:update", token, PedToNet(TattooPNJ.id), index[i].Collection, index[i].HashNameMale, serverIds)
                                end
                            end
                        end
                    })
                end)
                Wait(1)
            end
        end)
    end
end

local add_tattoo = RageUI.CreateMenu("", "Salon de tatouage", 0.0, 0.0, "shopui_title_tattoos4",
    "shopui_title_tattoos4")
local open2 = false
add_tattoo.Closed = function()
    open2 = false
    RageUI.Visible(add_tattoo, false)
    DeleteEntity(TattooPNJ.id)
    TattooPNJ = nil
end

function AddTattooMaleSolo(collection, hashName, price)
    if open2 then
        open2 = false
        RageUI.Visible(add_tattoo, false)
    else
        open2 = true
        RageUI.Visible(add_tattoo, true)
        CreateThread(function()
            while open2 do
                RageUI.IsVisible(add_tattoo, function()
                    if plys then
                        for k, v in pairs(plys) do
                            if v.isMale then
                                RageUI.Button("~o~" .. v.player .. "~s~ | ~o~" .. v.name, nil, {}, true, {
                                    onSelected = function()
                                        if p:pay(tonumber(price)) then 
                                            TriggerServerEvent('core:addTattooToPlayer', token, v.player,
                                                { Collection = collection, HashName = hashName })
                                            else
                                                exports['vNotif']:createNotification({
                                                    type = 'ROUGE',
                                                    content = "~c Vous n'avez ~s pas assez d'argent"
                                                })
                                            end
                                        open2 = false
                                        DeleteEntity(TattooPNJ.id)
                                        TattooPNJ = nil
                                        RageUI.CloseAll()
                                    end
                                }, nil)
                            end
                        end
                    else
                        RageUI.Button("Aucun joueur dans la zone", nil, {}, true, {})
                    end
                end)
                Wait(1)
            end
        end)
    end
end

function AddTattooFemaleSolo(collection, hashName, price)
    if open2 then
        open2 = false
        RageUI.Visible(add_tattoo, false)
    else
        open2 = true
        RageUI.Visible(add_tattoo, true)
        CreateThread(function()
            while open2 do
                RageUI.IsVisible(add_tattoo, function()
                    if plys then
                        for k, v in pairs(plys) do
                            if not v.isMale then
                                RageUI.Button("~o~" .. v.player .. "~s~ | ~o~" .. v.name, nil, {}, true, {
                                    onSelected = function()
                                        if p:pay(tonumber(price)) then 
                                            TriggerServerEvent('core:addTattooToPlayer', token, v.player,
                                                { Collection = collection, HashName = hashName })
                                            else
                                                exports['vNotif']:createNotification({
                                                    type = 'ROUGE',
                                                    content = "~c Vous n'avez ~s pas assez d'argent"
                                                })
                                            end
                                        open2 = false
                                        DeleteEntity(TattooPNJ.id)
                                        TattooPNJ = nil
                                        RageUI.CloseAll()
                                    end
                                }, nil)
                            end
                        end
                    else
                        RageUI.Button("Aucun joueur dans la zone", nil, {}, true, {})
                    end
                end)
                Wait(1)
            end
        end)
    end
end

RegisterNetEvent('core:addTattooToPlayer')
AddEventHandler('core:addTattooToPlayer', function(data)
    if data then
        if data.Collection ~= "" and data.HashName ~= "" then
            AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(data.Collection), GetHashKey(data.HashName))
        end
    end
end)

RegisterNetEvent('tattoos:update')
AddEventHandler('tattoos:update', function(ped_net, collection, hashName)
    if ped_net then
        if collection ~= "" and hashName ~= "" then
            local ped_ent = NetworkGetEntityFromNetworkId(ped_net)
            AddPedDecorationFromHashes(ped_ent, GetHashKey(collection), GetHashKey(hashName))
        end
    end
end)

RegisterNetEvent('core:updateTattoo')
AddEventHandler('core:updateTattoo', function(tattoos)
    ClearPedDecorations(p:ped())
    for i = 1, #tattoos, 1 do
        if tattoos[i] ~= nil then
            AddPedDecorationFromHashes(p:ped(), GetHashKey(tattoos[i].Collection),
                GetHashKey(tattoos[i].HashName))
        end
    end
end)

function GetAllPlayersInAreaWithDatatattooSudSolo()
    local players = GetAllPlayersInArea(p:pos(), 5.0)
    plys = {}
    
    for k, v in pairs(players) do
        if v == PlayerId() then
            local src = GetPlayerServerId(v)
            local name = TriggerServerCallback("core:GetPlayerAreaName", src)

            -- local isMale = p:getSex()

    --[[         if p:getSex() == "M" then
                local isMale = true
            else
                local isMale = false
            end ]]

    --[[         local sex

            if p:skin(players).sex == 0 then
                sex = true
            elseif p:skin(players).sex == 1 then
                sex = false
            end
            ]]


            local isMale = TriggerServerCallback("core:GetPlayerAreaSex", src)

            print("IsMale : ".. isMale)

            if isMale == "M" then

                table.insert(plys, {
                    player = src,
                    name = name,
                    isMale = true
                })
                
            else

                table.insert(plys, {
                    player = src,
                    name = name,
                    isMale = false
                })
            end
        end
    end
end


local posTattoo = {
    vector3(320.63403320313, 180.97050476074, 97.349494934082),
    vector3(316.49572753906, 182.592224121096, 97.349456787109),
    vector3(-294.60705566406, 6200.3481445313, 30.562995910645)
}

function LoadTattooSolo()
    for k, v in pairs(posTattoo) do
         zone.addZone(
            "posTattoo" .. k,
            v,
            "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
            function()
                print("solo")
                chooseMenuSolo()
            end,
            true,
            25, -- Id / type du marker
            0.6, -- La taille
            { 51, 204, 255 }, -- RGB
            170-- Alpha
        )
    end
end

function unloadTattooSolo()
    for k, v in pairs(posTattoo) do
        zone.removeZone("posTattoo" .. k)
    end
end

local alreadyLoaded = false
CreateThread(function()
    local inDuty
    Wait(1000)
    while true do
        inDuty = TriggerServerCallback("core:getNumberOfDuty", token, "tattooNord") + TriggerServerCallback("core:getNumberOfDuty", token, "tattooSud")
        if inDuty == 0 then 
            if not alreadyLoaded then
                LoadTattooSolo()
                alreadyLoaded = true
            end
        else
            if alreadyLoaded then
                unloadTattooSolo()
                alreadyLoaded = false
            end
        end
        Wait(5500)
    end
end)

