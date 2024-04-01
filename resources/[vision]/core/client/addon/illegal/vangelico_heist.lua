--[[local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

--TODO: add les items

local vangelicoHeist = {
    ["globalObj"] = nil,
    ['globalItem'] = nil,
}
local alarmeOff = false
local insideLoop = false
local busy = false
local prevAnim = ''
local blip = {}

local reward = nil
local glass = nil
local rewardDisp = nil

function StartVangelicoHeist()
    local isBraqued = TriggerServerCallback("core:getIfAlrdyRobbed")
    if not isBraqued and not alarmeOff then
        local policeMans = TriggerServerCallback("core:getNumberOfDuty", token,'lspd') + TriggerServerCallback("core:getNumberOfDuty", token,'lssd')
        if policeMans >= 1 then
            if IsPedArmed(p:ped(), 4) then
                SetCurrentPedWeapon(p:ped(), GetHashKey('WEAPON_UNARMED'), true)
                local prop = entity:CreateObject("prop_phone_ing_03", p:pos())
                if prop then
                    p:PlayAnim("anim@heists@humane_labs@emp@hack_door", "hack_intro", 0)
                    Wait(100)
                    AttachEntityToEntity(prop:getEntityId(), p:ped(), GetPedBoneIndex(p:ped(), 28422), 0.0, 0.0, 0.0, 0.0
                        , 0.0, 0.0, false, false, false, false, 2, true)
                    Wait(GetAnimDuration("anim@heists@humane_labs@emp@hack_door", "hack_intro") * 1000)
                    p:PlayAnim("anim@heists@humane_labs@emp@hack_door", "hack_loop", 0)
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'Progressbar',
                        data = {
                            text = "Crackage en cours",
                            time = 10,
                        }
                    }))
                    Wait(10000)
                    prop:delete()
                    local callpolice = math.random(0, 100)
                    if callpolice > 20 then
                        TriggerServerEvent('core:makeCall', "lspd",
                            vector3(-633.33001708984, -238.84931945801, 38.069793701172), true,
                            "Braquage de bijouterie")
                        TriggerServerEvent('core:makeCall', "lssd",
                            vector3(-633.33001708984, -238.84931945801, 38.069793701172), true,
                            "Braquage de bijouterie")
                        -- ShowNotification("~r~L'alarme a été déclenchée, la police arrive !")

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "L'alarme a été déclenchée, ~s la police arrive !"
                        })

                        alarmeOff = true
                    else
                        alarmeOff = true
                    end


                    if alarmeOff then
                        local random = math.random(1, 4)
                        local glassConfig = vangelico_config["glassCutting"]
                        loadModel(glassConfig.rewards[random].object.model)
                        loadModel(glassConfig.rewards[random].displayObj.model)
                        loadModel('h4_prop_h4_glass_disp_01a')

                        glass = CreateObject(GetHashKey('h4_prop_h4_glass_disp_01a'), -617.4622, -227.4347, 37.057, 1, 1
                            , 0)
                        SetEntityHeading(glass, -53.06)
                        reward = CreateObject(GetHashKey(glassConfig.rewards[random].object.model),
                            glassConfig.rewardPos.xy, glassConfig.rewardPos.z + 0.195, 1, 1, 0)
                        SetEntityHeading(reward, glassConfig['rewards'][random]['object']['rot'])
                        rewardDisp = CreateObject(GetHashKey(glassConfig.rewards[random].displayObj.model),
                            glassConfig.rewardPos, 1, 1, 0)
                        SetEntityRotation(rewardDisp, glassConfig.rewards[random].displayObj.rot)
                        TriggerServerEvent('core:globalObject', glassConfig.rewards[random].object.model, random)

                        TriggerServerEvent('core:insideLoop')
                    end
                end
            end
        else
            -- ShowNotification("Reviens plus tard !")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Reviens plus tard !"
            })
            
        end
    else
        -- ShowNotification("La boutique a deja été vandalisée")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s La boutique a deja été vandalisée !"
        })

    end
end

RegisterNetEvent("core:globalObjectStock")
AddEventHandler("core:globalObjectStock", function(obj, random)
    vangelicoHeist['globalObj'] = obj
    vangelicoHeist['globalItem'] = vangelico_config["glassCutting"].rewards[random].item
end)

