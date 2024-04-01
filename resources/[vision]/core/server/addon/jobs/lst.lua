RegisterNetEvent('giveMoneyLst', function()
    AddMoneyToSociety(300, 'lst')
end)

RegisterNetEvent('lstDiscordLog', function(ligne, startTime, stopTime)

    local playeridentity = GetPlayer(source):getFirstname() .. " " .. GetPlayer(source):getLastname()
    local playerdiscord = GetDiscord(source)


    local discord_webhook = {
        url = 'achanger'
    }

    local embeds = {
          {
            ["title"] = 'LST Log',
            ["description"] = playeridentity..' à fini la ligne '..ligne..'.\nDébut: '..startTime..'\nFin: '..stopTime,
            ['color'] = 16755740,
            ["footer"] = {
                ["text"] = os.date("%Y/%m/%d %X"),
                ["icon_url"] = "https://cdn.discordapp.com/attachments/791407719948091442/1010676021063843850/server_icon.png",

            },
          }
        }

    PerformHttpRequest(discord_webhook.url, 
    function(err, text, header) end, 
    'POST', 
    json.encode({username = 'LST LOG', embeds = embeds, avatar_url = 'https://cdn.discordapp.com/attachments/791407719948091442/1010676021063843850/server_icon.png'}),
   {['Content-Type'] = 'application/json'})

end)