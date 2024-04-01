local token = nil
local timer = 2 * 60000 ---2 minutes
local inHeist = false
local inHouse = false
local common
local recolt = false
local sound = 0
local looted = 0
local obj
local colorAlerte = { 3, 157, 26, 150 }
local alertePolice = false
local textAlerte = "Relativement calme"
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local RollTable = {}
local sizeOfItemList = 0
for k, v in pairs(House_heist_Item) do
    sizeOfItemList = sizeOfItemList + 1
end
-- sizeOfItemList = 18 pour l'instant
for i = 1, sizeOfItemList do
    for j = 1, House_heist_Item[i].luck do
        table.insert(RollTable, House_heist_Item[i])
    end
end

local function Roll() --> ObjectName [string]
    return RollTable[math.random(1, #RollTable)]
end

---
local name = nil
local boucle = false
function StartHouseHeist(id, pos, posInside, coffre)
    local policeMans = TriggerServerCallback("core:getNumberOfDuty", token,'lspd') + TriggerServerCallback("core:getNumberOfDuty", token,'lssd')
    if policeMans >= 3 then
        if p:haveItem("crochet") and not inHeist then
            for _, value in pairs(p:getInventaire()) do
                if value.name == "crochet" then
                    TriggerServerEvent("core:RemoveItemToInventory", token, "crochet", 1, value.metadatas)
                end
            end
            RequestAnimDict('missheistfbisetup1')
            while not HasAnimDictLoaded('missheistfbisetup1') do
                Wait(0)
            end
            p:PlayAnim('missheistfbisetup1', 'hassle_intro_loop_f', 1)
            SendNuiMessage(json.encode({
                type = 'closeWebview'
            }))
            SendNuiMessage(json.encode({
                type = 'openWebview',
                name = 'Progressbar',
                data = {
                    text = "Crochetage en cours...",
                    time = 10,
                }
            }))
            RemoveAnimDict("missheistfbisetup1")
            Modules.UI.RealWait(10000)
            TriggerServerEvent("core:heistlog", id, pos)
            if not inHeist then
                inHeist = true
            end
            alertePolice = false
            recolt = false
            common = {}
            looted = 0
            boucle = false

            ---start du cambriolage
            -- Tp
            TriggerServerEvent("core:addCrewExp", p:getCrew(), 100, "heist")
            TriggerServerEvent("core:InstancePlayer", token, id, "house_heist : Ligne 76")
            SetEntityCoordsNoOffset(p:ped(), posInside, 0.0, 0.0, 0.0)
            if not inHouse then
                inHouse = true
            end
            -- sortie
            if inHouse and inHeist and not boucle then
                boucle = true
                CreateThread(function()
                    while inHeist do
                        if #(p:pos() - pos) > 20 and not inHouse then
                            timer = 2 * 60000 ---3 minute
                            inHouse = false
                            recolt = false
                            sound = 0
                            boucle = false
                            colorAlerte = { 3, 157, 26, 150 }
                            alertePolice = false
                            textAlerte = "Relativement calme"
                            inHeist = false
                            return
                        end
                        Wait(1)
                        if IsPedRunning(p:ped()) and sound <= 100 and inHouse then
                            sound = sound + 0.1
                        end
                        if MumbleIsPlayerTalking(PlayerId()) and sound <= 100 and inHouse then
                            sound = sound + 0.03
                        end
                        if IsPedJumping(p:ped()) and sound <= 100 and inHouse then
                            sound = sound + 0.1
                        end
                        if IsPedWalking(p:ped()) and not GetPedStealthMovement(p:ped()) and sound <= 100 and inHouse then
                            sound = sound + 0.06
                        end
                        if sound <= 30 then
                            colorAlerte = { 3, 157, 26, 150 }
                            textAlerte = "Relativement calme"
                        elseif sound > 30 and sound <= 63 then
                            colorAlerte = { 157, 108, 3, 150 }
                            textAlerte = "Bruyant"
                        elseif sound > 60 then
                            colorAlerte = { 157, 3, 3, 150 }
                            textAlerte = "T'as réveillé le voisin"
                        end

                        Modules.UI.DrawSlider(0.42532941699028, 0.953125, 0.2, 0.03, { 0, 0, 0, 150 }, colorAlerte, sound
                            ,
                            100, {}, function()
                        end)
                        Modules.UI.DrawTexts(0.52489018440247, 0.95572918653488, textAlerte, true, 0.35,
                            { 255, 255, 255, 200 }, 1, false, false)
                    end
                end)
                CreateThread(function()

                    while inHeist do
                        local gamePool = GetGamePool("CVehicle")
                        ----check distance
                        if #(p:pos() - pos) > 20 and not inHouse then
                            timer = 2 * 60000 ---3 minute
                            inHouse = false
                            recolt = false
                            sound = 0
                            colorAlerte = { 3, 157, 26, 150 }
                            alertePolice = false
                            textAlerte = "Relativement calme"
                            boucle = false
                            inHeist = false
                            return
                        end
                        -- item zone
                        for key, value in pairs(coffre) do

                            while #(p:pos() - value) < 1 do
                                ShowHelpNotification("Appuyez sur ~r~~INPUT_CONTEXT~~s~ pour fouiller.")
                                if IsControlJustReleased(0, 38) and not recolt then

                                    item = Roll()
                                    common = item
                                    if item ~= nil then
                                        ClearPedTasksImmediately(p:ped())
                                        ExecuteCommand("e c")

                                        if item.propsName ~= "" then
                                            name = item.propsName
                                            obj = entity:CreateObject(item.propsName, p:pos())
                                            SetEntityCollision(obj:getEntityId(), false, true)
                                            AttachEntityToEntity(obj:getEntityId(), p:ped(),
                                                GetEntityBoneIndexByName(p:ped(), "IK_R_Hand"), item.offset[1],
                                                item.offset[2], item.offset[3], item.offset[4], item.offset[5],
                                                item.offset[6], false, false, false, false, 0.0, true)
                                        end
                                        if item.emote then
                                            p:PlayAnim(item.dict, item.anim, 49)
                                        else
                                            ExecuteCommand("e box")
                                        end
                                        recolt = true
                                    else
                                        -- ShowNotification("Vous n'avez rien trouvé.")

                                        -- New notif
                                        exports['vNotif']:createNotification({
                                            type = 'JAUNE',
                                            -- duration = 5, -- In seconds, default:  4
                                            content = "Vous n'avez ~s rien trouvé."
                                        })
                                    end
                                end
                                Wait(1)
                            end
                        end


                        -- Alerte police
                        if sound >= 60 and not alertePolice then
                            alertePolice = true
                            -- ShowNotification("~r~Attention~s~ La police à été alertée ! ")

                            -- New notif
                            exports['vNotif']:createNotification({
                                type = 'JAUNE',
                                -- duration = 5, -- In seconds, default:  4
                                content = "~s Attention, ~c La police à été alertée ! "
                            })

                            TriggerServerEvent('core:makeCall', "lspd", pos, true,
                                "cambriolage", false, 'illegal')

                            TriggerServerEvent('core:makeCall', "lssd", pos, true,
                                "cambriolage", false, 'illegal')
                        end

                        -- timer police

                        CreateThread(function()
                            while not alertePolice do
                                alertePolice = true
                                Wait(timer)
                                TriggerServerEvent('core:makeCall', "lspd", pos, true,
                                    "cambriolage", false, "illegal")
                                TriggerServerEvent('core:makeCall', "lssd", pos, true,
                                    "cambriolage", false, "illegal")
                                return
                            end
                        end)
                        ---Detection vehicule
                        for k, v in pairs(gamePool) do
                            while #
                                (
                                p:pos() - GetWorldPositionOfEntityBone(v, GetEntityBoneIndexByName(v, "platelight")) +
                                    vector3(0.0, 0.0, 0.5)) < 1.5 and recolt do
                                ShowHelpNotification("Appuyer sur ~r~~INPUT_CONTEXT~~s~ pour mettre l'objet dans le coffre.")
                                if IsControlJustReleased(0, 38) and recolt then
                                    SetVehicleDoorOpen(v, 5, false, false)
                                    p:PlayAnim("anim@heists@narcotics@trash", "throw_b", 49)
                                    Wait(1000)
                                    local plate = all_trim(GetVehicleNumberPlateText(v))
                                    TriggerServerCallback("core:GetVehicleInventory", tostring(plate), GetEntityModel(v), v, VehToNet(v))
                                    TriggerServerEvent("core:AddItemToVehicle", token, common.label, 1, tostring(plate), {})
                                    -- ShowNotification("vous venez de déposer un(e) " .. common.item)

                                    -- New notif
                                    exports['vNotif']:createNotification({
                                        type = 'JAUNE',
                                        -- duration = 5, -- In seconds, default:  4
                                        content = "Vous venez de déposer un(e) ~s " .. common.item
                                    })

                                    ExecuteCommand("e c")
                                    ClearPedTasksImmediately(p:ped())
                                    if obj ~= nil then
                                        obj:delete()
                                    end
                                    SetVehicleDoorShut(v, 5, false)
                                    recolt = false
                                    looted = looted + 1
                                    if looted == 5 then
                                        inHouse = false
                                        recolt = false
                                        sound = 0
                                        colorAlerte = { 3, 157, 26, 150 }
                                        alertePolice = false
                                        boucle = false
                                        textAlerte = "Relativement calme"
                                        -- ShowNotification("Vous avez fini de fouiller la maison.")

                                        -- New notif
                                        exports['vNotif']:createNotification({
                                            type = 'JAUNE',
                                            -- duration = 5, -- In seconds, default:  4
                                            content = "Vous avez ~s fini de fouiller ~c la maison."
                                        })

                                        inHeist = false
                                        break
                                    end
                                end
                                Wait(1)
                            end
                        end
                        ---sortie
                        while #(p:pos() - pos) < 2 do
                            ShowHelpNotification("Appuyer sur ~r~~INPUT_CONTEXT~~s~ pour rentrer")
                            if IsControlJustReleased(0, 38) and inHeist then
                                StartHouseHeist(id, pos, posInside, coffre)
                                -- StartHouseHeist(id)
                            end
                            Wait(1)
                        end
                        while #(p:pos() - posInside) < 3 do
                            ShowHelpNotification("Appuyer sur ~r~~INPUT_CONTEXT~~s~ pour sortir")
                            if IsControlJustReleased(0, 38) and inHeist then
                                SetEntityCoordsNoOffset(p:ped(), pos, 0.0, 0.0, 0.0)
                                inHouse = false
                                TriggerServerEvent("core:InstancePlayer", token, 0, "house_heist : Ligne 292")
                                if obj ~= nil then
                                    obj:delete()
                                end
                                Wait(300)

                                if common ~= nil and common.emote and recolt then
                                    p:PlayAnim(common.dict, common.anim, 49)
                                    obj = entity:CreateObject(name, p:pos())
                                    SetEntityCollision(obj:getEntityId(), false, true)
                                    AttachEntityToEntity(obj:getEntityId(), p:ped(),
                                        GetEntityBoneIndexByName(p:ped(), "IK_R_Hand"), common.offset[1],
                                        common.offset[2],
                                        common.offset[3], common.offset[4], common.offset[5], common.offset[6], false,
                                        false, false, false, 0.0, true)
                                elseif recolt then
                                    ExecuteCommand("e box")

                                end
                            end
                            Wait(1)
                        end
                        Wait(100)
                    end
                end)
            end
        else
            if inHeist then
                TriggerServerEvent("core:InstancePlayer", token, id, "house_heist : Ligne 320")
                SetEntityCoordsNoOffset(p:ped(), posInside, 0.0, 0.0, 0.0)
                RageUI.CloseAll()
                inHouse = true
                if recolt then
                    if common ~= nil and common.emote and recolt then
                        p:PlayAnim(common.dict, common.anim, 49)
                    elseif recolt then
                        ExecuteCommand("e box")
                    end
                end
            else
                -- ShowNotification("Tu n'as pas les ~r~outils nécessaire~s~.")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Tu n'as pas les ~s outils nécessaire."
                })

            end

            return
        end
    else
        print("Pas assez de policier en service")
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "Essayez plus tard."
        })
    end

