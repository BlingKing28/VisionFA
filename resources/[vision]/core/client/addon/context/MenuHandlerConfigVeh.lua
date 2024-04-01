local MenuForVeh = {
    [1131912276] = { 
        {
            icon = "ramasser",
            label = "Prendre le vélo",
            action = "TaskTakeBike"
        } },
    [1127861609] = { 
        {
            icon = "ramasser",
            label = "Prendre le vélo",
            action = "TaskTakeBike"
        } },
    [GetHashKey("surfboard")] = { 
        {
            icon = "ramasser",
            label = "Prendre la planche",
            action = "TakeSurfBeach"
        } },
    [GetHashKey("fixter")] = { 
        {
            icon = "ramasser",
            label = "Prendre le vélo",
            action = "TaskTakeBike"
        } },
    [GetHashKey("cruiser")] = { 
        {
            icon = "ramasser",
            label = "Prendre le vélo",
            action = "TaskTakeBike"
        } },
    [GetHashKey("scorcher")] = { 
        {
            icon = "ramasser",
            label = "Prendre le vélo",
            action = "TaskTakeBike"
        } },
    [GetHashKey("tribike2")] = { 
        {
            icon = "ramasser",
            label = "Prendre le vélo",
            action = "TaskTakeBike"
        } }
}

function GetContextActionForVeh(model)
    if MenuForVeh[model] ~= nil then
        return MenuForVeh[model]
    else
        return {}
    end
end
