local itemsUsage = {
    ["banana"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 15) --TODO: add truc du turfu
        end,
    },
    ["water"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 15)
        end,
    },
    ["laitchoco"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 15)
        end,
    },
    ["eaupetillante"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 15)
        end,
    },
    ["cameraw"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('camera:open', source)
        end,
    },
    ["ecola"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 15, "ng_proc_sodacan_01a")
        end,
    },
    ["sprunk"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 15, "ng_proc_sodacan_01b")
        end,
    },
    ["bread"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 15, "prop_food_bs_burger2")
        end,
    },
    ["GlaceItalienne"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 15, "bzzz_icecream_cherry")
        end,
    },
    ["tapas"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 20, "prop_food_bs_burger2")
        end,
    },
    ["Chips"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 20, "prop_food_bs_burger2")
        end,
    },
    ["BarreCereale"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 20, "prop_food_bs_burger2")
        end,
    },
    ["triangle"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 20, "prop_food_bs_burger2")
        end,
    },
    ["cake"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 20, "prop_food_bs_burger2")
        end,
    },
    ["Mr"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 10)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 10)
        end,
    },
    ["popcorn"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 15, "prop_taymckenzienz_popcorn")
        end,
    },
    ["gum"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 20)
        end,
    },
    ["lollipop"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 20, "natty_lollipop_spin01")
        end,
    },
    ["cofeecup"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 20, "p_amb_coffeecup_01")
        end,
    },
    ["chocolatbar"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 20, "prop_food_coffee")
        end,
    },
    ["litchi"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 15, "")
        end,
    },
    ["soja"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 5)
        end,
    },
    ["cucumber"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 5)
        end,
    },
    ["avocado"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 5)
        end,
    },
    ["oignon"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 5)
        end,
    },
    ["tomato"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 5)
        end,
    },
    ["salad"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 5)
        end,
    },
    ["lemon"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 5)
        end,
    },
    ["mint"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 5)
        end,
    },
    ["sesam"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 5)
        end,
    },
    ["algue"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 5)
        end,
    },
    ["chou"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 5)
        end,
    },
    ["milk"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 15, "prop_cs_milk_01")
        end,
    },
    ["juice"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_plastic_cup_02")
        end,
    },
    ["juicep"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_plastic_cup_02")
        end,
    },
    ["soda"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cs_bs_cup")
        end,
    },
    ["coffee"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 10, "p_amb_coffeecup_01")
        end,
    },
    ["tea"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 10, "v_res_mcofcup")
        end,
    },
    ["caprisun"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 10, "prop_plastic_cup_02")
        end,
    },
    ["whisky"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 25, "prop_drink_whisky")
            TriggerClientEvent("core:drink", source, 25)
        end,
    },
    ["jet27"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 25, "prop_drink_whisky")
            TriggerClientEvent("core:drink", source, 15)
        end,
    },
    ["Hydromel"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 70, "prop_drink_whisky")
            TriggerClientEvent("core:drink", source, 15)
        end,
    },
    ["vodka"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 25, "prop_shots_glass_cs")
            TriggerClientEvent("core:drink", source, 25)
        end,
    },
    ["gin"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 25, "prop_tequila")
            TriggerClientEvent("core:drink", source, 25)
        end,
    },
    ["tequila"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 25, "prop_tequila")
            TriggerClientEvent("core:drink", source, 25)
        end,
    },
    ["tunertablet"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('handlingtuning:client:openTablet', source, false)
        end,
    },
    ["beer"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 5, "prop_cs_beer_bot_01")
            TriggerClientEvent("core:drink", source, 5)
        end,
    },
    ["rhum"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 25, "prop_drink_whisky")
            TriggerClientEvent("core:drink", source, 25)
        end,
    },
    ["camerab"] = {
        removeOnUse = false,
        action = function(source)
            --if ToogleCamWeazel then
                TriggerClientEvent("vision:togglecamera", source)
           --     ToogleCamWeazel()
            --else
             --   ShowNotification("Vous devez être en service")
            --end
        end,
    },
    ["crochet"] = {
        removeOnUse = false,
        closestVeh = false,
        action = function(source)
            CreateThread(function()
                TriggerClientEvent("core:hookVehicle", source)
            end)
            TriggerClientEvent("core:UseCrocket", source)

        end,
    },
    ["cleankit"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent("core:UseToolNettoyage", source)
        end,
    },
    ["repairkit"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent("core:UseToolKit", source)
        end,
    },
    ["badgel"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:badge", source, "lspd")
        end,
    },
    ["badgep"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:badge", source, "weazel")
        end,
    },
    ["wine"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 25, "p_wine_glass_s")
            TriggerClientEvent("core:drink", source, 15)
        end,
    },
    ["cocktail"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 25, "prop_cocktail")
            TriggerClientEvent("core:drink", source, 15)
        end,
    },
    ["sake"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 25, "prop_drink_whisky")
            TriggerClientEvent("core:drink", source, 25)
        end,
    },
    ["fishburger"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_cs_burger_01")
        end,
    },
    ["panini"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_cs_burger_01")
        end,
    },
    ["catpat"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
    ["burger"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_cs_burger_01")
        end,
    },
    ["wrapp"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_food_bs_burger2")
        end,
    },
    ["wrapb"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_chicken_wrap_prop")
        end,
    },
    ["wings"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_chicken_wrap_prop")
        end,
    },
    ["nuggets"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_food_bs_burger2")
        end,
    },
    ["bucket"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "gn_cluckin_buckets")
        end,
    },
    ["pilon"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "gn_cluckin_buckets")
        end,
    },
    ["saladece"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
    ["saladeco"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
    ["donutn"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 50, "prop_donut_01")
        end,
    },
    ["donutc"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 50, "prop_donut_02")
        end,
    },
    ["sundae"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 15, "nels_ice_cream_meteorite_prop")
        end,
    },
    ["cookie"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 15, "prop_donut_01")
        end,
    },
    ["tiramisu"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 15, "prop_donut_01")
        end,
    },
    ["beignet"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 15, "prop_donut_01")
        end,
    },
    ["mochi"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 15, "prop_donut_01")
        end,
    },
    ["chatmallow"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 15, "prop_donut_01")
        end,
    },
    ["barbamilk"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 25, "prop_plastic_cup_02")
        end,
    },
    ["bubbletea"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 25, "prop_plastic_cup_02")
        end,
    },
    ["nougat"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 15, "prop_candy_pqs")
        end,
    },
    ["sushic"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 30, "salade")
        end,
    },
    ["maki"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 30, "salade")
        end,
    },
    ["ramenp"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
    ["ramenb"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
    ["nemp"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 30, "salade")
        end,
    },
    ["nemb"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 30, "salade")
        end,
    },
    ["water2"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 15, "prop_shots_glass_cs")
        end,
    },
    ["mojito"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 30, "prop_mojito")
            TriggerClientEvent("core:drink", source, 15)
        end,
    },
    ["punch"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 30, "prop_mojito")
            TriggerClientEvent("core:drink", source, 15)
        end,
    },
    ["pinacolada"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 30, "prop_pinacolada")
            TriggerClientEvent("core:drink", source, 15)
        end,
    },
    ["margarita"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 30, "prop_cocktail")
            TriggerClientEvent("core:drink", source, 15)
        end,
    },
    ["sexotb"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 30, "prop_daiquiri")
            TriggerClientEvent("core:drink", source, 15)
        end,
    },
    ["irishc"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 30, "prop_drink_whisky")
            TriggerClientEvent("core:drink", source, 15)
        end,
    },
    ["champ"] = {
       removeOnUse = true,
         action = function(source)
              TriggerClientEvent('core:hunger&thirst', source, "boisson", 30, "prop_champ_flute")
              TriggerClientEvent("core:drink", source, 10)
         end,
    },
    ["jumelle"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:useBinocular", source)
        end,
    },
    ["jumelles"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:useBinocular", source)
        end,
    },
    ["identitycard"] = {
        removeOnUse = false,
        action = function(source)
            --TODO: faire l'anim
        end,
    },
    ["bequille"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseBequille", source)
        end,
    },
    ["froulant"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent("core:SpawnWheelChair", source)
        end,
    },
    ["tablet"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:tabletteIllegalV1", source)
        end,
    },
    ["mask"] = {
        removeOnUse = false,
        action = function(source)
        end,
    },
    ["spray"] =  {
        removeOnUse = true,
        action = function (source)
            exports["rcore_spray"]:UseSpray(source)
        end
    },
    ["band"] =  {
        removeOnUse = true,
        action = function (source)
            TriggerClientEvent("core:UseItemsMedic1", source, 40)
        end
    },
    ["poudre"] = {
        removeOnUse = true,
        action = function (source)
            TriggerClientEvent("core:useTestPoudre", source)
        end
    },
    ["pad"] =  {
        removeOnUse = true,
        action = function (source)
            TriggerClientEvent("core:UseItemsMedic2", source, 20)
        end
    },
    ["medikit"] =  {
        removeOnUse = true,
        action = function (source)
            TriggerClientEvent("core:UseItemsMedic3", source, 100)
        end
    },
    ["medic"] =  {
        removeOnUse = true,
        action = function (source)
            TriggerClientEvent("core:UseItemsMedic4", source, 10)
        end
    },
    ["pad2"] =  {
        removeOnUse = true,
        action = function (source)
            TriggerClientEvent("core:UseItemsMedic5", source, 15)
        end
    },
    ["pad3"] =  {
        removeOnUse = true,
        action = function (source)
            TriggerClientEvent("core:UseItemsMedic5", source, 15)
        end
    },
    ["skate"] =  {
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent("core:UseSkate", source)
        end
    },
    ["weed"] =  {
        removeOnUse = true,
        action = function (source)
            -- make the player smoke weed
            TriggerClientEvent("core:UseWeed", source)
        end
    },
    ["heroine"] =  {
        removeOnUse = true,
        action = function (source)
            -- make the player smoke weed
            TriggerClientEvent("core:UseHeroine", source)
        end
    },
    ["tacos"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_tacos_prop")
        end,
    },
    ["fajitas"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_tacos_prop")
        end,
    },
    ["tortillas"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_tacos_prop")
        end,
    },
    ["quesadillas"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_tacos_prop")
        end,
    },
    ["burrito"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_tacos_prop")
        end,
    },

    ["cleaner"] =  {
        removeOnUse = true,
        action = function (source)
            TriggerClientEvent('rcore_spray:removeClosestSpray', source)
        end
    },
    ["umbrella"] =  {
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent('core:UseUmbrella', source)
        end
    },
    ["tasertrophy1"] =  {
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent('core:UseTaserTrophy', source)
        end
    },
    ["cig"] =  {
        removeOnUse = true,
        action = function (source)
            TriggerClientEvent('core:UseCig', source)
        end
    },
    ["cigar"] =  {
        removeOnUse = true,
        action = function (source)
            TriggerClientEvent('core:UseCigar', source)
        end
    },
    ["coke"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:UseCoke', source)
        end,
    },
    ["meth"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:UseMeth', source)
        end,
    },
    ["bike"] =  {
        removeOnUse = true,
        action = function (source, metadas)
            TriggerClientEvent('core:bike', source, metadas)
        end
    },
    ["surfboard"] =  {
        removeOnUse = true,
        action = function (source)
            TriggerClientEvent('core:UseSurfBoard', source)
        end
    },
    ["laptop"] ={
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent("core:UseLaptop", source)
        end
    },
    ["pince"] ={
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent("core:UsePinceBitche", source)
        end
    },
     ["pincecoupante"] ={
         removeOnUse = true,
         action = function (source)
             TriggerClientEvent("core:removeToPlySerflex", source)
         end
    },
    ["plate"] ={
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent("core:UsePlate", source)
        end
    },
    ["ammo30"] ={
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent("core:TransformMunition", source, 1)
        end
    },

    ["can"] ={
        removeOnUse = true,
        action = function (source)
            TriggerClientEvent("core:TransformCan", source, 1)
        end
    },

    ["ammobox_pistol"] ={
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent("core:UseMunition", source, "ammobox_pistol", 1)
        end
    },

    ["ammobox_flare"] ={
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent("core:UseMunition", source, "ammobox_flare", 1)
        end
    },

    ["ammobox_sub"] ={
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent("core:UseMunition", source, "ammobox_sub", 1)
        end
    },


    ["ammobox_shotgun"] ={
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent("core:UseMunition", source, "ammobox_shotgun", 1)
        end
    },

    ["ammobox_rifle"] ={
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent("core:UseMunition", source, "ammobox_rifle", 1)
        end
    },

    ["ammobox_snip"] ={
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent("core:UseMunition", source, "ammobox_snip", 1)
        end
    },

    ["ammobox_heavy"] ={
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent("core:UseMunition", source, "ammobox_heavy", 1)
        end
    },

    ["ammobox_rocket"] ={
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent("core:UseMunition", source, "ammobox_rocket", 1)
        end
    },

    ["ammobox_beambag"] ={
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent("core:UseMunition", source, "ammobox_beambag", 1)
        end
    },

    ["ammobox_global"] ={
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent("core:UseMunition", source, "ammobox_global", 1)
        end
    },

    ["sangle"] ={
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent("core:UseSangleBiatch", source)
        end
    },
    ["herse"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent("core:UseHerse", source)
        end,
    },
    ["boombox"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent("core:UseBoombox", source)
        end,
    },
    ["cups"] ={
        removeOnUse = true,
        action = function (source)
            TriggerClientEvent("core:UseCupsBiatch", source)
        end
    },
    ["shield"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("shield:TogglePoliceShield", source)
        end,
    },
    ["lssdshield"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("shield:ToggleLSSDShield", source)
        end,
    },
    -- Noel
    ["barbeapapa"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 20)
        end,
    },
    ["cafe"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 20, "p_ing_coffeecup_01")
        end,
    },
    ["cafeaulait"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 20, "p_ing_coffeecup_01")
        end,
    },
    ["choco"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 20, "prop_candy_pqs")
        end,
    },
    ["chocolatchaud"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 30, "p_ing_coffeecup_01")
        end,
    },
    ["churros"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 30)
        end,
    },
    ["crepe"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 30)
        end,
    },
    ["donut"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 50, "prop_donut_01")
        end,
    },
    ["gauffre"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40)
        end,
    },
    ["pommeamour"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 30, "apple_1")
        end,
    },
    ["sucreorge"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 20, "bzzz_food_xmas_lollipop_a")
        end,
    },
    ["sapin"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('core:SpawnSapinNoel', source)
        end,
    },
    ["gps"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('core:useGps', source)
        end,
    },
    ["ticket"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent("core:useTicketGratter", source)
        end,
    },
    -- ["firework"] = {
    --     removeOnUse = true,
    --     action = function(source)
    --         TriggerClientEvent("firework:itemTrigger", source)
    --     end,
    -- },
    ["sactete"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:putBagHead", source)
        end,
    },

    ["serflex"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent("core:putSerflex", source)
        end,
    },

    --lspd
    ["lspdgiletj"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lspdgiletj", 10)
        end,
    },
    ["lspdkevle1"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lspdkevle1", 33)
        end,
    },
    ["lspdkevle2"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lspdkevle2", 33)
        end,
    },
    ["lspdkevle3"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lspdkevle3", 33)
        end,
    },
    ["lspdriot"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lspdriot", 100)
        end,
    },
    ["lspdkevm1"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lspdkevm1", 66)
        end,
    },
    ["lspdkevlo1"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lspdkevlo1", 100)
        end,
    },
    ["lspdkevlo2"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lspdkevlo2", 100)
        end,
    },
    ["lspdkevlo3"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lspdkevlo3", 100)
        end,
    },
    ["lspdswat"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lspdswat", 100)
        end,
    },
    ["lspdkevpc"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lspdkevpc", 50)
        end,
    },
    ["lspdgnd"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lspdgnd", 50)
        end,
    },
    ["lspdgnd2"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lspdgnd2", 50)
        end,
    },

    --lst
    ["lstcard"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lstcard", 10)
        end,
    },

    --usss
    ["insigneKevUsss"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "insigneKevUsss", 10)
        end,
    },
    ["ussskev1"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "ussskev1", 100)
        end,
    },
    ["ussskev2"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "ussskev2", 100)
        end,
    },
    ["ussskev3"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "ussskev3", 100)
        end,
    },
    ["ussskev4"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "ussskev4", 50)
        end,
    },

    --lssd
    ["lssdgiletj"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lssdgiletj", 10)
        end,
    },
    ["lssdkevle1"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lssdkevle1", 33)
        end,
    },
    ["lssdkevle2"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lssdkevle2", 20)
        end,
    },
    ["lssdkevlo1"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lssdkevlo1", 100)
        end,
    },
    ["lssdkevlo2"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lssdkevlo2", 100)
        end,
    },
    ["lssdkevlo3"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lssdkevlo3", 100)
        end,
    },
    ["lssdkevlo4"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lssdkevlo4", 100)
        end,
    },
    ["lssdkevlo5"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lssdkevlo5", 100)
        end,
    },
    ["lssdkevlo6"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lssdkevlo6", 100)
        end,
    },
    ["lssdkevlo7"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lssdkevlo7", 100)
        end,
    },
    ["lssdinsigne"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lssdinsigne", 10)
        end,
    },
    ["lssdriot"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "lssdriot", 100)
        end,
    },

    --USBP
    ["usbpkevlo1"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "usbpkevlo1", 100)
        end,
    },
    ["usbpkevlo2"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "usbpkevlo2", 100)
        end,
    },
    ["usbpkevlo3"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "usbpkevlo3", 100)
        end,
    },
    ["usbpkevlo4"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "usbpkevlo4", 100)
        end,
    },
    ["usbpkevlo5"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "usbpkevlo5", 100)
        end,
    },
    ["usbpkevpc"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "usbpkevpc", 50)
        end,
    },
    ["usbpgiletb"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "usbpgiletb", 10)
        end,
    },
    ["usbpgiletj"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "usbpgiletj", 10)
        end,
    },
    ["usbpinsigne"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "usbpinsigne", 10)
        end,
    },

    --doj
    ["dojkev"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "dojkev", 100)
        end,
    },

    --boi
    ["boikev"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "boikev", 100)
        end,
    },

    --sams
    ["samskev"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "samskev", 200)
        end,
    },

    --WZ
    ["wzkev"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "wzkev", 200)
        end,
    },

    --gpb illégal
    ["keville1"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "keville1", 50)
        end,
    },
    ["keville2"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "keville2", 50)
        end,
    },
    ["keville3"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "keville3", 50)
        end,
    },
    ["keville4"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "keville4", 50)
        end,
    },
    ["keville5"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "keville5", 100)
        end,
    },
    ["keville6"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "keville6", 100)
        end,
    },
    ["keville7"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "keville7", 100)
        end,
    },
    ["keville8"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "keville8", 100)
        end,
    },
    ["keville9"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "keville9", 75)
        end,
    },
    ["keville10"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "keville10", 75)
        end,
    },
    ["keville11"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "keville11", 75)
        end,
    },
    ["keville12"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "keville12", 75)
        end,
    },
    ["giletc4"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent("core:UseKevlar", source, "giletc4", 25)
        end,
    },

    ["recycleur"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('core:useRecycleur', source)
        end,
    },
    ["megaphone"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('core:UseMegaphone', source)
        end,        
    },
    ["papier"] = {
        removeOnUse = false,
        action = function(source, meta)
            TriggerEvent('nuiPapier:server:openPapier', source, meta.id)
        end,
    },
    ["blocnote"] = {
        removeOnUse = false,
        action = function(source, meta)
            TriggerClientEvent("nuiPapier:client:openBlocnote", source, meta.title, meta.content)
        end,
    },
    ["BarbaMilk"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_plastic_cup_02")
        end,
    },
    ["BubbleTea"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_plastic_cup_02")
        end,
    },
    ["CatPat"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_food_bs_burger2")
        end,
    },
    ["ChatGourmand"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75,"prop_food_bs_burger2")
        end,
    },
    ["Chatmallow"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_food_bs_burger2")
        end,
    },
    ["IceCoffee"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "p_amb_coffeecup_01")
        end,
    },
    ["IceCreamCat"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_ice_cream_meteorite_prop")
        end,
    },
    ["Lailaitchaud"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cs_milk_01")
        end,
    },
    ["Milkshake"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "brum_cherryshake_bubblegum")
        end,
    },
    ["Mochi"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_food_bs_burger2")
        end,
    },
    ["Pocky"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_food_bs_burger2")
        end,
    },
    ["UwUBurger"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_cs_burger_01")
        end,
    },
    ["Ramens"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_cs_burger_01")
        end,
    },
    ["Sushis"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_cs_burger_01")
        end,
    },
    ["melto"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_cs_burger_01")
        end,
    },
    ["lapinut"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_cs_burger_01")
        end,
    },
    ["LatteMatcha"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_plastic_cup_02")
        end,
    },
    ["Aperitifs"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 50, "prop_candy_pqs")
        end,
    },
    ["CoolGranny"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_plastic_cup_02")
        end,
    },
    ["Doudou"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_plastic_cup_02")
        end,
    },
    ["FrenchKiss"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_plastic_cup_02")
        end,
    },
    ["RedVelvet"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cocktail")
        end,
    },
    ["Sexonthebeach"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cocktail")
        end,
    },
    ["Limonade"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_plastic_cup_02")
        end,
    },

    ["Theglace"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_plastic_cup_02")
        end,
    },

    ["Unitail"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 50, "prop_cocktail")
        end,
    },
    ["Jusdefruits"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_plastic_cup_02")
        end,
    },
    ["Soda"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cs_bs_cup")
        end,
    },
    ["Cafefrappe"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "brum_heartfrappe")
        end,
    },
    ["Cafepraline"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "p_amb_coffeecup_01")
        end,
    },
    ["Cappuccino"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "p_amb_coffeecup_01")
        end,
    },
    ["Caramelmacchiato"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "p_amb_coffeecup_01")
        end,
    },
    ["Chocoguimauve"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "p_amb_coffeecup_01")
        end,
    },
    ["Chocolatviennois"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "p_amb_coffeecup_01")
        end,
    },
    ["Cookie"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_donut_01")
        end,
    },
    ["Expresso"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "p_amb_coffeecup_01")
        end,
    },
    ["Latte"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "p_amb_coffeecup_01")
        end,
    },
    ["Muffinchoco"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_donut_01")
        end,
    },
    ["Fondantchocolat"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_donut_01")
        end,
    },
    ["Waffle"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_donut_01")
        end,
    },
    ["dynamite"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('core:attackLabo', source)
        end
    },
    ["Moulesfrites"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
    ["Plateaudecharcuterie"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
    ["escalope"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
    ["seafood-in-wood-"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
    ["Americanribs"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },

    ["Cheesecake"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_donut_01")
        end,
    },

    ["CinnamonRolls"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_donut_01")
        end,
    },


    ["Entrecote"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_cs_steak")
        end,
    },

    ["caviar"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40, "prop_cs_steak")
        end,
    },

    ["magret"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_cs_steak")
        end,
    },

    ["foiegras"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_cs_steak")
        end,
    },


    ["OeufsBacon"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
    ["Mac&cheese"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },

    ["Applepie"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 50, "salade")
        end,
    },
    

    ["DuffBeer"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cs_beer_bot_01")
            TriggerClientEvent("core:drink", source, 15)
        end,
    },
    ["BayviewBeer"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cs_beer_bot_01")
            TriggerClientEvent("core:drink", source, 15)
        end,
    },


    ["champagne"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_champ_flute")
        end,
    },
    ["Vinblanc"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "p_wine_glass_s")
        end,
    },
    ["Vinrouge"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "p_wine_glass_s")
        end,
    },

    -- CLUCKIN BELL
    ["gncluckinbucket"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "gn_cluckin_buckets")
        end,
    },
    ["gncluckinburg"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "gn_cluckin_burg")
        end,
    },
    ["gncluckinfowl"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "gn_cluckin_fowl")
        end,
    },
    ["gncluckinfries"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40, "gn_cluckin_fries")
        end,
    },
    ["gncluckinkids"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 60, "gn_cluckin_kids")
        end,
    },
    ["gncluckinrings"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40, "gn_cluckin_rings")
        end,
    },
    ["gncluckinsalad"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40, "gn_cluckin_salad")
        end,
    },
    ["gncluckinsoup"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 50, "gn_cluckin_soup")
        end,
    },
    ["gncluckincup"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "gn_cluckin_cup")
        end,
    },


    ["BloodyMary"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75,"prop_cocktail")
        end,
    },
    ["Blue-Mamas"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cocktail")
        end,
    },
    ["Gin"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cocktail")
        end,
    },
    ["Mojito"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cocktail")
        end,
    },
    ["Punch"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cocktail")
        end,
    },
    ["WhiteLady"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cocktail")
        end,
    },
    ["Tapas"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_tacos_prop")
        end,
    },
    ["Bretzel"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "natty_lollipop_spin01")
        end,
    },
    ["Poutine"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
    ["Saucisson"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
    ["vinchaud"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "bzzz_food_xmas_mulled_wine_a")
        end,
    },
    ["Blonde"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cs_beer_bot_01")
        end,
    },
    ["Camarade"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cocktail")
        end,
    },
    ["Jaggerbomb"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cocktail")
        end,
    },
    ["Vodka"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cocktail")
            TriggerClientEvent("core:drink", source, 25)
        end,
    },
    ["Whisky"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_drink_whisky")
        end,
    },
    ["911"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cocktail")
        end,
    },
    ["Cesar"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
    ["Hotdog"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_food_bs_burger2")
        end,
    },
    ["Mozzasticks"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_food_bs_burger2")
        end,
    },
    ["Pancakes"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_food_bs_burger2")
        end,
    },
    ["pizza-7945"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "knjgh_pizzaslice1")
        end,
    },
    ["PulledPork"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_food_bs_burger2")
        end,
    },
    ["Sandwich"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_food_bs_burger2")
        end,
    },
    ["Brune"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cs_beer_bot_01")
        end,
    },
    ["Rousse"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cs_beer_bot_01")
        end,
    },
    ["Ambree"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cs_beer_bot_01")
        end,
    },
    ["Pissedane"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cs_beer_bot_01")
            TriggerClientEvent("core:drink", source, 15)
        end,
    },
    ["Shamrock"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cs_beer_bot_01")
        end,
    },

    ["WilliamPeel"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_cs_beer_bot_01")
        end,
    },

    ["RhumCoke"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "prop_shots_glass_cs")
        end,
    },

    -- Burger Shot

    ["thesimplyburger"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 60, "nels_burger_simply_prop")
        end,
    },
    ["chickenwrap"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 50, "nels_chicken_wrap_prop")
        end,
    },
    ["goatcheesewrap"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 50, "nels_goat_wrap_prop")
        end,
    },
    ["friesbox"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40, "nels_fries_box_prop")
        end,
    },
    ["thefabulous6lbburger"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 100, "nels_burger_fabulous_6lb_prop")
        end,
    },
    ["thegloriousburger"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 100, "nels_burger_glorious_prop")
        end,
    },
    ["doubleshotburger"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_burger_double_shot_prop")
        end,
    },
    ["bssoda"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 75, "nels_soda_prop")
        end,
    },
    ["meteoriteicecream"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40, "nels_ice_cream_meteorite_prop")
        end,
    },
    ["orangotangicecream"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40, "nels_ice_cream_orang_otan_prop")
        end,
    },
    ["3ballsicecream"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40, "nels_ice_cream_orang_otan_prop")
        end,
    },
    ["pistacheicecream"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40, "nels_ice_cream_orang_otan_prop")
        end,
    },
    ["chocolateicecream"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40, "nels_ice_cream_orang_otan_prop")
        end,
    },
    ["vanilaicecream"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40, "nels_ice_cream_orang_otan_prop")
        end,
    },
    ["misterfreeze"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40, "nels_ice_cream_orang_otan_prop")
        end,
    },
    ["granita"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40, "nels_ice_cream_orang_otan_prop")
        end,
    },
    ["strawberryicecream"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40, "nels_ice_cream_orang_otan_prop")
        end,
    },
    ["magnumicecream"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40, "nels_ice_cream_orang_otan_prop")
        end,
    },
    ["ben&jerrys"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 40, "nels_ice_cream_orang_otan_prop")
        end,
    },
    ["pricklyburger"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_burger_prickly_prop")
        end,
    },
    ["bleederburger"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_burger_bleeder_prop")
        end,
    },

      -- Pizzeria
      ["pizzaburata"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_burger_bleeder_prop")
        end,
    },
    ["pizzamarghe"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_burger_bleeder_prop")
        end,
    },
    ["pizza4fromage"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_burger_bleeder_prop")
        end,
    },
    ["pizzachevre"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_burger_bleeder_prop")
        end,
    },
    ["crostini"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 35, "nels_burger_bleeder_prop")
        end,
    },
    ["saladeburata"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
    ["saladedefruit"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
    ["pizzanutella"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_burger_bleeder_prop")
        end,
    },

     -- hornys
     ["Batonspoulet_Hornys"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "gn_cluckin_fries")
        end,
    },
    ["Burgerpoulet_Hornys"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_burger_bleeder_prop")
        end,
    },
    ["Donut_Hornys"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "prop_donut_01")
        end,
    },
    ["Frites_Hornys"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 45, "gn_cluckin_fries")
        end,
    },
    ["Milkshake_Hornys"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 45, "p_ing_coffeecup_01")
        end,
    },
    ["Pignonpoulet_Hornys"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 45, "gn_cluckin_fries")
        end,
    },
    ["Wrappoulet_Hornys"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 25, "nels_chicken_wrap_prop")
        end,
    },
    ["Coffee_Hornys"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 25, "p_ing_coffeecup_01")
        end,
    },
    ["Soda_Hornys"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 45, "nels_soda_prop")
        end,
    },

    -- upnatom
    ["Black_burger"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_burger_bleeder_prop")
        end,
    },
    ["Burger_earth"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_burger_bleeder_prop")
        end,
    },
    ["Burger_Uranus"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "nels_burger_bleeder_prop")
        end,
    },
    ["Cup_space"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 45, "prop_donut_01")
        end,
    },
    ["Eggs_muffin"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 45, "prop_donut_01")
        end,
    },
    ["Frites_zigzag"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 45, "gn_cluckin_fries")
        end,
    },
    ["Granita_upnatom"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 25, "p_ing_coffeecup_01")
        end,
    },
    ["Ice_cup"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 25, "p_ing_coffeecup_01")
        end,
    },
    ["Onion_rings"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 45, "gn_cluckin_fries")
        end,
    },

    -- pearl
