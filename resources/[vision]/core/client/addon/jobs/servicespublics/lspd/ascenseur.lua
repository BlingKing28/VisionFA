local pos = {
    ["-3"] = vector3(-1096.1018066406, -850.37652587891, 4.8853883743286),
    ["-2"] = vector3(-1096.1018066406, -850.37652587891, 10.278650283813),
    ["-1"] = vector3(-1096.1018066406, -850.37652587891, 13.688353538513),
    ["0"] = vector3(-1096.1018066406, -850.37652587891, 19.002363204956),
    ["1"] = vector3(-1096.1018066406, -850.37652587891, 19.002363204956),
    ["2"] = vector3(-1096.1018066406, -850.37652587891, 23.041753768921),
    ["3"] = vector3(-1096.1018066406, -850.37652587891, 26.832525253296),
    ["4"] = vector3(-1096.1018066406, -850.37652587891, 30.757925033569),
    ["5"] = vector3(-1096.1018066406, -850.37652587891, 34.363254547119),
    ["6"] = vector3(-1096.1018066406, -850.37652587891, 38.255134582521),

}

local pos2 = {
    ["-3"] = vector3(-1065.8719482422, -833.80261230469, 5.4805750846863),
    ["-2"] = vector3(-1065.8719482422, -833.80261230469, 11.036411285411),
    ["-1"] = vector3(-1065.8719482422, -833.80261230469, 14.883447647095),
    ["0"] = vector3(-1065.8719482422, -833.80261230469, 19.049705505371),
    ["1"] = vector3(-1065.8719482422, -833.80261230469, 19.049705505371),
    ["2"] = vector3(-1065.8719482422, -833.80261230469, 23.036014556885),
    ["3"] = vector3(-1065.8719482422, -833.80261230469, 27.036527633667),


}
local one = false
function OpenAscenseur(k, pos)
    one = pos
    SendNUIMessage({
        type = "openWebview",
        name = "ascenseur",
        data = {
            floor = k
        }
    })
    -- ---AffichageNui
    -- etage = k
    -- SetEntityCoordsNoOffset(p:ped(), pos[1].x, pos[1].y, pos[1].z, 0, 0, 1)
end

for k, v in pairs(pos) do
    zone.addZone(
        "lspd_ascenseur" .. k,
        vector3(v.x, v.y, v.z),
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
        function()
            OpenAscenseur(k, true)
        end,
        false
    )

end

for k, v in pairs(pos2) do
    zone.addZone(
        "lspd_ascenseur2" .. k,
        vector3(v.x, v.y, v.z),
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
        function()
            OpenAscenseur(k, false)
        end,
        false
    )

end




RegisterNUICallback('elevator__callback', function(data, cb)
    if data.floor ~= nil and data.floor ~= "0" then
        if one then
            if #(p:pos() - vector3(pos[data.floor].x, pos[data.floor].y, pos[data.floor].z)) >= 2.0 then

                Modules.UI.RealWait(3000)
                SetNuiFocus(false, false)
                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }));

                SetEntityCoordsNoOffset(p:ped(), pos[data.floor].x, pos[data.floor].y, pos[data.floor].z, 0, 0, 1)
            else
                -- ShowNotification("Vous êtes déjà à cet étage")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Vous êtes déjà à cet étage"
                })

                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }));
            end
        else
            if data.floor == "4" or data.floor == "5" or data.floor == "6" then
                --ShowNotification("Mince étage pas disponible")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Mince, ~c étage pas disponible"
                })

                SendNuiMessage(json.encode({
                    type = 'closeWebview',
                }));
            else
                if #(p:pos() - vector3(pos2[data.floor].x, pos2[data.floor].y, pos2[data.floor].z)) >= 2.0 then

                    Modules.UI.RealWait(3000)
                    SetNuiFocus(false, false)
                    SendNuiMessage(json.encode({
                        type = 'closeWebview',
                    }));

                    SetEntityCoordsNoOffset(p:ped(), pos2[data.floor].x, pos2[data.floor].y, pos2[data.floor].z, 0, 0, 1)
                else
                    -- ShowNotification("Vous êtes déjà à cet étage")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Vous êtes déjà à cet étage"
                    })

                    SendNuiMessage(json.encode({
                        type = 'closeWebview',
                    }));
                end
            end
        end
    else
        -- ShowNotification("Étage en travaux")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'JAUNE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Étage en travaux"
        })

        SendNuiMessage(json.encode({
            type = 'closeWebview',
        }));
    end


end)
