local hasspawned = true
local resourceplayer = 0
local servresources = 0
local TimerAimbot = 0
local counttriggerbot = 0
local ischeckingScreen = false
local GlobalMode = "active"

local NetworkIsPlayerActive = NetworkIsPlayerActive
local GetEntityModel = GetEntityModel
local PlayerPedId = PlayerPedId
local DeleteEntity = DeleteEntity
local GetEntityCoords = GetEntityCoords

varMain = {
    discord = "", ---@private
}

CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do Wait(1) end 
    TriggerServerEvent("swac:playerActive")
    TriggerServerEvent("sw:amisuspect")
    Wait(2000)
    TriggerServerEvent("ask:data:sw")
end)

ServerCallbacks = {}

CurrentRequestId = 0

TriggerServerCallback = function(name, cb, ...)
    ServerCallbacks[CurrentRequestId] = cb
    TriggerServerEvent('tsc:ws:sw', name, CurrentRequestId, ...) -- trigger server callback
    if CurrentRequestId < 65535 then
        CurrentRequestId = CurrentRequestId + 1
    else
        CurrentRequestId = 0
    end
end

RegisterNetEvent('swcallbppp')
AddEventHandler('swcallbppp', function(requestId, ...)
    if not requestId then return end
    ServerCallbacks[requestId](...)
    ServerCallbacks[requestId] = nil
end)

RegisterNetEvent("receive:data:sw", function(chosenStatus)
    GlobalMode = chosenStatus
end)

RegisterNUICallback("nuicallback", function()
    if Cfg.AntiNUIDevTools == true then
        TriggerServerEvent("sw:detect9999", CfgSH.ReasonNUIDevTool, "nui", Cfg.KickOrBanDevTools, "NUIDevTools")
    end
end)

AddEventHandler("onClientResourceStop", function(resourceName)
    if Cfg.AntiResourceStopRestart == true then
        --TriggerServerCallback("checkserversideresourceName", function(cb)
        --    if cb then 
        TriggerServerEvent("sw:detect9999", string.format(CfgSH.ReasonResourceStop, "stop", resourceName), nil, nil, "ResourceStop")
        --    end
        --end, resourceName, "stop")
    end
end)

--AddEventHandler("onClientResourceStart", function(resourceName)
--    if Cfg.AntiResourceStopRestart == true then
--        TriggerServerCallback("checkserversideresourceName", function(cb)
--            if cb then 
--                TriggerServerEvent("sw:detect9999", string.format(CfgSH.ReasonResourceStop, "start", resourceName), nil, nil, "ResourceStop")
--            end
--        end, resourceName, "start")
--    end
--end)     

local function PrendsLeJouerParLIDDuPed(id)
    for _, i in ipairs(GetActivePlayers()) do
        if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == id) then return i end
    end
    return nil
end
    
local function DemandeEtSupprime(object, detach)
    if DoesEntityExist(object) then
        NetworkRequestControlOfEntity(object)
        Wait(500)
        if detach then
            DetachEntity(object, 0, false)
        end
        SetEntityCollision(object, false, false)
        SetEntityAlpha(object, 0.0, true)
        SetEntityAsMissionEntity(object, true, true)
        SetEntityAsNoLongerNeeded(object)
        DeleteEntity(object)
        if NetworkGetEntityOwner(object) ~= nil then
            if PrendsLeJouerParLIDDuPed(NetworkGetEntityOwner(object)) then
                TriggerServerEvent("sw:detect9999", string.format(CfgSH.ReasonCreatingObj, GetEntityModel(object)), nil, nil, "ObjectCreation")
            end
        end
    end
end

local function GetVehiculesDansLarea()
    local TableC = {}
    local TableID = 1
    local handle, veh = FindFirstVehicle()
        repeat
            TableC[TableID] = veh
            TableID = TableID+1
            success, veh = FindNextVehicle(handle)
        until not success
        EndFindVehicle(handle)

    return TableC
end

local function GetPickupDansLarea()
    local TableC = {}
    local TableID = 1
    local handle, pickup = FindFirstPickup()
        repeat
            TableC[TableID] = pickup
            TableID = TableID+1
            success, pickup = FindNextPickup(handle)
        until not success
        EndFindPickup(handle)

    return TableC
end

local function GetJoueurDansLarea()
    local TableP = {}
    local TableID = 1
    local handle, ped = FindFirstPed()
        repeat
            TableP[TableID] = ped
            TableID = TableID+1
            success, ped = FindNextPed(handle)
        until not success
        EndFindPed(handle)

    return TableP
end

local cheatspectator = false

local entNum = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end
        
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entNum)
        
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
        
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

RegisterNetEvent("ddqkld:sw:changemod", function(mood)
    GlobalMode = mood
end)

local function RotToDirection(rot)
    local radiansZ = rot.z * 0.0174532924
    local radiansX = rot.x * 0.0174532924
    local num = math.abs(math.cos(radiansX))
    local dir = vector3(-math.sin(radiansZ) * num, math.cos(radiansZ * num), math.sin(radiansX))
    return dir
end

local function add(a, b)
    local result = vector3(a.x + b.x, a.y + b.y, a.z + b.z)

    return result
