BijouterieShop = {
    cam = nil,
    open = false,
    Preopen = false,
}

local BijouterieShopPreopen = false

local oldSkin = nil

local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

RegisterNUICallback("focusOut", function()
    if BijouterieShop.open then
        zone.showNotif(BijouterieId)
        SetNuiFocusKeepInput(false)
        SetNuiFocus(false, false)
        ClearPedTasks(PlayerPedId())
        BijouterieShop.open = false
        p:setSkin(oldSkin)
    end
    if BijouterieShopPreopen then 
      --  print("If BijouterieShopPreopen")
        SetNuiFocusKeepInput(false)
        SetNuiFocus(false, false)
        BijouterieShopPreopen = false
    end
end)

local function WatchesAnim()
    RequestAnimDict("anim@random@shop_clothes@watches")
    while not HasAnimDictLoaded("anim@random@shop_clothes@watches") do Wait(1) end
    CreateThread(function()
        TaskPlayAnim(GetPlayerPed(-1), "anim@random@shop_clothes@watches", "intro", 8.0, -8.0, -1, 0, 0, 0, 0, 0)
        Wait(GetAnimDuration("anim@random@shop_clothes@watches", "intro") * 1000)
        while IsEntityPlayingAnim(GetPlayerPed(-1), "anim@random@shop_clothes@watches", "intro") do Wait(1) end
        if BijouterieShop.open then
            if IsEntityPlayingAnim(PlayerPedId(), "anim@random@shop_clothes@watches", "intro", 3) then
                TaskPlayAnim(GetPlayerPed(-1), "anim@random@shop_clothes@watches", "idle_d", 8.0, -8.0, -1, 1, 0, 0, 0, 0)
            end
        end
        RemoveAnimDict("anim@random@shop_clothes@watches")
    end)
end

