RegisterNetEvent("core:GetWeaponFromArmory")--useless
AddEventHandler("core:GetWeaponFromArmory", function(token, name, ammo)
    if CheckPlayerToken(source, token) then
        GetPlayer(source):AddWeaponIfPossible(name, ammo)
        MarkPlayerDataAsNonSaved(source)
        --RefreshPlayerData(source)
    else
        -- TODO ac detection
    end
end)

RegisterNetEvent("core:UpdateWeaponAmmo")
AddEventHandler("core:UpdateWeaponAmmo", function(token, name, ammo)
    if CheckPlayerToken(source, token) then
        GetPlayer(source):SetWeaponAmmo(name, ammo)
    else
        -- TODO ac detection
    end
end)


RegisterNetEvent("core:UpdateWeaponComponents")
AddEventHandler("core:UpdateWeaponComponents", function(token, name, components, option)
    if CheckPlayerToken(source, token) then
        GetPlayer(source):SetWeaponComponents(name, components, option)
    else
        -- TODO ac detection
    end
end)

--RegisterNetEvent("core:GiveWeaponToPlayer")--useless
--AddEventHandler("core:GiveWeaponToPlayer", function(token, name, target)
--    if CheckPlayerToken(source, token) then
--        GetPlayer(source):GiveWeaponIfPossible(name, source, target)
--        MarkPlayerDataAsNonSaved(source)
--        MarkPlayerDataAsNonSaved(target)
--        --RefreshPlayerData(source)
--        --RefreshPlayerData(target)
--    else
--        -- TODO ac detection
--    end
--end)