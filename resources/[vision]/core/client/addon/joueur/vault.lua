Citizen.CreateThread(function()
    while p == nil do Wait(1000) end
    Wait(1000)
    zone.addZone("vault", vector3(253.41453552246, 228.42141723633, 101.68321990967),
    "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir la porte du coffre",
    function()
        openVault()
    end, false)
    print("[INFO] Vault a été chargé correctement")
end)

function openVault()
    TriggerEvent("core:openVault")
    TriggerEvent("core:vaultSound")
end


RegisterNetEvent("core:openVault") -- vault door done
AddEventHandler("core:openVault", function()
    local doorcoords = {253.92, 224.56, 101.88}
    local obj = GetClosestObjectOfType(doorcoords[1],doorcoords[2], doorcoords[3], 1.5, GetHashKey("v_ilev_bk_vaultdoor"),false,false,false)
    local count = 0
    repeat
      local rotation = GetEntityHeading(obj) - 0.05
      SetEntityHeading(obj,rotation)
      count = count + 1
      Citizen.Wait(10)
    until count == 1500
    FreezeEntityPosition(obj, true)
end)

RegisterNetEvent("core:vaultSound")
AddEventHandler("core:vaultSound", function()
    local sescount = 0
    repeat
      PlaySoundFrontend(-1,"OPENING", "MP_PROPERTIES_ELEVATOR_DOORS" ,1)
      Citizen.Wait(900)
      sescount = sescount + 1
    until sescount == 18
end)