local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local open = false
local main = RageUI.CreateMenu("Setting", "Action disponible")
local demarcheMenu = RageUI.CreateSubMenu(main, "Demarche", "Demarche disponible")
main.Closed = function()
    open = false
    RageUI.Visible(main, false)
end
local tables = {}
function OpenSettingsMenu()
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
                    --Demarche
                    RageUI.Button("Démarche", false, { RightLabel = ">" }, true, {
                        onSelected = function()

                            tables = table.sort(Walks, function(a, b)
                                return a < b
                            end)
                            print(json.encode(tables), json.encode(table.sort(Walks)), json.encode(Walks))
                        end,
                    }, demarcheMenu)
                    --LoadingScreen a voir
                end)

                RageUI.IsVisible(demarcheMenu, function()
                    --Demarche
                    for k, v in pairs(Walks) do
                        RageUI.Button(k, false, {}, true, {
                            onSelected = function()
                                TriggerServerEvent("core:SetNewDemarche", token, v)
                                WalkMenuStart(v)
                            end
                        })
                    end
                    --LoadingScreen a voir
                end)
                Wait(1)
            end
        end)

    end
end

RegisterCommand("setting", function()
    OpenSettingsMenu()
end, false)
