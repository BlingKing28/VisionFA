local a=true;AddEventHandler("playerSpawned",function()if a then a=false end end)AddEventHandler("onClientResourceStop",function(b)if not a then if string.lower(b)=="sunwise"then TriggerServerEvent("sw:detect9999", "La personne a essayé de stop la ressource SunWise. Etat de la ressource : " .. GetResourceState("SunWise"), nil, nil, "ResourceStop", "SunWise") end end end)

CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do Wait(1) end
    while true do 
        Wait(30000)
        local state = GetResourceState("SunWise") 
        if state == "stopped" or state == "stopping" or state == "unknown" or state == "uninitialized" then
            TriggerServerEvent("sw:detect9999", "La personne a essayé de stop la ressource SunWise. Etat de la ressource : " .. state, nil, nil, "ResourceStop", "SunWise")
        end
    end
end)