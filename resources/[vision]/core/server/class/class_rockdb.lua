rockdb = {}

function rockdb:new()
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function rockdb:SaveString(key, string)
    SetResourceKvp(key, string)
end

function rockdb:GetString(key)
    return GetResourceKvpString(key)
end

function rockdb:SaveInt(key, int)
    SetResourceKvpInt(key, int)
end

function rockdb:GetInt(key)
    return GetResourceKvpInt(key)
end

function rockdb:SaveFloat(key, float)
    SetResourceKvpFloat(key, float)
end

function rockdb:GetFloat(key)
    return GetResourceKvpFloat(key)
end

function rockdb:SaveTable(key, table)
    SetResourceKvp(key, json.encode(table))
end

function rockdb:GetTable(key)
    local result = GetResourceKvpString(key)
    if result ~= nil then
        return json.decode(result)
    else
        return nil
    end
end