RegisterNetEvent("core:FreezePlayer")
AddEventHandler("core:FreezePlayer", function(staut)
    FreezeEntityPosition(p:ped(), staut)
end)

RegisterNetEvent("core:GotoBring")
AddEventHandler("core:GotoBring", function(coords)
    SetEntityCoords(p:ped(), coords)
end)

RegisterNetEvent("core:Message")
AddEventHandler("core:Message", function(msg)
    -- ShowAdvancedNotification("Vision", "Administration", msg, "CHAR_VISION", "VISION")

    TriggerClientEvent("__vision::createNotification", -1, {
        type  = 'VISION',
        name  = "VISION",
        content = msg,
        typeannonce = "ADMINISTRATION",
        labeltype = "ANNONCE",
        duration = 10,
    })

end)



RegisterNetEvent("core:StaffSpectate")
AddEventHandler("core:StaffSpectate", function(coords, id)
    if Staff.pLastId == nil then
        --if modsAdmin.noclip == false then
        --    ExecuteCommand("noclip")
        --    modsAdmin.noclip = true
        --end
        --Citizen.Wait(500)
        --SetEntityCoords(GetPlayerPed(-1), coords)
        NetworkSetInSpectatorMode(true, GetPlayerPed(GetPlayerFromServerId(id)))
        Staff.pLastId = id
    else
        NetworkSetInSpectatorMode(false, GetPlayerPed(GetPlayerFromServerId(id)))
        --SetEntityCoords(GetPlayerPed(-1), Staff.pLastPosition)
        --if modsAdmin.noclip ~= false then
        --    ExecuteCommand("noclip")
        --    modsAdmin.noclip = false
        --end
        Staff.pLastId = nil
    end
end)


RegisterNetEvent("core:TakeScreenBiatch")
AddEventHandler("core:TakeScreenBiatch", function(license)
    exports["screenshot-basic"]:requestScreenshotUpload("http://imageserver.visionrp.fr/upload/", "files[]",
        function(data)
            local resp = json.decode(data)
            TriggerServerEvent("testlog", resp.files[1].url, license)
        end)

end)


RegisterNetEvent("core:setPedStaff")
AddEventHandler("core:setPedStaff", function(ped)
    if LoadModel(ped) then
        if IsModelInCdimage(ped) and IsModelValid(ped) then
            SetPlayerModel(PlayerId(), ped)
            SetPedDefaultComponentVariation(p:ped())
        end
    end
end)
