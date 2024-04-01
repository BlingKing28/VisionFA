local entityType = 0
local toIgnore = 0
local flags = -1
local raycastLength = 20
local abs = math.abs
local cos = math.cos
local sin = math.sin
local pi = math.pi
local player
local playerCoords
local display = false
local key = 20
local startRaycast = false
local oldEntity = 0
local clickedEntity = 0
local chatOpen = false
local menu ---@type RubyUI
local clickable = false
AddEventHandler("chatActive", function(status)
    chatOpen = status
end)

function ClosetContextMenu()
    startRaycast = false
    ResetEntityAlpha(oldEntity)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
end

Keys.Register("`", "`", "Menu contextuel", function()
    if chatOpen then
        return
    end
    if not startRaycast then
        startRaycast = true
        -- SetNuiFocus(true, true)
        -- SetNuiFocusKeepInput(true, true)
        SetCursorLocation(0.5, 0.5)
        oldEntity = 0
        clickedEntity = 0
        -- Context.MouseOnMenu = false
        SetCurrentPedWeapon(p:ped(), 'WEAPON_UNARMED', true)
    else
        ResetEntityAlpha(oldEntity)
        startRaycast = false
        -- SetNuiFocus(false, false)
        -- SetNuiFocusKeepInput(false)
        Wait(500)
    end
end)
CreateThread(function()
    SetNuiFocus(false, false)
    while true do
        local pNear = false

        if startRaycast then
            DisableControlAction(0, 1, true) -- LookLeftRight
            DisableControlAction(0, 2, true) -- LookUpDown
            DisableControlAction(0, 142, true) -- MeleeAttackAlternate
            DisableControlAction(0, 18, true) -- Enter
            DisableControlAction(0, 322, true) -- ESC
            DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
            SetMouseCursorActiveThisFrame()

            --local hit, endCoords, surfaceNormal, entityHit, entityType, direction = ScreenToWorld(flags, toIgnore)
            -- print(GetControlNormal(0, 239), GetControlNormal(0, 240))
            local screenPosition = { x = GetControlNormal(0, 239), y = GetControlNormal(0, 240) }
            local hit, endCoords, normalDir, entityHit = ScreenToWorld(screenPosition, raycastLength)

            if menu == nil then
                menu = RubyUI:CreateMenu("Context", GetControlNormal(0, 239), GetControlNormal(0, 240))
            end


            -- print(entityHit, menu:GetMouseOnMenu())
            if entityHit ~= nil and entityHit ~= 0 then
                SetCursorSprite(4)



                if menu:GetMouseOnMenu() == false then
                    if entityHit ~= oldEntity then
                        ResetEntityAlpha(oldEntity)
                    end
                    oldEntity = entityHit
                    SetEntityAlpha(oldEntity, 170, false)
                else
                    SetCursorSprite(1)
                end
                local type = GetEntityType(entityHit)
                if type == 1 and #GetContextPedActionByJob(pJob) >= 0 then
                    clickable = true
                elseif type == 1 and #GetContextPedActionByJob(pJob) == 0 then
                    clickable = false
                end
                if type == 2 and #GetContextVehActionByJob(pJob) >= 0 or
                    #GetContextActionForVeh(GetEntityModel(entityHit)) > 0 then
                    clickable = true
                elseif type == 2 and #GetContextVehActionByJob(pJob) == 0 and
                    #GetContextActionForVeh(GetEntityModel(entityHit)) == 0 then
                    clickable = false
                end

                if type == 3 and #GetContextActionForObject(GetEntityModel(entityHit)) > 0 then
                    clickable = true
                elseif type == 3 and #GetContextActionForObject(GetEntityModel(entityHit)) == 0 then
                    clickable = false
                end
                if IsControlJustReleased(0, 24) and clickable then
                    CancelEvent()
                    SetNuiFocus(false, true)
                    if clickedEntity ~= oldEntity and oldEntity ~= 0 and menu:GetMouseOnMenu() == false then
                        clickedEntity = oldEntity

                        -- menu = RubyUI:CreateMenu("Context", GetControlNormal(0, 239), GetControlNormal(0, 240))
                        -- menu:HandleCooldown()
                        Context.setTargetEntity(oldEntity)

                        Context.GenerateMenuBasedOnEntity(oldEntity, menu)
                    end
                end


            else
                SetCursorSprite(1)
                --print(Context.MouseOnMenu)
                if IsControlJustReleased(0, 24) and menu:GetMouseOnMenu() == false then
                    clickedEntity = 0
                    ResetEntityAlpha(oldEntity)
                    startRaycast = false
                    --SetNuiFocus(false, false)
                    --SetNuiFocusKeepInput(false)
                    menu.isMouseOnAnyMenu = false
                    menu = nil
                    HandleContextMenuAttackCooldown()
                end
            end

            if clickedEntity ~= 0 then
                -- Context.render()
                -- if menu:Render() then
                clickedEntity = 0
                ResetEntityAlpha(oldEntity)
                startRaycast = false
                menu.isMouseOnAnyMenu = false
                menu = nil
                HandleContextMenuAttackCooldown()
                -- end
            end

            pNear = true
        end
        if pNear then
            Wait(0)
        else
            Wait(300)
        end
    end
end)


