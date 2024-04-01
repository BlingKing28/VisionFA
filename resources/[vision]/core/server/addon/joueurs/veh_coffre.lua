local stockOpendedTrunk = {}
RegisterServerCallback("core:PlayerInTrunk", function(source, plate)
    return encodetableTrunk(plate)
end)

local AllCoffreUsing = {}

function encodetableTrunk(plate)
    for i = 1, 350 do
        if stockOpendedTrunk[i] == nil then
            table.insert(stockOpendedTrunk, i, plate)
            return false          
        else 
            if stockOpendedTrunk[i] == plate then
                return true
            end
        end
    end
end

RegisterNetEvent("core:LeaveTrunk")
AddEventHandler("core:LeaveTrunk", function(sendplate)
    removetableTrunk(sendplate)
end)

function removetableTrunk(sendplate)
    for i = 1, 350 do
        if stockOpendedTrunk[i] == sendplate then
            table.remove(stockOpendedTrunk, i)
            break
        end
    end
end 

RegisterServerCallback("core:getUsingStatusCoffre", function(source, plate)
    local fund = false
    for i,v in ipairs(AllCoffreUsing) do 
        if v.plate == plate then 
            fund = true
        end
    end
    return fund
end)

RegisterNetEvent("core:setLockCoffreCar", function(token, plate, bool)
    local src = source 
    if CheckPlayerToken(src, token) then 
        if bool then 
            table.insert(AllCoffreUsing, {plate = plate, src = src})
        else
            for i, v in ipairs(AllCoffreUsing) do 
                if v.plate == plate then 
                    table.remove(AllCoffreUsing, i)
                end
            end
        end
    end
end)

AddEventHandler("playerDropped", function()
    local src = source 
    for i, v in ipairs(AllCoffreUsing) do 
        if v.src == src then
            table.remove(AllCoffreUsing, i)
        end
    end
end)