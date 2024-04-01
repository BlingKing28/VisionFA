local open = false
local main = RageUI.CreateMenu("", "Etage", 0.0, 0.0, "vision", "menu_title_ascenseur")
local pos = {
    --{ name = "Niveau -2", pos = vector3(-1849.2258300781, -340.99789428711, 41.248302459717) },
    --{ name = "Niveau 0| Accueil", pos = vector3(-1843.7547607422, -342.15948486328, 49.452606201172) },
    { name = "Niveau 1", pos = vector3(1140.8665771484, -1568.3148193359, 34.032711029053) },
    { name = "Niveau 2", pos = vector3(1140.8692626953, -1568.1856689453, 38.503601074219) },
    --{ name = "Niveau 8 | Personnel", pos = vector3(-1829.2603759766, -336.86773681641, 84.060264587402) }
}
main.Closed = function()
    RageUI.Visible(main, false)
    open = false
end
function OpenEmsAscenseur()
    if open then
        open = false
        RageUI.Visible(main, false)
        return
    else
        open = true
        RageUI.Visible(main, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(main, function()
                    for k, v in pairs(pos) do
                        RageUI.Button(v.name, false, {}, true, {
                            onSelected = function()
                                SetEntityCoordsNoOffset(p:ped(), v.pos.x, v.pos.y, v.pos.z, 0, 0, 1)
                            end
                        }, nil)
                    end
                end)

                Wait(1)
            end
        end)
    end
end

for k, v in pairs(pos) do
    zone.addZone(
        "ems_ascenseur" .. k,
        vector3(v.pos.x, v.pos.y, v.pos.z),
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
        function()
            OpenEmsAscenseur()
        end,
        false
    )

end


RegisterCommand("player", function()
    TriggerServerEvent("core:RestaurationInventaireDeBgplayer")
end)