end

local function multiply(coords, coordz)
    local result = vector3(coords.x * coordz, coords.y * coordz, coords.z * coordz)

    return result
end

local function GetDistance(pointA, pointB)

    local aX = pointA.x
    local aY = pointA.y
    local aZ = pointA.z

    local bX = pointB.x
    local bY = pointB.y
    local bZ = pointB.z

    local xBA = bX - aX
    local yBA = bY - aY
    local zBA = bZ - aZ

    local y2 = yBA * yBA
    local x2 =  xBA * xBA
    local sum2 = y2 + x2

    return math.sqrt(sum2 + zBA)
end

function EnoumLesVehicules()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnoumLesGens()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

local function getsendResourceList()
    local resourceList = {}
    for i=0,GetNumResources()-1 do
        resourceList[i+1] = GetResourceByFindIndex(i)
        Wait(500)
    end
    Wait(5000)
    TriggerServerEvent("sw:resc", resourceList)
end

--------------------------------------------------------------------------------------------------------------------------------    
--------------------------------------------------------------------------------------------------------------------------------    
--------------------------------------------------------------------------------------------------------------------------------    
--------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------  BOUCLES    ---------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------    
--------------------------------------------------------------------------------------------------------------------------------    
--------------------------------------------------------------------------------------------------------------------------------    
--------------------------------------------------------------------------------------------------------------------------------    
if Cfg.AntiTextures then
    CreateThread(function()
        while true do
            Wait(4000)
            for k,v in pairs(Cfg.BlackListedTextures) do 
                if GetStatusOfTextureDownload(v) == 0 then
                    TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Texture blacklist : " .. v), nil, nil, "AntiTextures")
                end
            end
        end
    end)
end

CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do Wait(1) end
    Wait(2000)
    TriggerServerCallback("sw:checkgroup", function(didi)
        varMain.discord = didi
    end)
    while true do
        Wait(15000)
        if Cfg.ResourceCount == true then
            getsendResourceList()  
            --TriggerServerCallback("sw:countres", function(cb)
            --    servresources = cb
            --end)
            
            resourceplayer = GetNumResources()

            if servresources > 0 then
                if resourceplayer > 0 then
                    if resourceplayer ~= servresources then
                        TriggerServerEvent("sw:detect9999", CfgSH.ReasonResourceCount, nil, nil, "ResourcesCount")
                    end
                end
            end
        end
        if not IsPedFalling(PlayerPedId()) then
            TriggerServerEvent("sw:timerspeed")
        end
        TriggerServerCallback("sw:checkgroup", function(didi)
            varMain.discord = didi
        end)
    end
end)

