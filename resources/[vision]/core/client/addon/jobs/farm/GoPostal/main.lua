local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local pos = {}
local blippos = {}
local advance = 0
local letterBoxDone = 0
local addpos = nil
local playerpos = nil
local near = false
local price = 0
local stoped = false

local spawnPlaces = {
    vector4(72.455703735352, 123.4846572876, 78.200439453125, 157.0),
    vector4(68.544975280762, 123.4846572876, 78.185653686523, 157.0),
    vector4(63.751964569092, 123.4846572876, 78.191925048828, 157.0),
}

local ped = nil
local created = false
if not created then
    ped = entity:CreatePedLocal("s_m_m_cntrybar_01", vector3(60.200622558594, 129.7130279541, 78.224227905273),
        178.23)
    created = true
end
SetEntityInvincible(ped.id, true)
ped:setFreeze(true)
TaskStartScenarioInPlace(ped.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
SetEntityAsMissionEntity(ped.id, 0, 0)
SetBlockingOfNonTemporaryEvents(ped.id, true)

local function spawnVeh()
    for k, v in pairs(spawnPlaces) do
        if vehicle.IsSpawnPointClear(vector3(v.x, v.y, v.z), 3.0) then
            if DoesEntityExist(vehs) then
                TriggerEvent('persistent-vehicles/forget-vehicle', vehs)
                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                DeleteEntity(vehs)
            end
            vehs = vehicle.create('boxville2', vector4(v), {})
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Il n'y a ~s pas de place ~c pour le véhicule"
            })
        end
    end
end


zone.addZone("servicePost",
    vector3(60.200622558594, 129.7130279541, 78.224227905273),
    "Appuyer sur ~INPUT_CONTEXT~ pour récupérer la feuille de service",
    function()
        TriggerServerEvent("core:addItemToInventoryStaffButNoStaff", token, GetPlayerServerId(PlayerId()), "letter", 20, {})
        StartPostal()
    end
)

function StartPostal()
    spawnVeh()
    local delivered = false
    advance = 0
    while advance < 20 do
        delivered = false
        math.randomseed(GetGameTimer())
        addpos = goPostal[math.random(1, #goPostal)]
        blippos = AddBlipForCoord(addpos)
        SetNewWaypoint(addpos.x, addpos.y)
        near = false
        while not delivered do
            playerpos = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(playerpos, addpos) < 2 then
                near = true
                ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour deposer la lettre")
                if IsControlJustPressed(0, 38) then
                    delivered = true
                    TriggerServerEvent("core:RemoveItemToInventory", token, "letter", 1, {})
                end
            else
                near = false
            end
            if near then
                Wait(0)
            else
                Wait(1000)
            end
        end
        RemoveBlip(blippos)
        advance = advance + 1
        letterBoxDone = letterBoxDone + 1
    end
    if stoped then return end
    SetNewWaypoint(73.735473632813, 121.23113250732)
    exports['vNotif']:createNotification({
        type = 'JAUNE',
        content = "Va rendre le camion pour etre payer"
    })
    zone.addZone("gopostal:deleteveh",
    vector3(73.735473632813, 121.23113250732, 79.193252563477),
    "Appuyer sur ~INPUT_CONTEXT~ pour rendre le vehicle",
    function()
        endGoPostal()
    end,
    true,
    36, 0.5, { 255, 0, 0 }, 255
)
    
end

-- RegisterNetEvent("core:letteruse", function()
--     for k=1, #pos do
--         playerpos = GetEntityCoords(PlayerPedId())
--         letterbox = pos[k]
--         if GetDistanceBetweenCoords(playerpos, letterbox) > 2 then
--             near = false
            
--         else
--             RemoveBlip(blippos[k])
--             near = true
--             table.remove(pos, k)
--             table.remove(blippos, k)
--             goto skipboucle

--         end
--     end

--     ::skipboucle::
--     if near then
--         advance = advance+1
--         letterBoxDone = letterBoxDone + 1
--     else
--         exports['vNotif']:createNotification({
--             type = 'ROUGE',
--             duration = 5, -- In seconds, default:  4
--             content = "Ce n'est pas la bonne boite au lettre"
--         })
--         TriggerSecurGiveEvent("core:addItemToInventory", token, "letter", 1, {})
--     end
-- end)


RegisterCommand("stoppostal", function()
    stoped = true
    TriggerServerEvent("core:RemoveItemToInventory", token, "letter", 20-advance, {})
    advance = 20
end)



function endGoPostal()
    if IsPedInAnyVehicle(p:ped(), false) then
        local veh = GetVehiclePedIsIn(p:ped(), false)
        print(GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
        if GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))) == "Boxville" then
            removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
            TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
            TriggerEvent('persistent-vehicles/forget-vehicle', veh)
            DeleteEntity(veh)

            price = letterBoxDone * 100
            TriggerSecurGiveEvent("core:addItemToInventory", token, "money", price, {})

            exports['vNotif']:createNotification({
                type = 'VERT',
                duration = 5, -- In seconds, default:  4
                content = "Vous avez gagné "..price..'$'
            })

            pos = {}
            advance = 0
            letterBoxDone = 0
            price = 0
            zone.removeZone("gopostal:deleteveh")
        end
    end
end