local function GetDatas()
    local Skin = p:skin()    
    ApplySkinFake(Skin)
    DataSendVangelico.catalogue = {}
    -- Montres
    local playerType = "Homme"
    if Skin.sex == 1 then
        playerType = "Femme"
    end
    local montresbanlistfemme = {0, 1, 11, 12, 13, 14, 15, 16, 17, 18, 29, 30, 31,32,33,34,35}

    for i = 0, GetNumberOfPedPropDrawableVariations(PlayerPedId(), 6) - 1 do 
        if playerType == "Homme" and (i ~= 40 and i ~= 2 and i ~= 22 and i ~= 23 and i ~= 24 and i ~= 25 and i ~= 26 and i ~= 27 and i ~= 28 and i ~= 29) and i < 53 then
                for z = 1, GetNumberOfPedPropTextureVariations(PlayerPedId(), 6, i) do
                    if (i == 0 and z > 1) then elseif (i == 1 and z > 1) then else
                        table.insert(DataSendVangelico.catalogue, {id = i, price = BijouteriePrices["Montres"][playerType][tostring(i.."_"..z)], image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerType.."/Montres/"..i.."_"..z..".webp", category="Montres", label = "Montre #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
                    end
                end
        elseif playerType == "Femme" then 
            for z = 1, GetNumberOfPedPropTextureVariations(PlayerPedId(), 6, i) do
                if not tableContains(montresbanlistfemme, i) then
                    table.insert(DataSendVangelico.catalogue, {id = i, price = BijouteriePrices["Montres"][playerType][tostring(i.."_"..z)], image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerType.."/Montres/"..i.."_"..z..".webp", category="Montres", label = "Montre #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
                end
            end
        end
    end
    
    -- Colliers
    local listbanfemmecollier = {209, 196, 195, 194}
    for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 7)-1 do
        if playerType == "Homme" and i > 224 and i < 267 and i ~= 228 and i ~= 246 and i ~= 249 and i ~= 229 and i ~= 233 and i ~= 234 and i ~= 235 and i ~= 236 then
            for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 7, i) do
                local add = i+1
                table.insert(DataSendVangelico.catalogue, {id = i, price = BijouteriePrices["Colliers"][playerType][tostring(i.."_"..z)], image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerType.."/Colliers/"..add.."_"..z..".webp", category="Colliers", label="Colier #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
            end
        elseif playerType == "Femme" and i > 172 and i < 217 then
            if not tableContains(listbanfemmecollier, i) then
                for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 7, i) do
                    if i == 114 and z > 2 then else
                        table.insert(DataSendVangelico.catalogue, {id = i, BijouteriePrices["Colliers"][playerType][tostring(i.."_"..z)], image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerType.."/Colliers/"..i.."_"..z..".webp", category="Colliers", label="Colier #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
                    end
                end
            end
        end
    end

    -- Bracelets
    for i = 0, GetNumberOfPedPropDrawableVariations(PlayerPedId(), 7)-1 do
        for z = 1, GetNumberOfPedPropTextureVariations(PlayerPedId(), 7, i) do
            if playerType == "Femme" then 
                if i ~= 15 then 
                    table.insert(DataSendVangelico.catalogue, {id = i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerType.."/Bracelet/"..i.."_"..z..".webp", category="Bracelets", label="Bracelet #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
                end
            else
                table.insert(DataSendVangelico.catalogue, {id = i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerType.."/Bracelet/"..i.."_"..z..".webp", category="Bracelets", label="Bracelet #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
            end
        end
    end

    -- Boucle d'oreille
    for i = 0, GetNumberOfPedPropDrawableVariations(PlayerPedId(), 2)-1 do
        for z = 1, GetNumberOfPedPropTextureVariations(PlayerPedId(), 2, i) do
            if playerType == "Femme" and i > 2 then
                table.insert(DataSendVangelico.catalogue, {id = i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerType.."/BoucleOreilles/"..i.."_"..z..".webp", category="Boucles d\'oreilles", label="Boucles d\'oreilles #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
            elseif playerType == "Homme" then
                table.insert(DataSendVangelico.catalogue, {id = i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerType.."/BoucleOreilles/"..i.."_"..z..".webp", category="Boucles d\'oreilles", label="Boucles d\'oreilles #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
            end
        end
    end

    -- bagues
    local bannedidbaguefemme = {115, 116, 122, 117, 118, 124}
    local bannedidbaguehomme = {141}
    for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 9) - 1 do
        if playerType == "Homme" and i > 136 and i < 145 then
            for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 7, i) do
                local add = i+1
                if not tableContains(bannedidbaguehomme, i) then
                    if i == 137 and z > 2 then else
                        if i == 138 and z > 2 then else
                            if i == 139 and z > 1 then else
                                if i == 140 and z > 2 then else
                                    if i == 144 and z > 3 then else
                                        if i == 143 and z > 1 then else
                                            table.insert(DataSendVangelico.catalogue, {id = i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerType.."/Bagues/"..add.."_"..z..".webp", category="Bagues", label="Bague #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        elseif playerType == "Femme" and i > 111 and i < 126 then
            if not tableContains(bannedidbaguefemme, i) then
                for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 7, i) do
                    if i == 119 and z > 2 then else
                        table.insert(DataSendVangelico.catalogue, {id = i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerType.."/Bagues/"..i.."_"..z..".webp", category="Bagues", label="Bague #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
                    end
                end
            end
        end
    end
    
    DataSendVangelico.headerIconName = "Vangelico"
    if p:getJob() == "vangelico" then
        DataSendVangelico.disableSubmit = false
    else
        DataSendVangelico.disableSubmit = true
    end

    return true
end

local function CreateCameraBijouterie(typecam)
    if BijouterieShop.cam == nil then
        BijouterieShop.cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    end
    SetCamActive(BijouterieShop.cam, 1)
    local coord = GetEntityCoords(PlayerPedId())
    local formattedcamval = {coord.x, coord.y, coord.z}
    if typecam == "Bracelets" then 
        formattedcamval = {coord.x+1.0, coord.y, coord.z+0.45, 55, -0.2}
        --if not IsEntityPlayingAnim(PlayerPedId(), "amb@code_human_wander_idles_fat@male@idle_a", "idle_a_wristwatch", 3) then
        --    PlayEmote("amb@code_human_wander_idles_fat@male@idle_a", "idle_a_wristwatch", 49, -1)
        --end
    elseif typecam == "Bagues" then         
        formattedcamval = {coord.x+1.0, coord.y, coord.z-0.1, 65, -0.3}
    elseif typecam == "Montres" then 
        formattedcamval = {coord.x+1.0, coord.y, coord.z+0.49, 60, 0.2}
        if not IsEntityPlayingAnim(PlayerPedId(), "anim@random@shop_clothes@watches", "intro", 3) then
            if not IsEntityPlayingAnim(PlayerPedId(), "anim@random@shop_clothes@watches", "idle_d", 3) then
                WatchesAnim()
            end
        end
    elseif typecam == "Colliers" then 
        formattedcamval = {coord.x+1.0, coord.y, coord.z+0.75, 60, 0.26}
        if not IsEntityPlayingAnim(PlayerPedId(), "clothingtie", "idle_a_wristwatch", 3) then
            PlayEmote("clothingtie", "try_tie_base", 49, -1)
        end
    elseif typecam == "Boucles d\'oreilles" then 
        formattedcamval = {coord.x+1.0, coord.y, coord.z+0.85, 30, 0.5}
        ClearPedTasks(PlayerPedId())
    end
    SetCamCoord(BijouterieShop.cam, formattedcamval[1], formattedcamval[2], formattedcamval[3])
    PointCamAtCoord(BijouterieShop.cam, coord.x, coord.y, coord.z + formattedcamval[5])
    SetCamFov(BijouterieShop.cam, formattedcamval[4] + 0.1)
    Wait(20)
    local p1 = GetCamCoord(BijouterieShop.cam)
    local p2 = GetEntityCoords(PlayerPedId())
    local dx = p1.x - p2.x
    local dy = p1.y - p2.y
    local heading = GetHeadingFromVector_2d(dx, dy)
    SetEntityHeading(PlayerPedId(), heading)
    RenderScriptCams(true, 0, 3000, 1, 0)
end

RegisterNUICallback("Menu_Vangelico_achat_callback", function(data)
    --print("Menu_Vangelico_achat_callback", json.encode(data), data.price)
    if data.button then 
        CreateCameraBijouterie(data.button)
    end
    if data.reset then 
        ClearPedTasks(PlayerPedId())
        RenderScriptCams(false, 0, 3000, 1, 0)
    end
   -- if data.price == nil then return end
    if BijouterieShop.open and data.category and data.id then
        local skin = GetFakeSkin()
        p:setSkin(skin)
        p:saveSkin()
        oldSkin = p:skin()
        print("Achat : ", data.category, data.id, data.VariationID)
        if data.category and data.category == "Montres" then 
            TriggerSecurGiveEvent("core:addItemToInventory", token, "montre", 1, {
                renamed = "Montre #" .. data.id,
                drawableId = data.id,
                variationId = data.VariationID or 0
            })
        elseif data.category == "Bracelets" then
            TriggerSecurGiveEvent("core:addItemToInventory", token, "bracelet", 1, {
                renamed = "Bracelets #" .. data.id,
                drawableId = data.id,
                variationId = data.VariationID or 0
            })
        elseif data.category == "Boucles d\'oreilles" then
            TriggerSecurGiveEvent("core:addItemToInventory", token, "bouclesoreilles", 1, {
                renamed = "Boucles d\'oreilles #" .. data.id,
                drawableId = data.id,
                variationId = data.VariationID or 0
            })
        elseif data.category == "Colliers" then
            TriggerSecurGiveEvent("core:addItemToInventory", token, "collier", 1, {
                renamed = "Collier #" .. data.id,
                drawableId = data.id,
                variationId = data.VariationID or 0
            })
        elseif data.category == "Bagues" or data.category == "Bague" then
            TriggerSecurGiveEvent("core:addItemToInventory", token, "bague", 1, {
                renamed = "Bague #" .. data.id,
                drawableId = data.id,
                variationId = data.VariationID or 0
            })
        end
        exports['vNotif']:createNotification({
            type = 'VERT',
            -- duration = 5, -- In seconds, default:  4
            content = "~c Vous avez récupéré votre/vos " .. data.category
        })
    end
end)

RegisterNUICallback("Menu_Vangelico_preview_callback", function(data)
   -- print("Menu_Vangelico_preview_callback", json.encode(data))
    if data == nil or data.category == nil then return end
    if data.VariationID == nil then data.VariationID = 0 end
    print("Id, Variation", data.id, data.VariationID)
    if data.category == "Montres" then 
        CreateCameraBijouterie("Montres") 
        data.category = "watches_1"
        if data.VariationID then
            SkinChangeFake("watches_2", data.VariationID, true)
        end
    end
    if data.category == "Bracelets" then 
        CreateCameraBijouterie("Bracelets") 
        data.category = "bracelets_1"
        if data.VariationID then
            SkinChangeFake("bracelets_2", data.VariationID, true)
        end
    end
    if data.category == "Bagues" or data.category == "Bague" then
        CreateCameraBijouterie("Bagues") 
        data.category = "bproof_1"
        if data.VariationID then
            SkinChangeFake("bproof_2", data.VariationID, true)
        end        
    end
    if data.category == "Boucles d\'oreilles" then 
        CreateCameraBijouterie("Boucles d\'oreilles") 
        data.category = "ears_1"
        if data.VariationID then
            SkinChangeFake("ears_2", data.VariationID, true)
        end
    end
    if data.category == "Colliers" then 
        CreateCameraBijouterie("Colliers") 
        data.category = "chain_1" 
        if data.VariationID then
            SkinChangeFake("chain_2", data.VariationID, true)
        end
    end
    SkinChangeFake(data.category, data.id, true)
end)


DataSendVangelico = {
    catalogue = {},
    buttons = {
        {
            name = 'Montres',
            width = 'full',
            --image = 'assets/Vangelico/logo_montre.svg',
            --hoverStyle = 'fill-black stroke-black',
            hoverStyle = 'stroke-black',
            image = 'https://media.discordapp.net/attachments/498529074717917195/1144402242640826379/image.png',
            type = 'coverBackground',
        },
        {
            name = 'Colliers',
            width = 'full',
            --image = 'assets/Vangelico/logo_colliers.svg',
            --hoverStyle = 'fill-black stroke-black',
            hoverStyle = 'stroke-black',
            image = 'https://media.discordapp.net/attachments/498529074717917195/1144402327164428429/image.png',
            type = 'coverBackground',
        },
        {
            name = 'Boucles d\'oreilles',
            width = 'full',
            --image = 'assets/Vangelico/logo_boucles_oreilles.svg',
            --hoverStyle = 'fill-black stroke-black',
            hoverStyle = 'stroke-black',
            image = 'https://media.discordapp.net/attachments/498529074717917195/1144402392880791663/image.png',
            type = 'coverBackground',
        },
        {
            name = 'Bracelets',
            width = 'full',
            --image = 'assets/Vangelico/logo_bracelets.svg',
            --hoverStyle = 'fill-black stroke-black',
            hoverStyle = 'stroke-black',
            image = 'https://media.discordapp.net/attachments/498529074717917195/1144402467136733234/image.png',
            type = 'coverBackground',
        },
        {
            name = 'Bagues',
            width = 'full',
            --image = 'assets/Vangelico/logo_bagues.svg',
            --hoverStyle = 'fill-black stroke-black',
            hoverStyle = 'stroke-black',
            image = 'https://media.discordapp.net/attachments/498529074717917195/1144402539907924118/image.png',
            type = 'coverBackground',
        },
    },
    headerIcon = 'assets/icons/bague.png',
    headerIconName = 'Bijouterie',
    hideItemList= {'Bagues'},
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_vangelico.webp',
    callbackName = 'Menu_Vangelico_achat_callback',
    showTurnAroundButtons = true
}

OpenBijouterieShopUI = function()
    local bool = GetDatas()
    oldSkin = p:skin()
    while not bool do 
        Wait(1)
    end
    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))
    Wait(50)
    BijouterieShop.open = true
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'MenuGrosCatalogue',
        data = DataSendVangelico
    }))
    forceHideRadar()
    SetNuiFocusKeepInput(true)
    CreateThread(function()
        while BijouterieShop.open do 
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
            if IsDisabledControlPressed(0, 38) then 
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+0.8)
            elseif IsDisabledControlPressed(0, 44) then 
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-0.8)
            end
        end
    end)
end

local bijouterie_pos = {
    vector3(-624.09, -232.08, 38.05),
}

local function closePreviewMenu()
    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))
end

RegisterNUICallback("Pre_vangelico_callback", function(data)
    
    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))
    Wait(100)
    if data.button and data.button == "Catalogue homme" then 
        OpenBijouterieHommeShopUI()
    elseif data.button == "Catalogue femme" then 
        OpenBijouterieFemmeShopUI()
    end
end)

PreVangelico = {
    catalogue = {},
    buttons = {
        {
            name = 'Catalogue homme',
            width = 'full',
            image = 'assets/svg/barber/barbe.svg',
            hoverStyle = 'fill-black stroke-black',
        },
        {
            name = 'Catalogue femme',
            width = 'full',
            image = 'assets/svg/barber/cheveux.svg',
            hoverStyle = 'fill-black stroke-black',
        },
    },
    headerIcon = 'assets/icons/bague.png',
    headerIconName = 'Bijouterie',
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_vangelico.webp',
    callbackName = 'Pre_vangelico_callback'
}

local function AskVangelicoWhatChoose()
    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))
    Wait(50)
    BijouterieShopPreopen = true
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'MenuGrosCatalogue',
        data = PreVangelico
    }))
    forceHideRadar()
    SetNuiFocusKeepInput(true)
    CreateThread(function()
        while BijouterieShopPreopen do 
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
            if IsDisabledControlPressed(0, 38) then 
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+0.8)
            elseif IsDisabledControlPressed(0, 44) then 
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-0.8)
            end
        end
    end)
