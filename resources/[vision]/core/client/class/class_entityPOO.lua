entity = {
    id = 0,
    netId = 0,
}

local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t 
end)

---@return entity
function entity:register(entity)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.id = entity
    obj.netId = NetworkGetNetworkIdFromEntity(entity)

    return obj
end

---@return entity
function entity:CreateVehicle(model, pos, heading)
    TriggerServerEvent("TREFSDFD5156FD", "VZEFDSF", 5000)
    if type(model) == "number" then
        LoadModel(model)
        model = model
    else
        LoadModel(model)
        model = GetHashKey(model)
    end
    local entity = CreateVehicle(model, pos.xyz, heading, true, false)
    SetEntityAsMissionEntity(entity, 1, 1)
    SetVehicleDoorsLocked(entity, 0)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.id = entity
    obj.netId = NetworkGetNetworkIdFromEntity(entity)

    return obj
end

---@return entity
function entity:CreateVehicleLocal(model, pos, heading)
    if type(model) == "number" then
        LoadModel(model)
        model = model
    else
        LoadModel(model)
        model = GetHashKey(model)
    end
    local entity = CreateVehicle(model, pos.xyz, heading, false, false)
    SetEntityAsMissionEntity(entity, 1, 1)
    SetVehicleDoorsLocked(entity, 0)

    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.id = entity

    return obj
end

---@return entity
function entity:CreateObject(model, pos)
    TriggerServerEvent("TREFSDFD5156FD", "IOAPP", 5000)
    LoadModel(model)
    local entity = CreateObject(GetHashKey(model), pos.xyz, true, false, true)
    SetEntityAsMissionEntity(entity, 1, 1)

    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.id = entity
    obj.netId = NetworkGetNetworkIdFromEntity(entity)

    return obj
end

---@return entity
function entity:CreateObjectLocal(model, pos)
    LoadModel(model)
    local entity = CreateObject(GetHashKey(model), pos.xyz, false, false, true)
    SetEntityAsMissionEntity(entity, 1, 1)
    
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.id = entity

    return obj
end

---@return entity
function entity:CreatePed(model, pos, heading)
    LoadModel(model)
    local entity = CreatePed(1, GetHashKey(model), pos.xyz, heading, true, false)
    SetEntityAsMissionEntity(entity, 1, 1)

    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.id = entity
    obj.netId = NetworkGetNetworkIdFromEntity(entity)

    return obj
end


---@return entity
function entity:CreatePedLocal(model, pos, heading)
   LoadModel(model)
   local entity = CreatePed(1, GetHashKey(model), pos.xyz, heading, false, false)
   SetEntityAsMissionEntity(entity, 1, 1)
    
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.id = entity

    --obj.id = 0
    return obj
end

function entity:getEntityId()
    return self.id
end

function entity:getModel()
    return GetEntityModel(self.id)
end

function entity:getHealth()
    return GetEntityHealth(self.id)
end

function entity:getPos()
    return GetEntityCoords(self.id)
end

function entity:getHeading()
    return GetEntityHeading(self.id) 
end

function entity:getNetId()
    return self.netId
end

function entity:getOwner()
    return NetworkGetEntityOwner(self.id) -- Should return player index, need test
end

function entity:isNetworked()
    if NetworkRegisterEntityAsNetworked(self.id) then
        return true
    else
        return false
    end
end

function entity:setPos(pos)
    SetEntityCoordsNoOffset(self.id, pos.xyz, 0.0, 0.0, 0.0)
end

function entity:setHeading(heading)
    SetEntityHeading(self.id, heading)
end

function entity:setFreeze(status)
    if DoesEntityExist(self.id) then
        FreezeEntityPosition(self.id, status)
    end
end

function entity:setAlpha(alpha)
    SetEntityAlpha(self.id, alpha, 0)
end

function entity:resetAlpha()
    ResetEntityAlpha(self.id)
end

function entity:delete()
    if self:isNetworked() and self.netId then
        TriggerServerEvent("DeleteEntity", token, {self.netId})
    else
        DeleteEntity(self.id)
    end
end