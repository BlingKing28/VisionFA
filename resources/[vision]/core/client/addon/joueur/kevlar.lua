local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

RegisterNetEvent("core:UseKevlar")
AddEventHandler("core:UseKevlar", function(item, shield)
    local inUse
    if p:haveItemWithCount(item, 1) then
        print(p:skin().bproof_1)
        if p:skin().bproof_1 == 71 or p:skin().bproof_1 == 67 --lspd
        or p:skin().bproof_1 == 57 or p:skin().bproof_1 == 58 --lspd
        or p:skin().bproof_1 == 58 or p:skin().bproof_1 == 57 --lspd
        or p:skin().bproof_1 == 80 or p:skin().bproof_1 == 70 --lspd
        or p:skin().bproof_1 == 78 or p:skin().bproof_1 == 70 --lspd
        or p:skin().bproof_1 == 79 or p:skin().bproof_1 == 70 --lspd
        or p:skin().bproof_1 == 69 or p:skin().bproof_1 == 70 --lspd
        or p:skin().bproof_1 == 122 or p:skin().bproof_1 == 111 --lspd
        or p:skin().bproof_1 == 82 or p:skin().bproof_1 == 83 --lspd

        or p:skin().bproof_1 == 72 or p:skin().bproof_1 == 71 --usss
        or p:skin().bproof_1 == 66 or p:skin().bproof_1 == 81 --usss
        or p:skin().bproof_1 == 67 or p:skin().bproof_1 == 82 --usss
        or p:skin().bproof_1 == 69 or p:skin().bproof_1 == 82 --usss
        or p:skin().bproof_1 == 128 or p:skin().bproof_1 == 58 --usss

        or p:skin().bproof_1 == 71 or p:skin().bproof_1 == 67 --lssd
        or p:skin().bproof_1 == 68 or p:skin().bproof_1 == 69 --lssd
        or p:skin().bproof_1 == 57 or p:skin().bproof_1 == 58 --lssd
        or p:skin().bproof_1 == 69 or p:skin().bproof_1 == 81 --lssd
        or p:skin().bproof_1 == 78 or p:skin().bproof_1 == 81 --lssd
        or p:skin().bproof_1 == 79 or p:skin().bproof_1 == 82 --lssd
        or p:skin().bproof_1 == 73 or p:skin().bproof_1 == 72 --lssd
        or p:skin().bproof_1 == 58 or p:skin().bproof_1 == 57 --lssd
        or p:skin().bproof_1 == 78 or p:skin().bproof_1 == 81 --lssd
        or p:skin().bproof_1 == 101 or p:skin().bproof_1 == 81 --lssd

        or p:skin().bproof_1 == 77 or p:skin().bproof_1 == 59 --USBP
        or p:skin().bproof_1 == 70 or p:skin().bproof_1 == 75 --USBP
        or p:skin().bproof_1 == 68 or p:skin().bproof_1 == 60 --USBP
        or p:skin().bproof_1 == 72 or p:skin().bproof_1 == 71 --USBP
        or p:skin().bproof_1 == 76 or p:skin().bproof_1 == 74 --USBP
        or p:skin().bproof_1 == 69 or p:skin().bproof_1 == 67 --USBP

        or p:skin().bproof_1 == 72 or p:skin().bproof_1 == 58 --doj/boi

        or p:skin().bproof_1 == 93 or p:skin().bproof_1 == 92 --sams
        or p:skin().bproof_1 == 93 or p:skin().bproof_1 == 92 --WZ
        or p:skin().bproof_1 == 109 or p:skin().bproof_1 == 109 --lst

        or p:skin().bproof_1 == 134 or p:skin().bproof_1 == 122 --illegal
        or p:skin().bproof_1 == 125 or p:skin().bproof_1 == 126 --illegal
        or p:skin().bproof_1 == 130 or p:skin().bproof_1 == 127 --illegal
        or p:skin().bproof_1 == 131 or p:skin().bproof_1 == 128 --illegal
        or p:skin().bproof_1 == 145 or p:skin().bproof_1 == 129 --illegal

        then
            inUse = false
            p:setShield(0)
            p:setCloth("bproof_1", 0)
            p:setCloth("bproof_2", 0)
            return
        else
            inUse = true
            if item == "lspdgiletj" then --lspd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 71)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 67)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "lspdkevle1" then --lspd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 57)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 58)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "lspdkevle2" then --lspd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 57)
                    p:setCloth("bproof_2", 5)
                else
                    p:setCloth("bproof_1", 58)
                    p:setCloth("bproof_2", 5)
                end
            elseif item == "lspdkevle3" then --lspd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 57)
                    p:setCloth("bproof_2", 6)
                else
                    p:setCloth("bproof_1", 58)
                    p:setCloth("bproof_2", 6)
                end
            elseif item == "lspdriot" then --lspd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 58)
                    p:setCloth("bproof_2", 2)
                else
                    p:setCloth("bproof_1", 57)
                    p:setCloth("bproof_2", 2)
                end
            elseif item == "lspdkevm1" then --lspd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 80)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 65)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "lspdkevlo1" then --lspd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 78)
                    p:setCloth("bproof_2", 1)
                else
                    p:setCloth("bproof_1", 70)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "lspdkevlo2" then --lspd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 79)
                    p:setCloth("bproof_2", 1)
                else
                    p:setCloth("bproof_1", 70)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "lspdkevlo3" then --lspd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 69)
                    p:setCloth("bproof_2", 2)
                else
                    p:setCloth("bproof_1", 70)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "lspdswat" then --lspd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 122)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 111)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "lspdkevpc" then --lspd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 82)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 83)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "lspdgnd" then --lspd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 68)
                    p:setCloth("bproof_2", 10)
                else
                    p:setCloth("bproof_1", 69)
                    p:setCloth("bproof_2", 10)
                end
            elseif item == "lspdgnd2" then --lspd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 82)
                    p:setCloth("bproof_2", 1)
                else
                    p:setCloth("bproof_1", 83)
                    p:setCloth("bproof_2", 1)
                end
            elseif item == "insigneKevUsss" then --usss
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 72)
                    p:setCloth("bproof_2", 3)
                else
                    p:setCloth("bproof_1", 71)
                    p:setCloth("bproof_2", 7)
                end
            elseif item == "ussskev1" then --usss
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 66)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 81)
                    p:setCloth("bproof_2", 1)
                end
            elseif item == "ussskev2" then --usss
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 67)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 82)
                    p:setCloth("bproof_2", 1)
                end
            elseif item == "ussskev3" then --usss
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 69)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 82)
                    p:setCloth("bproof_2", 1)
                end
            elseif item == "ussskev4" then --usss
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 128)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 58)
                    p:setCloth("bproof_2", 7)
                end
            elseif item == "lssdgiletj" then --lssd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 71)
                    p:setCloth("bproof_2", 1)
                else
                    p:setCloth("bproof_1", 67)
                    p:setCloth("bproof_2", 1)
                end
            elseif item == "lssdkevle1" then --lssd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 57)
                    p:setCloth("bproof_2", 1)
                else
                    p:setCloth("bproof_1", 58)
                    p:setCloth("bproof_2", 2)
                end
            elseif item == "lssdkevle2" then --lssd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 68)
                    p:setCloth("bproof_2", 1)
                else
                    p:setCloth("bproof_1", 69)
                    p:setCloth("bproof_2", 1)
                end
            elseif item == "lssdkevlo1" then --lssd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 69)
                    p:setCloth("bproof_2", 1)
                else
                    p:setCloth("bproof_1", 81)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "lssdkevlo2" then --lssd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 78)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 81)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "lssdkevlo3" then --lssd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 79)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 82)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "lssdkevlo4" then --lssd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 78)
                    p:setCloth("bproof_2", 2)
                else
                    p:setCloth("bproof_1", 82)
                    p:setCloth("bproof_2", 3)
                end
            elseif item == "lssdkevlo5" then --lssd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 101)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "lssdkevlo6" then --lssd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 101)
                    p:setCloth("bproof_2", 1)
                end
            elseif item == "lssdkevlo7" then --lssd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 101)
                    p:setCloth("bproof_2", 2)
                end
            elseif item == "lssdinsigne" then --lssd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 73)
                    p:setCloth("bproof_2", 1)
                else
                    p:setCloth("bproof_1", 72)
                    p:setCloth("bproof_2", 1)
                end
            elseif item == "lssdriot" then --lssd
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 58)
                    p:setCloth("bproof_2", 3)
                else
                    p:setCloth("bproof_1", 57)
                    p:setCloth("bproof_2", 3)
                end
            elseif item == "usbpkevlo1" then --USBP
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 77)
                    p:setCloth("bproof_2", 10)
                else
                    p:setCloth("bproof_1", 76)
                    p:setCloth("bproof_2", 10)
                end
            elseif item == "usbpkevlo2" then --USBP
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 59)
                    p:setCloth("bproof_2", 8)
                else
                    p:setCloth("bproof_1", 59)
                    p:setCloth("bproof_2", 8)
                end
            elseif item == "usbpkevlo3" then --USBP
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 70)
                    p:setCloth("bproof_2", 6)
                else
                    p:setCloth("bproof_1", 70)
                    p:setCloth("bproof_2", 6)
                end
            elseif item == "usbpkevlo4" then --USBP
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 70)
                    p:setCloth("bproof_2", 7)
                else
                    p:setCloth("bproof_1", 70)
                    p:setCloth("bproof_2", 7)
                end
            elseif item == "usbpkevlo5" then --USBP
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 75)
                    p:setCloth("bproof_2", 10)
                else
                    p:setCloth("bproof_1", 74)
                    p:setCloth("bproof_2", 10)
                end
            elseif item == "usbpkevpc" then --USBP
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 68)
                    p:setCloth("bproof_2", 12)
                else
                    p:setCloth("bproof_1", 69)
                    p:setCloth("bproof_2", 12)
                end
            elseif item == "usbpgiletb" then --USBP
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 60)
                    p:setCloth("bproof_2", 3)
                else
                    p:setCloth("bproof_1", 60)
                    p:setCloth("bproof_2", 5)
                end
            elseif item == "usbpgiletj" then --USBP
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 71)
                    p:setCloth("bproof_2", 8)
                else
                    p:setCloth("bproof_1", 67)
                    p:setCloth("bproof_2", 8)
                end
            elseif item == "usbpinsigne" then --USBP
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 72)
                    p:setCloth("bproof_2", 1)
                else
                    p:setCloth("bproof_1", 71)
                    p:setCloth("bproof_2", 1)
                end
            elseif item == "dojkev" then --doj
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 69)
                    p:setCloth("bproof_2", 3)
                else
                    p:setCloth("bproof_1", 58)
                    p:setCloth("bproof_2", 8)
                end
            elseif item == "boikev" then --boi
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 69)
                    p:setCloth("bproof_2", 4)
                else
                    p:setCloth("bproof_1", 58)
                    p:setCloth("bproof_2", 9)
                end
            elseif item == "samskev" then --sams
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 93)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 92)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "wzkev" then --sams
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 93)
                    p:setCloth("bproof_2", 4)
                else
                    p:setCloth("bproof_1", 92)
                    p:setCloth("bproof_2", 4)
                end
            elseif item == "keville1" then --illegal
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 134)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 122)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "keville2" then --illegal
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 125)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 126)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "keville3" then --illegal
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 125)
                    p:setCloth("bproof_2", 1)
                else
                    p:setCloth("bproof_1", 126)
                    p:setCloth("bproof_2", 1)
                end
            elseif item == "keville4" then --illegal
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 125)
                    p:setCloth("bproof_2", 2)
                else
                    p:setCloth("bproof_1", 126)
                    p:setCloth("bproof_2", 2)
                end
            elseif item == "keville5" then --illegal
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 130)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 127)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "keville6" then --illegal
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 130)
                    p:setCloth("bproof_2", 1)
                else
                    p:setCloth("bproof_1", 127)
                    p:setCloth("bproof_2", 1)
                end
            elseif item == "keville7" then --illegal
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 130)
                    p:setCloth("bproof_2", 2)
                else
                    p:setCloth("bproof_1", 127)
                    p:setCloth("bproof_2", 2)
                end
            elseif item == "keville8" then --illegal
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 130)
                    p:setCloth("bproof_2", 3)
                else
                    p:setCloth("bproof_1", 127)
                    p:setCloth("bproof_2", 3)
                end
            elseif item == "keville9" then --illegal
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 131)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 128)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "keville10" then --illegal
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 131)
                    p:setCloth("bproof_2", 1)
                else
                    p:setCloth("bproof_1", 128)
                    p:setCloth("bproof_2", 1)
                end
            elseif item == "keville11" then --illegal
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 131)
                    p:setCloth("bproof_2", 2)
                else
                    p:setCloth("bproof_1", 128)
                    p:setCloth("bproof_2", 2)
                end
            elseif item == "keville12" then --illegal
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 131)
                    p:setCloth("bproof_2", 3)
                else
                    p:setCloth("bproof_1", 128)
                    p:setCloth("bproof_2", 3)
                end
            elseif item == "giletc4" then --illegal
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 145)
                    p:setCloth("bproof_2", 0)
                else
                    p:setCloth("bproof_1", 129)
                    p:setCloth("bproof_2", 0)
                end
            elseif item == "lstcard" then --lst
                if p:skin().sex == 0 then
                    p:setCloth("bproof_1", 109)
                    p:setCloth("bproof_2", 0)
                else
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        content = "Cette carte n'est pas à votre taille."
                    })
                end
            end
            p:setShield(shield)
            while GetPedArmour(p:ped()) > 0 do Wait(1000) end
            if inUse and p:skin().bproof_1 ~= 0 then
                inUse = false
                p:setShield(0)
                p:setCloth("bproof_1", 0)
                p:setCloth("bproof_2", 0)
                for key, value in pairs(p:getInventaire()) do
                    if item == value.name then
                        TriggerServerEvent('core:RemoveItemToInventory', token, item, 1, value.metadatas)
                        -- p:setCloth("bproof_1", 1)
                        return
                    end
                end
            end
        end
    end
end)