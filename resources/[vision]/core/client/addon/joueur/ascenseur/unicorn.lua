local open = false
local main = RageUI.CreateMenu("", "Etage", 0.0, 0.0, "vision", "menu_title_ascenseur")
local pos = {
    { name = "Accueil", pos = vector3(118.37078094482, -1262.0744628906, 21.80637550354), },
    { name = "Niveau 1", pos = vector3(130.02481079102, -1284.2053222656, -85.218879699707), },
}
main.Closed = function()
    RageUI.Visible(main, false)
    open = false
end
function OpenUniAsc()
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
        "unicorn_ascenseur" .. k,
        vector3(v.pos.x, v.pos.y, v.pos.z),
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
        function()
            OpenUniAsc()
        end,
        false
    )
end