end

BijouterieId = 0

CreateThread(function()
    while zone == nil do
        Wait(1)
    end
    while p == nil do
        Wait(1)
    end

    for k, v in pairs(bijouterie_pos) do
        zone.addZone("bijouterie_shop" .. k,
            vector3(v.x, v.y, v.z - 0.9),
            "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le magasin de bijouterie",
            function()
                BijouterieId = "bijouterie_shop" .. k
                zone.hideNotif(BijouterieId)
                if p:getJob() == "vangelico" then
                    if not BijouterieShopPreopen then
                        AskVangelicoWhatChoose()
                    end
                else
                    if not BijouterieShop.open then
                        OpenBijouterieShopUI()
                    end
                end
            end, true,
            27,
            0.5,
            { 255, 255, 255 },
            170
        )
    end
end)

function firstToUpper(str) return (str:gsub("^%l", string.upper)) end

RegisterNetEvent("core:tempgiveiditem", function(player, dataid, name, variation)
    print("player, dataid, name, variation", player, dataid, name, variation)
    if name == "bouclesoreilles" then
        TriggerSecurGiveEvent("core:addItemToInventory", token, name, 1, {
			renamed = "Boucles d\'oreilles #" .. tonumber(dataid),
            drawableId = tonumber(dataid),
            variationId = tonumber(variation) or 0
        })
    else
        TriggerSecurGiveEvent("core:addItemToInventory", token, name, 1, {
            renamed = firstToUpper(name) .. " #" .. tonumber(dataid),
            drawableId = tonumber(dataid),
            variationId = tonumber(variation) or 0
        })
    end
end)

