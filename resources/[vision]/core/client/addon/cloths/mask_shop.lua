
local  token , onMenu, oldSkin =   nil , false
local firstStart, playerType = false, nil
local pedCoords = vector3(-1219.17, -1430.71, 3.37)

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

CreateThread(function()
    while zone == nil do Wait(1)end
    local ped = entity:CreatePedLocal("a_m_y_juggalo_01", pedCoords.xyz, 214.29)
    ped:setFreeze(true)
    SetEntityInvincible(ped.id, true)
    SetEntityAsMissionEntity(ped.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped.id, true)
    zone.addZone("Vespucci_mask", -- Nom
        vector3(-1218.427, -1431.60, 3.45),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le magasin de masque",
        function()
            oldSkin = p:skin()
            onMenu = true
            OpenMenuMask()
        end,false,27,0.3,{255,255,255},170)
end)

local listMasques = {}
RegisterNetEvent("core:RefreshMask") --- A CALL LORS D'UN SWITCH DE PERSO
AddEventHandler("core:RefreshMask", function()
    firstStart = false
end)

local BanMasque = {}
local function GetDatas()
    if not isPlayerPed() then
        local Skin = p:skin()
        ApplySkinFake(Skin)
    end
    if firstStart == false then
        firstStart = true
        DataSendMasquerade.catalogue = {}
        if p:skin().sex == 0 then
            DataSendMasquerade.headerIcon = 'assets/icons/market-cart.png'
            DataSendMasquerade.headerIconName = 'HOMME'
            playerType = "Homme"
        elseif p:skin().sex == 1 then
            DataSendMasquerade.headerIcon = 'assets/icons/market-cart.png'
            DataSendMasquerade.headerIconName = 'FEMME'
            playerType = "Femme" 
        end
        if playerType == "Homme" then --ban homme
            BanMasque = {1, 3, 5, 7, 8, 9, 10, 13, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 31, 34, 36, 38, 43, 44, 45, 46, 59, 60, 65, 66, 68, 70, 
            71, 72, 73, 76, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 91, 92, 93, 94, 96, 97, 98, 102, 120, 121, 123, 127, 129, 130, 131, 132, 134, 135, 
            136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 162, 163, 165, 166, 171, 172, 
            173, 175, 176, 177, 179, 180, 181, 182, 184, 189, 190, 191, 193, 194, 195, 196, 197, 198, 200, 201, 203, 206, 210, 211, 213, 214, 215, 
            223, 255, 258, 259, 260, 261, 263}
            
        else --ban femme
            BanMasque = {1, 3, 5, 7, 8, 9, 10, 13, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 31, 34, 36, 38, 43, 44, 45, 46, 59, 60, 65, 66, 68, 70, 
            71, 72, 73, 76, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 91, 92, 93, 94, 96, 97, 98, 102, 120, 121, 123, 127, 129, 130, 131, 132, 134, 135, 
            136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 162, 163, 165, 166, 171, 172, 
            173, 175, 176, 177, 179, 180, 181, 182, 184, 189, 190, 191, 193, 194, 195, 196, 197, 198, 199, 200, 201, 203, 204, 205, 206, 207, 208, 210, 211, 
            214, 215, 216, 235, 236, 237, 238, 241}
        end

        -- Masque
        for i = 1, GetNumberOfPedDrawableVariations(PlayerPedId(), 1) do
            if not tableContains(BanMasque, i) then
                table.insert(DataSendMasquerade.catalogue, {id = i, label="Masque N°"..i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Masque/"..playerType.."/"..i.."_1.webp", category="Masque", subCategory="Masque", idVariation = i})
                for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 1, i) do
                    table.insert(DataSendMasquerade.catalogue, {id = z, label="Variations N°"..z, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Masque/"..playerType.."/"..i.."_"..z..".webp", category="Masque", subCategory="Variations", targetId = i})
                end
            end
        end
    end
    return true
end

DataSendMasquerade = {
    catalogue = {},
    headerIconName = nil,
    headerIcon = nil,
    headerImage = 'assets/headers/header_masqerade.jpg',
    showTurnAroundButtons = true,
    progressBar = {
        {
            name= 'Masque'
        },
        {
            name= 'Variations'
        }
    },
    category = 'Masque',
}

function OpenMenuMask()
    local bool = GetDatas()
    while not bool do 
        Wait(1)
    end
    SetNuiFocusKeepInput(true)
    oldSkin = p:skin()
    forceHideRadar()
    SetEntityCoords(PlayerPedId(), -1215.88, -1429.70, 3.37, 0.0,0.0,0.0, false)
    SetEntityHeading(PlayerPedId(), 146.74)
    FreezeEntityPosition(PlayerPedId(), true)
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'MenuMasques',
        data = DataSendMasquerade
    }));
    PlayerCoords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamActive(cam, 1)
    SetCamCoord(cam, -1216.40, -1431.10, 4.80)
    SetCamFov(cam, 25.0)
    PointCamAtCoord(cam, -1215.94, -1429.65, PlayerCoords.z + 0.60)
    RenderScriptCams(true, 0, 3000, 1, 0)
    CreateThread(function()
        while onMenu do
            Wait(1)
            Heading = GetEntityHeading(PlayerPedId())
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
            DisableControlAction(0, 211, true)
            if IsDisabledControlPressed(0, 38) then
                SetEntityHeading(PlayerPedId(), Heading + 3.0)
            end
            if IsDisabledControlPressed(0, 44) then
                SetEntityHeading(PlayerPedId(), Heading - 3.0)
            end
            if IsDisabledControlPressed(0, 211) then
                print("test")
                SetEntityCoords(PlayerPedId(), -1218.427, -1431.60, 3.45, 0.0,0.0,0.0, false)
                SetEntityHeading(PlayerPedId(), 35.76)
                RegisterNUICallback("focusOut", function (data, cb)
                    TriggerScreenblurFadeOut(0.5)
                    DisplayHud(true)
                    openRadarProperly()
                    RenderScriptCams(false, false, 0, 1, 0)
                    DestroyCam(cam, false)
                    FreezeEntityPosition(PlayerPedId(), false)
                    p:setSkin(oldSkin)
                    onMenu = false
                end)
                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }))
            end
        end
    end)
