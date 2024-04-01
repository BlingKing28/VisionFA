local AllIds = {}

GetAllCrewIds = function(specificCrew)
    local Tbl = {}
    for k,v in pairs(AllIds) do 
        if specificCrew then
            if v.crew and v.crew == specificCrew then 
                table.insert(Tbl, v.id)
            end
        else
            if v.crew then
                table.insert(Tbl, v.id)
            end
        end
    end
    return Tbl
end

GetAllSouthIds = function()
    local Tbl = {}
    for k,v in pairs(AllIds) do 
        if v.IsInSouth then 
            table.insert(Tbl, v.id)
        end
    end
    return Tbl
end

GetAllNorthIds = function()
    local Tbl = {}
    for k,v in pairs(AllIds) do 
        if not v.IsInSouth then 
            table.insert(Tbl, v.id)
        end
    end
    return Tbl
end

GetAllBucketIds = function(bucket)
    local Tbl = {}
    for k,v in pairs(AllIds) do 
        if v.Bucket == bucket then 
            table.insert(Tbl, v.id)
        end
    end
    return Tbl
end

GetAllBucketIdsExcept = function(exeptBucket)
    local Tbl = {}
    for k,v in pairs(AllIds) do 
        if v.Bucket ~= exeptBucket then 
            table.insert(Tbl, v.id)
        end
    end
    return Tbl
end

GetAllJobsIds = function(specificJob)
    local Tbl = {}
    for k,v in pairs(AllIds) do 
        if specificJob then
            if v.job and v.job == specificJob then 
				table.insert(Tbl, v.id)
            end
        else
            if v.job then
                table.insert(Tbl, v.id)
            end
        end
    end
    return Tbl
end

TriggerClientEvents = function(name, ids, ...)
    if type(ids) == "table" then
        for i,v in ipairs(ids) do
            TriggerClientEvent(name, v, ...)
        end
    else
        print("[Core] Erreur lors d'un TriggerClientEvents, les ids ne sont pas une table. Type : " .. ids .. ". Nom de l'event : " .. name)
    end
end

ChangePlayerBucket = function(src, bucket)
    for i,v in ipairs(AllIds) do 
        if v.id == src then 
            v.bucket = bucket
            return
        end
    end
end

RegisterNetEvent("core:RegisterPlayer", function(crew, job, isInSouth)
    local src = source
    local found = false
    if next(AllIds) then
        for i,v in ipairs(AllIds) do 
            if v.id == src then 
                found = true
                if crew ~= nil then v.crew = crew end
                if job ~= nil then v.job = job end
                if isInSouth ~= nil then v.IsInSouth = isInSouth end
                return
            end
        end
    end
    if not found then 
        if crew == "None" then
            table.insert(AllIds, {job = job, id = src, IsInSouth = isInSouth})
        else
            table.insert(AllIds, {crew = crew, job = job, id = src, IsInSouth = isInSouth})
        end
    end
end)

RegisterCommand("getAllIds", function(source)
    if source == 0 then 
        print(json.encode(AllIds))
    end
end)

AddEventHandler("playerDropped", function(source)
    for i,v in ipairs(AllIds) do 
        if v.src == source then 
            table.remove(AllIds,k)
        end
    end
end)