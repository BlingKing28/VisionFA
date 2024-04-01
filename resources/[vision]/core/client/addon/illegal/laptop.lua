local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local UsingComputer = false
function setUsingComputer(bool)
    UsingComputer = bool
end

RegisterNetEvent("core:UseLaptop", function()
    if UsingComputer then
        return
    end
    UsingComputer = true
    local plyPed = PlayerPedId()
    local plyPos = GetEntityCoords(plyPed)
    local isInSouth = coordsIsInSouth(plyPos)
    local policeMans = nil
    if isInSouth then
        policeMans = TriggerServerCallback("core:getNumberOfDuty", token,'lspd')
    else
        policeMans = TriggerServerCallback("core:getNumberOfDuty", token,'lssd')
    end

    if policeMans >= 6 then 
        if (#(plyPos - vec3(753.67681884766, -1918.203125, 28.192085266113)) <= 5.0) or (#(plyPos - vec3(-122.28787994385, 6480.8115234375, 30.465162277222)) <= 5.0) then -- BRINKS
            TriggerServerEvent("core:addCrewExp", p:getCrew(), 3800)
            startHackingBrinks()
            return
        end

        --[[if #(plyPos - vec3(494.81155395508, -563.11547851563, 23.652143478394)) <= 5.0 then -- TRAIN
            TriggerServerEvent("core:addCrewExp", p:getCrew(), 5600)
            startHackingTrain()
            return
        end]]

        if policeMans >= 8 then -- FLEECA
            for k, v in pairs(Fleeca) do
                if not v.done then
                    if #(plyPos - v.door[1].pos.xyz) <= 3.5 then
                        TriggerServerEvent("core:addCrewExp", p:getCrew(), 5200)
                        AnimationHackingOpenDoor(v, k)
                        return
                    end
                end
            end
        end
    else
        exports['vNotif']:createNotification({
            type = 'JAUNE',
            content = "Ton ordinateur n'a ~s plus de batterie"
        })
    end
end)