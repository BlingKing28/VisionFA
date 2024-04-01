local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local voting = {
    vector3(-280.57015991211, -1932.8165283203, 30.149230957031),
    vector3(-279.29153442383, -1931.2640380859, 30.149223327637),
    vector3(-281.73208618164, -1934.0388183594, 30.149225234985),
}

local candidates = {
    {
        name = "Peter FITZGERALD",
        party = "Parti républicain"
    },
    {
        name = "Chase AANGELL",
        party = "Parti independent"
    },
    {
        name = "Antonin LEVY",
        party = "Parti independent"
    },
}

local enabled = false
local hasVoted = false

function loadElection()
    for k, v in pairs(voting) do
        zone.addZone("voting " ..math.random(1, 999999),
            v,
            "Appuyer sur ~INPUT_CONTEXT~ pour voter",
            function()
                startVoting()
            end,
            true,
            22, -- Id / type du marker
            0.6, -- La taille
            { 51, 204, 255 }, -- RGB
            180-- Alpha
        )
    end
end

function startVoting()
    hasVoted = TriggerServerCallback('voting:server:checkIfVoted', token)
    if not hasVoted then
        enabled = TriggerServerCallback('voting:server:enabled')
        VotingMenu()
    else
        -- ShowNotification("Vous avez déja voté")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "Vous avez déja ~s voté"
        })
        
        Wait(5000)
    end
end

local open = false
local voting_main = RageUI.CreateMenu("Vote", "Menu de vote")
local voting_candidate = RageUI.CreateSubMenu(voting_main, "Vote", "Menu de vote")
voting_main.Closed = function()
    open = false
end

function VotingMenu()
    if open then
        open = false
        RageUI.Visible(voting_main, false)
        return
    else
        open = true
        RageUI.Visible(voting_main, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(voting_main, function()
                    for k, v in pairs(candidates) do
                        RageUI.Button(v.name, v.party, {RightLabel = "~r~VOTER" }, enabled, {
                            onSelected = function()
                                TriggerServerEvent('voting:server:castVote', v.name, v.party, token)
                                open = false
                                RageUI.Visible(voting_main, false)
                                TriggerEvent("voting:confirm", v.name)
                            end
                        })
                    end
                end)
                Wait(0)
            end
        end)
    end
end

RegisterNetEvent("voting:confirm")
AddEventHandler("voting:confirm", function(candidate)
    local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    PushScaleformMovieMethodParameterString("~r~Vous avez voté pour ~b~"..candidate)
    PushScaleformMovieMethodParameterString("Merci d'avoir voté")
    PushScaleformMovieMethodParameterInt(5)
    EndScaleformMovieMethod()
    -- loop for 5 seconds
    local timer = GetGameTimer() + 5000
    while GetGameTimer() < timer do
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        Wait(0)
    end
end)

RegisterCommand("checkvotes", function()
    if p:getPermission() >= 4 then
        local result = TriggerServerCallback('voting:server:getVotes', token)
        for k, v in pairs(result) do
            print(v.name, v.party, v.votes)
        end
    end
end)

RegisterCommand("toggleElections", function()
    if p:getPermission() >= 4 then
        TriggerServerEvent('voting:server:toggleElections', token)
    end
end)


Citizen.CreateThread(function()
    while p == nil do
        Wait(1000)
    end
    Wait(1000)
    loadElection()
    print("[INFO] Les élections ont été chargées correctement")
end)