RegisterNetEvent("core:playerInsideLoop")
AddEventHandler("core:playerInsideLoop", function()
    loadAnimDict('missheist_jewel')
    loadAnimDict('anim@scripted@heist@ig16_glass_cut@male@')
    loadPtfxAsset('scr_ih_fin')
    insideLoop = true
    for k, v in pairs(vangelico_config['smashScenes']) do
        if not DoesBlipExist(blip[k]) then
            blip[k] = AddBlipForCoord(v.objPos)
            SetBlipScale(blip[k], 0.2)
            SetBlipColour(blip[k], 3)
        end
    end
    blip[21] = AddBlipForCoord(vector3(-617.4622, -227.4347, 37.057))
    SetBlipScale(blip[21], 0.2)
    SetBlipColour(blip[21], 3)
    Citizen.CreateThread(function()
        while insideLoop do
            local sleep = 1000
            local dst = #(p:pos() - vector3(-617.4622, -227.4347, 37.057))

            if dst <= 1.5 and not busy and not vangelico_config["glassCutting"].loot then
                sleep = 1
                --TODO: get si le mec a l'item pour casser la vitre
                ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour casser la vitre")
                if IsControlJustPressed(0, 38) then
                    OverHeatScene()
                end
            end

            if dst >= 40.0 then
                Outside()
                break
            end

            for k, v in pairs(vangelico_config["smashScenes"]) do
                local dst = #(p:pos() - v.objPos)

                if dst <= 1.3 and not v.loot and not busy then
                    sleep = 1
                    ShowHelpNotification("Appuyer sur ~INPUT_CONTEXT~ pour casser la vitre")
                    if IsControlJustPressed(0, 38) then
                        if IsPedArmed(p:ped(), 4) then
                            SmashScene(k)
                        else
                            -- ShowNotification("Tu as besoin d'une arme pour casser la vitre")

                            -- New notif
                            exports['vNotif']:createNotification({
                                type = 'ROUGE',
                                -- duration = 5, -- In seconds, default:  4
                                content = "Tu as ~s besoin d'une arme ~c pour casser la vitre"
                            })

                        end
                    end
                end

            end
            Wait(1)
        end
    end)
end)