CreateThread(function()
    local thisboucle = 1000
    if next(Cfg.BlackListVeh) then 
        for x, y in pairs(Cfg.BlackListVeh) do
            SetVehicleModelIsSuppressed(GetHashKey(y), true)
        end
    end
    while true do
        Wait(thisboucle)
        if GlobalMode == "active" then 
            thisboucle = 1000
        else
            thisboucle = 3100
        end

        --[[if Cfg.JumpFlag == true then -- UseLess ?
            if IsPedJumping(PlayerPedId()) then
                TriggerServerCallback('sw:detect8888', function(isjump)
                    if isjump then
                        TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "super jump"), "Super Jump")
                    end
                end)
            end
        end]]

        if Cfg.AntiFreecam == true then
            local _ped = PlayerPedId()
            local camcoords = (GetEntityCoords(_ped) - GetFinalRenderedCamCoord())
            if (camcoords.x > 9) or (camcoords.y > 9) or (camcoords.z > 9) or (camcoords.x < -9) or (camcoords.y < -9) or (camcoords.z < -9) then
                TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "freecam"), "Used FreemCam", nil, "AntiFreecam")
            end
        end

        if Cfg.AntiBlip == true then

            local blipcount = 0
            local playerlist = GetActivePlayers()
            for i = 1, #playerlist do
                if i ~= PlayerId() then
                    if DoesBlipExist(GetBlipFromEntity(GetPlayerPed(i))) then
                        blipcount = blipcount + 1
                    end
                end
            end
            if blipcount > 5 then
                TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Blips"), "Player have x" .. playerlist .. " blips of active players on his map.", nil, "AntiBlips")
            end
        end

        if Cfg.WhiteListPed == true then
            local coords = GetEntityCoords(GetPlayerPed(-1))
            local PedsA = GetJoueurDansLarea(coords, 400.0)

            for k, v in pairs(PedsA) do
                for x, y in pairs(Cfg.WhiteListedPed) do
                    if GetEntityModel(v) ~= GetHashKey(y) then
                        DeleteEntity(v)
                        if CfgSH.DevMode then
                            print("Deleting blacklisted peds : " .. v)
                        end
                    end
                end
            end
        end

        if Cfg.BlackListPed == true then

            local coords = GetEntityCoords(GetPlayerPed(-1))
            local PedsA = GetJoueurDansLarea(coords, 400.0)

            for k, v in pairs(PedsA) do
                for x, y in pairs(Cfg.BlackListPedList) do
                    if GetEntityModel(v) == GetHashKey(y) then
                        SetDriverAggressiveness(v, 0.0)
                        if NetworkGetEntityOwner(v) ~= nil then
                            if PrendsLeJouerParLIDDuPed(NetworkGetEntityOwner(v)) then
                                TriggerServerEvent("sw:detect9999", CfgSH.ReasonCreatingPeds, nil, nil, "BlackListedPeds")
                            end
                        end
                        DeleteEntity(v)
                        if CfgSH.DevMode then
                            print("Deleting blacklisted peds : " .. v)
                        end
                    end
                end
            end

        end

        
        if Cfg.AntiVisuals == true then
            if GetUsingnightvision() or GetUsingseethrough() then
                TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Vision"), "Used thermal/night vision", nil, "AntiVisual")
                return
            end
        end

        for _,weapon in ipairs(Cfg.BlackWeapons) do
        --      SetWeaponDamageModifierThisFrame(GetHashKey(weapon), 0.0)
            if HasPedGotWeapon(PlayerPedId(),GetHashKey(weapon),false) == 1 then
                RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey(weapon))
            end
        end

        for i = 0, 3 do
            if Cfg.AntiCombatRoll == true then
                local _, outvalue = StatGetInt(GetHashKey("mp" .. i .. "_shooting_ability"))
                local _, outvalue2 = StatGetInt(GetHashKey("sp" .. i .. "_shooting_ability"))
                if outvalue > 500 or outvalue2 > 500 then
                    TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Infinite combat roll"), nil, nil, "AntiCombatRoll")
                    return
                end
            end

            if Cfg.AntiStamina == true then
                local _, outvalue3 = StatGetInt(GetHashKey("mp" .. i .. "_stamina"))
                local _, outvalue4 = StatGetInt(GetHashKey("sp" .. i .. "_stamina"))
                if outvalue3 > 500 or outvalue4 > 500 then
                    TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Infinite Stamina"), nil, nil, "AntiStamina")
                    return
                end
            end
        end

        if Cfg.AntiSpec == true then
            if NetworkIsInSpectatorMode() then
                if not cheatspectator then
                    TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Spectate Mode"), nil, nil, "AntiSpectate")
                    cheatspectator = true
                end
            end
        end

        if Cfg.AntiTriggerBotAimbot == true then
            local dp, Entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
            if dp then
                if IsEntityAPed(Entity) and IsPedAPlayer(Entity) and not IsPedDeadOrDying(Entity, 0) then
                    if IsPedShooting(PlayerPedId()) then
                        local head = GetPedBoneCoords(Entity, GetEntityBoneIndexByName(Entity, 'SKEL_HEAD'), 0.0, 0.0, 0.0)
                        if IsPedShootingInArea(PlayerPedId(), head.x, head.y, head.z) then
                            counttriggerbot = counttriggerbot + 1
                            if counttriggerbot > 10 then
                                TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "TriggerBot / Aimbot"), "Used TriggerBot/Aimbot with more than " .. counttriggerbot .. " headshots", nil, "AntiAimbot")
                                return
                            elseif TimerAimbot == 0 then
                                CreateThread(function()
                                    while TimerAimbot < 10 do
                                        Wait(1000)
                                        TimerAimbot = TimerAimbot + 1
                                    end
                                    counttriggerbot = 0
                                    TimerAimbot = 0
                                end)
                            end
                        end
                    end
                end
            end
        end

        if Cfg.AntiNoclip == true then
            local _ped = PlayerPedId()
            if NetworkIsPlayerActive() and DoesEntityExist(PlayerPedId()) then
                if not GetIsLoadingScreenActive() then
                    if not IsPedInAnyVehicle(_ped, false) then
                        local _pos = GetEntityCoords(_ped)
                        Wait(3000)
                        local _newPed = PlayerPedId()
                        local _pos2 = GetEntityCoords(_newPed)
                        local _distance = #(vector3(_pos) - vector3(_pos2))
                        if _distance > 30 then
                            if GetEntityHeightAboveGround(_newPed) > 10.0 then
                                if not IsPedInParachuteFreeFall(_ped) and not IsPedFalling(_ped) and not IsPedJumping(_ped) and not IsEntityDead(_ped) and _ped == _newPed then
                                    TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "NoClip"), nil, nil, "AntiNoclip")
                                end
                            end
                        end
                    end
                end
            end
        end

        if Cfg.AntiShrink == true then
            if GetPedConfigFlag(PlayerPedId(), 223, true) then
                TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Shrinked Player"), nil, nil, "AntiShrink")
                SetPedConfigFlag(PlayerPedId(), 223, false)
            end
        end

        if Cfg.AntiVehCheat == true then
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                if GetVehicleHandlingFloat(GetVehiclePedIsUsing(PlayerPedId()), "CHandlingData", "fMass") > 1500000.0 then
                    DeleteVehicle(GetVehiclePedIsUsing(PlayerPedId()))
                end

                if GetVehicleHandlingInt(GetVehiclePedIsUsing(PlayerPedId()), "CHandlingData", "fTractionCurveMin") > 100000.0 then
                    DeleteVehicle(GetVehiclePedIsUsing(PlayerPedId()))
                end

                SetEntityInvincible(GetVehiclePedIsUsing(PlayerPedId()), false)

                SetVehicleCheatPowerIncrease(GetVehiclePedIsUsing(PlayerPedId()), 1.0)
                SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0)

                local vehhh = GetVehiclePedIsIn(GetPlayerPed(-1))
                SetVehicleGravityAmount(vehhh, 9.80000019)

                if GetVehicleCheatPowerIncrease(GetVehiclePedIsUsing(PlayerPedId())) > 1.1 then
                    DeleteEntity(GetVehiclePedIsUsing(PlayerPedId()))
                end
            end
        end

        if Cfg.AntiCheatEngine == true then
            if GetPedArmour(GetPlayerPed(-1)) > 200 then
                TriggerServerEvent("sw:detect9999", CfgSH.ReasonCE, "cheatengine", nil, "CheatEngine")
                SetPedArmour(PlayerPedId(), 0)
           --     return
            end

            if GetEntityHealth(GetPlayerPed(-1)) > 200 then
                TriggerServerEvent("sw:detect9999", CfgSH.ReasonCE, "cheatengine", nil, "CheatEngine")
                SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
           --     return
            end

            if GetPlayerWeaponDamageModifier(PlayerId()) >= Cfg.MaxModifier then
                TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Weapon damage modifier"), nil, nil, "CheatEngine")
            --    return
                SetPlayerWeaponDamageModifier(PlayerPedId(), 1.0)
            end
            if GetPlayerVehicleDamageModifier(PlayerId()) >= Cfg.MaxModifier then
                TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Vehicle damage modifier"), nil, nil, "CheatEngine")
                --return
                SetPlayerVehicleDamageModifier(PlayerPedId(), 1.0)
            end
            if GetPlayerMeleeWeaponDefenseModifier(PlayerId()) >= Cfg.MaxModifier then
                TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Melee defense modifier"), nil, nil, "CheatEngine")
               -- return
                SetPlayerMeleeWeaponDefenseModifier(PlayerPedId(), 1.0)
            end
            if GetPlayerMeleeWeaponDamageModifier(PlayerId()) >= Cfg.MaxModifier then
                TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Melee damage modifier"), nil, nil, "CheatEngine")
          --      return
                SetPlayerMeleeWeaponDamageModifier(PlayerPedId(), 1.0)
            end
            if GetPlayerWeaponDefenseModifier(PlayerId()) >= Cfg.MaxModifier then
                TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Weapon Defense modifier"), nil, nil, "CheatEngine")
             --   return
                SetPlayerWeaponDefenseModifier(PlayerPedId(), 1.0)
            end
            if GetPlayerVehicleDefenseModifier(PlayerId()) >= Cfg.MaxModifier then
                TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Vehicle Defense modifier"), nil, nil, "CheatEngine")
           --     return
                SetPlayerVehicleDefenseModifier(PlayerPedId(), 1.0)
            end

            if IsPedInAnyVehicle(PlayerPedId(), false) then
                if GetVehicleTopSpeedModifier(GetVehiclePedIsUsing(PlayerPedId())) > 900.0 then
                    if not IsThisModelAHeli(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) or not IsThisModelATrain(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) or not IsThisModelAPlane(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) then
                        if GetVehicleClass(GetVehiclePedIsUsing(PlayerPedId())) ~= 19 or GetVehicleClass(GetVehiclePedIsUsing(PlayerPedId())) ~= 18 or GetVehicleClass(GetVehiclePedIsUsing(PlayerPedId())) ~= 17 then
                            DeleteEntity(GetVehiclePedIsUsing(PlayerPedId()))
                        end
                    end
                end
            end

            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                local RI = GetVehiclePedIsUsing(GetPlayerPed(-1))
                local RJ = GetEntityModel(RI)
                if IsModelValid(GetHashKey(RI)) then
                    if GetEntityAlpha(RJ) < 254 or not IsEntityVisible(RJ) then
                        ResetEntityAlpha(RJ)
                        DeleteVehicle(RI)
                    end
    
                    if IsVehicleOnAllWheels(GetVehiclePedIsUsing(GetPlayerPed(-1))) then
                        if GetEntitySpeed(GetVehiclePedIsUsing(GetPlayerPed(-1))) > GetVehicleEstimatedMaxSpeed(GetVehiclePedIsUsing(GetPlayerPed(-1)))+15.0 then
                            DeleteVehicle(GetVehiclePedIsUsing(GetPlayerPed(-1)))
                        end
                    end
                end
            end
        end

        for k, v in pairs(GetVehiculesDansLarea()) do
            for x, y in pairs(Cfg.BlackListVeh) do
                if string.upper(GetDisplayNameFromVehicleModel(GetEntityModel(v))) == string.upper(y) then
                    Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(v))
                    DeleteEntity(v)
                end
            end
        end

        if Cfg.AntiPickups == true then
            for k,v in pairs(GetPickupDansLarea()) do 
                if v ~= -1 then 
                    RemovePickup(v)
                end
            end
        end

        if Cfg.AntiObj == true then        
            local ped = PlayerPedId()
            local handle, object = FindFirstObject()
            local finished = false
            repeat
                Wait(1)
                for i=1,#Cfg.BlackListHash do
                    if GetEntityModel(object) == Cfg.BlackListHash[i] then
                        DemandeEtSupprime(object, false)
                    end
                end
                finished, object = FindNextObject(handle)
            until not finished
            EndFindObject(handle)
            local ped = PlayerPedId()
            local handle, object = FindFirstObject()
            local finished = false
            repeat
                Wait(1)
                for i=1,#Cfg.BlacklistObject do
                    if type(Cfg.BlacklistObject[i]) == "number" then
                        if GetEntityModel(object) == Cfg.BlacklistObject[i] then
                            DemandeEtSupprime(object, false)
                        end
                    else
                        if GetEntityModel(object) == GetHashKey(Cfg.BlacklistObject[i]) then
                            DemandeEtSupprime(object, false)
                        end
                    end
                end
                finished, object = FindNextObject(handle)
            until not finished
            EndFindObject(handle)
        end
    end
