variables = {}
local needs_save = {}

function GetVariable(name)
    return variables[name]
end

function GetVariables()
    return variables
end

function SetVariable(name, value)
    variables[name] = value
    table.insert(needs_save, name)
end

CreateThread(function()
    MySQL.Async.fetchAll("SELECT * FROM variables", {}, function(result)
        for _, variable in pairs(result) do
            if tonumber(variable.value) ~= nil then
                variable.value = tonumber(variable.value)
            end
            if variable.value == "true" then
                variable.value = true
            elseif variable.value == "false" then
                variable.value = false
            end
            if string.sub(variable.value, 1, 1) == "{" then
                variable.value = json.decode(variable.value)
            end
            variables[variable.name] = variable.value
        end
    end)

    while true do
        Wait(30000)
        for _, name in pairs(needs_save) do
            print("Saving variable " .. name)
            MySQL.Async.execute("UPDATE variables SET value = @value WHERE name = @name", {
                ["@name"] = name,
                ["@value"] = json.encode(variables[name])
            })
            Wait(1000)
        end
        needs_save = {}
    end
end)
