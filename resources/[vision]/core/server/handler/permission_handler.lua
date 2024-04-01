function GetPlayerPermission(source)
    return GetPlayer(source):getPermission()
end

function HasPermission(source, permToCheck)
    if source == 0 then return true end
    if GetPlayer(source):getPermission() >= permToCheck then
        return true
    else
        return false
    end
end

CreateThread(function()
    while RegisterServerCallback == nil do
        Wait(100)
    end
    RegisterServerCallback("core:getPermAdmin", function(source, target)
        return GetPlayerPermission(target)
    end)
end)