pJob = ""
pJobGrade = 0
loadedJob = {}
local JobMenu = function()

end

local JobData = {
    ["cardealerSud"] = {
        load = function()
            LoadcardealerSudJob()
            LoadConcessEntreprise()
            LoadConcessHelico()
            LoadConcessBoat()
        end,
        unload = function()
            UnloadcardealerSudJob()
        end,
    },
    ["bennys"] = {
        load = function()
            LoadMecanoJob()
        end,
        unload = function()
            UnloadMechanicJob()
        end,
    },
    ["hayes"] = {
        load = function()
            LoadMecanoJob()
        end,
        unload = function()
            UnloadMechanicJob()
        end,
    },
    ["beekers"] = {
        load = function()
            LoadMecanoJob()
        end,
        unload = function()
            UnloadMechanicJob()
        end,
    },
    ["sunshine"] = {
        load = function()
            LoadMecanoJob()
        end,
        unload = function()
            UnloadMechanicJob()
        end
    },
    ["lspd"] = {
        load = function()
            LoadLspdJob()
        end,
        unload = function()
            UnloadLspdJob()
        end
    },
    ["bp"] = {
        load = function()
            LoadBpJob()
        end,
        unload = function()
            UnloadBpJob()
        end
    },
    ["lsfd"] = {
        load = function()
            LoadLsfdJob()
        end,
        unload = function()
            UnloadLsfdJob()
        end
    },
    ["autoecole"] = {
        load = function()
            LoadDrivingSchoolJob()
        end,
        unload = function()
            UnLoadDrivingSchoolJob()
        end
    },
    ["taxi"] = {
        load = function()
            LoadTaxiJob()
        end,
        unload = function()
            -- UnLoadDrivingSchoolJob()
            UnLoadTaxiJob()
        end
    },
    ["weazelnews"] = {
        load = function()
            LoadWeazelNewJob()
        end,
        unload = function()
            -- UnLoadDrivingSchoolJob()
            UnLoadWeazelNewsJob()
        end
    },
    ["ems"] = {
        load = function()
            LoadEmsJob()
        end,
        unload = function()
            -- UnLoadDrivingSchoolJob()
            UnLoadEmsJob()
        end
    },
    ["bcms"] = {
        load = function()
            LoadBcmsJob()
        end,
        unload = function()
            UnLoadBcmsJob()
        end
    },

    ["realestateagent"] = {
        load = function()
            LoadRealEstateAgent()
        end,
        unload = function()
            -- UnLoadDrivingSchoolJob()
            UnLoadRealEstateAgent()
        end
    },
    ["burgershot"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["tacosrancho"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["lucky"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["athena"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["mostwanted"] = {
        load = function()
            LoadMostWanted()
        end,
        unload = function()
            UnLoadMostWanted()
        end
    },
    ["sushistar"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["bahamas"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["unicorn"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["ltdsud"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["ltdmirror"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["justice"] = {
        load = function()
            LoadJustice()
        end,
        unload = function()
            -- UnLoadDrivingSchoolJob()
            UnLoadJustice()
        end
    },
    ["avocat"] = {
        load = function()
            LoadAvocat()
        end,
        unload = function()
            -- UnLoadDrivingSchoolJob()
            UnLoadAvocat()
        end
    },
    ["avocat2"] = {
        load = function()
            LoadAvocat2()
        end,
        unload = function()
            -- UnLoadDrivingSchoolJob()
            UnLoadAvocat2()
        end
    },
--[[     ["concessvelo"] = {
        load = function()
            LoadVespucciBike()
        end,
        unload = function()
            -- UnLoadDrivingSchoolJob()
            -- UnLoadJustice()
        end
    }, ]]
    ["pawnshop"] = {
        load = function()
            LoadPawnShopMenu()
        end,
        unload = function()
            UnLoadPawnShop()
        end
    },
    ["gouv"] = {
        load = function()
            LoadGouvJob()
        end,
        unload = function()
            -- UnLoadDrivingSchoolJob()
        end
    },
    ["mayansclub"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["concessentreprise"] = {
        load = function()
            LoadConcessEntreprise()
        end,
        unload = function()
            -- UnLoadDrivingSchoolJob()
        end
    },
    ["usss"] = {
        load = function()
            LoadUSSS()
        end,
        unload = function()
            -- UnLoadDrivingSchoolJob()
        end
    },
    ["casse"] = {
        load = function()
            LoadJobCasse()
        end,
        unload = function()
            UnloadCasseJob()
        end
    },
    ["uwu"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["pizzeria"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["pearl"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["upnatom"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["hornys"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["tequilala"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["tattooSud"] = {
        load = function()
            Loadtattoo()
        end,
        unload = function()
            UnLoadtattoo()
        end
    },
    ["tattooNord"] = {
        load = function()
            Loadtattoo()
        end,
        unload = function()
            UnLoadtattoo()
        end
    },
    ["comrades"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["sultan"] = {
        load = function()
            LoadSultan()
        end,
        unload = function()
            UnLoadSultan()
        end
    },
    ["mirror"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["yellowJack"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["blackwood"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["g6"] = {
        load = function()
            LoadG6()
        end,
        unload = function()
            --UnLoadMirror()
        end
    },
    ["barber"] = {
        load = function()
            LoadBarber()
        end,
        unload = function()
            UnLoadBarber()
        end
    },
    --[[["barberNord"] = {
        load = function()
            LoadBarber()
        end,
        unload = function()
            UnLoadBarber()
        end
    },]]
    ["shenails"] = {
        load = function()
            LoadSheNails()
        end,
        unload = function()
            --UnLoadMirror()
        end
    },
    ["rockford"] = {
        load = function()
            LoadLabel()
        end,
        unload = function()
            UnLoadLabel()
        end
    },
    ["records"] = {
        load = function()
            LoadLabel()
        end,
        unload = function()
            UnLoadLabel()
        end
    },
    ["harmony"] = {
        load = function()
            LoadMecanoJob()
        end,
        unload = function()
            UnloadMechanicJob()
        end,
    },
    ["lssd"] = {
        load = function()
            LoadLssdJob()
        end,
        unload = function()
            UnloadLssdJob()
        end
    },
    ["cardealerNord"] = {
        load = function()
            LoadcardealerNordJob()
        end,
        unload = function()
            UnloadcardealerNordJob()
        end
    },
    ["bayviewLodge"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["bean"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["pops"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["cluckin"] = {
        load = function()
            LoadRestaurant()
        end,
        unload = function()
            UnloadRestaurant()
        end
    },
    ["barber2"] = {
        load = function()
            LoadBarber()
        end,
        unload = function()
            UnLoadBarber()
        end
    },
    ["ammunation"] = {
        load = function()
            LoadAmmunation()
        end,
        unload = function()
            UnLoadAmmunation()
        end
    },
    ["vangelico"] = {
        load = function()
            LoadVangelico()
        end,
        unload = function()
            UnLoadVangelico()
        end
    },
    ["don"] = {
        load = function()
            LoadDon()
        end,
        unload = function()
            UnLoadDon()
        end
    },
    ["domaine"] = {
        load = function()
            LoadDomaine()
        end,
        unload = function()
            UnLoadDomaine()
        end
    },
    ["postop"] = {
        load = function()
            LoadPostOP()
        end,
        unload = function()
            UnLoadPostOP()
        end
    },
    ["boi"] = {
        load = function()
            LoadBOI()
        end,
        unload = function()
            UnloadBOI()
        end
    },
    ["lst"] = {
        load = function()
            LoadLstJob()
        end,
        unload = function()
            UnLoadLstJob()
        end
    },
}

Citizen.CreateThread(
    function()
        while p == nil do Wait(1000) end
        while true do
            Wait(1000)
            if p:getJob() ~= pJob then
                if JobData[pJob] ~= nil then -- Unload de l'ancien job
                    JobData[pJob].unload()
                    JobMenu = function() end
                end
                pJob = p:getJob()
                loadedJob = globalData.jobs[pJob]
                if JobData[pJob] ~= nil then -- Load du nouveau job
                    JobData[pJob].load()
                end
                TriggerEvent("core:changeJob")
                print("[INFO] Le job " .. pJob .. " à été chargé correctement")
            end
            if p:getJobGrade() ~= pJobGrade then
                if JobData[pJob] ~= nil then -- Unload de l'ancien job
                    JobData[pJob].unload()
                    JobMenu = function() end
                end
                pJob = p:getJob()
                loadedJob = globalData.jobs[pJob]
                if JobData[pJob] ~= nil then -- Load du nouveau job
                    JobData[pJob].load()
                end
                pJobGrade = p:getJobGrade()
                TriggerEvent("core:changeJob")
                print("[INFO] Le grade du job " .. pJob .. " grade: " .. pJobGrade .. " à été chargé correctement")
            end
        end
    end
)

RegisterNetEvent("jobs:unloadcurrent")
AddEventHandler("jobs:unloadcurrent", function()
    if JobData[pJob] ~= nil then -- Unload de l'ancien job
        JobData[pJob].unload()
        JobMenu = function() end
    end
end)

function RegisterJobMenu(func)
    JobMenu = func
end

Keys.Register("F1", "F1", "Ouvrir le menu métier", function()
    if not p:getInAction() then
        JobMenu()
    else
        -- ShowNotification("~r~Vous ne pouvez pas faire ça maintenant ...")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Vous ne pouvez pas faire ça maintenant ..."
        })
    end
end)

local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

-- RegisterCommand("annonce", function()
--     local job = p:getJob()
--     if job ~= "aucun" and job ~= "casse" then
--         local service = TriggerServerCallback("core:getOnDuty", token, job)
--         if service ~= nil then
--             for k, v in pairs(service) do
--                 if v == GetPlayerServerId(PlayerId()) then
--                     local annonce = KeyboardImput("Entrez le contenu de l'annonce")
--                     if annonce ~= "" and type(annonce) == "string" then
--                         local maj = string.sub(annonce, 1, 1)
--                         local removedString = string.sub(annonce, 2)
--                         local result = string.upper(maj) .. removedString
--                         TriggerServerEvent("core:makeAnnounceEntreprise", token, result)
--                     else
--                         -- ShowNotification("~r~Veuillez entrer un texte valide")

--                         -- New notif
--                         exports['vNotif']:createNotification({
--                             type = 'ROUGE',
--                             -- duration = 5, -- In seconds, default:  4
--                             content = "~s Veuillez entrer un texte valide"
--                         })

--                     end
--                 end
--             end
--         end
--     elseif job == "casse" then
--         local annonce = KeyboardImput("Entrez le contenu de l'annonce")
--         if annonce ~= "" and type(annonce) == "string" then
--             local maj = string.sub(annonce, 1, 1)
--             local removedString = string.sub(annonce, 2)
--             local result = string.upper(maj) .. removedString
--             TriggerServerEvent("core:makeAnnounceEntreprise", token, result)
--         else
--             -- ShowNotification("~r~Veuillez entrer un texte valide")

--             -- New notif
--             exports['vNotif']:createNotification({
--                 type = 'ROUGE',
--                 -- duration = 5, -- In seconds, default:  4
--                 content = "~s Veuillez entrer un texte valide"
--             })

--         end
--     else
--         -- ShowNotification("~r~Vous n'êtes dans aucune entreprise")

--         -- New notif
--         exports['vNotif']:createNotification({
--             type = 'ROUGE',
--             -- duration = 5, -- In seconds, default:  4
--             content = "~s Vous n'êtes dans aucune entreprise"
--         })

--     end
-- end)
local job = {
    ["lspd"] = {
        name = "LSPD",
        photo = "https://i.imgur.com/SKcGVYZ.png"
    },
    ["bp"] = {
        name = "Border Patrol",
        photo = "https://i.imgur.com/aNxvie8.png"
    },
    ["ems"] = {
        name = "EMS",
        photo = "https://i.imgur.com/e83bP1k.png"
    },
    ["taxi"] = {
        name = "Taxi",
        photo = "https://imgur.com/mlgJ9eG.png"
    },
    ["cardealerSud"] = {
        name = "Concessionnaire Voiture",
        photo = "https://i.imgur.com/7cclBzn.jpg"
    },
    ["realestateagent"] = {
        name = "Dynasty 8",
        photo = "https://media.discordapp.net/attachments/1028821380331999292/1034100603812581396/unknown.png"
    },
    -- ["ltdsud"] = {
    --     name = "LTD Sud",
    --     photo = "https://imgur.com/WJpZS7v.png"
    -- },
    -- ["ltdmirror"] = {
    --     name = "LTD Mirror",
    --     photo = "https://imgur.com/WJpZS7v.png"
    -- },
    ["burgershot"] = {
        name = "BurgerShot",
        photo = "https://imgur.com/x3ObcgO.png"
    },
    ["sushistar"] = {
        name = "SushiStar",
        photo = "https://imgur.com/CDNt7A1.png"
    },
    ["weazelnews"] = {
        name = "Weazel News",
        photo = "https://imgur.com/Ck3qNdz.png"
    },
    ["bennys"] = {
        name = "Benny's",
        photo = "https://imgur.com/CFSdc9J.png"
    },
    ["hayes"] = {
        name = "Hayes Auto",
        photo = ""
    },
    ["beekers"] = {
        name = "Beekers Garage",
        photo = "https://cdn.discordapp.com/attachments/1141654302172119091/1141747724774031370/beekers-garage_534768.png"
    },
    ["sunshine"] = {
        name = "Sunshine Garage",
        photo = "https://imgur.com/ZX26bbG.png"
    },
    ["concessvelo"] = {
        name = "SkateShop",
        photo = "https://imgur.com/tdQm9pp.png"
    },
    ["tacosrancho"] = {
        name = "Tacos 2 Ranchos",
        photo = "https://imgur.com/ZoD2lGs.png"
    },
    ["lucky"] = {
        name = "Lucky Plucker",
        photo = "https://imgur.com/e7ZHlu2.png"
    },
    ["athena"] = {
        name = "Athena Bar",
        photo = "https://imgur.com/L4Im7J2.png" 
    },
    ["pawnshop"] = {
        name = "PawnShop",
        photo = "https://imgur.com/ddPoutk.png"
    },
    ["casse"] = {
        name = "Casse",
        photo = "https://i.imgur.com/KPQABmk.png"
    },
    ["tequilala"] = {
        name = "Tequilala",
        photo = "https://cdn.discordapp.com/attachments/1027853229754687499/1042087955742851152/tequilala-_Imgur.jpg"
    },
    ["uwu"] = {
        name = "UWU Cafe",
        photo = "https://media.discordapp.net/attachments/1044893755204968508/1044948737316880444/t_m_catcafe_logo.png?width=670&height=670"
    },
    ["pizzeria"] = {
        name = "Pizzeria",
        photo = "https://i.imgur.com/DfA1Lrx.png"
    },
    ["pearl"] = {
        name = "Pearl",
        photo = "https://i.imgur.com/IHsjPmg.png"
    },
    ["upnatom"] = {
        name = "Up'n Atom",
        photo = "https://i.imgur.com/8uCVG7z.png"
    },
    ["hornys"] = {
        name = "Horny's",
        photo = "https://i.imgur.com/d4HJmOp.png"
    },
    ["comrades"] = {
        name = "Comrades bar",
        photo = "https://images-ext-1.discordapp.net/external/efMrpIqygRc32urHb4ivWMim3xNmg1pO3XABkkPjGFU/https/i.imgur.com/gP5zHAk.jpg?width=702&height=702"
    },
    ["sultan"] = {
        name = "Sultan's pazar",
        photo = "https://media.discordapp.net/attachments/1063175362193932288/1085612968546418738/SultanPazar1.png?width=671&height=671"
    },
    ["lst"] = {
        name = "Los Santos Transit",
        photo = "https://i.imgur.com/9NMITDy.png"
    },
    ["barber"] = {
        name = "Filipo Ciso",
        photo = "https://media.discordapp.net/attachments/1054171163154202777/1141423243165704422/C77D43C1-CAFC-486B-A837-5C7BA5C0E791-removebg-preview_2.png"
    },
    ["barber2"] = {
        name = "O'Sheas Barber",
        photo = "https://cdn.discordapp.com/attachments/1054171163154202777/1141425982444667011/image.psd_3.png"
    },
    ["tattooSud"] = {
        name = "Tattoo King",
        photo = "https://cdn.discordapp.com/attachments/1144958262278627328/1144958263096524810/King_Tattoo.png"
    }
}

-- RegisterCommand("createAnnonce", function()
--     local phone = TriggerServerCallback("core:GetPhoneNumber")
--     if p:getJob() == "lspd" then phone = "911" end
--     SendNuiMessage(json.encode({
--         type = 'openWebview',
--         name = 'CardNewsSocietyCreate',
--         data = {
--             name_society = job[p:getJob()].name;
--             logo_society = job[p:getJob()].photo;
--             numero_society = phone;
--         }
--     }))
-- end)

RegisterNUICallback("notification_callback", function(data, cb)


    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))
    local phone = TriggerServerCallback("core:GetPhoneNumber")
    if p:getJob() == "lspd" then phone = "911" end
    TriggerServerEvent("AnnonceSociety", token, p:getJob(), data.message_notification, phone)
end)
RegisterNetEvent("AnnonceSociety")
AddEventHandler("AnnonceSociety", function(jobs, message, phone)
    AnnonceSociety(jobs, message, phone)
end)

function AnnonceSociety(jobs, message, phone)
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'CardNewsSocietyShow',
        data = {
            name_society = job[jobs].name;
            logo_society = job[jobs].photo;
            phone_society = phone;
            message = message
        }
    }))
    Wait(100)
    SetNuiFocusKeepInput(false)
    SetNuiFocus(false, false)
end
