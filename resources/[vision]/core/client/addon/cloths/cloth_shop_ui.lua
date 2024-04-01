local ClothShop = {
    open = false,
    cam = nil,
    oldSkin = nil
}
local lastdata = nil

local token, nbStart, playerType = nil, 0, nil

RegisterNetEvent("core:RefreshBinco") --- A CALL LORS D'UN SWITCH DE PERSO
AddEventHandler("core:RefreshBinco", function()
    nbStart = 0
end)

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local function CreateCameraBinco(typevet)
    if ClothShop.cam == nil then
        ClothShop.cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    end
    SetCamActive(ClothShop.cam, 1)
    local coord = GetEntityCoords(PlayerPedId())
    local formattedcamval = {coord.x, coord.y, coord.z}
    if typevet == "Hauts" then 
        if not IsEntityPlayingAnim(PlayerPedId(), "clothingshirt", "try_shirt_neutral_b", 3) then
            PlayEmote("clothingshirt", "try_shirt_neutral_b", 49, -1)
        end
        formattedcamval = {coord.x+2.0, coord.y, coord.z+1.15, 30, 0.2}
    elseif typevet == "Chaussures" then 
        if not IsEntityPlayingAnim(PlayerPedId(), "clothingshoes", "try_shoes_neutral_d", 3) then
            PlayEmote("clothingshoes", "try_shoes_neutral_d", 49, -1)
        end
        formattedcamval = {coord.x+2.0, coord.y, coord.z-0.9, 30, -0.65}
    elseif typevet == "Bas" then 
        if not IsEntityPlayingAnim(PlayerPedId(), "clothingtrousers", "try_trousers_neutral_d", 3) then
            PlayEmote("clothingtrousers", "try_trousers_neutral_d", 49, -1)
        end
        formattedcamval = {coord.x+2.0, coord.y, coord.z-0.6, 50, -0.2}
    elseif typevet == "Accessoires" then 
        if not IsEntityPlayingAnim(PlayerPedId(), "clothingshirt", "try_shirt_neutral_b", 3) then
            PlayEmote("clothingshirt", "try_shirt_neutral_b", 49, -1)
        end
        formattedcamval = {coord.x+2.0, coord.y, coord.z+1.15, 30, 0.5}
    elseif typevet == "Autres" then 
        if not IsEntityPlayingAnim(PlayerPedId(), "clothingshirt", "try_shirt_neutral_b", 3) then
            PlayEmote("clothingshirt", "try_shirt_neutral_b", 49, -1)
        end
        formattedcamval = {coord.x+2.0, coord.y, coord.z+1.15, 30, 0.2}
    end
    SetCamCoord(ClothShop.cam, formattedcamval[1], formattedcamval[2], formattedcamval[3])
    PointCamAtCoord(ClothShop.cam, coord.x, coord.y, coord.z + formattedcamval[5])
    SetCamFov(ClothShop.cam, formattedcamval[4] + 0.1)
    Wait(20)
    local p1 = GetCamCoord(ClothShop.cam)
    local p2 = GetEntityCoords(PlayerPedId())
    local dx = p1.x - p2.x
    local dy = p1.y - p2.y
    local heading = GetHeadingFromVector_2d(dx, dy)
    if typevet == "Autres" then 
        heading = GetHeadingFromVector_2d(p2.x - p1.x, p2.y - p1.y)
    else
        heading = GetHeadingFromVector_2d(dx, dy)
    end
    SetEntityHeading(PlayerPedId(), heading)
    RenderScriptCams(true, 0, 3000, 1, 0)
end

RegisterNUICallback("MenuBincoClickButton", function(data) 
    if data.button == "Hauts" then
        CreateCameraBinco("Hauts")
    elseif data.button == "Bas" then
        CreateCameraBinco("Bas")
    elseif data.button == "Accessoires" then
        CreateCameraBinco("Accessoires")
    elseif data.button == "Chaussures" then
        CreateCameraBinco("Chaussures")
    elseif data.button == "Cou" then
    --    SendNuiMessage(json.encode({
    --        type = 'closeWebview',
    --    }))
        --local playerSkin = p:skin()
        --ApplySkin(playerSkin)
        --if IsEntityPlayingAnim(PlayerPedId(), "clothingshirt", "try_shirt_neutral_b", 3) or 
        --IsEntityPlayingAnim(PlayerPedId(), "clothingshoes", "try_shoes_neutral_d", 3) or 
        --IsEntityPlayingAnim(PlayerPedId(), "clothingtrousers", "try_trousers_neutral_d", 3) then
        --    ClearPedTasks(PlayerPedId())
        --end
        --SetNuiFocusKeepInput(false)
        --TriggerScreenblurFadeOut(0.5)
        --DisplayHud(true)
        --SetNuiFocus(false, false)
        --openRadarProperly()
        --RenderScriptCams(false, false, 0, 1, 0)
        --FreezeEntityPosition(PlayerPedId(), false)
        --ClothShop.open = false
        --ClothShop.cam = nil
        --DestroyCam(ClothShop.cam,false)
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            content = "Bientôt disponible"
        })
        --closeUI()
        CreateCameraBinco("Accessoires")
    elseif data.button == "Chapeaux" then
        CreateCameraBinco("Accessoires")
    elseif data.button == "Lunettes" then
        CreateCameraBinco("Accessoires")
    elseif data.button == "Sacs" then
        CreateCameraBinco("Autres")
    end
end)

RegisterNUICallback("MenuBincoClickHabit", function(data)
    --print(json.encode(data, {indent = true}))
    if data.category == "Hauts" then 
        if data.subCategory == "Hauts" then
            SkinChangeFake("torso_1",data.id)
            SkinChangeFake("torso_2", 0)
        elseif data.subCategory == "Variations" then
            SkinChangeFake("torso_2",data.id-1)
        elseif data.subCategory == "Sous-haut" then
            SkinChangeFake("tshirt_1",data.id)
            SkinChangeFake("tshirt_2", 0)
        elseif data.subCategory == "Variations 2" then
            SkinChangeFake("tshirt_2",data.id-1)
        elseif data.subCategory == "Bras" then
            SkinChangeFake("arms",data.id)
            SkinChangeFake("arms_2", 0)
        elseif data.subCategory == "Variations 3" then
            SkinChangeFake("arms_2",data.id-1)
        elseif data.subCategory == "pHauts" then
            lastdata = data.id
            SetPedComponentVariation(PlayerPedId(), 3, data.id, 0)
        elseif data.subCategory == "pVariations" then
            SetPedComponentVariation(PlayerPedId(), 3, lastdata, data.id-1)  
        end
    elseif data.category == "Bas" then
        if data.subCategory == "Bas" then
            SkinChangeFake("pants_1",data.id)
            SkinChangeFake("pants_2",0)
        elseif data.subCategory == "Variations" then
            SkinChangeFake("pants_2",data.id-1)
        elseif data.subCategory == "pBas" then
            lastdata = data.id
            SetPedComponentVariation(PlayerPedId(), 4, data.id, 0)
        elseif data.subCategory == "pVariations" then
            SetPedComponentVariation(PlayerPedId(), 4, lastdata, data.id-1)  
        end
    elseif data.category == "Chaussures" then
        if data.subCategory == "Chaussures" then
            SkinChangeFake("shoes_1",data.id)
            SkinChangeFake("shoes_2",0)
        elseif data.subCategory == "Variations" then
            SkinChangeFake("shoes_2",data.id-1)
        end
    elseif data.category == "Cou" then 
        if data.subCategory == "Cou" then
            SkinChangeFake("tshirt_1",data.id)
            SkinChangeFake("tshirt_2", 0)
        elseif data.subCategory == "Variations" then
            SkinChangeFake("tshirt_2",data.id-1)
        end
    elseif data.category == "Chapeaux" then
        if data.subCategory == "Chapeaux" then
            SkinChangeFake("helmet_1",data.id)
            SkinChangeFake("helmet_2",0)
        elseif data.subCategory == "Variations" then
            SkinChangeFake("helmet_2",data.id-1)
        elseif data.subCategory == "pChapeaux" then
            lastdata = data.id
            SetPedPropIndex(PlayerPedId(), 0, data.id, 0, true)
        elseif data.subCategory == "pVariations" then
            SetPedPropIndex(PlayerPedId(), 0, lastdata, data.id-1, true) 
        end
    elseif data.category == "Lunettes" then
        if data.subCategory == "Lunettes" then
            SkinChangeFake("glasses_1",data.id)
            SkinChangeFake("glasses_2",0)
        elseif data.subCategory == "Variations" then
            SkinChangeFake("glasses_2",data.id-1)
        elseif data.subCategory == "pLunettes" then
            lastdata = data.id
            SetPedPropIndex(PlayerPedId(), 1, data.id, 0, true)
        elseif data.subCategory == "pVariations" then
            SetPedPropIndex(PlayerPedId(), 1, lastdata, data.id-1, true)  
        end
    elseif data.category == "Sacs" then
        if data.subCategory == "Sacs" then
            SkinChangeFake("bags_1",data.id)
            SkinChangeFake("bags_2",0)
        elseif data.subCategory == "Variations" then
            SkinChangeFake("bags_2",data.id-1)
        end
    elseif data.category == "Accessoires" then 
        if data.subCategory == "pAccessoires" then
            lastdata = data.id
            SetPedComponentVariation(PlayerPedId(), 8, data.id, 0)  
        elseif data.subCategory == "pVariations" then
            SetPedComponentVariation(PlayerPedId(), 8, lastdata, data.id-1)  
        end
    end    
end)


