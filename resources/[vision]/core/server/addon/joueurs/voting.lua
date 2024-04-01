local enabled = false

Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(100) end

    RegisterServerCallback("voting:server:enabled", function(source)
        return enabled
    end)

    RegisterServerCallback('voting:server:checkIfVoted', function(source, token)
        local src = source
        if CheckPlayerToken(src, token) then
            CheckColumn()
            local id = GetPlayer(src):getId()
            local hasVoted = MySQL.Sync.fetchAll('SELECT hasvoted FROM players WHERE id = ? LIMIT 1', { id })
            print(json.encode(hasVoted))
            if hasVoted[1].hasvoted == 1 then
                return true
            else
                return false
            end
        else
            return false
        end
    end)

    RegisterServerCallback('voting:server:getVotes', function(source, token)
        local src = source
        if CheckPlayerToken(src, token) then
            local result = MySQL.Sync.fetchAll('SELECT * FROM election')
            return result
        else
            return false
        end
    end)
end)

AddEventHandler("voting:server:castVote")
RegisterNetEvent('voting:server:castVote', function(name, party, token)
    local src = source
    if CheckPlayerToken(src, token) then
        local id = GetPlayer(src):getId()

        CheckColumn()
        MySQL.Sync.execute('UPDATE players SET hasvoted = ? WHERE id = ?', { 1, id })

        CheckTable()
        local result = MySQL.Sync.fetchAll('SELECT votes FROM election WHERE name = ?', { name })

        if not result[1] then
            MySQL.Sync.execute('INSERT INTO election (name, party, votes) VALUES (?, ?, ?)', { name, party, 1 })
        else
            MySQL.Sync.execute("UPDATE election SET votes=? WHERE name=?;", { result[1].votes + 1, name })
        end
    end
end)

AddEventHandler("voting:server:toggleElections")
RegisterNetEvent('voting:server:toggleElections', function(token)
    local src = source
    if CheckPlayerToken(src, token) then
        if enabled then
            enabled = false
        else
            enabled = true
        end
    end
end)


function CheckColumn()
    MySQL.Async.fetchAll('SHOW COLUMNS FROM players LIKE "hasvoted"', {}, function(result)
        print(json.encode(result))
        if not result[1] then
            MySQL.Async.execute('ALTER TABLE players ADD hasvoted INT(1) DEFAULT 0', {}, function() end)
        end
    end)
end

function CheckTable()
    local check = MySQL.Sync.fetchAll('SHOW TABLES LIKE "election"')
    if not check[1] then
        MySQL.Sync.execute('CREATE TABLE election (name VARCHAR(255), party VARCHAR(255), votes INT(255))')
    end
end