local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

RegisterCommand("crewCreation", function(source, args, rawCommand)
    local playerId = args[1]
    if p:getPermission() >= 3 then
        TriggerServerEvent("core:createCrewCreation", playerId)
    end
end)

RegisterNetEvent("core:createCrewCreation")
AddEventHandler("core:createCrewCreation", function()
    openCrewCreate()
end)

function openCrewCreate()
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'CrewCreateMenu',
        data = {}
    }));
end

RegisterNUICallback("crewMenu_callback", function(data)
    local crew_cfg = {
        name = data.crewNameMenu,
        tag = "tag0",
        devise = data.crewDeviseMenu,
        grade = {
            { name = "Chef", id = 1 },
            { name = "Sous-Chef", id = 2 },
            { name = "manager", id = 3 },
            { name = "celui qui tient le canon", id = 4 },
            { name = "chair a canon", id = 5 }
        },
        color = data.crewColor,
    }
    TriggerServerEvent('core:CreateCrew', token, crew_cfg)
    SendNUIMessage({
        type = 'closeWebview',
        name = 'CrewCreateMenu'
    });
end)