["Cocktail"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "boisson", 25, "prop_cocktail")
            TriggerClientEvent("core:drink", source, 15)
        end,
    },
["Crevettes"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
["FishBowl"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
["Huitres"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
["Moules"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },
["Tarte_au_Citron"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 75, "salade")
        end,
    },

    -- NEW ITEMS

    ["malettecuir"] =  {
        removeOnUse = false,
        action = function (source)
            TriggerClientEvent('core:UseMaletteCuir', source)
        end
    },

    ["twinkies"] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:hunger&thirst', source, "nourriture", 35, "nels_burger_bleeder_prop")
        end,
    },

    -- WEAPON COMPONENTS

    ["components_suppressor"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('core:weapon:use', source, 'suppressor')
        end,
    },

    ["components_flashlight"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('core:weapon:use', source, 'flashlight')
        end,
    },

    ["components_grip"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('core:weapon:use', source, 'grip')
        end,
    },

    ["components_weaponskin"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('core:weapon:use', source, 'yusuf')
        end,
    },
    ["golfb"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('core:golfball', source, 'prop_golf_ball')
        end,
    },
    ["golfj"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('core:golfball', source, 'prop_golf_ball_p2')
        end,
    },
    ["golfv"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('core:golfball', source, 'prop_golf_ball_p3')
        end,
    },
    ["golfr"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('core:golfball', source, 'prop_golf_ball_p4')
        end,
    },
    -- ["letter"] = {
    --     removeOnUse = true,
    --     action = function(source)
    --         TriggerClientEvent('core:letteruse', source)
    --     end,
    -- },
    ["chainsaw"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('core:chainsawuse', source)
        end,
    },
    ["axe"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('core:axeuse', source)
        end,
    },
    ["shears"] = {
        removeOnUse = false,
        action = function(source)
            TriggerClientEvent('core:shearsuse', source)
        end,
    },
    ['scissors'] = {
        removeOnUse = true,
        action = function(source)
            TriggerClientEvent('core:scissors', source)
        end,
    }
}

-- ne pas touchez ça
function IsItemUsable(item)
    if itemsUsage[item] ~= nil then
        return true
    else
        return false
    end
end

function UseItemIfCan(source, item, metadas)
    if itemsUsage[item] ~= nil then
        if itemsUsage[item].removeOnUse then
            if itemsUsage[item].closestVeh then
                local vehicle, dst = TriggerClientCallback(source, "core:getAllClosestVeh")
                if dst < 1.5 then
                    RemoveItemToPlayer(source, item, 1, metadas)
                else
                    -- TriggerClientEvent('core:ShowNotification', source, "~r~Vous n'êtes pas à proximité d'un véhicule")
                    return
                end
            else
                RemoveItemToPlayer(source, item, 1, metadas)
            end
        end
        if item == "bike" then
            itemsUsage[item].action(source, metadas)
        else
            itemsUsage[item].action(source, metadas)
        end
        return true
    else
        return false
    end
end
