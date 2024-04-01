local token = nil

local posGestion
local posCoffre
local coffreCapacity
local garageSpawn
local garageDespawn   
posCasier = vector3(1590.1740722656, 3765.2431640625, 33.43745803833)
local listVeh
local garageMenuPos
local liveryNspeedo
local liverySteed2
local liveryFoodbike
local liveryTaco2
local boxville7

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)
function LoadRestaurant()
    print("Loading")
    restaurantService = false
    local jobName = p:getJob()
    local posRestaurant
    
    if jobName == "burgershot" then
        posGestion = vector3(1596.2878, 3757.6482, 33.437)
        posCoffre = vector3(1599.1985, 3753.2832, 33.4366)
        garageMenuPos = vector3(1595.2117, 3764.6201, 33.4329)
        garageSpawn = vector4(1601.0817, 3760.6501, 34.4318, 36.6673)
        garageDespawn = vector3(1601.0817, 3760.6501, 34.4318)
        posCasier = vector3(1590.1740722656, 3765.2431640625, 33.43745803833)
        liveryNspeedo = 8
        liverySteed2 = 2
        liveryTaco2 = 3
        liveryBoxville7 = 11
        liveryFoodbike = 3
        listVeh = {
            headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_burgershot.webp',
            headerIcon = 'assets/icons/voiture-icon.png',
            headerIconName = 'VEHICULES',
            callbackName = 'vehMenu',
            elements = {
                {
                    id = 1,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BurgerShot/boxville7.webp',
                    label = 'Boxville',
                    name = "boxville7"
                },
                {
                    id = 2,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BurgerShot/nspeedo.webp',
                    label = 'Speedo',
                    name = "nspeedo"
                },
                {
                    id = 3,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BurgerShot/foodbike.webp',
                    label = 'Scooter',
                    name = "foodbike"
                },
            }
        }
     elseif jobName == "uwu" then
         posGestion = vector3(-597.63720703125, -1053.5052490234, 21.344198226929)
         posCoffre = vector3(-588.58880615234, -1066.4090576172, 21.344194412231)
         garageMenuPos = vector3(-601.93908691406, -1055.7504882813, 21.546281814575)
         garageSpawn = vector4(-610.4658203125, -1059.4886474609, 20.788318634033, 93.266418457031)
         garageDespawn = vector3(-620.82489013672, -1058.6409912109, 21.78826713562)
         posCasier = vector3(-586.64532470703, -1049.2813720703, 21.34419631958)
         liveryNspeedo = 7
         liverySteed2 = 0
         liveryTaco2 = 0
         liveryBoxville7 = 5
         liveryFoodbike = 2
         listVeh = {
             headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_uwucoffee.webp',
             headerIcon = 'assets/icons/voiture-icon.png',
             headerIconName = 'VEHICULES',
             callbackName = 'vehMenu',
            elements = {
                 {
                     id = 1,
                     image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/UwUCafe/boxville7.webp',
                     label = 'Boxville',
                     name = "boxville7"
                 },
                 {
                     id = 2,
                     image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/UwUCafe/nspeedo.webp',
                     label = 'Speedo',
                     name = "nspeedo"
                 },
                 {
                     id = 3,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/UwUCafe/foodbike.webp',
                    label = 'Scooter',
                     name = "foodbike"
                 },
             }
         }
    elseif jobName == "bahamas" then
        posGestion = vector3(-1366.1268310547, -625.63800048828, 30.319976806641)
        posCoffre = vector3(-1402.6989, -598.7454, 29.32)
        garageMenuPos = vector3(-1383.2352294922, -639.93334960938, 27.673765182495)
        garageSpawn = vector4(-1376.3679199219, -643.02764892578, 28.673765182495, 224.49371337891)
        garageDespawn = vector3(-1376.3679199219, -643.02764892578, 28.673765182495)
        posCasier = vector3(-1377.0656738281, -634.17437744141, 29.319955825806)
        liveryNspeedo = 12
        liverySteed2 = 0
        liveryTaco2 = 0
        liveryBoxville7 = 3
        listVeh = {
            headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_bahamamamas.webp',
            headerIcon = 'assets/icons/voiture-icon.png',
            headerIconName = 'VEHICULES',
            callbackName = 'vehMenu',
            elements = {
                {
                    id = 1,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BahamasMamas/boxville7.webp',
                    label = 'Boxville',
                    name = "boxville7"
                },
                {
                    id = 2,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BahamasMamas/nspeedo.webp',
                    label = 'Speedo',
                    name = "nspeedo"
                },
            }
        }
    elseif jobName == "comrades" then
        posGestion = vector3(-1579.8624267578, -978.46044921875, 13.076283454895)
        posCoffre = vector3(-1583.3986816406, -991.95751953125, 12.075221061707)
        garageMenuPos = vector3(-1581.318359375, -992.04125976563, 12.020422935486)
        garageSpawn = vector4(-1564.04296875, -986.15386962891, 13.017504692078, 250.38995361328)
        garageDespawn = vector3(-1580.6940917969, -1006.1446533203, 13.017501831055)
        posCasier = vector3(-1578.5635986328, -986.94635009766, 12.075225830078)
        liveryNspeedo = 16
        liverySteed2 = 0
        liveryTaco2 = 0
        liveryBoxville7 = 0
        listVeh = {
            headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_comradesbar.webp',
            headerIcon = 'assets/icons/voiture-icon.png',
            headerIconName = 'VEHICULES',
            callbackName = 'vehMenu',
            elements = {
                {
                    id = 1,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/ComradesBar/nspeedo.webp',
                    label = 'Speedo',
                    name = "nspeedo"
                },
            }
        }
    elseif jobName == "ltdsud" then
        posGestion = vector3(-43.4921, -1748.884, 28.421)
        posCoffre = vector3(-41.453826904297, -1752.3195800781, 28.421016693115)
        coffreCapacity = 2000.0
        garageMenuPos = vector3(-40.8134, -1748.0006, 28.3267)
        garageSpawn = vector4(-35.6118, -1747.9089, 28.0957, 50.5783)
        garageDespawn = vector3(-35.6118, -1747.9089, 29.0957)
        posCasier = vector3(-709.64422607422, -907.13647460938, 18.215593338013)
        liveryNspeedo = 17
        liverySteed2 = 10
        liveryTaco2 = 0
        liveryBoxville7 = 7
        listVeh = {
            headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_ltd.webp',
            headerIcon = 'assets/icons/voiture-icon.png',
            headerIconName = 'VEHICULES',
            callbackName = 'vehMenu',
            elements = {
                {
                    id = 1,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LTD/boxville7.webp',
                    label = 'Boxville',
                    name = "boxville7"
                },
                {
                    id = 2,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LTD/nspeedo.webp',
                    label = 'Speedo',
                    name = "nspeedo"
                },
            }
        }
    elseif jobName == "mirror" then
        posGestion = vector3(1111.75390625, -639.96942138672, 56.815948486328)
        posCoffre = vector3(1117.2032470703, -636.85583496094, 56.817756652832)
        garageMenuPos = vector3(1063.2276611328, -778.73217773438, 57.262741088867)
        garageSpawn = vector4(1060.3372802734, -774.99444580078, 58.250545501709, 3.6259486675262)
        garageDespawn = vector3(1055.4509277344, -773.86444091797, 58.241821289063)
        posCasier = vector3(1116.7463378906, -634.62048339844, 55.817798614502)
        liveryNspeedo = 15
        liverySteed2 = 0
        liveryTaco2 = 0
        liveryBoxville7 = 8
        liveryFoodbike = 5
        listVeh = {
            headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/header_lemiroir.webp',
            headerIcon = 'assets/icons/voiture-icon.png',
            headerIconName = 'VEHICULES',
            callbackName = 'vehMenu',
            elements = {
                {
                    id = 1,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LeMiroir/boxville7.webp',
                    label = 'Boxville',
                    name = "boxville7"
                },
                {
                    id = 2,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LeMiroir/nspeedo.webp',
                    label = 'Speedo',
                    name = "nspeedo"
                },
                {
                    id = 3,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/CluckinBell/foodbike.webp',
                    label = 'Scooter',
                    name = "foodbike"
                },
            }
        }
    elseif jobName == "unicorn" then
        posGestion = vector3(93.260627746582, -1289.8096923828, 28.321634292603)
        posCoffre = vector3(94.157821655273, -1271.94140625, 20.111234664917)
        garageMenuPos = vector3(136.41621398926, -1278.7573242188, 28.363302230835)
        garageSpawn = vector4(140.63313293457, -1280.1213378906, 28.336940765381, 305.54016113281)
        garageDespawn = vector3(144.64332580566, -1287.9321289063, 28.341758728027)
        posCasier = vector3(120.53158569336, -1301.5828857422, 20.11106300354)
        liveryNspeedo = 13
        liverySteed2 = 0
        liveryTaco2 = 0
        liveryBoxville7 = 4
        listVeh = {
            headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_unicorn.webp',
            headerIcon = 'assets/icons/voiture-icon.png',
            headerIconName = 'VEHICULES',
            callbackName = 'vehMenu',
            elements = {
                {
                    id = 1,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Unicorn/boxville7.webp',
                    label = 'Boxville',
                    name = "boxville7"
                },
                {
                    id = 2,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Unicorn/nspeedo.webp',
                    label = 'Speedo',
                    name = "nspeedo"
                },
            }
        }
     elseif jobName == "cluckin" then
         posGestion = vector3(-166.76165771484, -269.77435302734, 42.599124908447)
         posCoffre = vector3(-156.81117248535, -275.30505371094, 42.599075317383)
         garageMenuPos = vector3(-138.4302520752, -249.41737365723, 42.89571762085)
         garageSpawn = vector4(-129.24969482422, -254.11538696289, 42.679912567139, 158.03704833984)
         garageDespawn = vector3(-135.52705383301, -250.99952697754, 43.848796844482)
         posCasier = vector3(1590.1740722656, 3765.2431640625, 33.43745803833)
         liveryNspeedo = 9
         liverySteed2 = 0
         liveryTaco2 = 5
         liveryBoxville7 = 0
         liveryFoodbike = 4
         listVeh = {
             headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_cluckinbell.webp',
             headerIcon = 'assets/icons/voiture-icon.png',
             headerIconName = 'VEHICULES',
             callbackName = 'vehMenu',
             elements = {
                 {
                     id = 1,
                     image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/CluckinBell/nspeedo.webp',
                     label = 'Speedo',
                     name = "nspeedo"
                 },
                 {
                     id = 2,
                     image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/CluckinBell/taco2.webp',
                     label = 'Tacos Van',
                     name = "taco2"
                 },
                 {
                     id = 3,
                     image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/CluckinBell/foodbike.webp',
                     label = 'Scooter',
                     name = "foodbike"
                 },
             }
         }
