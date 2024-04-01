local cardealerSudStock = {}
local cardealerNordStock = {}
local NumberCharset = {}
local Charset = {}

for i = 48, 57 do table.insert(NumberCharset, string.char(i)) end

for i = 65, 90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

local function LoadStockFromFile() -- Allow dynamic load
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "server/addon/jobs/cardealerSud_stock.json")
    cardealerSudStock = json.decode(loadFile)
    
    local loadFile2 = LoadResourceFile(GetCurrentResourceName(), "server/addon/jobs/cardealerNord_stock.json")
    cardealerNordStock = json.decode(loadFile2)
end

LoadStockFromFile()

local function RefreshStockFromFiles() -- Allow dynamic save
    SaveResourceFile(GetCurrentResourceName(), "server/addon/jobs/cardealerSud_stock.json", json.encode(cardealerSudStock), -1)
    SaveResourceFile(GetCurrentResourceName(), "server/addon/jobs/cardealerNord_stock.json", json.encode(cardealerNordStock), -1)
end

function AddVehiculeToStock(data, etp)
    if data == nil then return end

    if etp and etp == "cardealerSud" then
        table.insert(cardealerSudStock, { name = data.name, price = data.price })
    elseif etp == "cardealerNord" then
        table.insert(cardealerNordStock, { name = data.name, price = data.price })
    end
    RefreshStockFromFiles()
    LoadStockFromFile()
end

function RemoveVehicleConcessToStock(data, etp)
    if data == nil then return end
    if etp == "cardealerSud" then
        for i = 1, #cardealerSudStock do
            if cardealerSudStock[i].name == data then
                table.remove(cardealerSudStock, i)
                RefreshStockFromFiles()
                LoadStockFromFile()
                return
            end
        end
    else
        for i = 1, #cardealerNordStock do
            if cardealerNordStock[i].name == data then
                table.remove(cardealerNordStock, i)
                RefreshStockFromFiles()
                LoadStockFromFile()
                return
            end
        end
    end
end

local function GetRandomNumber(length)
    Citizen.Wait(0)
    math.randomseed(GetGameTimer())
    if length > 0 then
        return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
    else
        return ''
    end
end

local function GetRandomLetter(length)
    Citizen.Wait(0)
    math.randomseed(GetGameTimer())
    if length > 0 then
        return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    else
        return ''
    end
end

local function GeneratePlate()
    return string.upper(GetRandomLetter(4) .. "" .. GetRandomNumber(4))
end

function GenerateNotOwnedPlate()
    local free = false
    local plate = ""
    while not free do
        plate = GeneratePlate()
        local result = MySQL.Sync.fetchAll('SELECT plate FROM vehicles WHERE plate = @plate', { ['@plate'] = plate })
        if result[1] == nil then
            free = true
        end
    end
    return tostring(plate)
end

function BuyVehicle(player, vehicle, crew, color, job, etp, source)
    local model = vehicle
    local props = {}
    local plate = GenerateNotOwnedPlate()
    local newPlayer = GetPlayer(player):getId()
    props.plate = plate
    if crew == "None" then
        crew = nil
    end
    if job == "aucun" then 
        job = nil
    end
    -- if crew ~= nil and job == nil then
    --     newPlayer = crew
    -- elseif crew == nil and job ~= nil then
    --     newPlayer = job
    -- else
    --     newPlayer = GetPlayer(player):getId()
    -- end

    MySQL.Async.execute("INSERT INTO vehicles (owner, plate, name, props, inventory, garage, vente, job) VALUES (@1, @2, @3, @4, @5, @6, @7, @8)"
        , {
            ["1"] = newPlayer,
            ["2"] = props.plate,
            ["3"] = tostring(model),
            ["4"] = json.encode(props),
            ["5"] = json.encode({}),
            ["6"] = "central",
            ["7"] = crew,
            ["8"] = job
        }, function(affectedRows)
        if affectedRows ~= 0 then
             local inv
            if coffre[GetHashKey(model)] ~= nil and coffre[GetHashKey(model)] / 1000 ~= nil then
                inv = json.encode({item={}, cloths={}, weapons={}, weight={max=coffre[GetHashKey(model)] / 1000, current=0}})
            else
                inv = json.encode({item={}, cloths={}, weapons={}, weight={max=100, current=0}})
            end
            local veh = carDealerCreateCar({
                plate = props.plate,
                owner = newPlayer,
                name = model,
                props = json.encode(props),
                garage = nil,
                stored = 1,
                vente = crew,
                coowner = json.encode({}),
                job = job,
                inventory = json.encode(inv),
                mileage = 0,
                fuel = 100,
                body = json.encode({}),
                currentPlate = props.plate
            })
            if etp == "cardealerSud" then
                TriggerClientEvent('core:spawnVehiclecardealerSud', player, tostring(model), props.plate, color)
            else
                TriggerClientEvent('core:spawnVehiclecardealerNord', player, tostring(model), props.plate, color)
            end
            TriggerClientEvent('core:createKeys', source, props.plate, tostring(model))
        else
            --[[TriggerClientEvent('core:ShowNotification', player, "~r~Erreur lors de l'achat du véhicule")]]
            TriggerClientEvent("__vision::createNotification", player, {
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Erreur lors de l'achat du véhicule"
            })
        end
    end)
end

