-- "simulation" d'une class car Lua n'a pas vraiment de class, c'est juste pratique de faire ça
zone = {
    zones = {},

    addZone = function(name, pos, text, action_, haveMarker, markerType, markerSize, markerColor, markerAlpha, distInteract)

        local newZone = {
            name = name,
            pos = pos,
            text = text,
            actions = action_,
            haveMarker = haveMarker,
            markerType = markerType,
            markerSize = markerSize,
            markerColor = markerColor,
            markerAlpha = markerAlpha,
            distInteract = distInteract or 1.5
        }
        zone.zones[name] = newZone
    end,

    removeZone = function(name)
        zone.zones[name] = nil
    end,
    
    hideNotif = function(name)
        zone.zones[name].cancelNotif = true
    end,
    
    showNotif = function(name)
        zone.zones[name].cancelNotif = false
    end,
}


-- @ Zone handler

CreateThread(function()
    while p == nil do Wait(1000) end
    while true do
        local pNear = false 

        local pos = p:pos()
        for k, v in pairs(zone.zones) do
            local dst = #(pos - v.pos)

            if dst <= 15.0 then
                pNear = true
                if v.haveMarker then
                    DrawMarker(v.markerType, v.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.markerSize, v.markerSize,
                        v.markerSize, v.markerColor[1], v.markerColor[2], v.markerColor[3], v.markerAlpha, 0, 1, 2, 0,
                        nil, nil, 0)
                end
                if dst <= v.distInteract then
                    if (v.text ~= nil) then
                        if dst > 0.5 then
                            if not v.cancelNotif then
                                ShowHelpNotification(v.text, true)
                            end
                        end
                    end
                    if IsControlJustReleased(0, 38) then
                        v.actions()
                    end

                end
            end
        end

        if pNear then
            Wait(1)
        else
            Wait(500)
        end
    end
end)