elseif jobName == "tacosrancho" then
    posGestion = vector3(428.80484008789, -1914.3314208984, 24.471235275269)
    posCoffre = vector3( 425.74304199219, -1911.4929199219, 24.471235275269)
    garageMenuPos = vector3(401.10754394531, -1925.9727783203, 23.809778213501)
    garageSpawn = vector4(402.58480834961, -1921.3122558594, 23.748859405518, 231.12788391113)
    garageDespawn = vector3(406.75018310547, -1916.4705810547, 24.142221450806)
    liveryNspeedo = 10
    liverySteed2 = 0
    liveryTaco2 = 0
    liveryBoxville7 = 0
    liveryFoodbike = 0
    listVeh = {
        headerImage = 'https://media.discordapp.net/attachments/1146829717597606119/1147487872258166834/Banner-Tacos2Rancho.jpg',
        headerIcon = 'assets/icons/voiture-icon.png',
        headerIconName = 'VEHICULES',
        callbackName = 'vehMenu',
        elements = {
            {
                id = 1,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/CluckinBell/nspeedo.webp',
                label = 'Speedo',
                name = "nspeedo"
            },
            {
                id = 2,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/CluckinBell/taco2.webp',
                label = 'Tacos Van',
                name = "taco2"
            },
            {
                id = 3,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/CluckinBell/foodbike.webp',
                label = 'Scooter',
                name = "foodbike"
            },
        }
    }
     elseif jobName == "bean" then
     posGestion = vector3(-634.49597167969, 225.91368103027, 80.881454467773)
         posCoffre = vector3(-635.34906005859, 233.52919006348, 80.881477355957)
         garageMenuPos = vector3(-621.65844726563, 285.86074829102, 80.626640319824)
         garageSpawn = vector4(-618.75848388672, 281.36303710938, 80.636688232422, 168.36717224121)
         garageDespawn = vector3(-618.25714111328, 282.52471923828, 81.675308227539)
         posCasier = vector3(1590.1740722656, 3765.2431640625, 33.43745803833)
         liveryNspeedo = 6
         liverySteed2 = 0
         liveryTaco2 = 4
         liveryBoxville7 = 0
         liveryFoodbike = 1
         listVeh = {
             headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_beanmachine.webp',
         headerIcon = 'assets/icons/voiture-icon.png',
             headerIconName = 'VEHICULES',
             callbackName = 'vehMenu',
             elements = {
                 {
                     id = 1,
                     image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BeanMachine/nspeedo.webp',
                     label = 'Speedo',
                     name = "nspeedo"
                 },
                 {
                     id = 2,
                     image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BeanMachine/taco2.webp',
                     label = 'Tacos Van',
                     name = "taco2"
                 },
                 {
                     id = 3,
                     image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BeanMachine/foodbike.webp',
                    label = 'Scooter',
                     name = "foodbike"
                 },
             }
         }
    elseif jobName == "pops" then
        posGestion = vector3(1594.8505859375, 6454.9033203125, 26.0140209198)
        posCoffre = vector3(1585.6832275391, 6459.0302734375, 26.014009475708)
        garageMenuPos = vector3(1580.5357666016, 6460.2158203125, 24.317018508911)
        garageSpawn = vector4(1573.8974609375, 6463.0776367188, 24.823820114136, 159.03941345215)
        garageDespawn = vector3(1573.8974609375, 6463.0776367188, 24.823820114136)
        posCasier = vector3(1582.9136962891, 6460.6865234375, 25.014017105103)
        liveryNspeedo = 4
        liverySteed2 = 0
        liveryTaco2 = 0
        liveryBoxville7 = 6
        liveryFoodbike = 6
        listVeh = {
            headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_popsdiner.webp',
            headerIcon = 'assets/icons/voiture-icon.png',
            headerIconName = 'VEHICULES',
            callbackName = 'vehMenu',
            elements = {
                {
                    id = 1,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/PopsDiner/boxville7.webp',
                    label = 'Boxville',
                    name = "boxville7"
                },
                {
                    id = 2,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/PopsDiner/nspeedo.webp',
                    label = 'Speedo',
                    name = "nspeedo"
                },
                {
                    id = 3,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BeanMachine/foodbike.webp',
                    label = 'Scooter',
                    name = "foodbike"
                },
            }
        }
    elseif jobName == "bayviewLodge" then
        posGestion = vector3(-682.7666015625, 5805.291015625, 16.331018447876)
        posCoffre = vector3(-686.33410644531, 5798.66796875, 16.330997467041)
        garageMenuPos = vector3(-689.1708984375, 5789.060546875, 16.330862045288)
        garageSpawn = vector4(-684.80749511719, 5782.8706054688, 16.330854415894, 153.91329956055)
        garageDespawn = vector3(-684.21917724609, 5784.9653320313, 17.330860137939)
        posCasier = vector3(-688.49066162109, 5793.6845703125, 16.331008911133)
        liveryNspeedo = 18
        liverySteed2 = 0
        liveryTaco2 = 0
        liveryBoxville7 = 0
        liveryFoodbike = 0
        listVeh = {
            headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_bayviewlodge.webp',
            headerIcon = 'assets/icons/voiture-icon.png',
            headerIconName = 'VEHICULES',
            callbackName = 'vehMenu',
            elements = {
                {
                    id = 1,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/CluckinBell/nspeedo.webp',
                    label = 'Speedo',
                    name = "nspeedo"
                },
                {
                    id = 2,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/CluckinBell/foodbike.webp',
                    label = 'Scooter',
                    name = "foodbike"
                },
            }
        }
    elseif jobName == "yellowJack" then
        posGestion = vector3(1994.5003662109, 3043.3154296875, 46.212627410889)
        posCoffre = vector3(1981.9924316406, 3052.6611328125, 46.214988708496)
        garageMenuPos = vector3(1991.9890136719, 3041.9079589844, 46.214302062988)
        garageSpawn = vector4(1990.4350585938, 3031.2355957031, 46.056350708008, 53.0)
        garageDespawn = vector3(1990.4350585938, 3031.2355957031, 47.056350708008)
        posCasier = vector3(1994.4916992188, 3043.3154296875, 46.212619781494)
        liveryNspeedo = 22
        liverySteed2 = 0
        liveryTaco2 = 0
        liveryBoxville7 = 0
        liveryFoodbike = 0
        listVeh = {
            headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_yellowjack.webp',
            headerIcon = 'assets/icons/voiture-icon.png',
            headerIconName = 'VEHICULES',
            callbackName = 'vehMenu',
            elements = {
                {
                    id = 1,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/CluckinBell/nspeedo.webp',
                    label = 'Speedo',
                    name = "nspeedo"
                },
                {
                    id = 2,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/CluckinBell/taco2.webp',
                    label = 'Tacos Van',
                    name = "taco2"
                },
                {
                    id = 3,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/CluckinBell/foodbike.webp',
                    label = 'Scooter',
                    name = "foodbike"
                },
            }
        }
    elseif jobName == "blackwood" then
        posGestion = vector3(-295.87478637695, 6268.3813476563, 30.53249168396)
        posCoffre = vector3(-305.65612792969, 6268.8232421875, 30.526851654053)
        garageMenuPos = vector3(-300.87661743164, 6283.6860351563, 30.492605209351)
        garageSpawn = vector4(-306.3493347168, 6282.0986328125, 30.492616653442, 131.86166381836)
        garageDespawn = vector3(-306.3493347168, 6282.0986328125, 31.492616653442)
        posCasier = vector3(-295.67147827148, 6268.1586914063, 30.595254898071)
        liveryNspeedo = 22
        liverySteed2 = 0
        liveryTaco2 = 11
        liveryBoxville7 = 0
        liveryFoodbike = 0
        listVeh = {
            headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_blackwood.webp',
            headerIcon = 'assets/icons/voiture-icon.png',
            headerIconName = 'VEHICULES',
            callbackName = 'vehMenu',
            elements = {
                {
                    id = 1,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BlackWood/nspeedo.webp',
                    label = 'Speedo',
                    name = "nspeedo"
                },
                {
                    id = 2,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BlackWood/taco2.webp',
                    label = 'Tacos Van',
                    name = "taco2"
                },
            }
        }
    elseif jobName == "hornys" then
        posGestion = vector3(1238.2030029297, -349.33111572266, 68.082099914551)
        posCoffre = vector3(1248.9276123047, -352.57815551758, 68.082130432129)
        garageMenuPos = vector3(1242.5808105469, -348.05682373047, 68.083358764648)
        garageSpawn = vector4(1247.9146728516, -341.7421875, 68.082244873047, 77.275772094727)
        garageDespawn = vector3(1252.3312988281, -346.67123413086, 68.082252502441)
        posCasier = vector3(1245.5054931641, -354.95623779297, 68.082077026367)
        liveryNspeedo = 20
        liverySteed2 = 0
        liveryTaco2 = 12
        liveryBoxville7 = 0
        liveryFoodbike = 0
        listVeh = {
            headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_pearl.webp',
            headerIcon = 'assets/icons/voiture-icon.png',
            headerIconName = 'VEHICULES',
            callbackName = 'vehMenu',
            elements = {
                {
                    id = 1,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BlackWood/nspeedo.webp',
                    label = 'Speedo',
                    name = "nspeedo"
                },
                {
                    id = 2,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BlackWood/taco2.webp',
                    label = 'Tacos Van',
                    name = "taco2"
                },
            }
        }
    elseif jobName == "upnatom" then
        posGestion = vector3(1238.171875, -349.28503417969, 68.082122)
        posCoffre = vector3(1248.9384765625, -352.64166259766, 68.0821380615066)
        garageMenuPos = vector3(92.67106628418, 297.95245361328, 109.21015930176)
        garageSpawn = vector4(95.938087463379, 307.68960571289, 109.02170562744, 151.37860107422)
        garageDespawn = vector3(95.938087463379, 307.68960571289, 109.02170562744)
        posCasier = vector3(86.014213562012, 293.7287902832, 109.20938873291)
        liveryNspeedo = 23
        liverySteed2 = 0
        liveryTaco2 = 8
        liveryBoxville7 = 0
        liveryFoodbike = 0
        listVeh = {
            headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_pearl.webp',
            headerIcon = 'assets/icons/voiture-icon.png',
            headerIconName = 'VEHICULES',
            callbackName = 'vehMenu',
            elements = {
                {
                    id = 1,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BlackWood/nspeedo.webp',
                    label = 'Speedo',
                    name = "nspeedo"
                },
                {
                    id = 2,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BlackWood/taco2.webp',
                    label = 'Tacos Van',
                    name = "taco2"
                },
            }
        }
    elseif jobName == "pizzeria" then
        posGestion = vector3(796.27069091797, -749.63470458984, 30.265892028809)
        posCoffre = vector3(812.30255126953, -754.81140136719, 25.780841827393)
        garageMenuPos = vector3(812.17761230469, -739.62615966797, 27.603317260742)
        garageSpawn = vector4(808.88043212891, -737.27563476563, 27.598899841309, 89.595878601074)
        garageDespawn = vector3(808.88043212891, -737.27563476563, 26.598899841309)
        posCasier = vector3(809.04052734375, -758.91473388672, 30.265962600708)
        liveryNspeedo = 21
        liverySteed2 = 0
        liveryTaco2 = 11
        liveryBoxville7 = 9
        liveryFoodbike = 0
        listVeh = {
            headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_pizzeria.webp',
            headerIcon = 'assets/icons/voiture-icon.png',
            headerIconName = 'VEHICULES',
            callbackName = 'vehMenu',
            elements = {
                {
                    id = 1,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BlackWood/nspeedo.webp',
                    label = 'Speedo',
                    name = "nspeedo"
                },
                {
                    id = 2,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BlackWood/taco2.webp',
                    label = 'Tacos Van',
                    name = "taco2"
                },
            }
        }
    elseif jobName == "pearl" then
        posGestion = vector3(-1840.2545166016, -1182.6945800781, 13.309239387512)
        posCoffre = vector3(-1839.9287109375, -1192.6213378906, 13.316003799438)
        garageMenuPos = vector3(-1851.3967285156, -1202.3023681641, 12.017549514771)
        garageSpawn = vector4(-1851.4085693359, -1210.2785644531, 12.017549514771, 233.622813)
        garageDespawn = vector3(-1858.5034179688, -1195.4124755859, 12.017599105835)
        posCasier = vector3(-1838.3132324219, -1187.2651367188, 13.30924987793)
        liveryNspeedo = 24
        liverySteed2 = 0
        liveryTaco2 = 0
        liveryBoxville7 = 0
        liveryFoodbike = 0
        listVeh = {
            headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_pearl.webp',
            headerIcon = 'assets/icons/voiture-icon.png',
            headerIconName = 'VEHICULES',
            callbackName = 'vehMenu',
            elements = {
                {
                    id = 1,
                    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/BlackWood/nspeedo.webp',
                    label = 'Speedo',
                    name = "nspeedo"
                },
            }
        }
    end
    posRestaurant = {
        { name = "coffre_"..jobName, pos = posCoffre,
            action = function()
                if restaurantService then
                    OpenInventorySocietyMenu(coffreCapacity)
                else
                    -- ShowNotification("~r~Vous n'êtes pas en service")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous n'êtes ~s pas en service"
                    })

                end
            end },
        { name = "gestion_"..jobName, pos = posGestion,
            action = function()
                if restaurantService then
                    OpenSocietyMenu()
                else
                    -- ShowNotification("~r~Vous n'êtes pas en service")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous n'êtes ~s pas en service"
                    })

                end
            end },
        { name = "menuVeh_"..jobName, pos = garageMenuPos,
            action = function()
                if restaurantService then
                    OpenMenuVeh()
                else
                    -- ShowNotification("~r~Vous n'êtes pas en service")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous n'êtes ~s pas en service"
                    })

                end
            end },
            
            { name = "casier_"..jobName, pos = posCasier,
                action = function()
                    if restaurantService then
                        OpenRestaurantCasier()
                    else
                        -- ShowNotification("~r~Vous n'êtes pas en service")

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'ROUGE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous n'êtes ~s pas en service"
                        })

                    end
            end },
    }
    
    for key, v in pairs(posRestaurant) do
        zone.addZone(
            v.name,
            v.pos,
            "Appuyer sur ~INPUT_CONTEXT~ pour intéragir",
            function()
                v.action()
            end,
            true,
            25, -- Id / type du marker
            0.6, -- La taille
            { 51, 204, 255 }, -- RGB
            170-- Alpha
        )
    end


    ---casier
    local casierOpen = false
    function OpenRestaurantCasier()
        if not casierOpen then
            casierOpen = true

            CreateThread(function()
                while casierOpen do
                    Wait(0)
                    DisableControlAction(0, 1, casierOpen)
                    DisableControlAction(0, 2, casierOpen)
                    DisableControlAction(0, 142, casierOpen)
                    DisableControlAction(0, 18, casierOpen)
                    DisableControlAction(0, 322, casierOpen)
                    DisableControlAction(0, 106, casierOpen)
                    DisableControlAction(0, 24, true) -- disable attack
                    DisableControlAction(0, 25, true) -- disable aim
                    DisableControlAction(0, 263, true) -- disable melee
                    DisableControlAction(0, 264, true) -- disable melee
                    DisableControlAction(0, 257, true) -- disable melee
                    DisableControlAction(0, 140, true) -- disable melee
                    DisableControlAction(0, 141, true) -- disable melee
                    DisableControlAction(0, 142, true) -- disable melee
                    DisableControlAction(0, 143, true) -- disable melee
                end
            end)
            SetNuiFocusKeepInput(true)
            SetNuiFocus(true, true)
            Citizen.CreateThread(function()
                SendNUIMessage({
                    type = "openWebview",
                    name = "Casiers",
                    data = {
                        count = 60,
                    },
                })
            end)
        else
            casierOpen = false
            SetNuiFocusKeepInput(false)
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
            EnableControlAction(0, 142, true)
            EnableControlAction(0, 18, true)
            EnableControlAction(0, 322, true)
            EnableControlAction(0, 106, true)
            SetNuiFocus(false, false)
            SendNuiMessage(json.encode({
                type = 'closeWebview',
            }))
            return
        end
    end

    RegisterNUICallback("focusOut", function(data, cb)
        TriggerScreenblurFadeOut(0.5)
        casierOpen = false
        SetNuiFocusKeepInput(false)
        EnableControlAction(0, 1, true)
        EnableControlAction(0, 2, true)
        EnableControlAction(0, 142, true)
        EnableControlAction(0, 18, true)
        EnableControlAction(0, 322, true)
        EnableControlAction(0, 106, true)
        SetNuiFocus(false, false)
        openRadarProperly()
        DisplayHud(true)
        cb({})
    end)

    RegisterNUICallback("casier__callback", function(data)
        local casier = TriggerServerCallback("core:GetAllCasierByJob", pJob)
        if casier == nil then
            TriggerServerEvent("core:CreateNewCasier", token, pJob, data.numero)
            casier = TriggerServerCallback("core:GetAllCasierByJob", pJob)
        end

        if casier ~= nil and casier[data.numero] == nil then
            TriggerServerEvent("core:CreateNewCasier", token, pJob, data.numero)
            casier = TriggerServerCallback("core:GetAllCasierByJob", pJob)
        end

        if casier ~= nil and casier[data.numero] ~= nil then
            OpenInventoryCasier(pJob, data.numero)
        end
    end)

    function OpenMenuVeh()
        forceHideRadar()
            SendNuiMessage(json.encode({
                type = 'openWebview',
                name = 'MenuCatalogue',
                data = listVeh
            }))
    end



    zone.addZone(
        jobName.."_delete", garageDespawn, "Appuyer sur ~INPUT_CONTEXT~ pour ranger le véhicule",
        function()
            if IsPedInAnyVehicle(p:ped(), false) then
                if GetVehicleBodyHealth(p:currentVeh()) / 10 >= 80 or
                    GetVehicleEngineHealth(p:currentVeh()) / 10 >= 80 then
                    local veh = GetVehiclePedIsIn(p:ped(), false)
                    removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                    TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                    TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                    DeleteEntity(veh)
                else
                    -- ShowNotification("~r~Votre véhicule est trop abimé")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Votre véhicule est ~s trop abimé"
                    })

                end
            end
        end,
        true,
        36, 0.5, { 255, 0, 0 }, 255
    )

    local openRadial = false
    local function CloseRadial()
        openRadial = false
        SetNuiFocusKeepInput(false)
        EnableControlAction(0, 1, true)
        EnableControlAction(0, 2, true)
        EnableControlAction(0, 142, true)
        EnableControlAction(0, 18, true)
        EnableControlAction(0, 322, true)
        EnableControlAction(0, 106, true)
        SetNuiFocus(false, false)
        SendNuiMessage(json.encode({
            type = 'closeWebview'
        }))
    end

    function FactureRestaurant()
        if restaurantService then
            CloseRadial()
            TriggerEvent("nuiPapier:client:startCreation",2)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function SetRestaurantDuty()
        CloseRadial()
        if not restaurantService then
            -- ShowNotification("~g~Vous avez pris votre service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'VERT',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s pris ~c votre service"
            })

            TriggerServerEvent('core:DutyOn', jobName)
            restaurantService = true
            Wait(5000)
        else
            -- ShowNotification("~r~Vous avez quitté votre service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s quitté ~c votre service"
            })

            TriggerServerEvent('core:DutyOff', jobName)
            restaurantService = false
            Wait(5000)
        end
    end

    function CreateAdvert()
        if restaurantService then
            CloseRadial()
            CreateJobAnnonce()
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function StockMenu()
        if restaurantService then
            CloseRadial()
            handleOpenCommandMenu()
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function OpenRadialRestaurant()
        if not openRadial then
            openRadial = true
            closeUI()
            CreateThread(function()
                while openRadial do
                    Wait(0)
                    DisableControlAction(0, 1, openRadial)
                    DisableControlAction(0, 2, openRadial)
                    DisableControlAction(0, 142, openRadial)
                    DisableControlAction(0, 18, openRadial)
                    DisableControlAction(0, 322, openRadial)
                    DisableControlAction(0, 106, openRadial)
                    DisableControlAction(0, 24, true) -- disable attack
                    DisableControlAction(0, 25, true) -- disable aim
                    DisableControlAction(0, 263, true) -- disable melee
                    DisableControlAction(0, 264, true) -- disable melee
                    DisableControlAction(0, 257, true) -- disable melee
                    DisableControlAction(0, 140, true) -- disable melee
                    DisableControlAction(0, 141, true) -- disable melee
                    DisableControlAction(0, 142, true) -- disable melee
                    DisableControlAction(0, 143, true) -- disable melee
                end
            end)
            SetNuiFocusKeepInput(true)
            SetNuiFocus(true, true)
            Wait(200)
            CreateThread(function()
                SendNuiMessage(json.encode({
                    type = 'openWebview',
                    name = 'RadialMenu',
                    data = { elements = {
                        {
                            name = "ANNONCE",
                            icon = "assets/svg/radial/megaphone.svg",
                            action = "CreateAdvert"
                        }, 
                        {
                            name = "FACTURE",
                            icon = "assets/svg/radial/billet.svg",
                            action = "FactureRestaurant"
                        },
                        {
                            name = "PRISE DE SERVICE",
                            icon = "assets/svg/radial/checkmark.svg",
                            action = "SetRestaurantDuty"
                        },
                        {
                            name = "COMMANDE",
                            icon = "assets/svg/radial/carton.svg",
                            action = "StockMenu"
                        }
                    }, title = string.upper(globalData.jobs[p:getJob()].label) }
                }));
            end)
        else
            CloseRadial()
            return
        end
    end

    RegisterJobMenu(OpenRadialRestaurant)
    function UnloadRestaurant()
        for key, v in pairs(posRestaurant) do
            print(v.name)
            zone.removeZone(v.name)
        end
        zone.removeZone(jobName.."_delete")
    end
