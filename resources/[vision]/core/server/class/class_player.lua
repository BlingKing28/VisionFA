player = {
    id = 0, ---@private
    source = 0,
    license = "", ---@private
    firstname = "", ---@private
    lastname = "", ---@private
    age = "02/01/2000", ---@private
    sex = "", ---@private
    size = 180, ---@private
    birthplaces = "", ---@private
    inventaire = {}, ---@private
    weapons = {}, ---@private
    cloths = { skin = {}, cloths = {} }, ---@private
    tattoos = {}, ---@private
    degrader = {},
    banque = 5000, ---@private
    pos = Config.defaultPos, ---@private
    permission = 0, ---@private
    balance = 0, ---@private
    subscription = 0, ---@private
    job = "aucun", ---@private
    job_grade = 1, ---@private
    crew = "None", ---@private
    status = { hunger = 99, thirst = 99 , health = 200}, ---@private
    vip = 0,
    needSave = false, ---@private
    needPosSave = false,
    active = 1,
    idPerso = {},
    lastProperty = {},
}

player.__index = player

local p = {} ---@type player

---@return player
function GetPlayer(source)
    return p[source]
end

function RemovePlayer(source)
    p[source] = nil
end

---@return player
function player:new(data, default, source, perm)
    local self = setmetatable({}, player)
    print('default', default, perm)
    if not default then
        self.id = data.id
        self.source = source
        self.license = data.license
        self.firstname = data.firstname
        self.lastname = data.lastname
        self.age = data.age
        self.sex = data.sex
        self.birthplaces = data.birthplaces
        self.inventaire = json.decode(data.inventaire)
        if data.weapons == nil then
            self.weapons = {}
        else
            self.weapons = json.decode(data.weapons)
        end
        self.cloths = json.decode(data.cloths)
        self.tattoos = json.decode(data.tattoos)
        self.degrader = json.decode(data.degrader)
        self.banque = data.banque
        self.pos = json.decode(data.pos)
        self.permission = data.permission
        self.subscription = data.subscription
        self.balance = data.balance
        self.job = data.job
        self.job_grade = data.job_grade
        self.crew = data.crew
        self.status = json.decode(data.status)
        self.vip = data.vip
        self.needSave = false
        self.needPosSave = false
        self.active = data.active or 1
        self.idPerso = {}
        if self.cloths.cloths == nil then
            self.cloths.cloths = {}
        end
        self.lastProperty = json.decode(data.lastProperty)
    else
        self.source = source
        self.firstname = ""
        self.lastname = ""
        self.age = "02/01/2000"
        self.sex = ""
        self.size = 180        
        self.birthplaces = ""       
        self.inventaire = {}
        self.weapons = {}
        self.cloths = { skin = {}, cloths = {} }
        self.tattoos = {}
        self.degrader = {}
        self.banque = 5000
        self.pos = Config.defaultPos
        self.permission = perm or 0
        self.subscription = data.subscription
        self.balance = data.balance
        self.job = "aucun"
        self.job_grade = 1
        self.crew = "None"
        self.status = { hunger = 99, thirst = 99, health = 200 }
        self.vip = 0
        self.needSave = false
        self.needPosSave = false
        self.active = 1
        self.idPerso = {}
        self.license = GetLicense(source)
    end
    print(source, self.permission)
    p[source] = self
    return self
end

--getters and setters

function player:getId()
    return self.id
end

function player:setId(id)
    self.id = id
end

function player:setSource(source)
    self.source = source
end

function player:getSource()
    return self.source
end

function player:setLicense(license)
    self.license = license
end

function player:getLicense()
    return self.license
end

function player:getFirstname()
    return self.firstname
end

function player:setFirstname(firstname)
    self.firstname = firstname
end

function player:getLastname()
    return self.lastname
end

function player:setLastname(lastname)
    self.lastname = lastname
end

function player:getAge()
    return self.age
end

function player:setAge(age)
    self.age = age
end

function player:getSex()
    return self.sex
end

function player:setSex(sex)
    self.sex = sex
end

function player:getSize()
    return self.size
end

function player:setSize(size)
    self.size = size
end

function player:getBirthplaces()
    return self.birthplaces
end

function player:setBirthplaces(birthplaces)
    self.birthplaces = birthplaces