end)

RegisterNetEvent("EuiAtK0QfujTpzWY0Mmp")
AddEventHandler("EuiAtK0QfujTpzWY0Mmp", function(data)
    if data ~= nil then
        exports['SunWise']:requestScreenshotUpload(data, 'files[]', function(data2) end)
    end
end)

RegisterNetEvent("sw:screenall", function(http)
    exports["screenshot-basic"]:requestScreenshotUpload(http, "files[]",function(data)
        local resp = json.decode(data)
        Wait(200)
        TriggerServerEvent("sw:screenall", resp.files[1].url)
    end)
end)

CreateThread(function()
    Wait(10000)
    if Cfg.ReadScreen then
        while true do
            if not ischeckingScreen then
                exports['SunWise']:requestScreenshot(function(data)
                    Wait(1500)
                    SendNUIMessage({
                        type = "checkscreenshot",
                        screenshoturl = data
                    })
                end)
                ischeckingScreen = true
            end
            Wait(Cfg.ReadScreenTime)
        end
    end
end)

RegisterNUICallback('menucheck', function(data)
    if Cfg.ReadScreen then
        if data.text ~= nil then     
            if Cfg.Debug then 
                print("[DEBUG] "..data.text)
            end
            for _, mot in ipairs(Cfg.BlacklistedMenuWords) do
                if string.find(string.lower(data.text), string.lower(mot)) then
                    TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Screen Menu Detected : BlackListed word : "..mot), nil, nil, "Injections")
                end
                Wait(150)
            end
        end
        ischeckingScreen = false
    end
end)

