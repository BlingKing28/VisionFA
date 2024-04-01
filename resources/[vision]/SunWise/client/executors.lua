CreateThread(function()
    Wait(10000)
    while true do
        Wait(10000)
        if NetworkIsPlayerActive(PlayerId()) then
            if Cfg.AntiExecutors then
                local ResourceMetadataToSend = {}
                local ResourceFilesToSend = {}
                for i = 0, GetNumResources() - 1, 1 do
                    local resource = GetResourceByFindIndex(i)
                    for i = 0, GetNumResourceMetadata(resource, 'client_script') do
                        local typer = GetResourceMetadata(resource, 'client_script', i)
                        local filee =
                            LoadResourceFile(tostring(resource), tostring(typer))
                        if ResourceMetadataToSend[resource] == nil then
                            ResourceMetadataToSend[resource] = {}
                        end
                        if ResourceFilesToSend[resource] == nil then
                            ResourceFilesToSend[resource] = {}
                        end
                        if typer ~= nil then
                            table.insert(ResourceMetadataToSend[resource], #typer)
                        end
                        if filee ~= nil then
                            table.insert(ResourceFilesToSend[resource], #filee)
                        end
                    end
                    for i = 0, GetNumResourceMetadata(resource, 'client_scripts') do
                        local typesss = GetResourceMetadata(resource, 'client_scripts', i)
                        local filed =
                            LoadResourceFile(tostring(resource), tostring(typesss))
                        if ResourceMetadataToSend[resource] == nil then
                            ResourceMetadataToSend[resource] = {}
                        end
                        if ResourceFilesToSend[resource] == nil then
                            ResourceFilesToSend[resource] = {}
                        end
                        if typesss ~= nil then
                            table.insert(ResourceMetadataToSend[resource], #typesss)
                        end
                        if filed ~= nil then
                            table.insert(ResourceFilesToSend[resource], #filed)
                        end
                    end
                    for i = 0, GetNumResourceMetadata(resource, 'ui_page') do
                        local typeeeee = GetResourceMetadata(resource, 'ui_page', i)
                        local filezz =
                            LoadResourceFile(tostring(resource), tostring(typeeeee))
                        if ResourceMetadataToSend[resource] == nil then
                            ResourceMetadataToSend[resource] = {}
                        end
                        if ResourceFilesToSend[resource] == nil then
                            ResourceFilesToSend[resource] = {}
                        end
                        if typeeeee ~= nil then
                            table.insert(ResourceMetadataToSend[resource], #typeeeee)
                        end
                        if filezz ~= nil then
                            table.insert(ResourceFilesToSend[resource], #filezz)
                        end
                    end
                end

                TriggerServerEvent('sw:sendallresources', ResourceMetadataToSend,ResourceFilesToSend)
                ResourceMetadataToSend = {}
                ResourceFilesToSend = {}
                Wait(180000)
            end
        end
    end
end)