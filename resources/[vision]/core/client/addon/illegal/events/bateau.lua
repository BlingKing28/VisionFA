RegisterCommand("illegalboat", function(source,args)
    if p:getPermission() >= 3 then
        local x,y,z = args[1], args[2], args[3]
        if x and y and z then 
            RequestModel("squalo")
            while not HasModelLoaded("squalo") do Wait(1) end
            local veh = CreateVehicle(GetHashKey("squalo"), x,y,z, 50.0, 1)
            SetEntityAsMissionEntity(veh, true)
            SetNetworkIdExistsOnAllMachines(VehToNet(veh), true)
            RequestModel("a_m_y_soucent_03")
            while not HasModelLoaded("a_m_y_soucent_03") do Wait(1) end
            local ped = CreatePed(4, GetHashKey("a_m_y_soucent_03"), x,y,z, 50.0, false, false)
            SetEntityAsMissionEntity(ped, true)
            SetNetworkIdExistsOnAllMachines(PedToNet(ped), true)
            TaskWarpPedIntoVehicle(ped, veh, -1)
        else
            ShowNotification("Vous n'avez pas mis les coordonnées")
        end
    end
end)

RegisterCommand("nitrous", function()
  if p:getPermission() >= 3 then
    CreateThread(function()
      local waiiit = 1
      while true do 
        Wait(1)
        waiiit = waiiit + 1
        if GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId())) * 3.6 > 80.0 then
          if math.random(1,4) == 4 then
            CreateVehicleExhaustBackfire(GetVehiclePedIsIn(PlayerPedId()),1.25)
          end
        end
        if waiiit > 1000 then 
          break
        end
      end
    end)
  end
end)

function CreateVehicleExhaustBackfire(vehicle, scale)
    local exhaustNames = {
      "exhaust",    "exhaust_2",  "exhaust_3",  "exhaust_4",
      "exhaust_5",  "exhaust_6",  "exhaust_7",  "exhaust_8",
      "exhaust_9",  "exhaust_10", "exhaust_11", "exhaust_12",
      "exhaust_13", "exhaust_14", "exhaust_15", "exhaust_16"
    }
  
    for _, exhaustName in ipairs(exhaustNames) do
      local boneIndex = GetEntityBoneIndexByName(vehicle, exhaustName)
  
      if boneIndex ~= -1 then
        local pos = GetWorldPositionOfEntityBone(vehicle, boneIndex)
        local off = GetOffsetFromEntityGivenWorldCoords(vehicle, pos.x, pos.y, pos.z)
  
        UseParticleFxAsset('core')
        StartParticleFxNonLoopedOnEntity('veh_backfire', vehicle, off.x, off.y, off.z, 0.0, 0.0, 0.0, scale, false, false, false)
      end
    end
  end