end

local spawned = false
    RegisterNUICallback("vehMenu", function (data, cb)
        if not spawned then
            spawned = true
            if vehicle.IsSpawnPointClear(garageSpawn.xyz, 3.0) then
                RageUI.CloseAll()
                open = false
                if DoesEntityExist(vehs) then
                    TriggerEvent('persistent-vehicles/forget-vehicle', vehs)
                    removeKeys(GetVehicleNumberPlateText(vehs), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs))))
                    TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(vehs))
                    DeleteEntity(vehs)
                end
                vehs = vehicle.create(data.name, garageSpawn, {})
                local plate = vehicle.getProps(vehs).plate
                local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
                local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
                createKeys(plate, model)
                if data.name == "nspeedo" then
                    SetVehicleLivery(vehs, liveryNspeedo-1)
                    SetVehicleMod(vehs, 48, liveryNspeedo-1)
                elseif data.name == "taco2" then
                    SetVehicleLivery(vehs, liveryTaco2)
                    SetVehicleMod(vehs, 48, liveryTaco2)
                elseif data.name == "steed2" then
                    SetVehicleLivery(vehs, liverySteed2)
                    SetVehicleMod(vehs, 48, liverySteed2)
                elseif data.name == "boxville7" then
                    SetVehicleLivery(vehs, liveryBoxville7)
                    SetVehicleMod(vehs, 48, liveryBoxville7)
                elseif data.name == "foodbike" then
                    SetVehicleLivery(vehs, liveryFoodbike)
                    SetVehicleMod(vehs, 48, liveryFoodbike)
                end
            else
                -- ShowNotification("Il n'y a pas de place pour le véhicule")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Il n'y a ~s pas de place ~c pour le véhicule"
                })

            end
            Wait(50)
            spawned = false
        end
    end)