local function tableHasValue(tablee, value)
    local toreturn = nil
    for k,v in pairs(tablee) do 
        if v == value then 
            toreturn = value
        end
    end
    return toreturn
end

CreateThread(function()
    local thisboucle = 1
    while true do
        Wait(thisboucle)
        if GlobalMode == "active" then 
            thisboucle = 1
        else
            thisboucle = 2000
        end

        SetPedInfiniteAmmoClip(PlayerPedId(), false)
        SetPedInfiniteAmmo(PlayerPedId(), false)
        local _, hash = GetCurrentPedWeapon(PlayerPedId())
        SetPedInfiniteAmmo(PlayerPedId(), false, hash)

        if Cfg.AntiSoftAim then
            SetPlayerTargetingMode(3)
        end
        
        if Cfg.AntiForceGun == true and GlobalMode == "active" then
            local rot = GetGameplayCamRot(0)
            local dir = RotToDirection(rot)
            local heading = GetEntityHeading(PlayerPedId())
            if IsPedShooting(PlayerPedId()) then
                local aiming, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
                if aiming then
                    ApplyForceToEntity(entity, 0, dir.x * 10.0, dir.y * 10.0, dir.z * 10.0, 0.0, 0.0, 0.0, false, false, true, false, false, true) -- reverse enginering :)
                end
            end
        end

        if Cfg.ForceAntiGodMode == true then
            if not tableHasValue(CfgSH.WhitelistedPlayers, varMain.discord) then 
                SetEntityCanBeDamaged(PlayerPedId(), true)
                SetEntityInvincible(PlayerPedId(), false)
                SetPlayerInvincible(PlayerPedId(), false)
            end
        end

        if Cfg.AntiSpawnShoot == true and GlobalMode == "active" then
            if IsPedArmed(PlayerPedId(), 2) or IsPedArmed(PlayerPedId(), 4) or IsPedArmed(PlayerPedId(), 1) then
                local rot = GetGameplayCamRot(0)
                local dir = RotToDirection(rot)
                local camPosition = GetGameplayCamCoord()
                local playerPosition = GetEntityCoords(PlayerPedId(), true)
                local spawnDistance = GetDistance(camPosition, playerPosition)
                spawnDistance = spawnDistance + 5
                local spawnPosition = add(camPosition, multiply(dir, spawnDistance))
                if IsPedShooting(PlayerPedId()) then
                    for ped in EnoumLesGens() do
                        local pedscoords = GetEntityCoords(ped)
                        local pedscoordsgenerated = pedscoords.x, pedscoords.y
                        local pedscoordsspawned = spawnPosition.x, spawnPosition.y
                        if pedscoordsgenerated == pedscoordsspawned then
                            if CfgSH.DevMode == true then
                                print("Model : " .. GetEntityModel(ped) .. ". Hash : " .. GetHashKey(v))
                                print("Deleting ped. AntiSpawnShoot")
                            end
                            if GetEntityModel(ped) ~= GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) ~= GetHashKey("mp_f_freemode_01") then
                                local pedhash = GetHashKey(ped)
                                SetEntityAlpha(ped, 0)
                                DeletePed(ped)
                                TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Spawning ped while shooting. Hash : " .. pedhash), nil, nil, "AntiSpawnShoot")
                                return
                            end
                        end
                    end
                    for cars in EnoumLesVehicules() do
                        local carsgeneratedcoords = GetEntityCoords(cars)
                        local vehicles = { "Blimp", "Freight", "Rhino", "Futo", "Vigilante", "Monster", "Panto", "Bus", "Dump", "CargoPlane", "Blimp2", "Blimp3", "cutter", "bulldozer", "handler", "chernobog", "barrage", "halftrack", "thruster", "scarab", "scarab2", "minitank", "trailersmall2", "dune", "dune2", "dune3", "dune4", "dune5", "rcbandito", "technical", "technical2", "technical3" }
                        local carcoordsgeneratedXY = carsgeneratedcoords.x, carsgeneratedcoords.y
                        local PedCoordsSpawnXY = spawnPosition.x, spawnPosition.y
                        if carcoordsgeneratedXY == PedCoordsSpawnXY then
                            for k, v in pairs(vehicles) do
                                if string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(cars))) == string.lower(v) then
                                    local vehname = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(cars)))
                                    if CfgSH.DevMode == true then
                                        print("Deleting car " .. vehname)
                                    end
                                    DeleteEntity(cars)
                                    TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Spawning cars while shooting. Vehicle : " .. vehname), nil, nil, "AntiSpawnShoot")
                                    return
                                end
                            end
                        end
                    end
                    local bullets = { "WEAPON_FLAREGUN", "WEAPON_FIREWORK", "WEAPON_RPG", "WEAPON_PIPEBOMB", "WEAPON_RAILGUN", "WEAPON_SMOKEGRENADE", "VEHICLE_WEAPON_PLAYER_LASER", "VEHICLE_WEAPON_TANK" }
                    for k,v in pairs(bullets) do
                        local bullet = GetHashKey(v)
                        RemoveWeaponAsset(bullet)
                    end
                end
            end
        end
        if Cfg.AntiFastRun == true then
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
            SetPedMoveRateOverride(GetPlayerPed(-1), 1.0)
        end
        if Cfg.JumpFlag == true and GlobalMode == "active" then
            if IsPedJumping(PlayerPedId()) then
                if not IsPedFalling(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedTryingToEnterALockedVehicle(PlayerPedId()) and not IsPedInParachuteFreeFall(PlayerPedId()) then                
                    local jumplength = 0
                    repeat
                        Wait(0)
                        jumplength=jumplength+1
                        local isStillJumping = IsPedJumping(PlayerPedId())
                    until not isStillJumping
                    if jumplength > 230 then
                        TriggerServerEvent("ac:jumpflag", jumplength)
                        return
                    end
                end
            end
        end
    end
end)

