-- local proximity = plyState.proximity
-- print(proximity.index) -- prints the index of the proximity as seen in Cfg.voiceModes
-- print(proximity.distance) -- prints the distance of the proximity
-- print(proximity.mode) -- prints the mode name of the proximity

local token = nil
local state
-- {1.5, "Whisper"}, -- Whisper speech distance in gta distance units
-- 		{3.0, "Normal"}, -- Normal speech distance in gta distance units
-- 		{6.0, "Shouting"} -- Shou
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)


-- RegisterCommand('vocal', function()
--     state = TriggerServerCallback('core:GetStateMicrophone', token)
--     Modules.UI.SetPageActive("ui_vocal")
-- end)

function Modules.UI.DisplayVocal()
    if state.mode == "Normal" then
        local w, h = Modules.UI.ConvertToPixel(50, 50)
        Modules.UI.DrawSpriteNew("vocal", "unknown", 0.158, 0.925, w, h, 0, 255, 255
            ,
            255, 150, {
                NoHover = true,
                CustomHoverTexture = false,
                NoSelect = true,
                devmod = false
            }, function(onSelected, onHovered)
            if onSelected then
            end
        end)
    elseif state.mode == "Chuchoter" then
        local w, h = Modules.UI.ConvertToPixel(50, 50)
        Modules.UI.DrawSpriteNew("vocal", "voc_green", 0.158, 0.925, w, h, 0, 255, 255
            ,
            255, 150, {
                NoHover = true,
                CustomHoverTexture = false,
                NoSelect = true,
                devmod = false
            }, function(onSelected, onHovered)
            if onSelected then
            end
        end)
    elseif state.mode == "Crier" then
        local w, h = Modules.UI.ConvertToPixel(50, 50)
        Modules.UI.DrawSpriteNew("vocal", "voc_red", 0.158, 0.925, w, h, 0, 255, 255
            ,
            255, 150, {
                NoHover = true,
                CustomHoverTexture = false,
                NoSelect = true,
                devmod = false
            }, function(onSelected, onHovered)
            if onSelected then
            end
        end)
    end
end

local check = false
Citizen.CreateThread(function()
    while true do
        Wait(250)
        if MumbleIsPlayerTalking(PlayerId()) == 1 then
            if not check then
                check = true
                state = TriggerServerCallback('core:GetStateMicrophone', token)
            end
            Modules.UI.SetPageActive("ui_vocal")
        else
            check = false
            Modules.UI.SetPageInactive("ui_vocal")
        end
    end
end)
