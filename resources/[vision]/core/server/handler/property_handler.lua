properties = {} ---@type property

MySQL.ready(function()
    -- get all properties joined with the players table to get the concatenation of firstname and lastname
    MySQL.Async.fetchAll("SELECT property.*, CONCAT(players.firstname, ' ', players.lastname) AS owner_name FROM property LEFT JOIN players ON property.owner = players.id", {}, function(result)
        for _, prop in pairs(result) do
            local property = property:new({
                id = prop.id,
                name = prop.name,
                enter_pos = json.decode(prop.enter_pos),
                data = json.decode(prop.data),
                inventory = json.decode(prop.inventory),
                garage = json.decode(prop.garage),
                co_owner = json.decode(prop.co_owner),
                owner = prop.owner,
                type = prop.type,
                rentedAt = prop.rentedat,
                rentalEnd = prop.rentalEnd,
                crew = prop.crew,
                weight = prop.weight,
                owner_fullname = prop.owner_name
            }, true)
            properties[prop.id] = property
        end
    end)
end)

CreateThread(function()
    while true do
        Wait(30000)
        for _, prop in pairs(properties) do
            if prop.needs_save == true then
                print("Saving property " .. prop.id)
                MySQL.Async.execute("UPDATE property SET name = @name, enter_pos = @enter_pos, data = @data, inventory = @inventory, garage = @garage, owner = @owner, type = @type, rentedat = @rentedAt, rentalEnd = @rentalEnd, crew = @crew, weight = @weight, co_owner = @co_owner WHERE id = @id", {
                    ["@id"] = prop.id,
                    ["@name"] = prop.name,
                    ["@enter_pos"] = json.encode(prop.enter_pos),
                    ["@data"] = json.encode(prop.data),
                    ["@inventory"] = json.encode(prop.inventory),
                    ["@garage"] = json.encode(prop.garage),
                    ["@owner"] = prop.owner,
                    ["@type"] = prop.type,
                    ["@rentedAt"] = prop.rentedAt,
                    ["@rentalEnd"] = prop.rentalEnd,
                    ["@crew"] = prop.crew,
                    ["@weight"] = prop.weight,
                    ["@co_owner"] = json.encode(prop.co_owner)
                }, function(rowsChanged)
                    if rowsChanged > 0 then
                        prop.needs_save = false
                    end
                end)
                Wait(1000)
            end
        end
    end
end)

---@return property
function GetProperty(id)
    return properties[id]
end

function RemoveProperty(id)
    properties[id] = nil
end

function AllProperties()
    return properties
end

function AllPropertiesOnlyNecessaryData()
    local props = {}
    for _, prop in pairs(properties) do
        table.insert(props, {
            id = prop.id,
            enter_pos = prop.enter_pos,
            owner = prop.owner,
            type = prop.type,
            co_owner = prop.co_owner,
            data = { type = prop.data.type },
            name = prop.name,
            crew = prop.crew,
            rentalEnd = prop.rentalEnd,
        })
    end
    return props
end

-- function to get all the plates for vehiicle_handler
function AllPropertiesPlate()
    local props = {}
    for _, prop in pairs(properties) do
        if prop.data.type == "garage" then
            for _, plate in pairs(prop.garage) do
                table.insert(props, plate)
            end
        end
    end
    return props
end

-- Here i'm forced to insert it in database directly because i need the id of the property
function CreateProperty(prop) ---@return property

    local time = os.time()
    local created_property = property:new({
        id = MySQL.Sync.insert("INSERT INTO property (name, enter_pos, data, weight, owner, type, rentedAt, rentalEnd, crew) \
            VALUES (@name, @enter_pos, @data, @weight, @owner, @type, @rentedAt, @rentalEnd, @crew)",
        {
            ["@name"] = prop.name,
            ["@enter_pos"] = json.encode(prop.enter_pos),
            ["@data"] = json.encode(prop.data),
            ["@weight"] = prop.weight,
            ["@owner"] = prop.owner,
            ["@type"] = "Individuel",
            ["@rentedAt"] = time,
            ["@rentalEnd"] = time + (prop.data.duration * 86400),
            ["@crew"] = "NULL"
        }),
        name = prop.name,
        enter_pos = prop.enter_pos,
        data = prop.data,
        inventory = {},
        garage = {},
        owner = prop.owner,
        co_owner = {},
        type = "Individuel",
        rentedAt = time,
        rentalEnd = time + (prop.data.duration * 86400),
        crew = "",
        weight = prop.weight
    }, true)

    properties[created_property.id] = created_property

    return created_property
end

function DeleteProperty(id)
    MySQL.Async.execute("DELETE FROM property WHERE id = @id", {
        ["@id"] = id
    }, function(rowsChanged)
        if rowsChanged > 0 then
            RemoveProperty(id)
        end
    end)
end

local AllUsingCoffreProp = {}

RegisterServerCallback("core:property:IsUsingCoffre", function(source, token, id)
    local fuund
    if CheckPlayerToken(source, token) then 
        for i, v in ipairs(AllUsingCoffreProp) do 
            if v.id == id then
                fuund = v.using
            end
        end
    end
    return fuund
end)

RegisterNetEvent("core:property:setUsingCoffre", function(token, id, bool)
    local source = source
    if CheckPlayerToken(source, token) then 
        if bool then 
            table.insert(AllUsingCoffreProp, {using = true, id = id, src = source})
        else
            for i, v in ipairs(AllUsingCoffreProp) do 
                if v.id == id then
                    table.remove(AllUsingCoffreProp, i)
                end
            end
        end
    end
end)

AddEventHandler("playerDropped", function()
    local src = source 
    for i, v in ipairs(AllUsingCoffreProp) do 
        if v.src == src then
            table.remove(AllUsingCoffreProp, i)
        end
    end
end)

function IsVehicleInGarage(plate)
    for _, prop in pairs(properties) do
        if prop.data.type == "garage" then
            for _, veh in pairs(prop.garage) do
                if json.decode(veh) == nil or type(json.decode(veh)) ~= "table" then 
                    if veh == plate then
                        return true
                    end
                else
                    veh = json.decode(veh)
                    if veh ~= nil and veh ~= 0 and veh.props ~= nil and veh.props.plate ~= nil then
                        if veh.props.plate == plate then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end