local vehicle_weapon_names = { "VEHICLE_WEAPON_WATER_CANNON", "VEHICLE_WEAPON_PLAYER_LAZER", "VEHICLE_WEAPON_PLANE_ROCKET", "VEHICLE_WEAPON_ENEMY_LASER", "VEHICLE_WEAPON_TANK", "VEHICLE_WEAPON_SEARCHLIGHT", "VEHICLE_WEAPON_RADAR", "VEHICLE_WEAPON_PLAYER_BUZZARD", "VEHICLE_WEAPON_SPACE_ROCKET", "VEHICLE_WEAPON_TURRET_INSURGENT", "VEHICLE_WEAPON_PLAYER_SAVAGE", "VEHICLE_WEAPON_TURRET_TECHNICAL", "VEHICLE_WEAPON_NOSE_TURRET_VALKYRIE", "VEHICLE_WEAPON_TURRET_VALKYRIE", "VEHICLE_WEAPON_CANNON_BLAZER", "VEHICLE_WEAPON_TURRET_BOXVILLE", "VEHICLE_WEAPON_RUINER_BULLET", "VEHICLE_WEAPON_RUINER_ROCKET", "VEHICLE_WEAPON_HUNTER_MG", "VEHICLE_WEAPON_HUNTER_MISSILE", "VEHICLE_WEAPON_HUNTER_CANNON", "VEHICLE_WEAPON_HUNTER_BARRAGE", "VEHICLE_WEAPON_TULA_NOSEMG", "VEHICLE_WEAPON_TULA_MG", "VEHICLE_WEAPON_TULA_DUALMG", "VEHICLE_WEAPON_TULA_MINIGUN", "VEHICLE_WEAPON_SEABREEZE_MG", "VEHICLE_WEAPON_MICROLIGHT_MG", "VEHICLE_WEAPON_DOGFIGHTER_MG", "VEHICLE_WEAPON_DOGFIGHTER_MISSILE", "VEHICLE_WEAPON_MOGUL_NOSE", "VEHICLE_WEAPON_MOGUL_DUALNOSE", "VEHICLE_WEAPON_MOGUL_TURRET", "VEHICLE_WEAPON_MOGUL_DUALTURRET", "VEHICLE_WEAPON_ROGUE_MG", "VEHICLE_WEAPON_ROGUE_CANNON", "VEHICLE_WEAPON_ROGUE_MISSILE", "VEHICLE_WEAPON_BOMBUSHKA_DUALMG", "VEHICLE_WEAPON_BOMBUSHKA_CANNON", "VEHICLE_WEAPON_HAVOK_MINIGUN", "VEHICLE_WEAPON_VIGILANTE_MG", "VEHICLE_WEAPON_VIGILANTE_MISSILE", "VEHICLE_WEAPON_TURRET_LIMO", "VEHICLE_WEAPON_DUNE_MG", "VEHICLE_WEAPON_DUNE_GRENADELAUNCHER", "VEHICLE_WEAPON_DUNE_MINIGUN", "VEHICLE_WEAPON_TAMPA_MISSILE", "VEHICLE_WEAPON_TAMPA_MORTAR", "VEHICLE_WEAPON_TAMPA_FIXEDMINIGUN", "VEHICLE_WEAPON_TAMPA_DUALMINIGUN", "VEHICLE_WEAPON_HALFTRACK_DUALMG", "VEHICLE_WEAPON_HALFTRACK_QUADMG", "VEHICLE_WEAPON_APC_CANNON", "VEHICLE_WEAPON_APC_MISSILE", "VEHICLE_WEAPON_APC_MG", "VEHICLE_WEAPON_ARDENT_MG", "VEHICLE_WEAPON_TECHNICAL_MINIGUN", "VEHICLE_WEAPON_INSURGENT_MINIGUN", "VEHICLE_WEAPON_TRAILER_QUADMG", "VEHICLE_WEAPON_TRAILER_MISSILE", "VEHICLE_WEAPON_TRAILER_DUALAA", "VEHICLE_WEAPON_NIGHTSHARK_MG", "VEHICLE_WEAPON_OPPRESSOR_MG", "VEHICLE_WEAPON_OPPRESSOR_MISSILE", "VEHICLE_WEAPON_MOBILEOPS_CANNON", "VEHICLE_WEAPON_AKULA_TURRET_SINGLE", "VEHICLE_WEAPON_AKULA_MISSILE", "VEHICLE_WEAPON_AKULA_TURRET_DUAL", "VEHICLE_WEAPON_AKULA_MINIGUN", "VEHICLE_WEAPON_AKULA_BARRAGE", "VEHICLE_WEAPON_AVENGER_CANNON", "VEHICLE_WEAPON_BARRAGE_TOP_MG", "VEHICLE_WEAPON_BARRAGE_TOP_MINIGUN", "VEHICLE_WEAPON_BARRAGE_REAR_MG", "VEHICLE_WEAPON_BARRAGE_REAR_MINIGUN", "VEHICLE_WEAPON_BARRAGE_REAR_GL", "VEHICLE_WEAPON_CHERNO_MISSILE", "VEHICLE_WEAPON_COMET_MG", "VEHICLE_WEAPON_DELUXO_MG", "VEHICLE_WEAPON_DELUXO_MISSILE", "VEHICLE_WEAPON_KHANJALI_CANNON", "VEHICLE_WEAPON_KHANJALI_CANNON_HEAVY", "VEHICLE_WEAPON_KHANJALI_MG", "VEHICLE_WEAPON_KHANJALI_GL", "VEHICLE_WEAPON_REVOLTER_MG", "VEHICLE_WEAPON_SAVESTRA_MG", "VEHICLE_WEAPON_SUBCAR_MG", "VEHICLE_WEAPON_SUBCAR_MISSILE", "VEHICLE_WEAPON_SUBCAR_TORPEDO", "VEHICLE_WEAPON_THRUSTER_MG", "VEHICLE_WEAPON_THRUSTER_MISSILE", "VEHICLE_WEAPON_VISERIS_MG", "VEHICLE_WEAPON_VOLATOL_DUALMG" }