end

function player:setInventaire(inventaire)
    self.inventaire = inventaire
end

function player:getInventaire()
    return self.inventaire
end

function player:GetId()
    return self.id
end

function player:getId() -- copie de GetId() pour fix les fautes de frappes maj
    return self.id
end

function player:setId(id)
    self.id = id
end

function player:getSkin()
    return self.cloths.skin
end

function player:getCloths()
    return self.cloths
end

function player:getTattoos()
    return self.tattoos
end
function player:GetGradender()
    return self.degrader
end
function player:setGradender(degrade)
    self.degrader =degrade
end
function player:idPersonnage()
    return self.idPerso
end
function player:setidPersonnage(table)
    self.idPerso = table
end

function player:getBanque()
    return self.banque
end

function player:getPos()
    return self.pos
end

function player:getPermission()
    return self.permission
end

function player:getBalance()
    return self.balance
end

function player:getSubscription()
    return self.subscription
end

function player:getJob()
    return self.job
end

function player:getJobGrade()
    return self.job_grade
end

function player:getCrew()
    return self.crew
end

function player:getNeedSave()
    return self.needSave
end

function player:getWeapons()
    return self.weapons
end

function player:setWeapons(weapon)
    self.weapons  = weapon
end

function player:setCloths(cloths)
    self.cloths = cloths
end

function player:getCloths()
    return self.cloths
end

function player:setSkin(skin)
    self.cloths.skin = skin
end

function player:getSkin()
    return self.cloths.skin
end

function player:setClothsCloths(cloths)
    self.cloths.cloths = cloths
end

function player:getClothsCloths()
    return self.cloths.cloths
end

function player:setTattoos(tattoo)
    self.tattoos = tattoo
end

function player:getTattoos()
    return self.tattoos
end

function player:getDegrader()
    return self.degrader
end

function player:setDegrader(degrader)
    self.degrader = degrader
end

function player:setBanque(banque)
    self.banque = banque
end

function player:getBanque()
    return self.banque
end

function player:setPos(pos)
    self.pos = pos
end

function player:getPos()
    return self.pos
end

function player:getPermission()
    return self.permission
end

function player:setPermission(permission)
    self.permission = permission
end

function player:setJob(job)
    self.job = job
end

function player:getJob()
    return self.job
end

function player:setJobGrade(job_grade)
    self.job_grade = job_grade
end

function player:getJobGrade()
    return self.job_grade
end

function player:setCrew(crew)
    self.crew = crew
end

function player:getCrew()
    return self.crew
end

function player:setVip(vip)
    self.vip = vip
end

function player:getVip()
    return self.vip
end

function player:setStatus(status)
    self.status = status
end

function player:getStatus()
    return self.status
end

function player:setHunger(hunger)
    self.status.hunger = hunger
end

function player:getHunger()
    return self.status.hunger
end

function player:setThirst(thirst)
    self.status.thirst = thirst
end

function player:getThirst()
    return self.status.thirst
end

function player:setHealth(health)
    self.status.health = health
end

function player:getHealth()
    return self.status.health
end

function player:setNeedSave(status)
    self.needSave = status
end

function player:getNeedSave()
    return self.needSave
end

function player:setNeedPosSave(status)
    self.needPosSave = status
end

function player:getNeedPosSave()
    return self.needPosSave
end

function player:haveEnoughMoney(num)
    for k,v in pairs(self:getInventaire()) do
        if v.name == "money" then
            if v.count >= tonumber(num) then
                return true
            else
                return false
            end
        end
    end
end

function player:getStatus()
    return self.status
end

function player:setActive(active)
    self.active = active
end

function player:getActive()
    return self.active
end

function player:setIdPerso(idPerso)
    self.idPerso = idPerso
end

function player:getIdPerso()
    return self.idPerso
end

function player:setLastProperty(lastProperty)
    self.lastProperty = lastProperty
end

function player:getLastProperty()
    return self.lastProperty
end

-- weapons

---@return boolean
function player:DoesWeaponExist(name)
    if weapons[name] ~= nil then
        return true
    else
        return false
    end
end

---@return data
function player:GetWeaponData(name)
    return weapons[name]
end

---@return boolean
function player:HaveWeapon(name)
    if self.weapons[name] ~= nil then
        return true
    else
        return false
    end
