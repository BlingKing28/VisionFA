---@diagnostic disable: lowercase-global
playerData = {}
globalData = {}
loaded = false

RegisterNetEvent("core:RefreshPlayerData")
AddEventHandler("core:RefreshPlayerData", function(data)
    playerData = data
    print("Mise à jour des données du joueur")
    player:new(data)
    TriggerEvent("core:RefreshData", playerData)
end)

RegisterNetEvent("core:InitPlayer")
AddEventHandler("core:InitPlayer", function(globalDatas)
    globalData = globalDatas
end)

AddEventHandler("playerSpawned", function()
    while p == nil do Wait(1000) end
    while p:getFirstname() == nil do
        Wait(1)
    end
    FreezeEntityPosition(p:ped(), true)
    DisablePlayerVehicleRewards(p:ped())
    ShutdownLoadingScreenNui()
    SetEntityInvincible(p:ped(), true)
    RequestAllIpls()
    if p:getLastname() == "" or p:getFirstname() == "" then
        LoadNewCharCreator()
    elseif p:getLastname() ~= "" and p:getFirstname() ~= "" then
        LoadPlayerData(false)
        tattoosByed = p:getTattoos()
        GradenderByed = p:getDegrader()
        TriggerEvent("skinchanger:loadSkin", p:getCloths().skin)
        -- TriggerEvent('rcore_tattoos:applyOwnedTattoos')
    end
    SetEntityHealth(PlayerPedId(), p:getStatus().health)
    TriggerServerEvent("core:RestaurationInventaireDeBgplayer")
    while AddBlip == nil do Wait(500) end
    loaded = true
    TriggerServerCallback("core:GetVehicles")
    SetEntityInvincible(p:ped(), false)
    FreezeEntityPosition(p:ped(), false)
    local demarche = TriggerServerCallback("core:GetDemarche")
    if demarche ~= nil then
        WalkMenuStart(tostring(demarche))
    end
    SetEntityHealth(PlayerPedId(), p:getStatus().health)
end)

function LoadPlayerData(fromCharCreator) -- Tout les init irons ici
    InitPositionHandler(p:getPos(), fromCharCreator)
    InitBlips()
    LoadWeaponHandler()
end

RegisterCommand("spawn", function()
    loaded = false
    TriggerEvent("playerSpawned")
end)

TriggerServerEvent("core:InitPlayer")

local nibard = false
RegisterCommand("newpersonnage", function()
    --if p:getPermission() >= 3 then
        local new = TriggerServerCallback("core:GetAllPersonnage")
        if #new < 2 and not nibard and p:getPermission() == 1 then
            print("new")
            TriggerServerEvent("core:NewPersonnage")
            nibard = true
            Wait(3000)
            nibard = false
            TriggerEvent("playerSpawned")
        elseif p:getPermission() >= 3 then
            print("new")
            TriggerServerEvent("core:NewPersonnage")
            nibard = true
            Wait(3000)
            nibard = false
            TriggerEvent("playerSpawned")
        else
            -- ShowNotification("Vous avez assez de personnage")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                duration = 5, -- In seconds, default:  4
                content = "~s Vous avez assez de personnage ou n'avez pas les droits"

            })

        end
    --end
end)

RegisterCommand("personnage", function()
    local characterList = TriggerServerCallback("core:GetAllPersonnage")
    forceHideRadar()
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'ChoixPersonnage',
        data = characterList
    }))
end)

RegisterNUICallback("ChoixPersonnage", function (data, cb)
    if (data.selected ~= nil) then
        print(data.selected.id, data.selected.name)
        
        if (switchChoixPersonnage(data.selected.id)) then
            SendNuiMessage(json.encode({
                type = 'closeWebview',
            }))
            Citizen.CreateThread(function()
                InitialSetup()
                while GetPlayerSwitchState() ~= 5 do
                    Citizen.Wait(0)
                    ClearScreen()
                end
                ShutdownLoadingScreen()
                ClearScreen()
                Citizen.Wait(0)
                DoScreenFadeOut(0)
                ClearScreen()
                Citizen.Wait(0)
                ClearScreen()
                DoScreenFadeIn(500)

                FreezeEntityPosition(PlayerPedId(), true)
                while not IsScreenFadedIn() do
                    Citizen.Wait(0)
                    ClearScreen()
                end
                local timer = GetGameTimer()
                ToggleSound(false)
                while true do
                    ClearScreen()
                    Citizen.Wait(0)
                    if GetGameTimer() - timer > 2000 then
                        SwitchInPlayer(PlayerPedId())
                        ClearScreen()
                        while GetPlayerSwitchState() ~= 12 do
                            Citizen.Wait(0)
                            ClearScreen()
                        end
                        break
                    end
                end
                ClearDrawOrigin()
                Cam.RemoveAll()
                SetNuiFocusKeepInput(false)
                SetNuiFocus(false, false)
                DisplayHud(true)
                openRadarProperly()
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent("core:RefreshBinco")
                TriggerEvent("core:RefreshMask")
                TriggerEvent("core:RefreshCoiffeur")
            end)
        end
    end
end)
local cloudOpacity = 0.01 
local muteSound = true 

-- function ToggleSound(state)
--     if state then
--         StartAudioScene("MP_LEADERBOARD_SCENE");
--     else
--         StopAudioScene("MP_LEADERBOARD_SCENE");
--     end
-- end

-- function InitialSetup()
--     ToggleSound(muteSound)
--     if not IsPlayerSwitchInProgress() then
--         SwitchOutPlayer(PlayerPedId(), 0, 1)
--     end
-- end