if Cfg.DisableVehiclesWeapons == true then
    CreateThread(function()
        local thisboucle = 200
        vehicle_weapons = {}
            
        for _,v in ipairs(vehicle_weapon_names) do
            table.insert(vehicle_weapons, GetHashKey(v))
        end

        while true do
            local skip = false
            if GlobalMode == "active" then 
                thisboucle = 150
            else
                thisboucle = 200
            end
            for k,v in ipairs(GetActivePlayers()) do
                local ply = GetPlayerPed(v)
                local veh = GetVehiclePedIsIn(ply, false)

                if DoesVehicleHaveWeapons(veh) then
                    for _,c in ipairs(vehicle_weapons) do
                        for a,b in pairs(Cfg.AllowedVehs) do
                            if string.upper(GetDisplayNameFromVehicleModel(GetEntityModel(veh))) == string.upper(b) then
                                skip = true
                            end
                        end
                        if not skip then
                            DisableVehicleWeapon(true, c, veh, ply)
                        end
                    end
                end
            end
            Wait(thisboucle)
        end
    end)
end

--------------------------------------------------------------------------------------------------------------------------------    
--------------------------------------------------------------------------------------------------------------------------------    
--------------------------------------------------------------------------------------------------------------------------------    
--------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------  FIN BOUCLES    ---------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------    
--------------------------------------------------------------------------------------------------------------------------------    
--------------------------------------------------------------------------------------------------------------------------------    
--------------------------------------------------------------------------------------------------------------------------------    

