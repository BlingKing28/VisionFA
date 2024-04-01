local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

function LoadWeaponHandler()


    Citizen.CreateThread(function()
        while true do
            local pWeapons = p:getWeapons()

            for k,v in pairs(pWeapons) do
                if HasPedGotWeapon(p:ped(), GetHashKey(k), 0) then
                    local ammo = GetAmmoInPedWeapon(p:ped(), GetHashKey(k))
                    if ammo ~= v.ammo then
                        p:SetWeaponAmmo(k, ammo)
                        TriggerServerEvent("core:UpdateWeaponAmmo", token, k, ammo)
                        v.ammo = ammo
                    end
                end
            end

            Wait(1000)
        end
    end)


    Citizen.CreateThread(function()
        while true do
            local pWeapons = p:getWeapons()
            for k,v in pairs(pWeapons) do
                if HasPedGotWeapon(p:ped(), GetHashKey(k), 0) then
                    if pWeapons[k] == nil then
                        RemoveWeaponFromPed(p:ped(), GetHashKey(k))
                        -- TODO Ac screenshot detection
                    end
                end
            end
            Wait(2500)
        end
    end)
end