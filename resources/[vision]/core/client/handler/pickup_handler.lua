local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

--TODO: refaire avec système de metadatas et context menu
pickups = {

    pickup = {},

    createProps = function(player, pickupId, label, name, type, count, metadatas, coords)
        local coords = coords
        local forward = GetEntityForwardVector(GetPlayerPed(GetPlayerFromServerId(player)))
        local objCoords = (coords + forward)
        pickups.pickup[pickupId] = {
            coords = vector3(objCoords.x, objCoords.y, objCoords.z),
            id = pickupId,
            count = count,
            name = name,
            label = label,
            type = type,
            metadatas = metadatas,
            inRange = false,
            size = 0.4,
        }

        LoadModel("v_serv_abox_02")
        local obj = entity:CreateObjectLocal('v_serv_abox_02', pickups.pickup[pickupId].coords.xyz)
        PlaceObjectOnGroundProperly(obj:getEntityId())
        pickups.pickup[pickupId].obj = obj
        --TriggerServerEvent("core:isPlayerforObjectRoutingBucket", ObjToNet(obj.id), pickupId, player)
    end,

}

--RegisterNetEvent("core:isPlayerforObjectRoutingBucketC", function(pickupId)
--    pickups.pickup[pickupId].size = 0.0
--end)

Citizen.CreateThread(function()
    while p == nil do Wait(1) end
    while true do
        local spam = 250

        for k, v in pairs(pickups.pickup) do
            if #(v.coords - p:pos()) <= 5 then
                spam = 1

                if #(v.coords - p:pos()) < 2 then
                    DrawText3D(v.coords, "x" .. v.count .. " " .. v.label, v.size, 0)
                end
            elseif v.inRange then
                v.inRange = false
            else
                spam = 250
            end
        end
        Wait(spam)
    end
end)

function PickupItem()
    for k, v in pairs(pickups.pickup) do
        if #(v.coords - p:pos()) < 2 then
            if IsPedOnFoot(p:ped()) and not IsPedOnVehicle(p:ped()) and #(v.coords - p:pos()) <= 2 and not v.inRange then
                v.inRange = true
                p:PlayAnim("pickup_object", "pickup_low", 0)
                TriggerServerEvent("core:pickup", token, k)
            end
        elseif v.inRange then
            v.inRange = false
        end
    end
end

RegisterNetEvent("core:createPickup")
AddEventHandler("core:createPickup", function(player, pickupId, label, name, typer, count, metadatas, coords)
    pickups.createProps(player, pickupId, label, name, typer, count, metadatas, coords)
end)

RegisterNetEvent("core:removePickup")
AddEventHandler("core:removePickup", function(pickupId)
    local pickup = pickups.pickup[pickupId]
    if pickup and pickup.obj then
        pickup.obj:delete()
        pickups.pickup[pickupId] = nil
    end
end)
