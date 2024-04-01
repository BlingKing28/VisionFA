allCrews = {}
local crewPermission = {
    sellVeh = false,
    keyVeh = false,
    gest = false,
    prop = false,
    stockage = false,
}

local newPerm = {
    recrute = 1,
    exclure = 1,
    editPerm = 1,
    editMembres = 1,
    sendDm = 1
}

crew = {

    loadAllCrew = function()
        MySQL.Async.fetchAll("SELECT * FROM crew", {}, function(result)
            if result[1] ~= nil then
                for k, v in pairs(result) do
                    allCrews[result[k].id] = {}
                    allCrews[result[k].id].id = result[k].id
                    allCrews[result[k].id].name = result[k].name
                    allCrews[result[k].id].tag = result[k].tag
                    allCrews[result[k].id].rank = result[k].rank
                    allCrews[result[k].id].owner = result[k].owner
                    CorePrint("Loaded crew ^2" .. allCrews[result[k].id].name .. "^7")
                end
            else
                CorePrint("No crew found")
            end
        end)
    end,

    newLoadAllCrew = function()
        MySQL.Async.fetchAll("SELECT * FROM crew", {}, function(result)
            if result[1] ~= nil then
                allCrews = {}
                for k, v in pairs(result) do
                    allCrews[result[k].id] = {}
                    allCrews[result[k].id].id = result[k].id
                    allCrews[result[k].id].name = result[k].name
                    allCrews[result[k].id].tag = result[k].tag
                    allCrews[result[k].id].rank = result[k].rank
                    allCrews[result[k].id].owner = result[k].owner
                    allCrews[result[k].id].color = result[k].color
                    allCrews[result[k].id].perm = result[k].perm
                    allCrews[result[k].id].devise = result[k].devise
                    CorePrint("Loaded crew ^2" .. allCrews[result[k].id].name .. "^7")
                end
            else
                CorePrint("No crew found")
            end
        end)
    end,

    DoesCrewExist = function(name)
        for k, v in pairs(allCrews) do
            if string.upper(v.name) == string.upper(name) then
                return true
            end
        end
        return false
    end,

    getCrewId = function(name)
        local result = MySQL.Sync.fetchScalar("SELECT * FROM crew WHERE crew.name = @name", {
            ['@name'] = name
        })
        if result then
            return result
        else
            return nil
        end
    end,

    getCrewRankId = function(crewId, rank)
        local result = MySQL.Sync.fetchScalar("SELECT * FROM crew_rank WHERE crew_rank.crew_id = @crewId and `rank` = @rank"
            , {
            ['@crewId'] = crewId,
            ['@rank'] = rank
        })
        if result then
            return result
        else
            return nil
        end
    end,

    createCrew = function(source, name, tag, rank)
        if not crew.DoesCrewExist(name) then

            local result = MySQL.Sync.insert("INSERT INTO crew (`name`, `tag`, `owner`, `rank`) VALUES (@name, @tag, @owner, @rank)"
                , {
                ['@name'] = name,
                ['@tag'] = tag,
                ['@owner'] = GetPlayer(source):getId(),
                ['@rank'] = rank
            })
            if result then
                CorePrint("Crew ^2" .. name .. "^7 created")
                allCrews[result] = {}
                allCrews[result].id = result
                allCrews[result].name = name
                allCrews[result].tag = tag
                allCrews[result].rank = rank
                allCrews[result].owner = GetPlayer(source):getId()
                return true
            else
                CorePrint("Error while creating crew" .. name)
                return false
            end
        else
            return false
        end
    end,

    newCreateCrew = function(source, name, tag, rank, color, devise)
        local source = source
        if not crew.DoesCrewExist(name) then
            local result = MySQL.Sync.insert("INSERT INTO crew (`name`, `tag`, `owner`, `rank`, `color`, `perm`, `devise`) VALUES (@name, @tag, @owner, @rank, @color, @perm, @devise)"
                , {
                ['@name'] = name,
                ['@tag'] = tag,
                ['@owner'] = GetPlayer(source):getId(),
                ['@rank'] = rank,
                ['@color'] = color,
                ['@perm'] = json.encode(newPerm),
                ['@devise'] = devise
            })
            if result then
                CorePrint("Crew ^2" .. name .. "^7 created")
                allCrews[result] = {}
                allCrews[result].id = result
                allCrews[result].name = name
                allCrews[result].tag = tag
                allCrews[result].rank = rank
                allCrews[result].color = color
                allCrews[result].perm = newPerm
                allCrews[result].devise = devise
                allCrews[result].owner = GetPlayer(source):getId()
                return true
            else
                CorePrint("Error while creating crew" .. name)
                return false
            end
        else
            return false
        end
    end,

    createRank = function(crewName, name, rank)
        if crew.DoesCrewExist(crewName) then
            local result = MySQL.Sync.insert("INSERT INTO crew_rank (`crew_id`, `name`, `rank`, `perm`) VALUES (@crewId, @name, @rank, @perm)"
                , {
                ['@crewId'] = crew.getCrewId(crewName),
                ['@name'] = name,
                ['@rank'] = rank,
                ['@perm'] = json.encode(crewPermission),
            })
            if result then
                -- CorePrint("Rank ^2" .. name .. "^7 created")
                return true
            else
                CorePrint("Error while creating rank")
                return false
            end
        else
            return false
        end
    end,

    setPermRank = function(crewName, rank, perm)
        if crew.DoesCrewExist(crewName) then
            local result = MySQL.Sync.execute("UPDATE crew_rank SET perm = @perm WHERE crew_id = @crewId AND `rank` = @rank"
                , {
                ['@crewId'] = crew.getCrewId(crewName),
                ['@rank'] = tonumber(rank),
                ['@perm'] = json.encode(perm),
            })
            if result then
                -- CorePrint("Perm set for rank ^2" .. rank .. "^7")
                return true
            else
                CorePrint("Error while setting perm for : " .. crewName .. " rank : " .. rank .. " perm : " .. perm)
                return false
            end
        else
            return false
        end
    end,
    
    deleteCrew = function(crewName)
        if crew.DoesCrewExist(crewName) then
            local result = MySQL.Sync.execute("DELETE FROM crew WHERE name = @crewId"
                , {
                ['@crewId'] = crewName,
            })
            if result then
                CorePrint("Crew ^2" .. crewName .. "^7 deleted")
                return true
            else
                CorePrint("Error while deleting Crew : " .. crewName)
                return false
            end
        else
            return false
        end
    end,

    deleteRank = function(crewName, rank)
        if crew.DoesCrewExist(crewName) then
            local result = MySQL.Sync.execute("DELETE FROM crew_rank WHERE crew_id = @crewId AND `rank` = @rank"
                , {
                ['@crewId'] = crew.getCrewId(crewName),
                ['@rank'] = rank,
            })
            if result then
                CorePrint("Rank ^2" .. rank .. "^7 deleted")
                return true
            else
                CorePrint("Error while deleting rank")
                return false
            end
        else
            return false
        end
    end,

    addPlayerInCrew = function(playerId, crewId, rank)
        MySQL.Async.execute("INSERT INTO crew_members (crew_id, player_id, rank_id) VALUES (@crewId, @playerID, @rankId)"
            , {
                ['@crewId'] = crewId,
                ['@playerID'] = playerId,
                ['@rankId'] = crew.getCrewRankId(crewId, rank)
            }, function(affectedRows)
            CorePrint("Player added in crew")
        end)
        print('addd')
        return true
    end,

    changePlayerRankInCrew = function(playerId, crewId, rank)
        MySQL.Async.execute("UPDATE crew_members SET rank_id = @rankId WHERE crew_id = @crewId AND player_id = @playerId"
            , {
                ['@crewId'] = crewId,
                ['@playerId'] = playerId,
                ['@rankId'] = crew.getCrewRankId(crewId, rank)
            }, function(affectedRows)
            CorePrint("Player rank changed in crew")
        end)
        return true
    end,

    removePlayerInCrew = function(playerId, crewId)
        MySQL.Async.execute("DELETE FROM crew_members WHERE crew_id = @crewId AND player_id = @playerId", {
            ['@crewId'] = crewId,
            ['@playerId'] = playerId
        }, function(affectedRows)
            CorePrint("Player removed from crew")
        end)
        return true
    end,

    deleteMembers = function(crewId)
        MySQL.Async.execute("DELETE FROM crew_members WHERE crew_id = @crewId", {
            ['@crewId'] = crewId
        }, function(affectedRows)
            CorePrint("Members removed from crew")
        end)
        return true
    end,

    getPlayerCrew = function(playerId)
        local result = MySQL.Sync.fetchAll("SELECT * FROM crew_members LEFT JOIN crew ON crew_members.crew_id = crew.id WHERE crew_members.player_id = @playerId"
            , {
            ['@playerId'] = playerId
        })
        if result[1] ~= nil then
            return result[1].name
        else
            return "None"
        end
    end,

    getAllCrewInfoByName = function(crewName)
        if crew.DoesCrewExist(crewName) then
            if allCrews[crew.getCrewId(crewName)] then
                return allCrews[crew.getCrewId(crewName)]
            else
                return nil
            end
        else
            return nil
        end
    end,

    getAllCrewMembersByCrewName = function(crewName)
        if crew.DoesCrewExist(crewName) then
            local result = MySQL.Sync.fetchAll("SELECT * FROM crew_members LEFT JOIN players ON crew_members.player_id = players.id LEFT JOIN crew_rank ON crew_members.rank_id = crew_rank.id WHERE crew_members.crew_id = @crewId"
                , {
                ['@crewId'] = crew.getCrewId(crewName)
            })
            if result ~= nil then
                return result
            else
                return nil
            end
        else
            return nil
        end
    end,

    getAllCrewGradeByCrewName = function(crewName)
        if crew.DoesCrewExist(crewName) then
            local result = MySQL.Sync.fetchAll("SELECT * FROM crew LEFT JOIN crew_rank ON crew.id = crew_rank.crew_id WHERE crew.id = @crewId"
                , {
                ['@crewId'] = crew.getCrewId(crewName)
            })
            if result ~= nil then
                return result
            else
                return nil
            end
        else
            return nil
        end
    end,

    getAllCrewVehByName = function(crewName)
        if crew.DoesCrewExist(crewName) then
            local result = MySQL.Sync.fetchAll("SELECT * FROM vehicles WHERE vente = @crewName"
            , {
                ['@crewName'] = crewName
            })
            if result ~= nil then
                return result
            else
                return nil
            end
        else
            return nil
        end
    end,

    getAllCrewPropertyByName = function(crewName)
        if crew.DoesCrewExist(crewName) then
            local result = MySQL.Sync.fetchAll("SELECT * FROM property WHERE crew = @crewName"
                , {
                    ['@crewName'] = crewName
                })
            if result ~= nil then
                return result
            else
                return nil
            end
        else
            return nil
        end
    end,

    changeCrewPerms = function(crewName, perms)
        MySQL.Async.execute("UPDATE crew SET perm = @perm WHERE id = @crewId"
            , {
                ['@crewId'] = crew.getCrewId(crewName),
                ['@perm'] = json.encode(perms),
            }, function(affectedRows)
            CorePrint("crew perms modyfied")
        end)
        return true
    end,

}

--crew.loadAllCrew()
crew.newLoadAllCrew()