RegisterNUICallback("MenuBincoNomTenu", function(tenueName)
    local skin = SkinChangerGetSkin()
    local tenue = {
        ['tshirt_1'] = skin["tshirt_1"],
        ['tshirt_2'] = skin["tshirt_2"],
        ['torso_1'] = skin["torso_1"],
        ['torso_2'] = skin["torso_2"],
        ['decals_1'] = skin["decals_1"],
        ['decals_2'] = skin["decals_2"],
        ['arms'] = skin["arms"],
        ['arms_2'] = skin["arms_2"],
        ['pants_1'] = skin["pants_1"],
        ['pants_2'] = skin["pants_2"],
        ['shoes_1'] = skin["shoes_1"],
        ['shoes_2'] = skin["shoes_2"],
        ['bags_1'] = skin['bags_1'],
        ['bags_2'] = skin['bags_2'],
        ['chain_1'] = skin['chain_1'],
        ['chain_2'] = skin['chain_2'],
        ['helmet_1'] = skin['helmet_1'],
        ['helmet_2'] = skin['helmet_2'],
        ['ears_1'] = skin['ears_1'],
        ['ears_2'] = skin['ears_2'],
        ['mask_1'] = skin['mask_1'],
        ['mask_2'] = skin['mask_2'],
        ['glasses_1'] = skin['glasses_1'],
        ['glasses_2'] = skin['glasses_2'],
        ['bproof_1'] = skin['bproof_1'],
        ['bproof_2'] = skin['bproof_2'],
    }
    TriggerSecurGiveEvent("core:addItemToInventory", token, "outfit", 1, {renamed = tenueName, data = tenue})
    -- ShowNotification("Vous venez de récupérer une tenue")

    -- New notif
    exports['vNotif']:createNotification({
        type = 'JAUNE',
        -- duration = 5, -- In seconds, default:  4
        content = "~c Vous venez de récupérer ~s une tenue"
    })

end)