end

local maskChoise = nil
RegisterNUICallback("MenuMasquesClickHabit", function(data,cb)
    if data.subCategory == "Masque" then
        ApplySkinFake(oldSkin, "mask")
        SkinChangeFake("mask_1",data.id)
        SkinChangeFake("mask_2",0)
        maskChoise = data.id
    else
        ApplySkinFake(oldSkin, "mask")
        SkinChangeFake("mask_1",maskChoise)
        SkinChangeFake("mask_2",data.id-1)
    end
end)

RegisterNUICallback("MenuMasques", function(data, cb)
    print(json.encode(data))
    if p:pay(tonumber(50)) then
        TriggerSecurGiveEvent("core:addItemToInventory", token, "mask", 1, {
            renamed = "Masque N°" .. data.selections[1].id,
            drawableId = data.selections[1].id,
            variationId = data.selections[2].id-1,
            name = "mask"
        })
        SendNuiMessage(json.encode({
            type = 'closeWebview',
        }))
        SetEntityCoords(PlayerPedId(), -1218.427, -1431.60, 3.45, 0.0,0.0,0.0, false)
        SetEntityHeading(PlayerPedId(), 35.76)
        exports['vNotif']:createNotification({
            type = 'JAUNE',
            content = "Vous venez d'acheter un masque pour ~s 50$"
        })
        onMenu = false
    else
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            content = "~c Vous n'avez ~s pas assez d'argent"
        })

    end
end)

RegisterNUICallback("focusOut", function (data, cb)
    if onMenu then
        SetEntityCoords(PlayerPedId(), -1218.427, -1431.60, 3.45, 0.0,0.0,0.0, false)
        SetEntityHeading(PlayerPedId(), 35.76)
        p:setSkin(oldSkin)
        onMenu = false
    end
    TriggerScreenblurFadeOut(0.5)
    DisplayHud(true)
    openRadarProperly()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    FreezeEntityPosition(PlayerPedId(), false)
end)