function OverHeatScene()
    local reusite = math.random(0, 100)
    busy = true
    local animDict = 'anim@scripted@heist@ig16_glass_cut@male@'
    sceneObject = GetClosestObjectOfType(-617.4622, -227.4347, 37.057, 1.0, GetHashKey('h4_prop_h4_glass_disp_01a'), 0, 0
        , 0)
    scenePos = GetEntityCoords(sceneObject)
    sceneRot = GetEntityRotation(sceneObject)
    globalObj = GetClosestObjectOfType(-617.4622, -227.4347, 37.057, 5.0, GetHashKey(vangelicoHeist['globalObj']), 0, 0,
        0)
    loadAnimDict(animDict)
    RequestScriptAudioBank('DLC_HEI4/DLCHEI4_GENERIC_01', -1)

    cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
    SetCamActive(cam, true)
    RenderScriptCams(true, 0, 3000, 1, 0)

    for k, v in pairs(vangelico_config.Overheat['objects']) do
        loadModel(v)
        vangelico_config.Overheat['sceneObjects'][k] = CreateObject(GetHashKey(v), p:pos(), 1, 1, 0)
    end

    local newObj = CreateObject(GetHashKey('h4_prop_h4_glass_disp_01b'), GetEntityCoords(sceneObject), 1, 1, 0)
    SetEntityHeading(newObj, GetEntityHeading(sceneObject))

    for i = 1, #vangelico_config.Overheat['animations'] do
        vangelico_config.Overheat['scenes'][i] = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, true, false,
            1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(p:ped(), vangelico_config.Overheat['scenes'][i], animDict,
            vangelico_config.Overheat['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(vangelico_config.Overheat['sceneObjects'][1],
            vangelico_config.Overheat['scenes'][i], animDict, vangelico_config.Overheat['animations'][i][2], 1.0, -1.0,
            1148846080)
        NetworkAddEntityToSynchronisedScene(vangelico_config.Overheat['sceneObjects'][2],
            vangelico_config.Overheat['scenes'][i], animDict, vangelico_config.Overheat['animations'][i][3], 1.0, -1.0,
            1148846080)
        if i ~= 5 then
            NetworkAddEntityToSynchronisedScene(sceneObject, vangelico_config.Overheat['scenes'][i], animDict,
                vangelico_config.Overheat['animations'][i][4], 1.0, -1.0, 1148846080)
        else
            NetworkAddEntityToSynchronisedScene(newObj, vangelico_config.Overheat['scenes'][i], animDict,
                vangelico_config.Overheat['animations'][i][4], 1.0, -1.0, 1148846080)
        end
    end

    local sound1 = GetSoundId()
    local sound2 = GetSoundId()

    NetworkStartSynchronisedScene(vangelico_config.Overheat['scenes'][1])
    PlayCamAnim(cam, 'enter_cam', animDict, scenePos, sceneRot, 0, 2)
    Wait(GetAnimDuration(animDict, 'enter') * 1000 - 1000)

    NetworkStartSynchronisedScene(vangelico_config.Overheat['scenes'][2])
    PlayCamAnim(cam, 'idle_cam', animDict, scenePos, sceneRot, 0, 2)
    Wait(GetAnimDuration(animDict, 'idle') * 1000 - 1500)

    NetworkStartSynchronisedScene(vangelico_config.Overheat['scenes'][3])
    PlaySoundFromEntity(sound1, "StartCutting", vangelico_config.Overheat['sceneObjects'][2],
        'DLC_H4_anims_glass_cutter_Sounds', true, 80)
    loadPtfxAsset('scr_ih_fin')
    UseParticleFxAssetNextCall('scr_ih_fin')
    fire1 = StartParticleFxLoopedOnEntity('scr_ih_fin_glass_cutter_cut', vangelico_config.Overheat['sceneObjects'][2],
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1065353216, 0.0, 0.0, 0.0, 1065353216, 1065353216, 1065353216, 0)
    PlayCamAnim(cam, 'cutting_loop_cam', animDict, scenePos, sceneRot, 0, 2)
    Wait(GetAnimDuration(animDict, 'cutting_loop') * 1000)
    StopSound(sound1)
    StopParticleFxLooped(fire1)

    if reusite < 50 then
        -- ShowNotification("Vous avez récupéré le diamant !")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'JAUNE',
            -- duration = 5, -- In seconds, default:  4
            content = "Vous avez ~s récupéré le diamant !"
        })

        TriggerServerEvent('core:lootSync', 'glassCutting')
        DeleteObject(sceneObject)
        NetworkStartSynchronisedScene(vangelico_config.Overheat['scenes'][5])
        Wait(2000)
        DeleteObject(globalObj)
        PlayCamAnim(cam, 'success_cam', animDict, scenePos, sceneRot, 0, 2)
        Wait(GetAnimDuration(animDict, 'success') * 1000 - 2000)
        DeleteObject(vangelico_config.Overheat['sceneObjects'][1])
        DeleteObject(vangelico_config.Overheat['sceneObjects'][2])
        ClearPedTasks(p:ped())
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
        TriggerSecurGiveEvent("core:addItemToInventory", token, "diamond", 1, {})
        busy = false
        TriggerServerEvent('core:vangelico_removeBlips', blip[21])
    else
        -- ShowNotification("Vous avez échoué, prenez la fuite !")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "Vous avez ~s échoué,~c prenez la fuite !"
        })

        vangelico_config['glassCutting'].loot = true
        NetworkStartSynchronisedScene(vangelico_config.Overheat['scenes'][4])
        PlaySoundFromEntity(sound2, "Overheated", vangelico_config.Overheat['sceneObjects'][2],
            'DLC_H4_anims_glass_cutter_Sounds', true, 80)
        UseParticleFxAssetNextCall('scr_ih_fin')
        fire2 = StartParticleFxLoopedOnEntity('scr_ih_fin_glass_cutter_overheat',
            vangelico_config.Overheat['sceneObjects'][2], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1065353216, 0.0, 0.0, 0.0)
        PlayCamAnim(cam, 'overheat_react_01_cam', animDict, scenePos, sceneRot, 0, 2)
        Wait(GetAnimDuration(animDict, 'overheat_react_01') * 1000)
        StopSound(sound2)
        StopParticleFxLooped(fire2)

        DeleteObject(sceneObject)
        NetworkStartSynchronisedScene(vangelico_config.Overheat['scenes'][6])
        DeleteObject(globalObj)
        PlayCamAnim(cam, 'exit_cam', animDict, scenePos, sceneRot, 0, 2)
        Wait(GetAnimDuration(animDict, 'exit') * 1000)
        DeleteObject(vangelico_config.Overheat['sceneObjects'][1])
        DeleteObject(vangelico_config.Overheat['sceneObjects'][2])
        ClearPedTasks(p:ped())
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
        busy = false
    end
end

