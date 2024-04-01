isBlk = false

Citizen.CreateThread(function()
  while true do
    SetArtificialLightsState(isBlk)
    SetArtificialLightsStateAffectsVehicles(blackout.car)
    Wait(1000)
  end
end)

RegisterNetEvent('setBlk')
AddEventHandler('setBlk', function(blk)
  print('setBlk', blk)
  isBlk = blk
end)

AddEventHandler('playerSpawned', function()
  TriggerServerEvent('isBlk')
end)