RegisterNetEvent("core:cardealerBuyVeh")
AddEventHandler("core:cardealerBuyVeh", function(token, data, price, etp)
    local source = source
    if CheckPlayerToken(source, token) then

        if RemoveMoneyToSociety(tonumber(price), etp) then
            AddVehiculeToStock(data, etp)
            Wait(100)
            if etp == "cardealerSud" then
                TriggerClientEvent("core:cardealerSudGetStock", -1, cardealerSudStock)
            else
                TriggerClientEvent("core:cardealerNordGetStock", -1, cardealerNordStock)
            end
        else
            --[[TriggerClientEvent('core:ShowNotification', source,
                "Votre societé n'a pas assez d'argent pour acheter ce véhicule.")]]
            TriggerClientEvent("__vision::createNotification", source, {
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Votre societé n'a pas assez d'argent pour acheter ce véhicule"
            })
        end
    else
        --TODO: add AC verif
    end
end)

RegisterNetEvent("core:reSellVehicle")
AddEventHandler("core:reSellVehicle", function(token, vehicle, price, etp)
    if CheckPlayerToken(source, token) then
        RemoveVehicleConcessToStock(vehicle, etp)
        Wait(100)
        if etp == "cardealerSud" then
            TriggerClientEvent("core:cardealerSudGetStock", -1, cardealerSudStock)
        else
            TriggerClientEvent("core:cardealerNordGetStock", -1, cardealerNordStock)
        end
        if AddMoneyToSociety(price, etp) then
            --[[TriggerClientEvent('core:ShowNotification', source, "Vous venez de vendre.")]]
            TriggerClientEvent("__vision::createNotification", source, {
                type = 'VERT',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Vous venez de vendre votre véhicule"
            })
        end
    else

    end
end)

RegisterNetEvent("core:cardealerGetStock")
AddEventHandler("core:cardealerGetStock", function(token, crew, etp)
    if CheckPlayerToken(source, token) then
        if etp == "cardealerSud" then
            TriggerClientEvent("core:cardealerSudGetStock", -1, cardealerSudStock, crew)
        else
            TriggerClientEvent("core:cardealerNordGetStock", -1, cardealerNordStock, crew)            
        end
    else

    end
end)

RegisterNetEvent("core:assignBuyerToVehicle")
AddEventHandler("core:assignBuyerToVehicle", function(token, vehicle, buyer, crew, color, job, etp)
    local source = source
    if CheckPlayerToken(source, token) then
        RemoveVehicleConcessToStock(vehicle.name, etp)
        BuyVehicle(buyer, vehicle.name, crew, color, job, etp, source)
        Wait(100)
        if etp == "cardealerSud" then
            TriggerClientEvent("core:cardealerSudGetStock", -1, cardealerSudStock)
        else
            TriggerClientEvent("core:cardealerNordGetStock", -1, cardealerNordStock)
        end
    else

    end
end)

tryCarNorth = false
tryCarSouth = false
RegisterNetEvent("core:cardealerTryVeh")
AddEventHandler("core:cardealerTryVeh", function(token, target, vehicle, etp)
    local src = source
    print(source, target)
    SendDiscordLog("cardealerTryVeh", src, string.sub(GetDiscord(src), 9, -1), GetPlayer(src):getLastname() .. " " .. GetPlayer(src):getFirstname(),
        target, string.sub(GetDiscord(target), 9, -1), GetPlayer(target):getLastname() .. " " .. GetPlayer(target):getFirstname(),
        vehicle, etp)
    if CheckPlayerToken(source, token) then
        if etp == "cardealerSud" then
            tryCarSouth = true
            TriggerClientEvent('core:cardealerSudTryVeh', target, vehicle)
        else
            tryCarNorth = true
            TriggerClientEvent('core:cardealerNordTryVeh', target, vehicle)
        end
    else

    end
end)

RegisterServerCallback('core:isTryCar', function(source, etp)
    if etp == 'nord' then
        return tryCarNorth
    end
    return tryCarSouth
end)

RegisterNetEvent("core:unsetTryCar")
AddEventHandler("core:unsetTryCar", function(etp)
    if etp == 'nord' then
        tryCarNorth = false
    end
    tryCarSouth = false
end)

RegisterNetEvent("core:tryDebug")
AddEventHandler("core:tryDebug", function(pos)
    if pos == 'nord' then
        tryCarNorth = false
        return
    end
    tryCarSouth = false
    return
end)

RegisterNetEvent("core:concessVeloTryVeh")
AddEventHandler("core:concessVeloTryVeh", function(token, target, vehicle)
    if CheckPlayerToken(source, token) then
        TriggerClientEvent('core:concessVeloTryVeh', source, vehicle)
    else

    end
end)
RegisterNetEvent("core:concessEntrepriseTryVeh")
AddEventHandler("core:concessEntrepriseTryVeh", function(token, target, vehicle)
    if CheckPlayerToken(source, token) then
        TriggerClientEvent('core:concessEntrepriseTryVeh', source, vehicle)
    else

    end
end)
-- Callback

Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(100) end

    RegisterServerCallback("core:GetPlayerCrewArea", function(source, target)
        local player = GetPlayer(target):getCrew()
        return player
    end)
    RegisterServerCallback("core:GetPlayerJobArea", function(source, target)
        local player = GetPlayer(target):getJob()
        return player
    end)
    RegisterServerCallback("core:GetPlayerAreaName", function(source, target)
        --local player = GetPlayer(target):getIdentity()
        return GetPlayer(target):getFirstname() .. " " .. GetPlayer(target):getLastname()
    end)
    RegisterServerCallback("core:GetPlayerAreaSex", function(source, target)
        local player = GetPlayer(target):getSex()
        return player
    end)
end)