end

function player:AddWeaponIfPossible(name, ammo)
    if self:DoesWeaponExist(name) then
        -- if not self:HaveWeapon(name, ammo) then
        --     local weapon = self:GetWeaponData(name)
        --     self.weapons[name] = {
        --         ammo = ammo,
        --         hash = weapon.hash,
        --         nameGXT = weapon.NameGXT,
        --         descGXT = weapon.DescriptionGXT,
        --         name = name,
        --     }
        --     return true
        -- else
        --     return false, "Possède déja l'arme"
        -- end
    else
        return false, "Arme inconnu"
    end
end

function player:SetWeaponAmmo(name, ammo)
    if self:HaveWeapon(name) then
        self.weapons[name].ammo = ammo
        return true
    else
        return false
    end
end

function player:SetWeaponComponents(name, components, option)
    if self:HaveWeapon(name) then

        if components == 'suppressor' then
            self.weapons[name].metadatas.suppressor = option
            --[[ print("OK SERVER SUPPRESSOR") ]]
        elseif components == 'flashlight' then
            self.weapons[name].metadatas.flashlight = option
            --[[ print("OK SERVER FLASHLIGHT") ]]
        elseif components == 'grip' then
            self.weapons[name].metadatas.grip = option
            --[[ print("OK SERVER GRIP") ]]
        end
        return true
    else
        return false
    end
end

function player:RemoveWeapon(name)
    if self:HaveWeapon(name) then
        self.weapons[name] = nil
        return true
    else
        return false
    end
end

function player:GiveWeaponIfPossible(name, source, target)
    if self:HaveWeapon(name) then
        -- TODO
        if not GetPlayer(target):HaveWeapon(name) then
            local weapon = GetPlayer(target):GetWeaponData(name)
            GetPlayer(target).weapons[name] = {
                ammo = self.weapons[name].ammo,
                hash = weapon.hash,
                nameGXT = weapon.NameGXT,
                descGXT = weapon.DescriptionGXT,
            }
            self:RemoveWeapon(name)
        else
            --TriggerClientEvent("core:ShowNotification", source, "La personne possède déja l'arme")
            TriggerClientEvent("__vision::createNotification", source, {
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s La personne possède déja l'arme"
            })
        end
    else
        --TriggerClientEvent("core:ShowNotification", source, "Vous ne possède pas l'arme")
        TriggerClientEvent("__vision::createNotification", source, {
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Vous ne possède pas l'arme"
        })
    end
end

-- bannk fct

function player:HaveMoneyAccount()
    if self.banque >= 0 then
        return true
    else
        return false
    end
end

function player:AddMoneyAccount(money)
    self.banque = self:getBanque() + money
end


function player:GetMoney()
    for k, v in pairs(player:getInventaire()) do
        if v.name == money then 
            return v.count
        end
    end
    return 0
end
function player:RemoveMoneyAccount(money)
    if self:getBanque() >= money then
        self.banque = self:getBanque() - money
        return true
    else
        return false
    end
end

-- players fct

function player:isMale()
    if p:getSex() == "M" then
        return true
    else
        return false
    end
end

function player:getFullName()
    return getFirstname() .. " " .. getLastname()
end

GetPlayer = function(source)
    return p[source]
end

-- export

exports('GetPlayer', function()
    return p
end)

exports('GetPlayerTarget', function(target)
    return p[target]
end)

exports('GetMoneyPlayer', function(source)
    return GetPlayer(source):GetMoney()
end)

exports('GetPlayerJob', function(source)
    return GetPlayer(source):getJob()
end)

exports('GetPlayerPerm', function(source)
    return GetPlayer(source):getPermission()
end)

GetPlayerPerm = function(source) -- NE PAS TOUCHER SVPPPP
    local perm
    if GetPlayer(source) then
        perm = GetPlayer(source):getPermission()
    else
        perm = 0
    end
    return perm
end

function GetAllplayer()
    return p
end

exports('GetPlayerIdbdd', function(source)
    while GetPlayer(source) == nil do Wait(1000) end
    return GetPlayer(source):GetId()
end)

exports('GetPlayerFullname', function(source)
    return GetPlayer(source):getFirstname() .. " " .. GetPlayer(source):getLastname()
end)