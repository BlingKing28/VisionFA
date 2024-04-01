function GetLicense(id)
    local identifiers = GetPlayerIdentifiers(id)
    for _, v in pairs(identifiers) do
        if string.find(v, "license") then
            return v
        end
    end
    print("Couldn't find license for  : "..id)
    return "license:000000000000000000000000000000000000"
end

function GetSteam(id)
    local identifiers = GetPlayerIdentifiers(id)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            return v
        end
    end
    print("Couldn't find steam for  : "..id)
    return "steam:00000000000000000"
end

function GetDiscord(id)
    local identifiers = GetPlayerIdentifiers(id)
    for _, v in pairs(identifiers) do
        if string.find(v, "discord") then
            return v
        end
    end
    print("Couldn't find discord for  : "..id)
    return "discord:000000000000000000"
end

function PlayersIdentifierToString(source)
    local identifiers = GetPlayerIdentifiers(source)
    local cb = ""
    for _, v in pairs(identifiers) do
        cb = cb..v.."\n"
    end
    return cb
end

function GetPlayerFromLicenseIfExist(license)
    local players = GetPlayers()
    for k,v in pairs(players) do
        local ids = GetPlayerIdentifiers(v)
        for _,i in pairs(ids) do
            if i == license then    
                return v
            end
        end
    end
    return false
end

function CorePrint(text)
    print("^3Core:^7 "..text)
end

function CoreError(...)
    print("^7<--------->")
    print("^1Error:^7 ")
    print(...)
    print("^7<--------->")
end

function CompareMetadatas(t1, t2)
    -- Compare each entry of table t1 with the same entry of table t2
    -- If entry is a table, recursively call this function
    -- If t1 entry is not the same as t2 entry, return false
    -- If tables are not exactly the same, return false

    if type(t1) ~= "table" or type(t2) ~= "table" then
        return false
    end

    for k,v in pairs(t1) do
        if type(v) == "table" then
            if not CompareMetadatas(v, t2[k]) then
                return false
            end
        else
            if v ~= t2[k] then
                return false
            end
        end
    end
    return true
end

-- Events utils

RegisterNetEvent("DeleteEntity")
AddEventHandler("DeleteEntity", function(token, table)
    if CheckPlayerToken(source, token) then
        for k,v in pairs(table) do
            DeleteEntity(NetworkGetEntityFromNetworkId(v))
        end
    end
end)

RegisterNetEvent("core:getClothData")
AddEventHandler("core:getClothData", function(cloth)
    cloth = json.decode(cloth)
    SendDiscordLog("vetement", source, json.encode(cloth))
end)

exports('getDiscord', function(id)
    return GetDiscord(id)
end)