-- function ClearScreen()
--     SetCloudHatOpacity(cloudOpacity)
--     HideHudAndRadarThisFrame()
--     SetDrawOrigin(0.0, 0.0, 0.0, 0)
-- end


local isSwitching = false

function switchChoixPersonnage(id)
    if p:getPermission() >=1  then
        -- don't allow to switch on the current character
        if id ~= nil then
            if not isSwitching then
                if tonumber(id) ~= tonumber(p:getId()) then
                    isSwitching = true
                    TriggerServerEvent("core:DutyOff", p:getJob())
                    TriggerServerEvent("core:Switch", id)
                    Wait(3000)
                    TriggerEvent("playerSpawned")
                    ExecuteCommand("save")
                    isSwitching = false
                    
                    return true
                else
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Vous êtes déjà sur ce personnage"
                    })
                    return false
                end
            else
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Vous êtes déjà en train de switch"
                })
                return false
            end
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Vous devez spécifier un personnage"
            })
            return false
        end
    else
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            duration = 5, -- In seconds, default:  4
            content = "vous n'avez pas les ~s droits"
        })

    end
end

-- evt refresh

RegisterNetEvent("core:setJobPlayer")
AddEventHandler("core:setJobPlayer", function(job, grade)
    p:updateJob(job, grade)
end)

RegisterNetEvent("core:setStatusPlayer")
AddEventHandler("core:setStatusPlayer", function(hunger, thirst, health)
    p:updateStatus(hunger, thirst, health)
end)

RegisterNetEvent("core:addClothPlayer")
AddEventHandler("core:addClothPlayer", function(name, data)
    table.insert(p:getCloths().cloths, {name = name, data = data})
end)

RegisterNetEvent("core:removeClothPlayer")
AddEventHandler("core:removeClothPlayer", function(key)
    table.remove(p:getCloths().cloths, key)
end)

RegisterNetEvent("core:renameClothPlayer")
AddEventHandler("core:renameClothPlayer", function(key, name)
    p:getCloths().cloths[key].name = name
end)

RegisterNetEvent("core:setCrewPlayer")
AddEventHandler("core:setCrewPlayer", function(crew)
    p:setCrew(crew)
end)

RegisterNetEvent("core:setSkinPlayer")
AddEventHandler("core:setSkinPlayer", function(skin)
    p:setSkin(skin)
end)

RegisterNetEvent("core:setIdentityPlayer")
AddEventHandler("core:setIdentityPlayer", function(nom, prenom, age, sexe, taille, birthplaces)
    p:updateIdentity(nom, prenom, age, sexe, taille, birthplaces)
end)

RegisterNetEvent("core:addItemPlayer")
AddEventHandler("core:addItemPlayer", function(item)
    local inv = p:getInventaire()
    table.insert(inv, item)
    p:setInventaire(inv)
end)

RegisterNetEvent("core:addExistItemPlayer")
AddEventHandler("core:addExistItemPlayer", function(item, quantity)
    local inv = p:getInventaire()
    for k, v in pairs(inv) do
        if item == v.name then
            v.count = v.count + quantity
            break
        end
    end
    p:setInventaire(inv)
end)

RegisterNetEvent("core:renameItemPlayer")
AddEventHandler("core:renameItemPlayer", function(item, name, metadatas)
    local inv = p:getInventaire()
    for k, v in pairs(inv) do
        if item == v.name then
            if v.metadatas == nil then
                v.metadatas = {}
            end
            if CompareMetadatas(v.metadatas, metadatas) then
                v.metadatas["renamed"] = name
            end
        end
    end
    p:setInventaire(inv)
end)

RegisterNetEvent("core:renameClothPlayer")
AddEventHandler("core:renameClothPlayer", function(item, name, metadatas)
    local inv = p:getInventaire()
    for k, v in pairs(inv) do
        if item == v.name and v.metadatas["drawableId"] == metadatas["drawableId"] and v.metadatas["renamed"] == metadatas["renamed"] then
            if v.metadatas == nil then v.metadatas = {} end
            v.metadatas["renamed"] = name
        end
    end
    p:setInventaire(inv)
end)

RegisterNetEvent("core:RemoveItemFromInventoryNil")
AddEventHandler("core:RemoveItemFromInventoryNil", function(name, quantity, metadatas)
    local inv = p:getInventaire()
    if inv ~= nil then
        for i = 1, #inv do
            if inv[i] ~= nil then
                if inv[i].name ~= nil and inv[i].metadatas == nil then
                    if inv[i].name == "money" and inv[i].metadatas == nil then
                        if inv[i].count - quantity <= 0 then table.remove(inv, i)
                        else inv[i].count = inv[i].count - quantity end
                        p:setInventaire(inv)
                        break
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("core:RemoveMetadatasInventory")
AddEventHandler("core:RemoveMetadatasInventory", function(name, quantity, metadatas)
    local inv = p:getInventaire()
    if inv ~= nil then
        print('1')
        for i = 1, #inv do
            if inv[i] ~= nil then
                print('2', quantity, inv[i].count, inv[i].count - quantity)
                if inv[i].name ~= nil and inv[i].metadatas ~= nil and CompareMetadatas(inv[i].metadatas, metadatas) and inv[i].name == name then
                    print(json.encode(inv[i]))
                    if inv[i].count - quantity <= 0 then table.remove(inv, i)
                    else inv[i].count = inv[i].count - quantity end
                    print(json.encode(inv[i]))
                    p:setInventaire(inv)
                    break
                end
            end
        end
    end
end)