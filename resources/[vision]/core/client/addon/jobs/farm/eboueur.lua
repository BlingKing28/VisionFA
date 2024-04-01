local inWork = false
local blip = nil
local trashZone = {
    { pos = vector3(-1078.0856933594, -1166.5551757813, 2.1581120491028), passed = false },
    { pos = vector3(-1073.8218994141, -1156.7716064453, 2.1586005687714), passed = false },
    { pos = vector3(-1072.7861328125, -1146.3161621094, 2.1586000919342), passed = false },
    { pos = vector3(-1065.6304931641, -1160.3076171875, 2.1587145328522), passed = false },
    { pos = vector3(-1055.8239746094, -1146.0864257813, 2.1532318592072), passed = false },
    { pos = vector3(-1048.7404785156, -1141.6166992188, 2.1585991382599), passed = false },
    { pos = vector3(-1033.3255615234, -1131.5852050781, 2.1585998535156), passed = false },
    { pos = vector3(-1027.6092529297, -1139.6350097656, 2.1585972309113), passed = false },
    { pos = vector3(-1016.3553466797, -1132.6447753906, 2.1585998535156), passed = false },
    { pos = vector3(-1021.2952880859, -1124.7598876953, 2.1586003303528), passed = false },
    { pos = vector3(-1018.4948730469, -1119.2598876953, 2.1240236759186), passed = false },
    { pos = vector3(-994.58032226563, -1120.1525878906, 2.1514439582825), passed = false },
    { pos = vector3(-983.07696533203, -1104.5001220703, 2.049197435379), passed = false },
    { pos = vector3(-978.865234375, -1111.7239990234, 2.1503126621246), passed = false },
    { pos = vector3(-975.18756103516, -1100.0477294922, 2.1112101078033), passed = false },
    { pos = vector3(-968.58392333984, -1102.2199707031, 2.1503129005432), passed = false },
    { pos = vector3(-963.4228515625, -1089.3184814453, 2.1503121852875), passed = false },
    { pos = vector3(-956.22436523438, -1097.6044921875, 2.1503114700317), passed = false },
    { pos = vector3(-946.11926269531, -1078.1896972656, 2.1503124237061), passed = false },
    { pos = vector3(-932.78509521484, -1071.9927978516, 2.1503126621246), passed = false },
    { pos = vector3(-1170.97265625, -1101.1815185547, 2.4668090343475), passed = false },
    { pos = vector3(-1180.8922119141, -1089.7353515625, 2.2126572132111), passed = false },
    { pos = vector3(-1195.4807128906, -1075.3151855469, 2.1504337787628), passed = false },
    { pos = vector3(-1194.8197021484, -1063.9545898438, 2.1504335403442), passed = false },
    { pos = vector3(-1197.5139160156, -1050.6607666016, 2.1504311561584), passed = false },
    { pos = vector3(-1198.2774658203, -1045.439453125, 2.1504483222961), passed = false },
    { pos = vector3(-1202.97265625, -1032.0179443359, 2.1504321098328), passed = false },
    { pos = vector3(-1177.0379638672, -1110.8784179688, 3.0182590484619), passed = false },
    { pos = vector3(-1168.3035888672, -1110.4732666016, 2.285480260849), passed = false },
    { pos = vector3(-1161.3431396484, -1122.0092773438, 2.2928485870361), passed = false },
    { pos = vector3(-1154.0012207031, -1122.9656982422, 2.3661148548126), passed = false },
    { pos = vector3(-1156.7877197266, -1130.1276855469, 2.6475300788879), passed = false },
    { pos = vector3(-1159.87109375, -1145.5881347656, 2.7157928943634), passed = false },
    { pos = vector3(-1159.1032714844, -1147.8563232422, 2.7157928943634), passed = false },
    { pos = vector3(-1158.9399414063, -1150.5266113281, 2.7963535785675), passed = false },
    { pos = vector3(-1146.2373046875, -1148.5965576172, 2.8188257217407), passed = false },
    { pos = vector3(-1139.712890625, -1151.9177246094, 2.8034248352051), passed = false },
    { pos = vector3(-1148.5539550781, -1165.3946533203, 2.5292744636536), passed = false },
    { pos = vector3(-1137.3929443359, -1172.2781982422, 2.4857649803162), passed = false },
    { pos = vector3(-1131.0150146484, -1165.3996582031, 2.697990655899), passed = false },
    { pos = vector3(-1157.5745849609, -1090.2160644531, 2.1548025608063), passed = false },
    { pos = vector3(-1161.4470214844, -1082.2076416016, 2.1548199653625), passed = false },
    { pos = vector3(-1128.8912353516, -1063.2081298828, 2.1503596305847), passed = false },
    { pos = vector3(-1121.7373046875, -1072.0921630859, 2.1503596305847), passed = false },
    { pos = vector3(-1123.0246582031, -1068.2436523438, 2.1002526283264), passed = false },
    { pos = vector3(-1120.2957763672, -1067.0375976563, 2.1108808517456), passed = false },
    { pos = vector3(-1120.9028320313, -1058.8052978516, 2.1503591537476), passed = false },
    { pos = vector3(-1111.5093994141, -1051.5010986328, 2.1503565311432), passed = false },
    { pos = vector3(-1105.6375732422, -1060.7425537109, 2.1503596305847), passed = false },
    { pos = vector3(-1101.9027099609, -1048.5068359375, 2.1503593921661), passed = false },
    { pos = vector3(-1096.2144775391, -1054.4127197266, 2.1503591537476), passed = false },
    { pos = vector3(-1092.5607910156, -1050.6463623047, 2.1331672668457), passed = false },
    { pos = vector3(-1083.0710449219, -1037.8131103516, 2.150269985199), passed = false },
    { pos = vector3(-1071.9500732422, -1030.9095458984, 2.149694442749), passed = false },
    { pos = vector3(-1054.5958251953, -1016.8218383789, 2.106751203537), passed = false },
    { pos = vector3(-1047.8489990234, -1015.0192871094, 2.1503593921661), passed = false },
    { pos = vector3(-1043.3082275391, -1024.5168457031, 2.1503567695618), passed = false },
    { pos = vector3(-1036.1427001953, -1003.5972900391, 2.1501915454865), passed = false },
    { pos = vector3(-1017.2169189453, -1014.9962158203, 2.1503579616547), passed = false },
    { pos = vector3(-991.42199707031, -993.49261474609, 2.1503093242645), passed = false },
    { pos = vector3(-990.35235595703, -995.29467773438, 2.1503093242645), passed = false },
    { pos = vector3(-1171.9685058594, -969.58319091797, 3.7885992527008), passed = false },
    { pos = vector3(-1168.5543212891, -967.78894042969, 3.5109498500824), passed = false },
    { pos = vector3(-1163.935546875, -981.08813476563, 2.1501953601837), passed = false },
    { pos = vector3(-1164.2086181641, -985.35614013672, 2.150194644928), passed = false },
    { pos = vector3(-1158.0557861328, -989.32476806641, 2.151444196701), passed = false },
    { pos = vector3(-1185.7592773438, -940.6533203125, 3.8678612709045), passed = false },
    { pos = vector3(-1187.5833740234, -938.376953125, 3.8760628700256), passed = false },
    { pos = vector3(-1178.1188964844, -945.92712402344, 3.2715363502502), passed = false },
    { pos = vector3(-1147.1800537109, -955.17175292969, 2.6581847667694), passed = false },
    { pos = vector3(-1139.9114990234, -951.60943603516, 2.6506371498108), passed = false },
    { pos = vector3(-1131.4510498047, -971.25054931641, 2.1501953601837), passed = false },
    { pos = vector3(-1126.3132324219, -979.80444335938, 2.1501948833466), passed = false },
    { pos = vector3(-1115.2412109375, -967.28283691406, 2.1544864177704), passed = false },
    { pos = vector3(-1104.193359375, -965.89227294922, 2.4196088314056), passed = false },
    { pos = vector3(-1127.1744384766, -943.55834960938, 2.6416962146759), passed = false },
    { pos = vector3(-1134.9775390625, -921.21075439453, 2.7005558013916), passed = false },
    { pos = vector3(-1138.9392089844, -921.17956542969, 2.6589217185974), passed = false },
    { pos = vector3(-1145.6337890625, -916.83618164063, 2.6986422538757), passed = false },
    { pos = vector3(-1146.4680175781, -915.15832519531, 2.6992638111115), passed = false },
    { pos = vector3(-1114.4771728516, -911.50982666016, 2.6090290546417), passed = false },
    { pos = vector3(-1081.2032470703, -936.11413574219, 2.45614361763), passed = false },
    { pos = vector3(-873.04632568359, -1077.9744873047, 2.1578781604767), passed = false },
    { pos = vector3(-867.11413574219, -1086.1950683594, 2.1628775596619), passed = false },
    { pos = vector3(-862.421875, -1095.6021728516, 2.1629998683929), passed = false },
    { pos = vector3(-845.60357666016, -1063.0856933594, 9.7489318847656), passed = false },
    { pos = vector3(-842.71099853516, -1046.8077392578, 11.560258865356), passed = false },
    { pos = vector3(-835.005859375, -1071.6153564453, 11.42299079895), passed = false },
    { pos = vector3(-833.91680908203, -1066.3728027344, 11.234926223755), passed = false },
    { pos = vector3(-835.84832763672, -1067.4312744141, 11.141626358032), passed = false },
    { pos = vector3(-840.61077880859, -1070.9151611328, 10.864756584167), passed = false },
    { pos = vector3(-842.06915283203, -1072.6462402344, 10.825216293335), passed = false },
    { pos = vector3(-844.11706542969, -1074.6612548828, 10.775274276733), passed = false },
    { pos = vector3(-814.86560058594, -1107.1556396484, 11.168999671936), passed = false },
    { pos = vector3(-822.923828125, -1093.5773925781, 11.14321231842), passed = false },
    { pos = vector3(-813.76263427734, -1077.4729003906, 11.132590293884), passed = false },
    { pos = vector3(-842.740234375, -1125.677734375, 7.0617837905884), passed = false },
    { pos = vector3(-845.52282714844, -1113.4528808594, 7.0608139038086), passed = false },
    { pos = vector3(-847.20208740234, -1111.9909667969, 7.0627937316895), passed = false },
    { pos = vector3(-849.03692626953, -1112.4909667969, 7.0623664855957), passed = false },
    { pos = vector3(-878.16009521484, -1138.80078125, 5.6866593360901), passed = false },
    { pos = vector3(-878.83056640625, -1139.5541992188, 5.7006893157959), passed = false },
    { pos = vector3(-883.33715820313, -1141.8706054688, 5.7746262550354), passed = false },
    { pos = vector3(-885.03851318359, -1142.9990234375, 5.8044738769531), passed = false },
    { pos = vector3(-904.78204345703, -1145.6300048828, 6.1296429634094), passed = false },
    { pos = vector3(-896.54174804688, -1145.7373046875, 6.0021257400513), passed = false },
    { pos = vector3(-913.451171875, -1170.3870849609, 4.8960990905762), passed = false },
    { pos = vector3(-920.60906982422, -1160.1514892578, 4.772084236145), passed = false },
    { pos = vector3(-877.77661132813, -1198.2911376953, 4.8641066551208), passed = false },
    { pos = vector3(-740.85949707031, -1130.9505615234, 10.600107192993), passed = false },
    { pos = vector3(-736.96514892578, -1136.8917236328, 10.609148025513), passed = false },
    { pos = vector3(-714.20233154297, -1133.7504882813, 10.813073158264), passed = false },
    { pos = vector3(-708.74938964844, -1139.7879638672, 10.812965393066), passed = false },
    { pos = vector3(-711.0615234375, -1141.7080078125, 10.813086509705), passed = false },
    { pos = vector3(-635.80383300781, -1226.0693359375, 11.916346549988), passed = false },
    { pos = vector3(-634.04547119141, -1225.2448730469, 12.106046676636), passed = false },
    { pos = vector3(-785.30346679688, -1353.8825683594, 5.1502695083618), passed = false },
    { pos = vector3(-783.04132080078, -1365.4989013672, 5.1502394676208), passed = false },
    { pos = vector3(-777.15942382813, -1365.6400146484, 5.0005264282227), passed = false },
    { pos = vector3(-766.14459228516, -1347.8366699219, 5.0005221366882), passed = false },
    { pos = vector3(-798.23773193359, -1385.9471435547, 5.000518321991), passed = false },
    { pos = vector3(-817.96759033203, -1382.4185791016, 5.0005593299866), passed = false },
    { pos = vector3(-830.31329345703, -1361.0059814453, 5.0015206336975), passed = false },
    { pos = vector3(-827.46514892578, -1358.5751953125, 5.0005240440369), passed = false },
    { pos = vector3(-822.89825439453, -1340.5864257813, 5.1511259078979), passed = false },
    { pos = vector3(-828.43048095703, -1339.5678710938, 5.1055002212524), passed = false },
    { pos = vector3(-826.03198242188, -1335.3643798828, 5.1034851074219), passed = false },
    { pos = vector3(-846.23486328125, -1317.5864257813, 5.000394821167), passed = false },
    { pos = vector3(-881.54888916016, -1321.3455810547, 5.00017786026), passed = false },
    { pos = vector3(-840.529296875, -1262.1451416016, 5.1501770019531), passed = false },
    { pos = vector3(-842.02478027344, -1260.9909667969, 5.1501770019531), passed = false },
    { pos = vector3(-863.55914306641, -1267.8823242188, 5.1501150131226), passed = false },
    { pos = vector3(-865.69525146484, -1282.2125244141, 5.1501760482788), passed = false },
    { pos = vector3(-899.69293212891, -1294.8591308594, 5.201557636261), passed = false },
    { pos = vector3(1099.2683105469, -775.56927490234, 58.347629547119), passed = false },
    { pos = vector3(1132.9421386719, -790.45672607422, 57.598686218262), passed = false },
    { pos = vector3(1149.8099365234, -437.68432617188, 67.000709533691), passed = false },
    { pos = vector3(1141.9675292969, -425.19683837891, 67.291801452637), passed = false },
    { pos = vector3(1146.3331298828, -409.07577514648, 67.301338195801), passed = false },
    { pos = vector3(1153.1531982422, -383.44342041016, 67.305671691895), passed = false },
    { pos = vector3(1115.7344970703, -344.45556640625, 67.096984863281), passed = false },
    { pos = vector3(1118.3107910156, -342.87686157227, 67.111030578613), passed = false },
    { pos = vector3(1130.1779785156, -317.18954467773, 67.074760437012), passed = false },
    { pos = vector3(1132.8021240234, -316.65042114258, 67.08422088623), passed = false },
    { pos = vector3(1167.9025878906, -318.47817993164, 69.327491760254), passed = false },
    { pos = vector3(1167.3333740234, -316.24978637695, 69.328956604004), passed = false },
    { pos = vector3(1177.740234375, -304.84222412109, 68.997398376465), passed = false },
    { pos = vector3(1182.5131835938, -304.15933227539, 69.112854003906), passed = false },
    { pos = vector3(1244.9989013672, -348.34097290039, 69.201927185059), passed = false },
    { pos = vector3(1239.2755126953, -404.99896240234, 69.014518737793), passed = false },
    { pos = vector3(1236.1853027344, -414.22283935547, 68.925567626953), passed = false },
    { pos = vector3(1237.7459716797, -458.35150146484, 66.685890197754), passed = false },
    { pos = vector3(1229.0943603516, -474.02334594727, 66.541954040527), passed = false },
    { pos = vector3(1229.3986816406, -489.7702331543, 66.422500610352), passed = false },
    { pos = vector3(269.96304321289, 311.51837158203, 105.54482269287), passed = false },
    { pos = vector3(349.8359375, 340.59625244141, 105.20143127441), passed = false },
    { pos = vector3(314.01516723633, 363.54125976563, 105.41466522217), passed = false },
    { pos = vector3(309.6032409668, 344.22741699219, 105.29510498047), passed = false },
    { pos = vector3(397.37979125977, 289.92358398438, 102.94876861572), passed = false },
    { pos = vector3(366.56146240234, 256.04968261719, 103.00476837158), passed = false },
    { pos = vector3(340.96975708008, 262.41384887695, 103.34279632568), passed = false },
    { pos = vector3(267.43170166016, 276.10629272461, 105.62521362305), passed = false },
    { pos = vector3(174.9188079834, 306.49240112305, 105.37043762207), passed = false },
    { pos = vector3(102.01104736328, 318.16796875, 112.09503936768), passed = false },
    { pos = vector3(98.014350891113, 298.31951904297, 110.00287628174), passed = false },
    { pos = vector3(143.29800415039, 195.24626159668, 106.58731842041), passed = false },
    { pos = vector3(134.86845397949, 170.10746765137, 105.08863830566), passed = false },
    { pos = vector3(97.768600463867, 159.88031005859, 104.65162658691), passed = false },
    { pos = vector3(-176.51243591309, 298.23461914063, 93.763877868652), passed = false },
    { pos = vector3(-42.270709991455, -1757.9427490234, 29.491668701172), passed = false },
    { pos = vector3(-43.648281097412, -1759.5430908203, 29.491668701172), passed = false },
    { pos = vector3(-11.245405197144, -1813.3521728516, 25.899271011353), passed = false },
    { pos = vector3(-12.848200798035, -1813.6571044922, 25.899271011353), passed = false },
    { pos = vector3(1.211553812027, -1824.9361572266, 25.350902557373), passed = false },
    { pos = vector3(42.82755279541, -1877.7679443359, 22.407220840454), passed = false },
    { pos = vector3(76.66487121582, -1930.0231933594, 20.833595275879), passed = false },
    { pos = vector3(118.20948791504, -1943.9063720703, 20.662490844727), passed = false },
    { pos = vector3(130.42192077637, -1886.2780761719, 23.512687683105), passed = false },
    { pos = vector3(156.58460998535, -1816.9578857422, 28.101402282715), passed = false },
    { pos = vector3(158.7522277832, -1818.8430175781, 28.099878311157), passed = false },
    { pos = vector3(187.8233795166, -1846.5268554688, 27.196092605591), passed = false },
    { pos = vector3(192.18350219727, -1812.6793212891, 28.712373733521), passed = false },
    { pos = vector3(222.87991333008, -1838.4753417969, 27.041521072388), passed = false },
    { pos = vector3(231.08604431152, -1847.8754882813, 26.846466064453), passed = false },
    { pos = vector3(109.89598083496, -1746.1656494141, 29.203302383423), passed = false },
    { pos = vector3(95.942611694336, -1687.4254150391, 29.209894180298), passed = false },
    { pos = vector3(100.27949523926, -1691.9611816406, 29.201469421387), passed = false },
    { pos = vector3(139.84326171875, -1724.2156982422, 29.208915710449), passed = false },
    { pos = vector3(149.29614257813, -1729.0311279297, 29.261316299438), passed = false },
    { pos = vector3(196.91796875, -1758.2899169922, 29.151424407959), passed = false },
    { pos = vector3(196.21704101563, -1771.6259765625, 29.210258483887), passed = false },
    { pos = vector3(198.22457885742, -1772.6848144531, 29.219163894653), passed = false },
    { pos = vector3(250.8755645752, -1810.8140869141, 27.111734390259), passed = false },
    { pos = vector3(252.60217285156, -1820.7337646484, 26.86155128479), passed = false },
    { pos = vector3(285.87216186523, -1812.4267578125, 27.128637313843), passed = false },
    { pos = vector3(356.75177001953, -1869.2800292969, 26.888076782227), passed = false },
    { pos = vector3(392.88046264648, -1813.9512939453, 28.994853973389), passed = false },
    { pos = vector3(391.29937744141, -1815.3740234375, 28.999164581299), passed = false },
    { pos = vector3(433.33285522461, -1878.6943359375, 27.047185897827), passed = false },
    { pos = vector3(422.40518188477, -1883.4189453125, 26.515943527222), passed = false },
    { pos = vector3(412.29965209961, -1900.9000244141, 25.607164382935), passed = false },
    { pos = vector3(414.1369934082, -1902.9580078125, 25.581750869751), passed = false },
    { pos = vector3(396.79797363281, -1924.3736572266, 24.775852203369), passed = false },
    { pos = vector3(339.74468994141, -1973.8143310547, 24.279346466064), passed = false },
    { pos = vector3(342.20684814453, -2092.1665039063, 18.58801651001), passed = false },
    { pos = vector3(305.13021850586, -2102.2497558594, 17.583282470703), passed = false },
    { pos = vector3(303.24026489258, -2103.0712890625, 17.423442840576), passed = false },
    { pos = vector3(218.24041748047, -2012.0931396484, 18.908777236938), passed = false },
    { pos = vector3(248.99800109863, -1965.0904541016, 21.960519790649), passed = false },
}
local savedPos = {}
local startPos = vector3(-425.53598022461, -1689.9555664063, 18.744178771973)
local props = {
    prop = "hei_prop_heist_binbag",
    offset = { 0.049, 0.034, -0.025, 0, -100.4, 0.0 }
}
local workObj = nil
local veh = nil
local recup = false
local inCamion = false
local numberOfAction = 0
local totalPrice = 0
local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local function IsPlayerInCamion()
    if GetEntityModel(p:currentVeh()) == GetHashKey("trash2") then
        return true
    else
        return false
    end