local function GetDatasType(playerTypef)
    local Skin = p:skin()    
    ApplySkinFake(Skin)
    DataSendVangelico.catalogue = {}
    -- Montres
    local montresbanlistfemme = {0, 1, 11, 12, 13, 14, 15, 16, 17, 18, 29, 30, 31,32,33,34,35}

    for i = 0, GetNumberOfPedPropDrawableVariations(PlayerPedId(), 6) - 1 do 
        if playerTypef == "Homme" and (i ~= 40 and i ~= 2 and i ~= 22 and i ~= 23 and i ~= 24 and i ~= 25 and i ~= 26 and i ~= 27 and i ~= 28 and i ~= 29) and i < 53 then
                for z = 1, GetNumberOfPedPropTextureVariations(PlayerPedId(), 6, i) do
                    if (i == 0 and z > 1) then elseif (i == 1 and z > 1) then else
                        table.insert(DataSendVangelico.catalogue, {id = i, price = 0, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerTypef.."/Montres/"..i.."_"..z..".webp", category="Montres", label = "Montre #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
                    end
                end
        elseif playerTypef == "Femme" then 
            for z = 1, GetNumberOfPedPropTextureVariations(PlayerPedId(), 6, i) do
                if not tableContains(montresbanlistfemme, i) then
                    table.insert(DataSendVangelico.catalogue, {id = i, price = 0, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerTypef.."/Montres/"..i.."_"..z..".webp", category="Montres", label = "Montre #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
                end
            end
        end
    end
    
    -- Colliers
    local listbanfemmecollier = {209, 196, 195, 194}
    for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 7)-1 do
        if playerTypef == "Homme" and i > 224 and i < 267 and i ~= 228 and i ~= 246 and i ~= 249 and i ~= 229 and i ~= 233 and i ~= 234 and i ~= 235 and i ~= 236 then
            for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 7, i) do
                local add = i+1
                table.insert(DataSendVangelico.catalogue, {id = i, price = 0, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerTypef.."/Colliers/"..add.."_"..z..".webp", category="Colliers", label="Colier #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
            end
        elseif playerTypef == "Femme" and i > 172 and i < 217 then
            if not tableContains(listbanfemmecollier, i) then
                for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 7, i) do
                    if i == 114 and z > 2 then else
                        table.insert(DataSendVangelico.catalogue, {id = i, price = 0, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerTypef.."/Colliers/"..i.."_"..z..".webp", category="Colliers", label="Colier #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
                    end
                end
            end
        end
    end

    -- Bracelets
    for i = 0, GetNumberOfPedPropDrawableVariations(PlayerPedId(), 7)-1 do
        for z = 1, GetNumberOfPedPropTextureVariations(PlayerPedId(), 7, i) do
            if playerTypef == "Femme" then 
                if i ~= 15 then 
                    table.insert(DataSendVangelico.catalogue, {id = i, price = 0, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerTypef.."/Bracelet/"..i.."_"..z..".webp", category="Bracelets", label="Bracelet #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
                end
            else
                table.insert(DataSendVangelico.catalogue, {id = i, price = 0, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerTypef.."/Bracelet/"..i.."_"..z..".webp", category="Bracelets", label="Bracelet #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
            end
        end
    end

    -- Boucle d'oreille
    for i = 0, GetNumberOfPedPropDrawableVariations(PlayerPedId(), 2)-1 do
        for z = 1, GetNumberOfPedPropTextureVariations(PlayerPedId(), 2, i) do
            if playerTypef == "Femme" and i > 2 then
                table.insert(DataSendVangelico.catalogue, {id = i, price = 0, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerTypef.."/BoucleOreilles/"..i.."_"..z..".webp", category="Boucles d\'oreilles", label="Boucles d\'oreilles #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
            elseif playerTypef == "Homme" then
                table.insert(DataSendVangelico.catalogue, {id = i, price = 0, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerTypef.."/BoucleOreilles/"..i.."_"..z..".webp", category="Boucles d\'oreilles", label="Boucles d\'oreilles #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
            end
        end
    end

    -- bagues
    local bannedidbaguefemme = {115, 116, 122, 117, 118, 124}
    local bannedidbaguehomme = {141}
    for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 9) - 1 do
        if playerTypef == "Homme" and i > 136 and i < 145 then
            for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 7, i) do
                local add = i+1
                if not tableContains(bannedidbaguehomme, i) then
                    if i == 137 and z > 2 then else
                        if i == 138 and z > 2 then else
                            if i == 139 and z > 1 then else
                                if i == 140 and z > 2 then else
                                    if i == 144 and z > 1 then else
                                        if i == 143 and z > 1 then else
                                            table.insert(DataSendVangelico.catalogue, {id = i, price = 0, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerTypef.."/Bagues/"..add.."_"..z..".webp", category="Bagues", label="Bague #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        elseif playerTypef == "Femme" and i > 113 and i < 127 then
            if not tableContains(bannedidbaguefemme, i) then
                for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 7, i) do
                    if i == 119 and z > 2 then else
                        table.insert(DataSendVangelico.catalogue, {id = i, price = 0, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Vangelico/"..playerTypef.."/Bagues/"..i.."_"..z..".webp", category="Bagues", label="Bague #" .. i, ownCallbackName= 'Menu_Vangelico_preview_callback', VariationID = z-1})
                    end
                end
            end
        end
    end
    
    DataSendVangelico.headerIconName = playerTypef
    DataSendVangelico.disableSubmit = false

    return true
end

OpenBijouterieHommeShopUI = function()
    if p:getJob() == "vangelico" then
        local bool = GetDatasType("Homme")
        oldSkin = p:skin()
      --  print("YESSS 3")
        while not bool do 
            Wait(1)
        end
      --  print("YESSS 4")
        BijouterieShop.open = true
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuGrosCatalogue',
            data = DataSendVangelico
        }))
        forceHideRadar()
        SetNuiFocusKeepInput(true)
        CreateThread(function()
            local disablekeys = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 23, 24, 25, 26, 32, 33, 34, 35, 37, 44, 45, 61, 268,270, 269,266,281,280,278,279,71,72,73,74,77,87,232,62, 63,69, 70, 140, 141, 142, 257, 263, 264}
            while BijouterieShop.open do 
                Wait(1)
                for k,v in pairs(disablekeys) do 
                    DisableControlAction(0, v, true)
                end
                for i = 0, 255 do
                    DisableControlAction(0, i, false)
                end
                if IsDisabledControlPressed(0, 38) then 
                    SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+0.8)
                elseif IsDisabledControlPressed(0, 44) then 
                    SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-0.8)
                end
            end
        end)
    end
end

OpenBijouterieFemmeShopUI = function()
    if p:getJob()  == "vangelico" then
        local bool = GetDatasType("Femme")
        oldSkin = p:skin()
        while not bool do 
            Wait(1)
        end
        SendNuiMessage(json.encode({
            type = 'closeWebview',
        }))
        Wait(50)
        BijouterieShop.open = true
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuGrosCatalogue',
            data = DataSendVangelico
        }))
        forceHideRadar()
        SetNuiFocusKeepInput(true)
        CreateThread(function()
            local disablekeys = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 23, 24, 25, 26, 32, 33, 34, 35, 37, 44, 45, 61, 268,270, 269,266,281,280,278,279,71,72,73,74,77,87,232,62, 63,69, 70, 140, 141, 142, 257, 263, 264}
            while BijouterieShop.open do 
                Wait(1)
                for k,v in pairs(disablekeys) do 
                    DisableControlAction(0, v, true)
                end
                for i = 0, 255 do
                    DisableControlAction(0, i, false)
                end
                if IsDisabledControlPressed(0, 38) then 
                    SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+0.8)
                elseif IsDisabledControlPressed(0, 44) then 
                    SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-0.8)
                end
            end
        end)
    end
end

RegisterCommand("bijouteriefemme", OpenBijouterieFemmeShopUI)