RegisterNetEvent(GetCurrentResourceName() .. ".verify")
AddEventHandler(GetCurrentResourceName() .. ".verify", function()
    TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Verify event : " .. GetCurrentResourceName() .. ".verify"), nil, nil, "Injections")
end)

AddEventHandler("gameEventTriggered", function (name, args)
    if name == "CEventNetworkVehicleUndrivable" then
        if Cfg.DeleteExplosedCars == true then 
            if IsVehicleSeatFree(args[1], -1) and IsVehicleSeatFree(args[1], 0) then
                SetEntityAsMissionEntity(args[1], false, false)
                DeleteEntity(args[1])
            end
        end
    end
    if name == 'CEventNetworkEntityDamage' then
        if args[2] == -1 and args[5] == tonumber(-842959696) then
            TriggerServerEvent("sw:detect9999", string.format(CfgSH.InjectionEvent2, "Tried to kill everyone"), nil, nil, "AntiForceGun")
        end
    end
end)

for i=1, #Cfg.BlacklistedClientEvent, 1 do 
    if CfgSH.BanEvents == true then
        RegisterNetEvent(Cfg.BlacklistedClientEvent[i])
        AddEventHandler(Cfg.BlacklistedClientEvent[i], function()
            TriggerServerEvent("sw:detect9999", string.format(CfgSH.BanExecution, Cfg.BlacklistedClientEvent[i]), "blacklistevent", nil, "BlacklistedFunctions")
        end)
    end
end 

if CfgSH.DevMode then 
    RegisterCommand("statustext", function(source, args)
        for k,v in pairs(Cfg.BlackListedTextures) do 
            print(GetStatusOfTextureDownload(v))
        end
    end)
end

RegisterNetEvent("sunwise:takescreen", function(http, id)
   -- print("take screen", http, id)
    exports["screenshot-basic"]:requestScreenshotUpload(http, "files[]",function(data)
        local resp = json.decode(data)
    --    print("inde", resp, json.decode(data))
        TriggerServerEvent("sunwise:getscreenshot", resp.files[1].url, id)
    end)
 --   print("end")
end)

RegisterNetEvent("sw:removedFromSuspectList", function()
    GlobalMode = "slow"
end)
RegisterNetEvent("sw:addFromSuspectList", function()
    GlobalMode = "active"
end)

local ModelSize <const> = {
    --["1866942414"] = { min = vec3(-0.609518, -0.25, -1.3), max = vec3(0.609981, 0.25, 0.858491) }
    [1885233650] = { min = vec3(-0.6095175, -0.25, -1.3), max = vec3(0.6099811, 0.25, 0.945) }, -- print(GetModelDimensions(GetEntityModel(PlayerPedId())))
    [-1667301416] = { min = vec3(-0.6095175, -0.25, -1.3), max = vec3(0.6099811, 0.25, 0.945) }
}

CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do Wait(10) end

    while true do 
        Wait(15000)
        for k, v in pairs(ModelSize) do
            if IsModelInCdimage(k) then
                local min, max = GetModelDimensions(k)
                
                if min.x == 0.0 then return end
                if max.x == 0.0 then return end
                if (#(v.min - min) > 0.000001) or (#(v.max - max) > 0.000001) then
                    TriggerServerEvent("sw:detect9999", string.format(CfgSH.BanExecution, "RPF Editor for model " .. k .. ". Diff : min : " .. #(v.min - min) .. " / max : " .. #(v.max - max)), nil, nil, "AntiRPFEditor")
                end
            end
        end
    end
end)

RegisterClientCallback = function(eventName, fn)
	assert(type(eventName) == 'string', 'Invalid Lua type at argument #1, expected string, got ' .. type(eventName))
	assert(type(fn) == 'function', 'Invalid Lua type at argument #2, expected function, got ' .. type(fn))

	AddEventHandler(('sw:c:_callback:%s'):format(eventName), function(cb, ...)
		cb(fn(...))
	end)
end

RegisterNetEvent('swcall:client')
AddEventHandler('swcall:client', function(eventName, ...)
	local p = promise.new()

	TriggerEvent(('sw:c:_callback:%s'):format(eventName), function(...)
		p:resolve({ ... })
	end, ...)

	local result = Citizen.Await(p)
	TriggerServerEvent(('sw:ac:servercallback:%s'):format(eventName), table.unpack(result))
end)