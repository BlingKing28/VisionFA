blk = false

--RegisterCommand('Blackout', function()
--    blk = not blk
--    TriggerClientEvent('setBlk', -1, blk)
--end)

RegisterServerEvent('isBlk')
AddEventHandler('isBlk', function()
  print('isBlk', source, blk)
  TriggerClientEvent('setBlk', source, blk)
end)

RegisterServerEvent('adminBlackout')
AddEventHandler('adminBlackout', function()
  print('adminBlackout', source, blk)
  --SendDiscordLog("wheather", source, string.sub(GetDiscord(source), 9, -1), GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(),
  --  "blackout", blk)
  blk = not blk
  TriggerClientEvent('setBlk', -1, blk)
end)