local BanHat, BanGlases , BanTop, BanLeg, BanShoes, BanBag, BanSous, BanSous = {}, {}, {}, {}, {}, {}, {}, {}
local function GetDatas()
    if not isPlayerPed() then
        local Skin = p:skin()
        ApplySkinFake(Skin)
    end
    if nbStart == 0 then
        nbStart = 1
        DataSendBinco.catalogue = {}
        if isPlayerPed() then --C'est un ped
            DataSendBinco.headerIcon = 'assets/inventory/glasses.svg'
            DataSendBinco.headerIconName = 'PED'
            playerType = "Ped"    
        elseif p:skin().sex == 0 then
            DataSendBinco.headerIcon = 'assets/icons/image_homme.png'
            DataSendBinco.headerIconName = 'Binco Homme'
            playerType = "Homme"
        elseif p:skin().sex == 1 then
            DataSendBinco.headerIcon = 'assets/icons/image_homme.png'
            DataSendBinco.headerIconName = 'Binco Femme'
            playerType = "Femme" 
        end
        if playerType == "Homme" then --ban homme
            BanHat = {0,3, 4, 5, 8, 9, 10, 11, 19, 38, 39, 46, 47, 57, 59, 73, 74, 78, 79, 80, 81, 91, 92, 107, 109, 110, 111, 115, 116, 117, 118, 119, 121, 
            122, 123, 124, 125, 126, 129, 130, 131, 132, 133, 134, 137, 138, 144, 147, 148, 149, 150, 176, 177, 185, 186, 191, 196, 199, 201, 
            207, 219, 220, 222, 224}
            BanGlases = {1, 6, 11, 14, 26, 27, 47, 52, 55}
            BanTop = {1, 2, 4, 5, 6, 8, 10, 11, 13, 48, 54, 55, 65, 66, 91, 116, 165, 177, 178, 186, 201,  213, 214, 215, 216, 
            228, 231, 246, 252, 274, 275, 276, 277, 278, 279, 280, 281, 283, 285, 286, 287, 289, 291, 314, 315, 316, 317, 318, 
            319, 320, 333, 372, 397, 424, 437, 447, 448, 450, 451, 452, 453, 455, 458, 459, 461, 463, 464, 465, 
            466, 467, 468, 469, 470, 471, 472, 473, 475, 476, 477, 478, 480, 481, 482, 483, 484, 486, 487, 488, 489, 490, 491, 
            493, 494, 495, 496, 497, 502, 503, 504, 505, 507, 508, 512, 513, 514, 515, 516, 520, 521, 522, 523, 
            524, 525, 526, 527, 530, 531, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 
            550, 552, 553, 554, 555, 556, 557, 558, 559, 560, 622}
            BanLeg = {2, 14, 30, 41, 44, 57, 67, 77, 84, 85, 92, 93, 95, 106, 107, 108, 109, 110, 112, 113, 114, 115, 120, 
            121, 125, 127, 136, 145, 157, 162, 168, 171, 173, 177, 178, 180, 184, 185, 192, 193, 196, 203, 204, 205}
            BanShoes = {2, 4, 5, 6, 10, 11, 17, 33, 47, 55, 58, 68, 78, 83, 84, 85, 86, 87, 90, 91, 100, 134}
            BanBag = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 
            39, 42, 43, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 
            83, 84, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 116, 117, 118, 119, 120, 121, 
            122, 123, 124, 125, 126, 127, 128, 130, 131, 132, 133, 135, 136, 137, 138, 139, 141, 142, 143, 144, 145, 149, 151, 152, 154, 155, 156, 158, 159, 160, 
            162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189}
            BanSous = {2, 3, 4, 5, 8, 13, 45, 57, 58, 59, 78, 97, 98, 99, 100, 101, 102, 108, 117, 118, 119, 120, 121, 122, 123, 125, 126, 127, 129, 131, 137, 
            143, 145, 151, 153, 154, 155, 156, 159, 160, 161, 162, 164, 170, 172, 183, 189, 190, 194, 202, 203, 204, 205, 206, 207, 210, 211, 
            212, 214, 215, 216, 217, 218, 219, 220, 221, 223, 224, 225, 226, 228, 229, 230, 231, 233, 234, 235, 236, 237, 238, 239, 240, 241, 244, 245, 246, 247, 
            248, 249, 250, 251, 252, 253, 256, 260, 261, 263, 264, 265, 266, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 
            287, 288, 295, 297, 298}
            BanArm = {}

            priceTop = {[566] = 75, [567] = 115, [568] = 55, [569] = 55, [570] = 70, [571] = 650, [572] = 150, [573] = 650, [575] = 50, [576] = 55, [577] = 20,
            [578] = 55, [579] = 20, [580] = 45, [581] = 30, [583] = 40, [585] = 75, [586] = 45, [587] = 85, [588] = 40, [589] = 25, [590] = 30, [591] = 85,
            [592] = 180, [593] = 30, [594] = 25, [595] = 60, [596] = 45, [597] = 75, [598] = 45, [599] = 50, [600] = 130, [601] = 55, [602] = 125, [603] = 30,
            [605] = 15, [606] = 40, [607] = 75, [608] = 80, [609] = 85, [610] = 85, [611] = 60, [612] = 60, [613] = 30, [614] = 160, [615] = 75, [616] = 45,
            [617] = 1060, [618] = 70, [619] = 85, [621] = 25, [623] = 180, [624] = 30, [625] = 45, [626] = 60, [627] = 85, [628] = 75, [629] = 60, [630] = 230,
            [631] = 5, [632] = 30, [634] = 25, [635] = 1350, [636] = 25, [637] = 30, [638] = 45, [639] = 45, [640] = 50, [641] = 690, [642] = 550, [643] = 280,
            [644] = 295, [645] = 1500, [646] = 55, [647] = 150, [648] = 50, [649] = 455, [650] = 190, [651] = 250, [652] = 160, [653] = 95, [654] = 300, [655] = 200,
            [656] = 75, [657] = 815, [658] = 2700, [659] = 15, [660] = 25, [661] = 95, [662] = 15, [663] = 15, [665] = 75, [666] = 450, [667] = 150, [668] = 2500,
            [669] = 75, [670] = 150, [671] = 80, [672] = 75, [673] = 140, [674] = 480, [675] = 550, [676] = 655, [677] = 450, [678] = 570, [679] = 240, [680] = 75,
            [681] = 110, [682] = 625, [683] = 750, [684] = 500, [685] = 90, [686] = 90, [687] = 50, [688] = 80}

            priceLeg = {[207] = 100, [208] = 100, [209] = 100, [210] = 100, [211] = 100, [212] = 100, [213] = 100, [214] = 100, [215] = 100, [216] = 100, [217] = 350,
            [218] = 100, [219] = 150, [220] = 100, [221] = 40, [222] = 100, [223] = 100, [224] = 100, [225] = 200, [226] = 150, [227] = 100, [228] = 100, [229] = 100,
            [230] = 100, [231] = 100, [232] = 250, [233] = 400, [234] = 1200, [235] = 150, [236] = 150, [237] = 100, [238] = 100, [239] = 100, [240] = 250, [241] = 300,
            [242] = 350, [243] = 100, [244] = 100, [245] = 100, [246] = 1200, [247] = 300, [248] = 350, [249] = 100, [250] = 250, [251] = 350, [252] = 350, [253] = 200,
            [254] = 400, [255] = 250, [256] = 150, [257] = 350, [258] = 350, [259] = 150, [260] = 350, [261] = 400, [262] = 1000, [263] = 650, [264] = 1000, [265] = 500,
            [266] = 800, [267] = 1600, [268] = 300, [269] = 300, [270] = 500, [271] = 950, [272] = 100, [273] = 650, [274] = 250, [275] = 250, [276] = 1650, [277] = 650,
            [278] = 450, [279] = 450, [280] = 150, [281] = 350, [282] = 150, [283] = 150, [284] = 100, [285] = 150, [286] = 250, [287] = 350, [288] = 350}

            priceShoes = {[136] = 100, [137] = 400, [138] = 200, [139] = 150, [140] = 130, [141] = 100, [142] = 50, [143] = 170, [144] = 150, [145] = 130, [146] = 500,
            [147] = 170, [148] = 110, [149] = 120, [150] = 50, [151] = 80, [152] = 140, [153] = 80, [154] = 160, [155] = 900, [156] = 450, [157] = 140, [158] = 100,
            [159] = 160, [160] = 170, [161] = 130, [162] = 160, [163] = 140, [164] = 230, [165] = 400, [166] = 500, [167] = 1200, [168] = 160, [169] = 100, [170] = 300,
            [171] = 190, [172] = 200, [173] = 170, [174] = 130, [175] = 2000, [176] = 150, [177] = 130, [178] = 1400, [179] = 150, [180] = 500, [181] = 130, [182] = 140,
            [183] = 150, [184] = 600}

            priceHat = {[226] = 150, [227] = 90, [228] = 90, [229] = 60, [230] = 60, [231] = 70, [232] = 80, [233] = 100, [234] = 70, [235] = 80, [236] = 30, [237] = 100,
            [238] = 150, [239] = 130, [240] = 120, [241] = 200, [242] = 60, [243] = 90, [244] = 90, [245] = 80, [246] = 60, [247] = 70, [248] = 70, [249] = 90, [250] = 90,
            [251] = 120}

            priceGlass = {[1] = 0, [2] = 120, [3] = 90, [4] = 45, [5] = 150, [6] = 5, [7] = 75, [8] = 250, [9] = 115, [10] = 250, [11] = 5, [12] = 200, [13] = 125, [14] = 5,
            [15] = 145, [16] = 45, [17] = 210, [18] = 225, [19] = 150, [20] = 75, [21] = 5, [22] = 5, [23] = 75, [24] = 45, [25] = 85, [26] = 5, [27] = 5, [28] = 170, [29] = 300,
            [30] = 20, [31] = 90, [32] = 75, [33] = 150, [34] = 200, [35] = 125, [36] = 125, [37] = 100, [38] = 90, [39] = 90, [40] = 195, [41] = 195, [42] = 55, [43] = 20, [44] = 5,
            [45] = 225, [46] = 200, [47] = 5, [48] = 150, [49] = 150, [50] = 65, [51] = 85, [52] = 5, [53] = 75, [54] = 5, [55] = 85, [56] = 75, [57] = 75, [58] = 450, [59] = 850,
            [60] = 750, [61] = 55, [62] = 150, [63] = 150, [64] = 150, [65] = 650, [66] = 650, [67] = 150, [68] = 550, [69] = 350, [70] = 650, [71] = 800, [72] = 800, [73] = 150,
            [74] = 650}

            priceBag = {[40] = 200, [41] = 200, [44] = 200, [45] = 200, [81] = 200, [82] = 200, [85] = 200, [86] = 200, [111] = 30, [112] = 50, [113] = 50, [114] = 30, [115] = 30,
            [129] = 200, [134] = 150, [140] = 150, [146] = 150, [147] = 150, [148] = 150, [150] = 200, [153] = 400, [157] = 200, [161] = 120, [190] = 250, [191] = 70, [192] = 250,
            [193] = 250, [194] = 250, [196] = 200, [197] = 200, [198] = 200, [199] = 200, [200] = 200, [201] = 200, [202] = 250, [203] = 400, [204] = 350, [205] = 500, [206] = 500,
            [207] = 250, [208] = 250, [209] = 250}
        else --ban femme
            BanHat = {0, 2, 3, 8, 9, 10, 11, 12, 19, 37, 45, 46, 72, 73, 77, 78, 79, 80, 90, 91, 110,
            115, 116, 117, 118, 120, 122, 123, 124, 125, 128, 132, 133, 136, 137, 143, 146, 147, 148, 149, 175, 176, 184, 185, 188, 
            191, 196, 202, 205, 209}
            BanGlases = {12, 13, 15, 29, 51}
            BanTop = {4, 10, 11, 12, 15, 29, 41, 47, 48, 61, 108, 146, 152, 162, 179, 180, 188, 203, 218, 219, 220, 238, 241, 254, 260, 287, 
            288, 289, 290, 291, 296, 298, 299, 300, 302, 304, 325, 326, 327, 328, 329, 330, 331, 336, 348, 391, 420, 440, 468, 481, 482, 483, 
            484, 485, 486, 488, 491, 492, 493, 496, 497, 498, 499, 500, 502, 503, 504, 505, 506, 507, 510, 511, 512, 513, 514, 515, 
            516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 
            546, 548, 549, 550, 551, 552, 555, 556, 557, 558, 559, 560, 561, 564, 565, 567, 568, 569, 570, 571, 572, 572, 576, 577, 579, 585}
            BanLeg = {2, 5, 6, 7, 10, 13, 14, 15, 29, 42, 46, 59, 79, 86, 88, 95, 96, 98, 113, 114, 115, 116, 117, 119, 120, 121, 122, 126, 127, 
            131, 130, 132, 143, 152, 159, 166, 173, 174, 175, 176, 178, 179, 183, 184, 186, 189, 190, 194, 197, 198, 200, 201, 222, 236}
            BanShoes = {4, 5, 6, 9, 10, 11, 12, 17, 34, 48, 58, 61, 71, 87, 88, 89, 90, 94, 95, 104, 138}
            BanBag = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 
            40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 
            78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 
            114, 115, 116, 117, 118, 119, 120, 121, 212, 122, 123, 124, 126, 127, 128, 130, 131, 132, 133, 136, 137, 138, 140, 141, 142, 143, 144, 145, 146, 147, 148, 
            149, 150, 151, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173}
            BanSous = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 15, 34, 35, 36, 81, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 
            135, 136, 137, 138, 139, 140, 141, 148, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 174, 177, 184, 186, 187, 188, 189, 190, 191, 192, 195, 196, 197, 
            198, 200, 207, 209, 219, 220, 221, 234, 235, 238, 239, 240, 241, 242, 244, 246, 247, 248, 249, 250, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 
            263, 265, 266, 267, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 288, 289, 290, 291, 292, 294, 295, 296, 
            299, 300, 302, 303, 308, 310}
            BanArm = {}
            priceTop = {[586] = 250, [587] = 150, [588] = 100, [589] = 150, [590] = 150, [591] = 100, [592] = 100, [593] = 100, [594] = 100, [595] = 150, [596] = 200,
            [597] = 100, [598] = 350, [599] = 150, [600] = 75, [601] = 150, [602] = 150, [603] = 150, [604] = 100, [606] = 200, [607] = 350, [608] = 75, [609] = 250,
            [610] = 250, [611] = 75, [612] = 75, [613] = 100, [614] = 100, [615] = 100, [616] = 100, [617] = 100, [619] = 100, [620] = 250, [621] = 150, [622] = 100,
            [623] = 300, [624] = 100, [625] = 150, [626] = 200, [627] = 150, [628] = 150, [629] = 150, [630] = 100, [631] = 100, [632] = 300, [633] = 100, [634] = 150,
            [635] = 100, [636] = 150, [637] = 600, [638] = 75, [639] = 100, [640] = 100, [641] = 250, [642] = 100, [643] = 100, [644] = 250, [645] = 100, [646] = 100,
            [647] = 100, [648] = 150, [649] = 100, [650] = 100, [651] = 75, [652] = 150, [653] = 75, [654] = 75, [655] = 75, [656] = 75, [657] = 250, [658] = 200,
            [659] = 100, [660] = 150, [661] = 100, [662] = 100, [663] = 100, [664] = 350, [665] = 100, [666] = 200, [667] = 150, [668] = 150, [669] = 150, [670] = 250,
            [671] = 100, [672] = 100, [673] = 673, [674] = 150, [675] = 250, [676] = 100, [677] = 100, [678] = 300, [679] = 200, [680] = 150, [681] = 200, [682] = 100,
            [683] = 150, [684] = 150, [685] = 150, [686] = 150, [687] = 100, [688] = 100, [689] = 100, [690] = 100, [692] = 300, [693] = 150, [694] = 300, [695] = 150,
            [696] = 150, [698] = 250, [699] = 1250, [700] = 150, [701] = 150, [702] = 150, [703] = 150, [704] = 75, [705] = 150, [706] = 75, [707] = 75, [709] = 100,
            [712] = 150, [713] = 450}

            priceLeg = {[203] = 100, [204] = 500, [205] = 40, [206] = 500, [207] = 40, [208] = 100, [209] = 100, [210] = 100, [211] = 100, [212] = 100, [213] = 100,
            [214] = 100, [215] = 100, [216] = 100, [217] = 100, [218] = 100, [219] = 100, [220] = 100, [221] = 40, [223] = 100, [224] = 100, [225] = 100, [226] = 350,
            [227] = 100, [228] = 100, [229] = 100, [230] = 100, [231] = 100, [232] = 100, [233] = 100, [235] = 40, [237] = 40, [238] = 40, [239] = 40, [240] = 40, [241] = 40,
            [242] = 100, [243] = 100, [244] = 100, [245] = 95, [246] = 70, [247] = 50, [248] = 65, [249] = 70, [250] = 45, [251] = 40, [252] = 50, [253] = 70, [254] = 200,
            [255] = 70, [256] = 90, [257] = 75, [258] = 250, [259] = 1500, [260] = 90, [261] = 40, [262] = 90, [263] = 50, [264] = 60}

            priceShoes = {[140] = 100, [141] = 120, [142] = 200, [143] = 200, [144] = 300, [145] = 300, [146] = 200, [147] = 150, [148] = 250, [149] = 150, [150] = 500,
            [151] = 150, [152] = 500, [153] = 150, [154] = 100, [155] = 500, [156] = 40, [157] = 40, [158] = 40, [159] = 40, [160] = 40, [161] = 40, [162] = 40, [163] = 40,
            [164] = 300, [165] = 135, [166] = 100, [167] = 100, [168] = 100, [169] = 150, [170] = 100, [171] = 100}

            priceHat = {[226] = 150, [227] = 200, [228] = 100, [229] = 100, [230] = 150, [231] = 50, [232] = 20, [233] = 20, [234] = 20, [235] = 20, [236] = 20, [237] = 20,
            [238] = 20, [239] = 20, [240] = 20, [241] = 20, [242] = 20}

            priceGlass = {[1] = 20, [2] = 20, [3] = 20, [4] = 20, [5] = 20, [6] = 50, [7] = 20, [8] = 20, [9] = 20, [10] = 20, [11] = 50, [12] = 20, [13] = 20, [14] = 20,
            [15] = 50, [16] = 20, [17] = 20, [18] = 20, [19] = 20, [20] = 20, [21] = 20, [22] = 20, [23] = 20, [24] = 20, [25] = 20, [26] = 20, [27] = 20, [28] = 20, [29] = 20,
            [30] = 20, [31] = 20, [32] = 20, [33] = 20, [34] = 20, [35] = 20, [36] = 20, [37] = 20, [38] = 20, [39] = 20, [40] = 20, [41] = 20, [42] = 20, [43] = 20, [44] = 20,
            [45] = 20, [46] = 20, [47] = 20, [48] = 20, [49] = 20, [50] = 20, [51] = 20, [52] = 20, [53] = 20, [54] = 20, [55] = 20, [56] = 20, [57] = 20, [58] = 60, [59] = 200,
            [60] = 150, [61] = 50, [62] = 50, [63] = 200, [64] = 200, [65] = 50, [66] = 50, [67] = 100, [68] = 200, [69] = 150, [70] = 20, [71] = 20, [72] = 70, [73] = 150,
            [74] = 75, [75] = 175, [76] = 300, [77] = 225, [78] = 65, [79] = 65, [80] = 65}

            priceBag = {[111] = 200, [112] = 200, [113] = 200, [125] = 200, [129] = 200, [134] = 200, [135] = 200, [139] = 200, [152] = 100, [174] = 200, [175] = 200, [176] = 200,
            [177] = 200, [178] = 200, [179] = 30, [180] = 30, [181] = 30, [182] = 30, [183] = 30, [184] = 30, [185] = 200, [186] = 150, [187] = 350, [188] = 350, [189] = 250,
            [190] = 250, [191] = 200, [192] = 200}
        end

        if isPlayerPed() then
            DataSendBinco.buttons = {
                {
                    name = 'Hauts',
                    width = 'full',
                    image = 'assets/svg/binco/'..playerType..'/tshirt.svg',
                    hoverStyle = 'fill-black stroke-black',
                    price = 20,
                    progressBar = {
                        {
                            name= 'pHauts'
                        },
                        {
                            name= 'pVariations'
                        }
                    } 
                },
                {
                    name = 'Bas',
                    width = 'full',
                    image = 'assets/svg/binco/'..playerType..'/jeans.svg',
                    hoverStyle = 'fill-black stroke-black',
                    price = 20,
                    progressBar = {
                        {
                            name= 'pBas'
                        },
                        {
                            name= 'pVariations'
                        }
                    } 
                },
                {
                    name = 'Accessoires',
                    width = 'full',
                    image = 'assets/svg/binco/'..playerType..'/shoe.svg',
                    hoverStyle = 'fill-black stroke-black',
                    price = 20,
                    progressBar = {
                        {
                            name= 'pAccessoires'
                        },
                        {
                            name= 'pVariations'
                        }
                    } 
                },
                {
                    name = 'Chapeaux',
                    width = 'half',
                    image = 'assets/svg/binco/'..playerType..'/hat.svg',
                    hoverStyle = 'fill-black stroke-black',
                    price = 20,
                    progressBar = {
                        {
                            name= 'pChapeaux'
                        },
                        {
                            name= 'pVariations'
                        }
                    } 
                },
                {
                    name = 'Lunettes',
                    width = 'half',
                    image = 'assets/svg/binco/'..playerType..'/glasses.svg',
                    hoverStyle = 'fill-black stroke-black',
                    price = 20,
                    progressBar = {
                        {
                            name= 'pLunettes'
                        },
                        {
                            name= 'pVariations'
                        }
                    } 
                },
            }
        else
            DataSendBinco.buttons = {
                {
                    name = 'Hauts',
                    width = 'full',
                    hoverStyle = 'stroke-black',
                    image = 'https://cdn.discordapp.com/attachments/1063934823976144966/1143950049479512174/bd49bb3f81599c1dd8840e5935b016d3.png',
                    type = 'coverBackground',
                    --image = 'assets/svg/binco/'..playerType..'/tshirt.svg',
                    --hoverStyle = 'fill-black stroke-black',
                    price = 20,
                    progressBar = {
                        {
                            name= 'Hauts'
                        },
                        {
                            name= 'Variations'
                        },
                        {
                            name= 'Sous-haut',
                        },
                        {
                            name= 'Variations 2'
                        },
                        {
                            name= 'Bras'
                        },
                        {
                            name= 'Variations 3'
                        }
                    } 
                },
                {
                    name = 'Bas',
                    width = 'full',
                    hoverStyle = 'stroke-black',
                    image = 'https://media.discordapp.net/attachments/498529074717917195/1144393305195552768/image.png',
                    type = 'coverBackground',
                    --image = 'assets/svg/binco/'..playerType..'/jeans.svg',
                    --hoverStyle = 'fill-black stroke-black',
                    price = 20,
                    progressBar = {
                        {
                            name= 'Bas'
                        },
                        {
                            name= 'Variations'
                        }
                    } 
                },
                {
                    name = 'Chaussures',
                    width = 'full',
                    hoverStyle = 'stroke-black',
                    image = 'https://media.discordapp.net/attachments/498529074717917195/1144393364926627913/image.png',
                    type = 'coverBackground',
                    --image = 'assets/svg/binco/'..playerType..'/shoe.svg',
                    --hoverStyle = 'fill-black stroke-black',
                    price = 20,
                    progressBar = {
                        {
                            name= 'Chaussures'
                        },
                        {
                            name= 'Variations'
                        }
                    } 
                },
                {
                    name = 'Chapeaux',
                    width = 'full',
                    hoverStyle = 'stroke-black',
                    image = 'https://media.discordapp.net/attachments/498529074717917195/1144393779575541780/image.png',
                    type = 'coverBackground',
                    width = 'half',
                    --image = 'assets/svg/binco/'..playerType..'/hat.svg',
                    --hoverStyle = 'fill-black stroke-black',
                    price = 20,
                    progressBar = {
                        {
                            name= 'Chapeaux'
                        },
                        {
                            name= 'Variations'
                        }
                    } 
                },
                {
                    name = 'Lunettes',
                    width = 'half',
                    --image = 'assets/svg/binco/'..playerType..'/glasses.svg',
                    --hoverStyle = 'fill-black stroke-black',
                    hoverStyle = 'stroke-black',
                    image = 'https://media.discordapp.net/attachments/498529074717917195/1144394033012162610/image.png',
                    type = 'coverBackground',
                    price = 20,
                    progressBar = {
                        {
                            name= 'Lunettes'
                        },
                        {
                            name= 'Variations'
                        }
                    } 
                },
                {
                    name = 'Sacs',
                    width = 'half',
                    hoverStyle = 'stroke-black',
                    image = 'https://media.discordapp.net/attachments/498529074717917195/1144393559659778078/image.png',
                    type = 'coverBackground',
                   --image = 'assets/svg/binco/'..playerType..'/bag.svg',
                   --hoverStyle = 'fill-black stroke-black',
                    price = 20,
                    progressBar = {
                        {
                            name= 'Sacs'
                        },
                        {
                            name= 'Variations'
                        }
                    } 
                },
                {
                    name = 'Cou',
                    width = 'half',
                    hoverStyle = 'stroke-black',
                    image = 'https://media.discordapp.net/attachments/498529074717917195/1144393442533838939/image.png',
                    type = 'coverBackground',
                    price = 20,
                    progressBar = {
                        {
                            name= 'Cou'
                        }
                    } 
                },
            }
        end


        --[[
        Pour les sans PED
        ]]
        -- Pantalon
        for i = 1, GetNumberOfPedDrawableVariations(PlayerPedId(), 4)-1 do
            if not tableContains(BanLeg, i) then
                local price = 40
                if priceLeg[i] ~= nil then price = priceLeg[i] end
                table.insert(DataSendBinco.catalogue, {id = i, price = price, label=i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Bas/"..i.."_1.webp", category="Bas", subCategory="Bas", idVariation=i})
                for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 4, i) do
                    table.insert(DataSendBinco.catalogue, {id = z, label=z, price=666, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Bas/"..i.."_"..z..".webp", category="Bas", subCategory="Variations", targetId=i })
                end
            end
        end
        -- Chaussures
        for i = 1, GetNumberOfPedDrawableVariations(PlayerPedId(), 6)-1 do
            if not tableContains(BanShoes, i) then
                local price = 40
                if priceShoes[i] ~= nil then price = priceShoes[i] end
                table.insert(DataSendBinco.catalogue, {id = i, price = price, label=i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Chaussures/"..i.."_1.webp", category="Chaussures", subCategory="Chaussures", idVariation=i})
                for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 6, i) do
                    table.insert(DataSendBinco.catalogue, {id = z, label=z, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Chaussures/"..i.."_"..z..".webp", category="Chaussures", subCategory="Variations", targetId=i })
                end
            end
        end
        -- Hauts
        for i = 1, GetNumberOfPedDrawableVariations(PlayerPedId(), 11)-1 do
            if not tableContains(BanTop, i) then
                local price = 35
                if priceTop[i] ~= nil then price = priceTop[i] end
                table.insert(DataSendBinco.catalogue, {id = i, price = price, label=i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Hauts/"..i.."_1.webp", category="Hauts", subCategory="Hauts", idVariation=i})
                for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 11, i) do
                    table.insert(DataSendBinco.catalogue, {id = z, label=z, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Hauts/"..i.."_"..z..".webp", category="Hauts", subCategory="Variations", targetId=i })
                end
            end
        end
        -- Soushaut
        for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 8)-1 do
            if not tableContains(BanSous, i) then
                table.insert(DataSendBinco.catalogue, {id = i, price = 150, label=i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Sous_Hauts/"..i.."_1.webp", category="Hauts", subCategory="Sous-haut", idVariation=i}) 
                for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 8, i) do
                    table.insert(DataSendBinco.catalogue, {id = z, label=z, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Sous_Hauts/"..i.."_"..z..".webp", category="Hauts", subCategory="Variations 2", targetId=i })
                end
            end
        end
        -- Bras
        for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 3)-1 do
            if not tableContains(BanArm, i) then
                table.insert(DataSendBinco.catalogue, {id = i, price = 150, label=i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Bras/"..i.."_1.webp", category="Hauts", subCategory="Bras", idVariation=i})
                for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 3, i) do
                    table.insert(DataSendBinco.catalogue, {id = z, label=z, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Bras/"..i.."_"..z..".webp",  category="Hauts", subCategory="Variations 3", targetId=i })
                end
            end
        end
        -- Chapeaux
        for i = 0, GetNumberOfPedPropDrawableVariations(PlayerPedId(), 0)-1 do
            if not tableContains(BanHat, i) then
                local price = 20
                if priceHat[i] ~= nil then price = priceHat[i] end
                table.insert(DataSendBinco.catalogue, {id = i, price = price, label=i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Chapeaux/"..i.."_1.webp", category="Chapeaux", subCategory="Chapeaux", idVariation=i})
                for z = 1, GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, i) do
                    table.insert(DataSendBinco.catalogue, {id = z, label=z, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Chapeaux/"..i.."_"..z..".webp", category="Chapeaux", subCategory="Variations", targetId=i })
                end
            end
        end
        -- Lunettes
        for i = 0, GetNumberOfPedPropDrawableVariations(PlayerPedId(), 1)-1 do
            if not tableContains(BanGlases, i) then
                local price = 20
                if priceGlass[i] ~= nil then price = priceGlass[i] end
                table.insert(DataSendBinco.catalogue, {id = i, price = price, label=i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Lunettes/"..i.."_1.webp", category="Lunettes", subCategory="Lunettes", idVariation=i})
                for z = 1, GetNumberOfPedPropTextureVariations(PlayerPedId(), 1, i) do
                    table.insert(DataSendBinco.catalogue, {id = z, label=z, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Lunettes/"..i.."_"..z..".webp", category="Lunettes", subCategory="Variations", targetId=i })
                end
            end
        end
        -- Sacs
        for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 5)-1 do
            if not tableContains(BanBag, i) then
                local price = 35
                if priceBag[i] ~= nil then price = priceBag[i] end
                table.insert(DataSendBinco.catalogue, {id = i, price = price, label=i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Sacs/"..i.."_1.webp", category="Sacs", subCategory="Sacs", idVariation=i})
                for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 5, i) do
                    table.insert(DataSendBinco.catalogue, {id = z, label=z, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Sacs/"..i.."_"..z..".webp", category="Sacs", subCategory="Variations", targetId=i })
                end
            end
        end

        --table.insert(DataSendBinco.catalogue, {id = 0, price = 150, label="1", image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Chapeaux/1_1.webp", category="Cou", subCategory="Cou", idVariation=0})


        --[[
        Pour les PED
        ]]
        --Pantalons
        for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 4)-1 do
            --if not tableContains(BanLeg, i) then
                table.insert(DataSendBinco.catalogue, {id = i, label=i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Bas/"..i.."_1.webp", category="Bas", subCategory="pBas", idVariation=i})
                for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 4, i) do
                    table.insert(DataSendBinco.catalogue, {id = z, label=z, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Bas/"..i.."_"..z..".webp", category="Bas", subCategory="pVariations", targetId=i })
                end
            --end
        end
        -- Hauts
        for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 3)-1 do
            --if not tableContains(BanTop, i) then
                table.insert(DataSendBinco.catalogue, {id = i, label=i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Hauts/"..i.."_1.webp", category="Hauts", subCategory="pHauts", idVariation=i})
                for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 3, i) do
                    table.insert(DataSendBinco.catalogue, {id = z, label=z, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Hauts/"..i.."_"..z..".webp", category="Hauts", subCategory="pVariations", targetId=i })
                end
            --end
        end
        for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 8)-1 do
            --if not tableContains(BanTop, i) then
                table.insert(DataSendBinco.catalogue, {id = i, label=i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Hauts/"..i.."_1.webp", category="Accessoires", subCategory="pAccessoires", idVariation=i})
                for z = 1, GetNumberOfPedTextureVariations(PlayerPedId(), 8, i) do
                    table.insert(DataSendBinco.catalogue, {id = z, label=z, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Hauts/"..i.."_"..z..".webp", category="Accessoires", subCategory="pVariations", targetId=i })
                end
            --end
        end
        -- Chapeaux
        if GetEntityModel(PlayerPedId()) == 2064532783 then
            for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 0) do
                --if not tableContains(BanHat, i) then
                    table.insert(DataSendBinco.catalogue, {id = i, label=i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Chapeaux/"..i.."_1.webp", category="Chapeaux", subCategory="pChapeaux", idVariation=i})
                    for z = 1, GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, i) do
                        table.insert(DataSendBinco.catalogue, {id = z, label=z, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Chapeaux/"..i.."_"..z..".webp", category="Chapeaux", subCategory="pVariations", targetId=i })
                    end
                --end
            end
        else
            for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 0)-1 do
                --if not tableContains(BanHat, i) then
                    table.insert(DataSendBinco.catalogue, {id = i, label=i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Chapeaux/"..i.."_1.webp", category="Chapeaux", subCategory="pChapeaux", idVariation=i})
                    for z = 1, GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, i) do
                        table.insert(DataSendBinco.catalogue, {id = z, label=z, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Chapeaux/"..i.."_"..z..".webp", category="Chapeaux", subCategory="pVariations", targetId=i })
                    end
                --end
            end
        end
        -- Lunettes
        for i = 0, GetNumberOfPedPropDrawableVariations(PlayerPedId(), 1)-1 do
            --if not tableContains(BanGlases, i) then
                table.insert(DataSendBinco.catalogue, {id = i, label=i, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Lunettes/"..i.."_1.webp", category="Lunettes", subCategory="pLunettes", idVariation=i})
                for z = 1, GetNumberOfPedPropTextureVariations(PlayerPedId(), 1, i) do
                    table.insert(DataSendBinco.catalogue, {id = z, label=z, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Binco/"..playerType.."/Lunettes/"..i.."_"..z..".webp", category="Lunettes", subCategory="pVariations", targetId=i })
                end
            --end
        end
        -- Accesoire
    end
    return true
end



RegisterNUICallback("MenuBinco", function(data) 
    local choise = {}
    if isPlayerPed() then
        if data.selections[1].category == "Hauts" then
            if p:pay(tonumber(DataSendBinco.buttons[1].price)) then
                TriggerSecurGiveEvent("core:addItemToInventory", token, "ptshirt", 1, {
                    renamed = "Haut N°" .. data.selections[1].id,
                    drawableId = data.selections[1].id,
                    variationId = data.selections[2].id-1
                })

                exports['vNotif']:createNotification({
                    type = 'JAUNE',
                    content = "~c Vous venez d'acheter un haut pour ~s " ..DataSendBinco.buttons[1].price.. "$"
                })
                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }))
            else
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    content = "~c Vous n'avez ~s pas assez d'argent"
                })

            end
        end
        if data.selections[1].category == "Bas" then
            if p:pay(tonumber(DataSendBinco.buttons[2].price)) then
                TriggerSecurGiveEvent("core:addItemToInventory", token, "ppant", 1, {
                    renamed = "Bas N°" .. data.selections[1].id,
                    drawableId = data.selections[1].id,
                    variationId = data.selections[2].id-1
                })

                exports['vNotif']:createNotification({
                    type = 'JAUNE',
                    content = "~c Vous venez d'acheter un bas pour ~s " ..DataSendBinco.buttons[1].price.. "$"
                })
                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }))
            else
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    content = "~c Vous n'avez ~s pas assez d'argent"
                })

            end
        end
        if data.selections[1].category == "Chapeaux" then
            if p:pay(tonumber(DataSendBinco.buttons[4].price)) then
                TriggerSecurGiveEvent("core:addItemToInventory", token, "phat", 1, {
                    renamed = "Chapeau N°" .. data.selections[1].id,
                    drawableId = data.selections[1].id,
                    variationId = data.selections[2].id-1
                })

                exports['vNotif']:createNotification({
                    type = 'JAUNE',
                    content = "~c Vous venez d'acheter un chapeau pour ~s " ..DataSendBinco.buttons[1].price.. "$"
                })
                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }))
            else
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    content = "~c Vous n'avez ~s pas assez d'argent"
                })

            end
        end
        if data.selections[1].category == "Lunettes" then
            if p:pay(tonumber(DataSendBinco.buttons[5].price)) then
                TriggerSecurGiveEvent("core:addItemToInventory", token, "pglasses", 1, {
                    renamed = "Lunettes N°" .. data.selections[1].id,
                    drawableId = data.selections[1].id,
                    variationId = data.selections[2].id-1
                })

                exports['vNotif']:createNotification({
                    type = 'JAUNE',
                    content = "~c Vous venez d'acheter des lunettes pour ~s " ..DataSendBinco.buttons[1].price.. "$"
                })
                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }))
            else
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    content = "~c Vous n'avez ~s pas assez d'argent"
                })

            end
        end
        if data.selections[1].category == "Accessoires" then
            if p:pay(tonumber(DataSendBinco.buttons[3].price)) then
                TriggerSecurGiveEvent("core:addItemToInventory", token, "paccs", 1, {
                    renamed = "Accessoires N°" .. data.selections[1].id,
                    drawableId = data.selections[1].id,
                    variationId = data.selections[2].id-1
                })

                exports['vNotif']:createNotification({
                    type = 'JAUNE',
                    content = "~c Vous venez d'acheter un bas pour ~s " ..DataSendBinco.buttons[1].price.. "$"
                })
                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }))
            else
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    content = "~c Vous n'avez ~s pas assez d'argent"
                })

            end
        end
    else
        if data.selections[1].category == "Hauts" then
            if p:pay(tonumber(DataSendBinco.buttons[1].price)) then
                TriggerSecurGiveEvent("core:addItemToInventory", token, "tshirt", 1, {
                    renamed = "Haut N°" .. data.selections[1].id,
                    drawableTorsoId = data.selections[1].id,
                    variationTorsoId = data.selections[2].id-1,
                    drawableArmsId = data.selections[5].id,
                    variationArmsId = data.selections[6].id-1,
                    drawableTshirtId = data.selections[3].id,
                    variationTshirtId = data.selections[4].id-1
                })
                exports['vNotif']:createNotification({
                    type = 'JAUNE',
                    content = "~c Vous venez d'acheter un haut pour ~s " ..DataSendBinco.buttons[1].price.. "$"
                })
                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }))
                local newSkin = GetFakeSkin()
                p:setSkin(newSkin)
                p:saveSkin()
            else
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    content = "~c Vous n'avez ~s pas assez d'argent"
                })

            end
        end
        if data.selections[1].category == "Bas" then
            if p:pay(tonumber(DataSendBinco.buttons[2].price)) then
                TriggerSecurGiveEvent("core:addItemToInventory", token, "pant", 1, {
                    renamed = "Pantalon N°" .. data.selections[1].id,
                    drawableId = data.selections[1].id,
                    variationId = data.selections[2].id-1
                })

                -- ShowNotification("Vous venez d'acheter un pantalon pour ~g~"..DataSendBinco.buttons[2].price.."~s~ $")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'JAUNE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~c Vous venez d'acheter un pantalon pour ~s " ..DataSendBinco.buttons[2].price.. "$"
                })

                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }))
                local newSkin = GetFakeSkin()
                p:setSkin(newSkin)
                p:saveSkin()
            else
                -- ShowNotification("Vous n'avez pas assez d'argent")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~c Vous n'avez ~s pas assez d'argent"
                })
            end
        end
        if data.selections[1].category == "Chaussures" then
            if p:pay(tonumber(DataSendBinco.buttons[3].price)) then
                TriggerSecurGiveEvent("core:addItemToInventory", token, "feet", 1, {
                    renamed = "Chaussures N°" .. data.selections[1].id,
                    drawableId = data.selections[1].id,
                    variationId = data.selections[2].id-1
                })
                -- ShowNotification("Vous venez d'acheter des chaussures pour ~g~"..DataSendBinco.buttons[3].price.."~s~ $")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'JAUNE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~c Vous venez d'acheter des chaussures pour ~s " ..DataSendBinco.buttons[3].price.. "$"
                })

                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }))
                local newSkin = GetFakeSkin()
                p:setSkin(newSkin)
                p:saveSkin()
            else
                -- ShowNotification("Vous n'avez pas assez d'argent")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~c Vous n'avez ~s pas assez d'argent"
                })

            end
        end
        if data.selections[1].category == "Chapeaux" then
            if p:pay(tonumber(DataSendBinco.buttons[4].price)) then
                TriggerSecurGiveEvent("core:addItemToInventory", token, "hat", 1, {
                    renamed = "Chapeau N°" .. data.selections[1].id,
                    drawableId = data.selections[1].id,
                    variationId = data.selections[2].id-1
                })
                -- ShowNotification("Vous venez d'acheter un chapeau pour ~g~"..DataSendBinco.buttons[4].price.."~s~ $")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'JAUNE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~c Vous venez d'acheter un chapeau pour ~s " ..DataSendBinco.buttons[4].price.. "$"
                })

                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }))
                local newSkin = GetFakeSkin()
                p:setSkin(newSkin)
                p:saveSkin()
            else
                -- ShowNotification("Vous n'avez pas assez d'argent")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~c Vous n'avez ~s pas assez d'argent"
                })
            end
        end
        if data.selections[1].category == "Lunettes" then
            if p:pay(tonumber(DataSendBinco.buttons[5].price)) then
                TriggerSecurGiveEvent("core:addItemToInventory", token, "glasses", 1, {
                    renamed = "Lunettes N°" .. data.selections[1].id,
                    drawableId = data.selections[1].id,
                    variationId = data.selections[2].id-1
                })
                -- ShowNotification("Vous venez d'acheter une paire de lunettes pour ~g~"..DataSendBinco.buttons[5].price.."~s~ $")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'JAUNE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~c Vous venez d'acheter une paire de lunettes pour ~s " ..DataSendBinco.buttons[5].price.. "$"
                })

                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }))
                local newSkin = GetFakeSkin()
                p:setSkin(newSkin)
                p:saveSkin()
            else
                -- ShowNotification("Vous n'avez pas assez d'argent")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~c Vous n'avez ~s pas assez d'argent"
                })
            end
        end
        if data.selections[1].category == "Sacs" then
            if p:pay(tonumber(DataSendBinco.buttons[6].price)) then
                    TriggerSecurGiveEvent("core:addItemToInventory", token, "access", 1, {
                    renamed = "Sac N°" .. data.selections[1].id,
                    drawableId = data.selections[1].id,
                    variationId = data.selections[2].id-1,
                    name = "sac"
                })
                -- ShowNotification("Vous venez d'acheter un sac pour ~g~"..DataSendBinco.buttons[6].price.."~s~ $")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'JAUNE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~c Vous venez d'acheter un sac pour ~s " ..DataSendBinco.buttons[6].price.. "$"
                })

                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }))
                local newSkin = GetFakeSkin()
                p:setSkin(newSkin)
                p:saveSkin()
            else
                -- ShowNotification("Vous n'avez pas assez d'argent")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~c Vous n'avez ~s pas assez d'argent"
                })
            end
        end
    end