end

local function GetPoint()
    if next(savedPos) then
        local random = math.random(1, #savedPos)
        local point = savedPos[random]
        if point.passed then
            return false
        else
            return random, point
        end
        return false
    end
    return false
end

function StopJobCourse()
    if workObj then
        workObj:delete()
    end
    savedPos = {}
    RemoveBlip(blip)
    if veh then
        TriggerEvent('persistent-vehicles/forget-vehicle', veh)
        print("1")
        removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
        TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
        DeleteEntity(veh)
    end
    blip = nil
    workObj = nil
    TriggerSecurEvent('core:eboueurEndDuty', totalPrice) --TODO: edit this
    totalPrice = 0
end

function TakeEboueurService()
    local alrdyTakeService = TriggerServerCallback("core:getIfAlrdyTakeService", token)
    print(alrdyTakeService, inWork)
    if alrdyTakeService and inWork then
        StopJobCourse()
        inWork = false
        return
    else
        if p:haveEnoughMoney(100) then
            inWork = true
            TriggerServerEvent('core:eboueurStartDuty', token)
            local outPos = vector4(-425.53598022461, -1689.9555664063, 18.744178771973, 158.12982177734)
            veh = vehicle.create("trash2", outPos, {})
            local plate = vehicle.getProps(veh).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, veh, VehToNet(veh), p:getJob())
            createKeys(plate, model)
            p:pay(100)
            -- ShowNotification("Une caution de 100$ a été prélevée pour votre camion.")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'DOLLAR',
                -- duration = 5, -- In seconds, default:  4
                content = "Une ~s caution de 100$ ~c a été prélevée pour votre camion."
            })

            TaskWarpPedIntoVehicle(p:ped(), veh, -1)

            -- create a deepcopy of trashzone in savedpos
            for i = 1, #trashZone do
                savedPos[i] = trashZone[i]
            end
            while not IsPedInAnyVehicle(PlayerPedId()) do Wait(1) end
            Wait(500)
            Citizen.CreateThread(function()
                while IsPlayerInCamion() do
                    local key, v = GetPoint()

                    recup = false
                    inCamion = false

                    if key ~= false and numberOfAction < 100 and v then
                        blip = AddBlipForCoord(v.pos)
                        SetBlipRoute(blip, true)

                        while #(p:pos() - v.pos) > 10.0 and inWork do
                            Visual.Subtitle("Dirigez-vous vers le prochain point - " .. math.floor(#(p:pos() - v.pos)) .. "m", 60)
                            Wait(50)
                        end

                        if not inWork then
                            StopJobCourse()
                            break
                        end

                        while #(p:pos() - v.pos) <= 10.0 and inWork and IsPlayerInCamion() do
                            Visual.Subtitle("Descendez du camion pour aller récupérer la poubelle", 60)
                            Wait(50)
                        end

                        if not inWork then
                            StopJobCourse()
                            break
                        end

                        while #(p:pos() - v.pos) < 100 and inWork and not recup do
                            Visual.Subtitle("Récupérez la poubelle puis mettez-la a l'arrière du camion", 60)
                            DrawMarker(20, v.pos, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 9, 151, 227, 255, 0, 0, 0, 0)
                            if #(p:pos() - v.pos) < 3.5 then
                                ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récupérer la poubelle")
                                if IsControlJustPressed(0, 38) then
                                    SetBlipCoords(blip,
                                        GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "platelight")) +
                                        vector3(0.0, 0.0, 0.5))
                                    p:PlayAnim("anim@heists@narcotics@trash", "throw_b", 49)
                                    Wait(1000)
                                    ClearPedTasksImmediately(p:ped())
                                    local obj = entity:CreateObject(props.prop, p:pos())
                                    AttachEntityToEntity(obj:getEntityId(), p:ped(),
                                        GetEntityBoneIndexByName(p:ped(), "IK_R_Hand"), props.offset[1], props.offset[2],
                                        props.offset[3], props.offset[4], props.offset[5], props.offset[6], false, false,
                                        false, false, 0.0, true)
                                    p:PlayAnim("anim@heists@narcotics@trash", "walk", 49)
                                    workObj = obj
                                    recup = true
                                end
                            end
                            Wait(1)
                        end

                        while inWork and recup and not inCamion do
                            Visual.Subtitle("Récupérez la poubelle puis mettez-la a l'arrière du camion", 60)
                            DrawMarker(20,
                                GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "platelight")) +
                                vector3(0.0, 0.0, 0.5), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 9, 151, 227, 255, 0, 0,
                                0, 0)
                            -- TaskPlayAnim(p:ped(), "anim@heists@narcotics@trash", "walk", 1.0, -1.0, -1, 3, 0, 0, 0, 0)
                            if #
                                (
                                p:pos() - GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "platelight")) +
                                    vector3(0.0, 0.0, 0.5)) < 1.5 then
                                ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour mettre la poubelle dans le camion")
                                if IsControlJustPressed(0, 38) then
                                    SetVehicleDoorOpen(veh, 5, false, false)
                                    p:PlayAnim("anim@heists@narcotics@trash", "throw_b", 49)
                                    Wait(1000)
                                    workObj:delete()
                                    workObj = nil
                                    ClearPedTasksImmediately(p:ped())
                                    exports['vNotif']:createNotification({
                                        type = 'JAUNE',
                                        content = "Retournez dans le camion pour avoir le prochain point"
                                    })
                                    SetVehicleDoorShut(veh, 5, false)
                                    inCamion = true
                                    recup = false
                                    totalPrice = totalPrice + math.random(35, 50)
                                    numberOfAction = numberOfAction + 1
                                end
                            end
                            Wait(1)
                        end

                        while inWork and inCamion and not IsPedInVehicle(p:ped(), veh) do
                            Visual.Subtitle("Remontez dans le camion", 60)
                            table.remove(savedPos, key)
                            RemoveBlip(blip)
                            blip = nil
                            Wait(50)
                        end
                    else
                        blip = AddBlipForCoord(startPos)
                        SetBlipRoute(blip, true)

                        while #(p:pos() - startPos) > 5.0 and IsPlayerInCamion() do
                            Visual.Subtitle("Service terminé, retournez à l'entreprise pour rendre votre camion", 60)
                            Wait(50)
                        end

                        while #(p:pos() - startPos) <= 5.0 and IsPlayerInCamion() do
                            ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger votre camion")
                            if IsControlJustPressed(0, 38) then
                                TriggerSecurGiveEvent("core:addItemToInventory", token, "money", 100, {})
                                -- ShowNotification("la caution de 100$ vous a été rendue.")

                                -- New notif
                                exports['vNotif']:createNotification({
                                    type = 'DOLLAR',
                                    -- duration = 5, -- In seconds, default:  4
                                    content = "La ~s caution de 100$ ~c vous a été ~s rendue."
                                })

                                Visual.PromptDuration(10000, "Rangement du camion ...", 1)
                                RemoveBlip(blip)
                                Wait(2000)
                                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                                DeleteEntity(veh)
                                veh = nil
                                RemoveBlip(blip)
                                Visual.PromptDuration(1, "Rangement du camion ...", 1)
                                exports['vNotif']:createNotification({
                                    type = 'DOLLAR',
                                    -- duration = 5, -- In seconds, default:  4
                                    content = "Va voir le patron pour récupérer ta ~s paye ~c et finir ton ~s service ~c !"
                                })
                            end
                            Wait(1)
                        end
                    end
                    Wait(300)
                end
            end)
        else
            -- ShowNotification("Vous n'avez pas assez d'argent")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Vous n'avez pas assez d'argent"
            })

        end
    end --e
end

Citizen.CreateThread(function()
    while zone == nil do Wait(1) end

    zone.addZone(
        "eboueur_job", -- Nom
        vector3(-428.890625, -1728.0677490234, 19.783836364746), -- Position
        "Appuyer sur ~INPUT_CONTEXT~ pour prendre/arrêter votre service", -- Text afficher
        function() -- Action qui seras fait
            TakeEboueurService()
        end,
        false
    )

    local ped = entity:CreatePedLocal("s_m_y_garbage", vector3(-428.890625, -1728.0677490234, 18.783836364746),
        71.37141418457)

    SetEntityInvincible(ped.id, true)
    ped:setFreeze(true)
    TaskStartScenarioInPlace(ped.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
    SetEntityAsMissionEntity(ped.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped.id, true)
end)

