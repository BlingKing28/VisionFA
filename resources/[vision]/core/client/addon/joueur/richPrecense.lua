Citizen.CreateThread(function()
    while p == nil do Wait(1000) end
    
    --while true do -- desactivé pour l'instant car on a rien a mêtre a jour 
        SetDiscordAppId(1140671762779082822)
        SetDiscordRichPresenceAsset("visionlogo")
        SetDiscordRichPresenceAssetText("discord.gg/visionrp")

        SetDiscordRichPresenceAction(0, "Jouer", "fivem://connect/cfx.re/join/rky7g8")
        SetDiscordRichPresenceAction(1, "Discord", "https://discord.gg/visionrp")
        --Wait(60000)
    --end
end)

RegisterNetEvent("core:UpdateRichPresence")
AddEventHandler("core:UpdateRichPresence", function (number)
    SetRichPresence("Vision - "..number.. " joueurs connectés")
end)