end)


DataSendOpenBinco = {
    --catalogue = {},
    --headerIconName = nil,
    --headerIcon = nil,
    --headerImage = 'assets/headers/binco.png',
    progressElementToForceBoutiqueHeader = {'Vetements', 'Boutique'},
    --user = {}

}

DataSendBinco = {
    catalogue = {},
    headerIconName = nil,
    headerIcon = nil,
    headerImage = 'assets/headers/binco.png',
    hideItemList= {'Bras','Variations 3', 'pHauts', 'pVariations', 'pBas', 'pAccessoires', 'pChapeaux', 'pLunettes'},
    showTurnAroundButtons = true,
    user = {}
}

OpenClothShopUIBefore = function()
    DataSendOpenBinco.headerIcon = 'assets/icons/image_homme.png'
    if isPlayerPed() then --C'est un ped
        DataSendOpenBinco.headerIconName = 'Binco Ped'
    elseif p:skin().sex == 0 then
        DataSendOpenBinco.headerIconName = 'Binco Homme'
    elseif p:skin().sex == 1 then
        DataSendOpenBinco.headerIconName = 'Binco Femme'
    end
    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))
    Wait(50)
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'MenuPreBinco',
        data = DataSendOpenBinco
    }))
    ClothShop.open = true
end

OpenClothShopUI = function()
    local bool = GetDatas()
    while not bool do 
        Wait(1)
    end
    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))
    Wait(50)
    ClothShop.open = true
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'MenuBinco',
        data = DataSendBinco
    }))
    forceHideRadar()
    SetNuiFocusKeepInput(true)
    FreezeEntityPosition(PlayerPedId(), true)
    CreateThread(function()
        while ClothShop.open do 
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
            DisableControlAction(0, 245, true) 
            DisableControlAction(0, 257, true) 
            DisableControlAction(0, 140, true) 
            DisableControlAction(0, 141, true) 
            DisableControlAction(0, 142, true) 
            DisableControlAction(0, 143, true)
            DisableControlAction(0, 38, true)
            DisableControlAction(0, 44, true)
            if IsDisabledControlPressed(0, 38) then
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+1.5)
            end
            if IsDisabledControlPressed(0, 44) then
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-1.5)
            end
            if IsControlJustPressed(0, 211) then
                RegisterNUICallback("focusOut", function(data, cb)
                    if ClothShop.open then
                        if isPlayerPed() ~= 1885233650 then
                            if IsEntityPlayingAnim(PlayerPedId(), "clothingshirt", "try_shirt_neutral_b", 3) or 
                            IsEntityPlayingAnim(PlayerPedId(), "clothingshoes", "try_shoes_neutral_d", 3) or 
                            IsEntityPlayingAnim(PlayerPedId(), "clothingtrousers", "try_trousers_neutral_d", 3) then
                                ClearPedTasks(PlayerPedId())
                            end
                            SetNuiFocusKeepInput(false)
                            TriggerScreenblurFadeOut(0.5)
                            DisplayHud(true)
                            openRadarProperly()
                            RenderScriptCams(false, false, 0, 1, 0)
                            FreezeEntityPosition(PlayerPedId(), false)
                            ClothShop.open = false
                            ClothShop.cam = nil
                            DestroyCam(ClothShop.cam,false)
                        else
                            local playerSkin = p:skin()
                            ApplySkin(playerSkin)
                            if IsEntityPlayingAnim(PlayerPedId(), "clothingshirt", "try_shirt_neutral_b", 3) or 
                            IsEntityPlayingAnim(PlayerPedId(), "clothingshoes", "try_shoes_neutral_d", 3) or 
                            IsEntityPlayingAnim(PlayerPedId(), "clothingtrousers", "try_trousers_neutral_d", 3) then
                                ClearPedTasks(PlayerPedId())
                            end
                            SetNuiFocusKeepInput(false)
                            TriggerScreenblurFadeOut(0.5)
                            DisplayHud(true)
                            openRadarProperly()
                            RenderScriptCams(false, false, 0, 1, 0)
                            FreezeEntityPosition(PlayerPedId(), false)
                            ClothShop.open = false
                            ClothShop.cam = nil
                            DestroyCam(ClothShop.cam,false)
                        end
                    end
                end)
                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }))
            end
        end
    end)
