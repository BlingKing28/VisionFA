Megaphone = {
    IsUsing = false,
    Obj = nil,
}
RegisterNetEvent("core:UseMegaphone", function()
    if not Megaphone.IsUsing then
        RequestAnimDict("molly@megaphone")
        while not HasAnimDictLoaded("molly@megaphone") do Wait(1) end
        TaskPlayAnim(PlayerPedId(), "molly@megaphone", "megaphone_clip", 1.0, -1, -1, 50, 0, 0, 0, 0)
        RequestModel(GetHashKey("prop_megaphone_01"))
        while not HasModelLoaded(GetHashKey("prop_megaphone_01")) do Wait(1) end
        Megaphone.obj = CreateObject(GetHashKey("prop_megaphone_01"), GetEntityCoords(PlayerPedId()), 1)
        AttachEntityToEntity(Megaphone.obj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0500,
        0.0540,
        -0.0060,
        -71.8855,
        -13.0889,
        -16.0242, true, true, false , true, 1, true)
        Megaphone.IsUsing = true 
        TriggerServerEvent("core:talkonmegaphone", true)
    else
        DeleteEntity(Megaphone.obj)
        SetModelAsNoLongerNeeded(GetHashKey("prop_megaphone_01"))
        StopAnimTask(PlayerPedId(), "molly@megaphone", "megaphone_clip", 1.0)
        TriggerServerEvent("core:talkonmegaphone", false)
        Megaphone.IsUsing = false
    end
end)