end

local PropertyData = {}
---Point d'entrer et sortie
-- CreateThread(function()
--     while zone == nil do
--         Wait(1)
--     end
--     Wait(5000)
--     local property = TriggerServerCallback("core:getPropertyList", token)
--     local tables = {}
--     PropertyData = property
--     -- for k, v in pairs(House_heist.House) do
--     --     for key, value in pairs(PropertyData) do
--     --         local vec= vec3(tonumber(value.enter_pos.x), tonumber(value.enter_pos.y), tonumber(value.enter_pos.z))
--     --         local pos = #(v.EnterPos - vec)
--     --         if pos >= 5.0 then
--     --             if json.encode(tables) == "[]" then
--     --                 table.insert(tables, {name = v.name, pos = v.EnterPos, k= k})
--     --             end
--     --             for _, i in pairs(tables) do
--     --                 if i.pos ~= v.EnterPos then
--     --                     table.insert(tables, {name = v.name, pos = v.EnterPos, k= k})
--     --                 end
--     --             end
--     --         end
--     --     end
--     -- end
--     for k, v in pairs(House_heist.House) do
--         zone.addZone(v.name .. math.random(0,456456454), -- Nom
--         v.EnterPos, -- Position
--         nil, -- Text afficher
--         function() -- Action qui seras fait
--             if p:haveItem("crochet") then
--                 StartHouseHeist(k)
--             end
--         end, false)
--     end

-- end)