end

RegisterNUICallback("focusOut", function(data, cb)
    print("focus outi")
    if ClothShop.open then
        print("ClothShop.open")
        zone.showNotif(ClothShopId)
        if isPlayerPed() then
            if IsEntityPlayingAnim(PlayerPedId(), "clothingshirt", "try_shirt_neutral_b", 3) or 
            IsEntityPlayingAnim(PlayerPedId(), "clothingshoes", "try_shoes_neutral_d", 3) or 
            IsEntityPlayingAnim(PlayerPedId(), "clothingtrousers", "try_trousers_neutral_d", 3) then
                ClearPedTasks(PlayerPedId())
            end
            SetNuiFocusKeepInput(false)
            TriggerScreenblurFadeOut(0.5)
            DisplayHud(true)
            openRadarProperly()
            RenderScriptCams(false, false, 0, 1, 0)
            FreezeEntityPosition(PlayerPedId(), false)
            ClothShop.open = false
            ClothShop.cam = nil
            DestroyCam(ClothShop.cam,false)
        else
            local playerSkin = p:skin()
            ApplySkin(playerSkin)
            if IsEntityPlayingAnim(PlayerPedId(), "clothingshirt", "try_shirt_neutral_b", 3) or 
            IsEntityPlayingAnim(PlayerPedId(), "clothingshoes", "try_shoes_neutral_d", 3) or 
            IsEntityPlayingAnim(PlayerPedId(), "clothingtrousers", "try_trousers_neutral_d", 3) then
                ClearPedTasks(PlayerPedId())
            end
            SetNuiFocusKeepInput(false)
            TriggerScreenblurFadeOut(0.5)
            DisplayHud(true)
            openRadarProperly()
            RenderScriptCams(false, false, 0, 1, 0)
            FreezeEntityPosition(PlayerPedId(), false)
            ClothShop.open = false
            ClothShop.cam = nil
            DestroyCam(ClothShop.cam,false)
        end
    end
end)