function Outside()
    insideLoop = false
    for i = 1, #blip, 1 do
        if DoesBlipExist(blip[i]) then
            RemoveBlip(blip[i])
        end
    end
    blip = {}
    for k, v in pairs(vangelico_config['smashScenes']) do
        v.loot = false
    end
    vangelico_config['glassCutting'].loot = false
    local glassObjectDel = GetClosestObjectOfType(-617.4622, -227.4347, 37.057, 1.0,
        GetHashKey('h4_prop_h4_glass_disp_01a'), 0, 0, 0)
    local glassObjectDel2 = GetClosestObjectOfType(-617.4622, -227.4347, 37.057, 1.0,
        GetHashKey('h4_prop_h4_glass_disp_01b'), 0, 0, 0)
    SetModelAsNoLongerNeeded(GetHashKey('h4_prop_h4_glass_disp_01a'))
    SetModelAsNoLongerNeeded(GetHashKey('h4_prop_h4_glass_disp_01b'))
    SetModelAsNoLongerNeeded(GetHashKey(glassConfig.rewards[random].object.model))
    SetModelAsNoLongerNeeded(GetHashKey(glassConfig.rewards[random].displayObj.model))
    DeleteObject(glassObjectDel)
    DeleteObject(glassObjectDel2)
    DeleteObject(glass)
    DeleteObject(reward)
    DeleteObject(rewardDisp)
end

function SmashScene(index)
    --if GetSelectedPedWeapon(p:ped()) then
    busy = true
    TriggerServerEvent('core:lootSync', 'smashScenes', index)
    local animDict = 'missheist_jewel'
    local ptfxAsset = "scr_jewelheist"
    local particleFx = "scr_jewel_cab_smash"
    loadAnimDict(animDict)
    loadPtfxAsset(ptfxAsset)
    local sceneCfg = vangelico_config['smashScenes'][index]
    SetEntityCoords(p:ped(), sceneCfg.scenePos)
    local anims = {
        { 'smash_case_necklace', 300 },
        { 'smash_case_d', 300 },
        { 'smash_case_e', 300 },
        { 'smash_case_f', 300 }
    }
    local selected = ""
    repeat
        selected = anims[math.random(1, #anims)]
    until selected ~= prevAnim
    prevAnim = selected

    if index == 4 or index == 10 or index == 14 or index == 8 then
        selected = { 'smash_case_necklace_skull', 300 }
    end

    cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
    SetCamActive(cam, true)
    RenderScriptCams(true, 0, 0, 0, 0)

    scene = NetworkCreateSynchronisedScene(sceneCfg['scenePos'], sceneCfg['sceneRot'], 2, true, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(p:ped(), scene, animDict, selected[1], 2.0, 4.0, 1, 0, 1148846080, 0)
    NetworkStartSynchronisedScene(scene)

    PlayCamAnim(cam, 'cam_' .. selected[1], animDict, sceneCfg['scenePos'], sceneCfg['sceneRot'], 0, 2)

    Wait(300)

    TriggerServerEvent('core:smashSync', sceneCfg)
    for i = 1, 5 do
        PlaySoundFromCoord(-1, "Glass_Smash", sceneCfg['objPos'], 0, 0, 0)
    end
    SetPtfxAssetNextCall(ptfxAsset)
    StartNetworkedParticleFxNonLoopedAtCoord(particleFx, sceneCfg['objPos'], 0.0, 0.0, 0.0, 2.0, 0, 0, 0)
    Wait(GetAnimDuration(animDict, selected[1]) * 1000 - 1000)
    ClearPedTasks(p:ped())
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    TriggerServerEvent('core:vangelico_removeBlips', blip[index])
    TriggerSecurGiveEvent("core:addItemToInventory", token, "jewel", 1, {})
    busy = false
    --end
end

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(0)
    end
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(50)
    end
end

function loadPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do
        RequestNamedPtfxAsset(dict)
        Wait(50)
    end
end

RegisterNetEvent("core:lootSyncObj")
AddEventHandler("core:lootSyncObj", function(type, index)
    if index then
        vangelico_config[type][index].loot = true
    else
        vangelico_config[type].loot = true
    end
end)

RegisterNetEvent("core:smashSyncObj")
AddEventHandler("core:smashSyncObj", function(sceneCfg)
    CreateModelSwap(sceneCfg.objPos, 0.3, GetHashKey(sceneCfg['oldModel']), GetHashKey('newModel'), 1)
end)

RegisterNetEvent("core:playerVangelico_removeBlips")
AddEventHandler("core:playerVangelico_removeBlips", function(blip)
    RemoveBlip(blip)
    blip = nil
end)

Citizen.CreateThread(function()
    while zone == nil do Wait(1) end

    zone.addZone(
        "vangelico_heist", -- Nom
        vector3(-631.50, -234.57, 38.05), -- Position
        "Appuyez sur ~INPUT_CONTEXT~ pour retirer l'alarme (Braquage)", -- Text afficher
        function() -- Action qui seras fait
            StartVangelicoHeist()
        end,
        false
    )
end)]]