RegisterNetEvent("core:UseCrocket")
AddEventHandler("core:UseCrocket", function()
    -- for k, v in pairs(House_heist.House) do
    --     if #(p:pos() - v.EnterPos) <= 3.0 then
    --         StartHouseHeist(k)
    --     end
    -- end
    local properties = GetAllProperties()
    for k, v in pairs(properties) do -- load property
        if #(p:pos() - vector3(v.enter_pos.x, v.enter_pos.y, v.enter_pos.z)) <= 3.0 then
            for key, value in pairs(v.data) do
                local proper = TriggerServerCallback("core:property:getProperty", token, v.id)
                Enter(v.id, vector3(v.enter_pos.x, v.enter_pos.y, v.enter_pos.z), proper)
                -- body
                return
            end


        end
    end
end)

function Enter(id, enter, property)
    if property.data.type == "habitation" then
        property.data.type = "Appartement"
    end
    
    if property.data.type == "stockage" then
        property.data.type = "Entrepot"
    end

    if property.data.type == "garage" then
        property.data.type = "Garage"
    end
    for k, v in pairs(Property) do
        for i = 1, #Property[k].data do
            RemoveIpl(Property[k].data[i].ipl)
        end
        if k == property.data.type then
            for _, i in pairs(v.data) do
                if i.name == property.data.interior then
                    if i.ipl ~= "" then
                        EnableIpl(i.ipl, true)

                        while not IsIplActive(i.ipl) do
                            Wait(1)
                        end
                    end
                    if string.find(property.data.interior, "Vide") then 
                        exports['vNotif']:createNotification({
                            type = 'ROUGE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "~s Cette propriétée est sécurisé"
                        })
                        return
                    end
                    if property.data.type ~= "Garage" then
                        StartHouseHeist(id, enter, i.leave, i.itemPos)
                    else
                        -- ShowNotification("~r~Cette propriétée est sécurisé")

                        -- New notif
                        exports['vNotif']:createNotification({
                            type = 'ROUGE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "~s Cette propriétée est sécurisé"
                        })

                    end
                end
            end
        end
    end
end