local cloths_pos = {
    vector3(77.503921508789, -1398.0554199219, 29.378450393677),
    vector3(119.74308776855, -222.70625305176, 54.557708740234),
    vector3(423.55407714844, -801.01702880859, 29.49342918396),
    vector3(-161.18197631836, -295.82052612305, 39.733341217041),
    vector3(-1188.8310546875, -772.24237060547, 17.329620361328),
    vector3(-826.20935058594, -1078.0648193359, 11.330412864685),
    vector3(-1454.8548583984, -242.90182495117, 49.811191558838),
    vector3(-706.07836914063, -159.1233215332, 37.415233612061),
    vector3(-3172.6130371094, 1044.1192626953, 20.863344192505),
    vector3(-1103.6965332031, 2705.2814941406, 19.110157012939),
    vector3(616.27331542969, 2762.8762207031, 42.088245391846),
    vector3(1191.3132324219, 2708.5024414063, 38.224914550781),
    vector3(1691.0006103516, 4827.412109375, 42.065406799316),
    vector3(6.5052900314331, 6517.4887695313, 31.880146026611),
}

ClothShopId = 0

CreateThread(function()
    while zone == nil do
        Wait(1)
    end
    for k, v in pairs(cloths_pos) do
        zone.addZone("cloths_shop" .. k,
            vector3(v.x, v.y, v.z - 0.9),
            "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le magasin de vêtements",
            function()
                if not ClothShop.open then
                    ClothShopId = "cloths_shop" .. k
                    zone.hideNotif(ClothShopId)
                    exports['tuto-fa']:GotoStep(5)
                    OpenClothShopUI()
                end
            end, false,
            27,
            0.5,
            { 255, 255, 255 },
            170,
            4.0
        )
    end
end)

function isPlayerPed()
    if GetEntityModel(PlayerPedId()) ~= -1667301416 and GetEntityModel(PlayerPedId()) ~= 1885233650 then
        return true
    else
        return false
    end
end
exports("isPlayerPed", isPlayerPed)
