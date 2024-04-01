Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(100) end
    RegisterServerCallback("core:sapinprerequischeck", function(source)
        local boulenoel = DoesPlayerHaveItemCount(source, "boulenoel", 3)
        local girlande = DoesPlayerHaveItemCount(source, "guirlande", 1)
        if boulenoel == true and girlande == true then
            return true, ""
        else
            if girlande == false then
                return false, "guirlande"
            else
                return false, "Boule(s) de Noël"
            end
        end
    end)
end)