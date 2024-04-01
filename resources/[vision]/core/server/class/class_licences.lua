license = {
    GetAllLicensePlayer = function(playerid)
        local id = GetPlayer(playerid):getId()
        if id ~= nil then
            local result = MySQL.Sync.fetchAll("SELECT license_type FROM license WHERE license.id_player = @id"
                , {
                ['@id'] = id
            })
            return result
        end
    end,
    GetLicenseInPlayer = function(playerid, licenseType)
        local id = GetPlayer(playerid):getId()
        if id ~= nil then
            local result = MySQL.Sync.fetchAll("SELECT license_type FROM license WHERE license.id_player = @id AND license.license_type = @license"
                , {
                ['@id'] = id,
                ['@license'] = license.GetIdLicense(licenseType)
            })

            if json.encode(result) ~= "[]" then
                return true
            else
                return false
            end
        end
    end,
    GetNameLicense = function(license_type)
        if license_type ~= nil then
            local result = MySQL.Sync.fetchAll("SELECT name FROM license_type WHERE license_type.id = @license_type"
                , {
                ['@license_type'] = license_type
            })
            return result[1].name
        else
            print("L'argument license_type est nil")
        end
    end,
    GetIdLicense = function(license_name)
        if license_name ~= nil then
            local result = MySQL.Sync.fetchAll("SELECT id FROM license_type WHERE license_type.name = @license_name"
                , {
                ['@license_name'] = license_name
            })
            return result[1].id
        else
            print("L'argument license_name est nil")
        end
    end,
    AddNewLicense = function(playerid, license_type)
        if license.GetLicenseInPlayer(playerid, license_type) then
            return false
        else
            MySQL.Async.execute("INSERT INTO license (id_player, license_type) VALUES (@playerid, @licence_type)",
                {
                    ['@playerid'] = GetPlayer(playerid):getId(),
                    ['@licence_type'] = license.GetIdLicense(license_type)
                },
                function(affectedRows)
                    print("Ajout licence" ..
                        license_type .. " à l'id n° " .. GetPlayer(playerid):getId() .. " mis a jour")
                end)
            return true
        end
    end,

    RemoveLicense = function(playerid, license_type)
        if not license.GetLicenseInPlayer(playerid, license_type) then
            return false
        else
            MySQL.Async.execute("DELETE FROM license WHERE license.id_player = @playerid AND license.license_type = @licence_type",
                {
                    ['@playerid'] = GetPlayer(playerid):getId(),
                    ['@licence_type'] = license.GetIdLicense(license_type)
                },
                function(affectedRows)
                    print("Supression licence" ..
                        license_type .. " à l'id n° " .. GetPlayer(playerid):getId() .. " mis a jour")
                end)
            return true
        end
    end,
}
