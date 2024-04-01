local open = false
local main = RageUI.CreateMenu("", "Etage", 0.0, 0.0, "vision", "menu_title_ascenseur")
local pos = {
    { name = "Accueil", pos = vector3(2497.3212890625, -349.40048217773, 94.092300415039), },
    { name = "Niveau 1", pos = vector3(2497.2077636719, -349.44778442383, 101.89334869385), },
    { name = "Niveau 2", pos = vector3(2497.26953125, -349.29458618164, 105.69055938721), },
}
main.Closed = function()
    RageUI.Visible(main, false)
    open = false
end
function OpenEtatMajor()
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
                                SetEntityCoords(p:ped(), v.pos.x, v.pos.y, v.pos.z, 0, 0, 1)

                            end
                        }, nil)
                    end
                    Wait(1)
                end)
            end
        end)
    end
end

for k, v in pairs(pos) do
    zone.addZone(
        "major_ascenseur" .. k,
        vector3(v.pos.x, v.pos.y, v.pos.z),
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
        function()
            OpenEtatMajor()
        end,
        false
    )

end
