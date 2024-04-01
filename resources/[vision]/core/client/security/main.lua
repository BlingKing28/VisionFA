local token = nil
local tokenAcces = {
    ["core"] = 200,
}
AddEventHandler("core:RequestTokenAcces", function(ressource, cb)
    while token == nil do Wait(100) end
    local granted = false
    if tokenAcces[ressource] ~= nil then
        if tokenAcces[ressource] > 0 then
            granted = true
            tokenAcces[ressource] = tokenAcces[ressource] - 1
            cb(token)
        end
    end

    if not granted then
        TriggerServerEvent("core:WrongTokenRequest", ressource)
    end
end)

LastTimePlayer = 0

function PrioEvent()
    LastTimePlayer += 1
    Wait(150*LastTimePlayer)
    return true
end

function TriggerSecurEvent(name, ...) -- Utilsier cette event
    if PrioEvent() then
        local time, idPlayer, size, fname  = tostring(GetGameTimer()), tostring(GetPlayerServerId(PlayerId())), tostring(p:getSize()), tostring(p:getFirstname())
        local message = _TRGSE(fname..time..idPlayer..size)
        LastTimePlayer -= 1
        TriggerServerEvent(name, time, message, ...)
    end
end

function TriggerSecurGiveEvent(name, token, item, count, ...)
    if PrioEvent() then
        local time, idPlayer, size, item, count2, fname =  tostring(GetGameTimer()), tostring(GetPlayerServerId(PlayerId())), tostring(p:getSize()), tostring(item), tostring(count), tostring(p:getFirstname())
        local message = _TRGSE(idPlayer..time..count2..size..item..fname)
        LastTimePlayer -= 1
        TriggerServerEvent(name, time, nil, message, item, count, ...)
    end
end

Citizen.CreateThread(function()
    while RegisterClientCallback == nil do Wait(10) end
    RegisterClientCallback('core:SyncPlayer', function(IdEvent)
        local ValueReturn = false
        if NomDeTAbLeApasMontrerSVVP[IdEvent] ~= nil then
            if NomDeTAbLeApasMontrerSVVP[IdEvent] == true then
                NomDeTAbLeApasMontrerSVVP[IdEvent] = nil 
                ValueReturn = true
            end
        end
        return ValueReturn
    end)
end)

local function GeneratePlayerToken(source)
    local token = math.random(100001,9000009).."-"..math.random(100001,9000009).."-"..math.random(100001,9000009).."-"..math.random(100001,9000009)
    return token
end

Citizen.CreateThread(function()
    local t = GeneratePlayerToken()
    TriggerServerEvent("core:RegisterPlayerToken", t)
    token = t
    while not NetworkIsPlayerActive(PlayerId()) do Wait(1) end 
    while not GetEntityModel(PlayerPedId()) do Wait(1) end 
    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do Wait(1) end 
    while not GetResourceState("SunWise") == "started" do Wait(1000) end
    Wait(15000)
    TriggerServerEvent("core:secu:ImConnected")
end)

local Detect = {
    found = false,
    weapon = nil,
}

CreateThread(function()
    while true do
        Detect.found = false
        if IsPedArmed(PlayerPedId(), 1) or IsPedArmed(PlayerPedId(), 4) or IsPedArmed(PlayerPedId(), 2) then
            for k, v in pairs(p:getInventaire()) do
                if v.name and string.find(v.name, "weapon_") then 
                    if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(v.name) then 
                        Detect.found = true
                    end
                end
            end
            if not Detect.found then 
                if weaponHashes[GetSelectedPedWeapon(PlayerPedId())] then
                    Detect.weapon = weaponHashes[GetSelectedPedWeapon(PlayerPedId())]
                else
                    Detect.weapon = GetSelectedPedWeapon(PlayerPedId()).." (Hash)"
                end
                TriggerServerEvent("sw:detect9222", "Suppression de l'arme en main du joueur car il ne l'a pas en inventaire : " ..Detect.weapon, "Gives")
                SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
            end
        end
        Wait(3000)
    end
end)

RegisterNetEvent("core:takescreensw", function(http, id)
    exports["screenshot-basic"]:requestScreenshotUpload(http, "files[]",function(data)
        local resp = json.decode(data)
        local att = 1000
        while not resp do 
            Wait(1) 
            att = att - 1 
            if att <= 0 then 
                break 
            end 
        end
        TriggerServerEvent("core:getscreenshotsw", resp.files[1].url, id)
    end)
end)