function HandleContextMenuAttackCooldown()
    CreateThread(function()
        --print("Starting cooldown")
        local timer = GetGameTimer() + 1000
        while GetGameTimer() < timer do
            DisableControlAction(0, 24, true)
            --print("locked")
            Wait(0)
        end
    end)
end

function ScreenToWorld(screenPosition, maxDistance)
    local pos = GetGameplayCamCoord()
    local rot = GetGameplayCamRot(0)
    local fov = GetGameplayCamFov()
    local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, fov, 0, 2)
    local camRight, camForward, camUp, camPos = GetCamMatrix(cam)
    DestroyCam(cam, true)

    local screenPos = vector2(screenPosition.x - 0.5, screenPosition.y - 0.5) * 2.0

    local fovRadians = DegToRad(fov)
    local to = camPos + camForward + (camRight * screenPos.x * fovRadians * 0.95) -
        (camUp * screenPos.y * fovRadians * 0.53)

    local direction = (to - camPos) * maxDistance
    local endPoint = camPos + direction

    local rayHandle = StartShapeTestRay(camPos.x, camPos.y, camPos.z, endPoint.x, endPoint.y, endPoint.z, -1, nil, 0)
    local _, hit, worldPosition, normalDirection, entity = GetShapeTestResult(rayHandle)


    if GetEntityType(entity) == 0 then
        local player, dst = GetClosestPlayer()
        --print(dst)
        if dst ~= nil and dst <= 3.0 then
            entity = GetPlayerPed(player)
        else
            entity = 0
        end
    end

    if (hit == 1) then
        return true, worldPosition, normalDirection, entity
    else
        return false, vector3(0, 0, 0), vector3(0, 0, 0), nil
    end
end

function DegToRad(degrees)
    return (degrees * 3.14) / 180.0
end

-- function ScreenToWorld(flags, toIgnore)
--     local camRot = GetGameplayCamRot(0)
--     local camPos = GetGameplayCamCoord()
--     local posX = GetControlNormal(0, 239)
--     local posY = GetControlNormal(0, 240)
--     local cursor = vector2(posX, posY)
--     local cam3DPos, forwardDir = ScreenRelToWorld(camPos, camRot, cursor)
--     local direction = camPos + forwardDir * raycastLength
--     local rayHandle = StartShapeTestRay(cam3DPos, direction, flags, toIgnore, 0)
--     local _, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
--     if entityHit >= 1 then
--         entityType = GetEntityType(entityHit)
--     end
--     return hit, endCoords, surfaceNormal, entityHit, entityType, direction
-- end

-- function ScreenRelToWorld(camPos, camRot, cursor)
--     local camForward = RotationToDirection(camRot)
--     local rotUp = vector3(camRot.x + 1.0, camRot.y, camRot.z)
--     local rotDown = vector3(camRot.x - 1.0, camRot.y, camRot.z)
--     local rotLeft = vector3(camRot.x, camRot.y, camRot.z - 1.0)
--     local rotRight = vector3(camRot.x, camRot.y, camRot.z + 1.0)
--     local camRight = RotationToDirection(rotRight) - RotationToDirection(rotLeft)
--     local camUp = RotationToDirection(rotUp) - RotationToDirection(rotDown)
--     local rollRad = -(camRot.y * pi / 180.0)
--     local camRightRoll = camRight * cos(rollRad) - camUp * sin(rollRad)
--     local camUpRoll = camRight * sin(rollRad) + camUp * cos(rollRad)
--     local point3DZero = camPos + camForward * 1.0
--     local point3D = point3DZero + camRightRoll + camUpRoll
--     local point2D = World3DToScreen2D(point3D)
--     local point2DZero = World3DToScreen2D(point3DZero)
--     local scaleX = (cursor.x - point2DZero.x) / (point2D.x - point2DZero.x)
--     local scaleY = (cursor.y - point2DZero.y) / (point2D.y - point2DZero.y)
--     local point3Dret = point3DZero + camRightRoll * scaleX + camUpRoll * scaleY
--     local forwardDir = camForward + camRightRoll * scaleX + camUpRoll * scaleY
--     return point3Dret, forwardDir
-- end

-- function RotationToDirection(rotation)
--     local x = rotation.x * pi / 180.0
--     --local y = rotation.y * pi / 180.0
--     local z = rotation.z * pi / 180.0
--     local num = abs(cos(x))
--     return vector3((-sin(z) * num), (cos(z) * num), sin(x))
-- end

-- function World3DToScreen2D(pos)
--     local _, sX, sY = GetScreenCoordFromWorldCoord(pos.x, pos.y, pos.z)
--     return vector2(sX, sY)
-- end
