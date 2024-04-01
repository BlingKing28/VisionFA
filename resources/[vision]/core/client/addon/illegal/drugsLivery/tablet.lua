local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)
--print('tablet')
ArmesMaxStock = {
    ["pf"] = {
        ["plate"] = 6,
    },
    ["gang"] = {
        --arme blanche
        ["weapon_bat"] = 10,
        ["weapon_bottle"] = 10,
        ["weapon_crowbar"] = 10,
        ["weapon_golfclub"] = 10, 
        ["weapon_hatchet"] = 10,
        ["weapon_knuckle"] = 10,
        ["weapon_machete"] = 10,
        ["weapon_nightstick"] = 10,
        ["weapon_wrench"] = 10,
        ["weapon_knife"] = 10,
        ["weapon_switchblade"] = 10,
        ["weapon_battleaxe"] = 10,
        ["weapon_poolcue"] = 10,
        ["weapon_canette"] = 10,
        ["weapon_bouteille"] = 10,
        ["weapon_pelle"] = 10,
        ["weapon_pickaxe"] = 10,
        ["weapon_sledgehammer"] = 10,
        ["weapon_dagger"] = 10,
        ["serflex"] = 8,
    },
    ["mc"] = {
        ["weapon_pistol"] = 6,
        ["weapon_vintagepistol"] = 4,
        ["weapon_snspistol"] = 4,
        ["weapon_dbshotgun"] = 4,
        ["weapon_molotov"] = 3,
        ["weapon_sawnoffshotgun"] = 2,
        ["pincecoupante"] = 8,
    },
    ["orga"] = {
        ["weapon_katana"] = 2,
        ["weapon_pistol"] = 6,
        ["weapon_combatpistol"] = 6,
        ["weapon_heavypistol"] = 4,
        ["weapon_revolver"] = 4,
        ["weapon_doubleaction"] = 4,

        ["weapon_microsmg"] = 2,
        ["weapon_machinepistol"] = 2,
        ["weapon_minismg"] = 2,

        ["weapon_assaultshotgun"] = 2,
        ["weapon_pumpshotgun"] = 2, 
        ["weapon_heavyshotgun"] = 2,
        
    },
    ["mafia"] = {
        ["weapon_pistol50"] = 4,
        ["weapon_autoshotgun"] = 2,
        ["weapon_combatshotgun"] = 2, 
        ["weapon_compactrifle"] = 2, 
        ["weapon_assaultrifle"] = 2,
        ["weapon_gusenberg"] = 2,
        ["weapon_smg"] = 2,
        ["weapon_carbinerifle"] = 2,
        ["weapon_specialcarbine"] = 2,
        ["weapon_pistol"] = 6,
        ["weapon_combatpistol"] = 6,
    },
}

pfWeapon = {
    {
        id = 1,
        price = 5000,
        name = 'Plaque illegal',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Utils/plate.webp',
        stock = ArmesMaxStock.pf["plate"],
        spawnName = "plate",
        type = "weapons",
        level = 1
    },
}

pf = {
    name = "pf",
    drogues = {
    },
    armes = {
    },
    autre = {
        {
            id = 1,
            price = 1200,
            name = 'Ordinateur',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Utils/ordinateur_portable.webp',
            spawnName = "laptop",
            type = "utils"
        }
    }
}

gangWeapon = {
    {
        id = 1,
        price = 1750,
        name = 'Batte de baseball',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_bat.webp',
        stock = ArmesMaxStock.gang["weapon_bat"],
        spawnName = "weapon_bat",
        type = "weapons",
        level = 3
    },
    { 
        id = 2,
        price = 1750,
        name = 'Pied de Biche',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_crowbar.webp',
        stock = ArmesMaxStock.gang["weapon_crowbar"],
        spawnName = "weapon_crowbar",
        type = "weapons",
        level = 3
    },
    { 
        id = 3,
        price = 1750,
        name = 'Club de Golf',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_golfclub.webp',
        stock = ArmesMaxStock.gang["weapon_golfclub"],
        spawnName = "weapon_golfclub",
        type = "weapons",
        level = 3
    },
    { 
        id = 4,
        price = 1750,
        name = 'Queue de billard',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_poolcue.webp',
        stock = ArmesMaxStock.gang["weapon_poolcue"],
        spawnName = "weapon_poolcue",
        type = "weapons",
        level = 3
    },
    { 
        id = 5,
        price = 1900,
        name = 'Clé anglaise',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_wrench.webp',
        stock = ArmesMaxStock.gang["weapon_wrench"],
        spawnName = "weapon_wrench",
        type = "weapons",
        level = 3
    },
    { 
        id = 6,
        price = 2000,
        name = 'Bouteille en verre',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_bottle.webp',
        stock = ArmesMaxStock.gang["weapon_bottle"],
        spawnName = "weapon_bottle",
        type = "weapons",
        level = 3
    },
    { 
        id = 7,
        price = 3000,
        name = 'Couteau',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_knife.webp',
        stock = ArmesMaxStock.gang["weapon_knife"],
        spawnName = "weapon_knife",
        type = "weapons",
        level = 3
    },
    { 
        id = 8,
        price = 3500,
        name = 'Dague Antique',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_dagger.webp',
        stock = ArmesMaxStock.gang["weapon_dagger"],
        spawnName = "weapon_dagger",
        type = "weapons",
        level = 4
    },
    { 
        id = 9,
        price = 3650,
        name = 'Couteau à cran d arrêt',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_switchblade.webp',
        stock = ArmesMaxStock.gang["weapon_switchblade"],
        spawnName = "weapon_switchblade",
        type = "weapons",
        level = 4
    },
    { 
        id = 10,
        price = 3800,
        name = 'Poing américain',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_knuckle.webp',
        stock = ArmesMaxStock.gang["weapon_knuckle"],
        spawnName = "weapon_knuckle",
        type = "weapons",
        level = 4
    },
    { 
        id = 11,
        price = 4500,
        name = 'Hachette',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_hatchet.webp',
        stock = ArmesMaxStock.gang["weapon_hatchet"],
        spawnName = "weapon_hatchet",
        type = "weapons",
        level = 4
    },
    { 
        id = 12,
        price = 5000,
        name = 'Machette',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_machete.webp',
        stock = ArmesMaxStock.gang["weapon_machete"],
        spawnName = "weapon_machete",
        type = "weapons",
        level = 4
    }, 
    { 
        id = 13,
        price = 5500,
        name = 'Hache de guerre',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_battleaxe.webp',
        stock = ArmesMaxStock.gang["weapon_battleaxe"],
        spawnName = "weapon_battleaxe",
        type = "weapons",
        level = 4
    },
    { 
        id = 14,
        price = 1350,
        name = 'Pelle',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_pelle.webp',
        stock = ArmesMaxStock.gang["weapon_pelle"],
        spawnName = "weapon_pelle",
        type = "weapons",
        level = 4
    },
    { 
        id = 15,
        price = 2750,
        name = 'Pioche',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_pickaxe.webp',
        stock = ArmesMaxStock.gang["weapon_pickaxe"],
        spawnName = "weapon_pickaxe",
        type = "weapons",
        level = 4
    },
    { 
        id = 16,
        price = 2650,
        name = 'Masse',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_sledgehammer.webp',
        stock = ArmesMaxStock.gang["weapon_sledgehammer"],
        spawnName = "weapon_sledgehammer",
        type = "weapons",
        level = 4
    },
}

gang = {
    name = "gang",
    drogues = {
        --{
        --    id = 1,
        --    price = 20,
        --    name = 'Weed',
        --    image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Drogues/weed.webp",
        --    spawnName = "weed",
        --    type = "drugs"
        --}, 
        {
            id = 1,
            price = 30,
            name = 'Engrais',
            image = "assets/inventory/items/engrais.png",
            spawnName = "engrais",
            type = "drugs"
        },
        {
            id = 2,
            price = 30,
            name = 'Fertilisant',
            image = "assets/inventory/items/fertilisant.png",
            spawnName = "fertilisant",
            type = "drugs"
        },
        {
            id = 3,
            price = 5,
            name = 'Graine de cannabis',
            image = "assets/inventory/items/grainecannabis.png",
            spawnName = "grainecannabis",
            type = "drugs"
        },
    },
    armes = {
    },
    autre = {
        {
            id = 1,
            price = 10,
            name = 'Outils de crochetage',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Utils/Outils_crochetage.webp',
            spawnName = "crochet",
            type = "utils"
        },
        {
            id = 2,
            price = 30,
            name = 'Serflex',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Utils/Serflex.webp',
            spawnName = "serflex",
            type = "utils"
        }
    }
}

mcWeapon = {
    -- { 
    --     id = 1,
    --     price = 14000,
    --     name = 'Beretta 92 FS',
    --     image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_pistol.webp',
    --     stock = ArmesMaxStock.mc["weapon_pistol"],
    --     spawnName = "weapon_pistol",
    --     type = "weapons",
    --     level = 3
    -- },
    { 
        id = 2,
        price = 13200,
        name = 'FN Model 1922',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_vintagepistol.webp',
        stock = ArmesMaxStock.mc["weapon_vintagepistol"],
        spawnName = "weapon_vintagepistol",
        type = "weapons",
        level = 3
    },
    {
        id = 3,
        price = 10240,
        name = 'H&K P7M10',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_snspistol.webp',
        stock = ArmesMaxStock.mc["weapon_snspistol"],
        spawnName = "weapon_snspistol",
        type = "weapons",
        level = 3
    },
    { 
        id = 4,
        price = 65000,
        name = 'Double Canon',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_dbshotgun.webp',
        stock = ArmesMaxStock.mc["weapon_dbshotgun"],
        spawnName = "weapon_dbshotgun",
        type = "weapons",
        level = 4
    },
    { 
        id = 10,
        price = 80000,
        name = 'Mossberg 500',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_sawnoffshotgun.webp',
        stock = ArmesMaxStock.mc["weapon_sawnoffshotgun"],
        spawnName = "weapon_sawnoffshotgun",
        type = "weapons",
        level = 4
    },
    { 
        id = 5,
        price = 12000,
        name = 'Cocktail Molotov',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_molotov.webp',
        stock = ArmesMaxStock.mc["weapon_molotov"],
        spawnName = "weapon_molotov",
        type = "weapons",
        level = 3
    },
    -- { 
    --     id = 6,
    --     price = 190,
    --     name = 'Pince coupante',
    --     image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Utils/Pince_coupante.webp',
    --     stock = ArmesMaxStock.mc["pincecoupante"],
    --     spawnName = "pincecoupante",
    --     type = "weapons",
    --     level = 4
    -- },
}

mc = {
    name = "mc",
    drogues = {
        --{
        --    id = 1,
        --    price = 35,
        --    name = 'Heroine',
        --    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Drogues/Heroine.webp',
        --    spawnName = "heroine",
        --    type = "drugs"
        --},
        {
            id = 1,
            price = 5,
            name = 'Pavot somnifère',
            image = "assets/inventory/items/pavosomnifere.png",
            spawnName = "pavosomnifere",
            type = "drugs"
        },
        {
            id = 2,
            price = 28,
            name = 'Chlorure Ammonium',
            image = "assets/inventory/items/chlorureammonium.png",
            spawnName = "chlorureammonium",
            type = "drugs"
        },
        {
            id = 3,
            price = 30,
            name = 'Anhydride Acétique',
            image = "assets/inventory/items/anhydrideacetique.png",
            spawnName = "anhydrideacetique",
            type = "drugs"
        },
    },
    armes = {
    },
    autre = {
        {
            id = 2,
            price = 800,
            name = 'Meuleuse',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Utils/Meuleuse.webp',
            spawnName = "meuleuse",
            type = "utils"
        },
        {
            id = 3,
            price = 800,
            name = 'Perceuse',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Utils/Perceuse.webp',
            spawnName = "drill",
            type = "utils"
        },
        {
            id = 4,
            price = 600,
            name = 'Munition de fusil a pompe',
            image = 'assets/inventory/items/ammobox_shotgun.webp',
            spawnName = "ammobox_shotgun",
            type = "utils"
        },
        {
            id = 5,
            price = 190,
            name = 'Pince coupante',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Utils/Pince_coupante.webp',
            spawnName = "pincecoupante",
            type = "utils"
        },
    }
}

orgaWeapon = {
    --[[     { 
        id = 1,
        price = 14000,
        name = 'Beretta 92 FS',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_pistol.webp',
        stock = ArmesMaxStock.orga["weapon_pistol"],
        spawnName = "weapon_pistol",
        type = "weapons",
        level = 3
    },
    { 
        id = 2,
        price = 18000,
        name = 'Glock 17',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_combatpistol.webp',
        stock = ArmesMaxStock.orga["weapon_combatpistol"],
        spawnName = "weapon_combatpistol",
        type = "weapons",
        level = 3
    }, ]]
    { 
        id = 3,
        price = 26900,
        name = 'Colt M45A1',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_heavypistol.webp',
        stock = ArmesMaxStock.orga["weapon_heavypistol"],
        spawnName = "weapon_heavypistol",
        type = "weapons",
        level = 3
    },
    { 
        id = 4,
        price = 33400,
        name = 'Taurus Raging Bull',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_revolver.webp',
        stock = ArmesMaxStock.orga["weapon_revolver"],
        spawnName = "weapon_revolver",
        type = "weapons",
        level = 3
    },
    { 
        id = 5,
        price = 36650,
        name = 'Colt M1892',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_doubleaction.webp',
        stock = ArmesMaxStock.orga["weapon_doubleaction"],
        spawnName = "weapon_doubleaction",
        type = "weapons",
        level = 3
    },
    { 
        id = 6,
        price = 50000,
        name = 'IMI UZI',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_microsmg.webp',
        stock = ArmesMaxStock.orga["weapon_microsmg"],
        spawnName = "weapon_microsmg",
        type = "weapons",
        level = 3
    },
    { 
        id = 7,
        price = 60000,
        name = 'Intratec TEC-DC9',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_machinepistol.webp',
        stock = ArmesMaxStock.orga["weapon_machinepistol"],
        spawnName = "weapon_machinepistol",
        type = "weapons",
        level = 4
    },
    { 
        id = 8,
        price = 68000,
        name = 'Škorpion Vz. 61',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_minismg.webp',
        stock = ArmesMaxStock.orga["weapon_minismg"],
        spawnName = "weapon_minismg",
        type = "weapons",
        level = 4
    },
    { 
        id = 9,
        price = 205000,
        name = 'UTAS UTS-15',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_assaultshotgun.webp',
        stock = ArmesMaxStock.orga["weapon_assaultshotgun"],
        spawnName = "weapon_assaultshotgun",
        type = "weapons",
        level = 4
    },
    { 
        id = 11,
        price = 92500,
        name = 'Remington 870E',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_pumpshotgun.webp',
        stock = ArmesMaxStock.orga["weapon_pumpshotgun"],
        spawnName = "weapon_pumpshotgun",
        type = "weapons",
        level = 4
    },
    { 
        id = 12,
        price = 160000,
        name = 'Saiga 12K',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_heavyshotgun.webp',
        stock = ArmesMaxStock.orga["weapon_heavyshotgun"],
        spawnName = "weapon_heavyshotgun",
        type = "weapons",
        level = 4
    },
    { 
        id = 13,
        price = 4768,
        name = '6000',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_katana.webp',
        stock = ArmesMaxStock.orga["weapon_katana"],
        spawnName = "weapon_katana",
        type = "weapons",
        level = 3
    },
}

orga = {
    name = "orga",
    drogues = {
        --{
        --    id = 1,
        --    price = 50,
        --    name = 'Cocaine',
        --    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Drogues/cocaine.webp',
        --    spawnName = "coke",
        --    type = "drugs"
        --},
        {
            id = 1,
            price = 5,
            name = 'Feuille de Coca',
            image = "assets/inventory/items/feuilledecoca.png",
            spawnName = "feuilledecoca",
            type = "drugs"
        },
        {
            id = 2,
            price = 40,
            name = 'Acide Sulfurique',
            image = "assets/inventory/items/acidesulfurique.png",
            spawnName = "acidesulfurique",
            type = "drugs"
        },
        {
            id = 3,
            price = 40,
            name = 'Kerosene',
            image = "assets/inventory/items/kerosene.png",
            spawnName = "kerosene",
            type = "drugs"
        },
    },
    armes = {
    },
    autre = {
        {
            id = 2,
            price = 200,
            name = 'Munition d\'Arme de poing',
            image = 'assets/inventory/items/ammobox_pistol.png',
            spawnName = "ammobox_pistol",
            type = "utils"
        },
        {
            id = 3,
            price = 400,
            name = 'Munition de mitraillette & mitrailleuse légère',
            image = 'assets/inventory/items/ammobox_sub.png',
            spawnName = "ammobox_sub",
            type = "utils"
        }
    }
}

mafiaWeapon = {
    { 
        id = 1,
        price = 30160,
        name = 'Desert Eagle .50',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_pistol50.webp',
        stock = ArmesMaxStock.mafia["weapon_pistol50"],
        spawnName = "weapon_pistol50",
        type = "weapons",
        level = 3
    },
    { 
        id = 2,
        price = 222000,
        name = 'Armsel Striker',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_autoshotgun.webp',
        stock = ArmesMaxStock.mafia["weapon_autoshotgun"],
        spawnName = "weapon_autoshotgun",
        type = "weapons",
        level = 4
    },
    { 
        id = 3,
        price = 250000,
        name = 'Franchi SPAS-12',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_combatshotgun.webp',
        stock = ArmesMaxStock.mafia["weapon_combatshotgun"],
        spawnName = "weapon_combatshotgun",
        type = "weapons",
        level = 4
    },
    { 
        id = 4,
        price = 191000,
        name = 'AKS-74u',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_compactrifle.webp',
        stock = ArmesMaxStock.mafia["weapon_compactrifle"],
        spawnName = "weapon_compactrifle",
        type = "weapons",
        level = 3
    },
    { 
        id = 5,
        price = 236500,
        name = 'AK-47',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_assaultrifle.webp',
        stock = ArmesMaxStock.mafia["weapon_assaultrifle"],
        spawnName = "weapon_assaultrifle",
        type = "weapons",
        level = 4
    },
    { 
        id = 6,
        price = 160000,
        name = 'M1928A1 Thompson',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_gusenberg.webp',
        stock = ArmesMaxStock.mafia["weapon_gusenberg"],
        spawnName = "weapon_gusenberg",
        type = "weapons",
        level = 4
    },
    { 
        id = 7,
        price = 155000,
        name = 'H&K MP5A5',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_smg.webp',
        stock = ArmesMaxStock.mafia["weapon_smg"],
        spawnName = "weapon_smg",
        type = "weapons",
        level = 3
    },
    { 
        id = 8,
        price = 244000,
        name = 'M4A1',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_carbinerifle.webp',
        stock = ArmesMaxStock.mafia["weapon_carbinerifle"],
        spawnName = "weapon_carbinerifle",
        type = "weapons",
        level = 4
    },
    { 
        id = 9,
        price = 258000,
        name = 'H&K G36C',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_specialcarbine.webp',
        stock = ArmesMaxStock.mafia["weapon_specialcarbine"],
        spawnName = "weapon_specialcarbine",
        type = "weapons",
        level = 4
    },
    { 
        id = 10,
        price = 19000,
        name = 'Beretta 92 FS',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_pistol.webp',
        stock = ArmesMaxStock.mafia["weapon_pistol"],
        spawnName = "weapon_pistol",
        type = "weapons",
        level = 3
    },
    { 
        id = 11,
        price = 21000,
        name = 'Glock 17',
        image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Armes/weapon_combatpistol.webp',
        stock = ArmesMaxStock.mafia["weapon_combatpistol"],
        spawnName = "weapon_combatpistol",
        type = "weapons",
        level = 3
    },
}

mafia = {
    name = "mafia",
    drogues = {
        --{
        --    id = 1,
        --    price = 70,
        --    name = 'Methamphetamine',
        --    image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Drogues/methamphetamine.webp',
        --    spawnName = "meth",
        --    type = "drugs"
        --},
        {
            id = 1,
            price = 35,
            name = 'Methylamine',
            image = "assets/inventory/items/methylamine.png",
            spawnName = "methylamine",
            type = "drugs"
        },
        {
            id = 2,
            price = 70,
            name = 'Ephédrine',
            image = "assets/inventory/items/ephedrine.png",
            spawnName = "ephedrine",
            type = "drugs"
        },
        {
            id = 3,
            price = 35,
            name = 'Phenylacetone',
            image = "assets/inventory/items/phenylacetone.png",
            spawnName = "phenylacetone",
            type = "drugs"
        },
    },
    armes = {
    },
    autre = {
        --GPB
        {
            id = 4,
            price = 8520,
            name = 'Kevlar Léger 1',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/GPB/keville1.webp',
            spawnName = "keville1",
            type = "utils"
        },
        {
            id = 5,
            price = 8520,
            name = 'Kevlar Léger 2',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/GPB/keville2.webp',
            spawnName = "keville2",
            type = "utils"
        },
        {
            id = 6,
            price = 8520,
            name = 'Kevlar Léger 3',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/GPB/keville3.webp',
            spawnName = "keville3",
            type = "utils"
        },
        {
            id = 7,
            price = 8520,
            name = 'Kevlar Léger 4',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/GPB/keville4.webp',
            spawnName = "keville4",
            type = "utils"
        },

        {
            id = 8,
            price = 10500,
            name = 'Kevlar Moyen 1',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/GPB/keville9.webp',
            spawnName = "keville9",
            type = "utils"
        },
        {
            id = 9,
            price = 10500,
            name = 'Kevlar Moyen 2',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/GPB/keville10.webp',
            spawnName = "keville10",
            type = "utils"
        },
        {
            id = 10,
            price = 10500,
            name = 'Kevlar Moyen 3',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/GPB/keville11.webp',
            spawnName = "keville11",
            type = "utils"
        },
        {
            id = 11,
            price = 10500,
            name = 'Kevlar Moyen 4',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/GPB/keville12.webp',
            spawnName = "keville12",
            type = "utils"
        },

        {
            id = 12,
            price = 12870,
            name = 'Kevlar Lourd 1',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/GPB/keville5.webp',
            spawnName = "keville5",
            type = "utils"
        },
        {
            id = 13,
            price = 12870,
            name = 'Kevlar Lourd 2',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/GPB/keville6.webp',
            spawnName = "keville6",
            type = "utils"
        },
        {
            id = 14,
            price = 12870,
            name = 'Kevlar Lourd 3',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/GPB/keville7.webp',
            spawnName = "keville7",
            type = "utils"
        },
        {
            id = 15,
            price = 12870,
            name = 'Kevlar Lourd 4',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/GPB/keville8.webp',
            spawnName = "keville8",
            type = "utils"
        },
        {
            id = 16,
            price = 200,
            name = 'Munition d\'arme de poing',
            image = 'assets/inventory/items/ammobox_pistol.png',
            spawnName = "ammobox_pistol",
            type = "utils"
        },
        {
            id = 17,
            price = 700,
            name = 'Munition de fusil d\'assaut',
            image = 'assets/inventory/items/ammobox_rifle.png',
            spawnName = "ammobox_rifle",
            type = "utils"
        },
        {
            id = 18,
            price = 800,
            name = 'Munition d\'arme lourde',
            image = 'assets/inventory/items/ammobox_heavy.png',
            spawnName = "ammobox_heavy",
            type = "utils"
        }
    }
}

Drugs.crew = {
    --test
    {name = "TEST CREW", typeCrew = mc, wp = mcWeapon},
    --pf
    {name = "9 Blocc", typeCrew = pf, wp = pfWeapon},
    {name = "Kuso Gaki", typeCrew = pf, wp = pfWeapon},
    {name = "Les sdf de la freeway", typeCrew = pf, wp = pfWeapon},
    {name = "Boston Street", typeCrew = pf, wp = pfWeapon},
    {name = "Sokudo Chasers", typeCrew = pf, wp = pfWeapon},
    {name = "Night Shift", typeCrew = pf, wp = pfWeapon},
    {name = "Vinewood Boyz", typeCrew = pf, wp = pfWeapon},
    --gang
    {name = "Aztecas", typeCrew = gang, wp = gangWeapon},
    {name = "BallasGang", typeCrew = gang, wp = gangWeapon},
    {name = "Los Santos Vagos", typeCrew = gang, wp = gangWeapon},
    {name = "Les Families", typeCrew = gang, wp = gangWeapon},
    {name = "BallasGangz", typeCrew = gang, wp = gangWeapon},
    {name = "les papys", typeCrew = gang, wp = gangWeapon},
    {name = "YBD", typeCrew = gang, wp = gangWeapon},
    {name = "13 Crimson Gang", typeCrew = gang, wp = gangWeapon},
    --mc
    {name = "Grim Bastards", typeCrew = mc, wp = mcWeapon},
    {name = "The Lost MC", typeCrew = mc, wp = mcWeapon},
    {name = "MayansMC", typeCrew = mc, wp = mcWeapon},
    {name = "Calaveras Nomads", typeCrew = mc, wp = mcWeapon},
    {name = "Angels Of Death", typeCrew = mc, wp = mcWeapon},
    --orga
    {name = "Wonderland", typeCrew = orga, wp = orgaWeapon},
    {name = "Loco Syndicate", typeCrew = orga, wp = orgaWeapon},
    {name = "Cartel Madrazo", typeCrew = orga, wp = orgaWeapon},
    {name = "Luz Familiar", typeCrew = orga, wp = orgaWeapon},
    {name = "Faucons Rouge", typeCrew = orga, wp = orgaWeapon},
    {name = "Los Surenos", typeCrew = orga, wp = orgaWeapon},
    {name = "Cherokees", typeCrew = orga, wp = orgaWeapon},
    {name = "Blacks Angels", typeCrew = orga, wp = orgaWeapon},
    --mafia
    {name = "Cartel Santa Blanca", typeCrew = mafia, wp = mafiaWeapon},
    {name = "Mafia Arménienne", typeCrew = mafia, wp = mafiaWeapon},
    {name = "Los Sicarios", typeCrew = mafia, wp = mafiaWeapon},
    {name = "Mafia Albanaise", typeCrew = mafia, wp = mafiaWeapon},
    {name = "TRIADE", typeCrew = mafia, wp = mafiaWeapon},
    {name = "Cartel De Bogota", typeCrew = mafia, wp = mafiaWeapon},
}

Drugs.cooldown = {
    --24h = 86400
    --pf
    ["plate"] = 432000,
    --gang
    ["weapon_bat"] = 172800,
    ["weapon_bottle"] = 172800,
    ["weapon_crowbar"] = 172800,
    ["weapon_golfclub"] = 172800,
    ["weapon_hatchet"] = 172800,
    ["weapon_knuckle"] = 172800,
    ["weapon_machete"] = 172800,
    ["weapon_nightstick"] = 172800,
    ["weapon_wrench"] = 172800,
    ["weapon_knife"] = 172800,
    ["weapon_switchblade"] = 172800,
    ["weapon_battleaxe"] = 172800,
    ["weapon_poolcue"] = 172800,
    ["weapon_canette"] = 172800,
    ["weapon_bouteille"] = 172800,
    ["weapon_pelle"] = 172800,
    ["weapon_pickaxe"] = 172800,
    ["weapon_sledgehammer"] = 172800,
    ["weapon_dagger"] = 172800,
    ["serflex"] = 172800,

    --mc
    ["weapon_pistol"] = 345600,
    ["weapon_vintagepistol"] = 259200,
    ["weapon_snspistol"] = 259200,
    ["weapon_dbshotgun"] = 604800,
    ["weapon_molotov"] = 604800,
    ["pincecoupante"] = 172800,
    
    --orga
    ["weapon_katana"] = 604800,
    ["weapon_combatpistol"] = 345600,
    ["weapon_heavypistol"] = 345600,
    ["weapon_revolver"] = 345600,
    ["weapon_doubleaction"] = 604800,

    ["weapon_microsmg"] = 432000,
    ["weapon_machinepistol"] = 432000,
    ["weapon_minismg"] = 432000,

    ["weapon_assaultshotgun"] = 604800,
    ["weapon_sawnoffshotgun"] = 604800,
    ["weapon_pumpshotgun"] = 604800, 
    ["weapon_heavyshotgun"] = 604800,

    --mafia
    ["weapon_pistol50"] = 345600,
    ["weapon_autoshotgun"] = 432000,
    ["weapon_combatshotgun"] = 864000, 
    ["weapon_compactrifle"] = 432000, 
    ["weapon_assaultrifle"] = 864000,
    ["weapon_gusenberg"] = 864000,
    ["weapon_smg"] = 345600,
    ["weapon_carbinerifle"] = 864000,
    ["weapon_specialcarbine"] = 864000,
}

local ct
local store
local crewLevel = nil
--RegisterCommand("tabletteIllegal", function()
    --if p:getCrew() ~= "None" then

function addWpOnStore(crewName)
    local typecrew
    store.armes = {}
    for k, v in pairs(Drugs.crew) do
        if v.name == crewName then
            for kk, vv in pairs(v.wp) do
                if vv.level <= crewLevel then
                    table.insert(store.armes, vv)
                end
            end
        end
    end
    
    ----print(json.encode(gang.armes))
end

--print("tabletteIllegal test")
RegisterNetEvent("core:tabletteIllegalV1")
AddEventHandler("core:tabletteIllegalV1", function()
    for k, v in pairs(Drugs.crew) do
        if v.name == p:getCrew() then
            crewLevel = TriggerServerCallback("core:GetCrewLevel", p:getCrew())
            while not crewLevel do Wait(1) end
            store = v.typeCrew
            addWpOnStore(v.name)
            ct = v.typeCrew
            local value = TriggerServerEvent("drugsDeliveries:getHistoryOrderServer", token)
            TriggerServerEvent("core:GetWeaponListCrew", p:getCrew(), crewLevel)
            Wait(200)
            openIllegalTablet()
        end
    end
end)
--end)

local listWeaponMyCrew = {}
RegisterNetEvent("core:GetlistWeaponMyCrewClient")
AddEventHandler("core:GetlistWeaponMyCrewClient", function(data, timestamp)
    --print(json.encode(data))
    listWeaponMyCrew = data
    for k,v in pairs(store.armes) do 
        for i,j in pairs(listWeaponMyCrew) do
            --print(store.name)
            --print("Stock ", ArmesMaxStock[store.name][j.weapon], j.quantity)
            if v.spawnName == j.weapon then
                v.stock = ArmesMaxStock[store.name][j.weapon] - j.quantity
                --print("Calcul", v.stock)
                if v.stock == 0 then
                    v.stock = nil
                    v.cooldown = (j.cooldown - timestamp)*1000
                    --TriggerServerEvent("core:StartCooldown", p:getCrew(), v.spawnName, Drugs.cooldown[v.spawnName])
                end
            end
        end
    end
end)

local crewName = ''--'Gouvernement'
local crewDesc = ''--'Vespucci - Trafic de drogues et d\'armes'
local crewInitials = ''--'LS'
local crewColor = ''--"#FF0000"
local crewMotto = ''--'Tip top coolos'

local orders = {}

local info = {
    totalSpent = 0,
    totalCommands = 0,
    mostOrdered = ''
}

function getCrewInfo()
    crewInfo, crewMembers, crewGrade = TriggerServerCallback("core:getCrewInfo", token, p:getCrew())
    --print(crewInfo.name, crewInfo.devise, string.sub(crewInfo.name, 1, 1), crewInfo.color, crewInfo.devise)
    crewName = crewInfo.name
    crewDesc = crewInfo.devise
    crewInitials = string.sub(crewInfo.name, 1, 1)
    crewColor = crewInfo.color
    crewMotto =  crewInfo.devise
end

-- function getStore()
--     storeBdd = TriggerServerCallback("drugsDeliveries:getStore", token, p:getCrew()) --getStore todo get all object to sell for this crew
--     for k, v in pairs(storeBdd) do
--         if (store[v.ObjectType] == nil) then
--             store[v.ObjectType] = {}
--         end
--         store[v.ObjectType][k] = {}
--         store[v.ObjectType][k].id = k
--         store[v.ObjectType][k].price = v.price
--         store[v.ObjectType][k].name = v.name
--         store[v.ObjectType][k].image = v.image
--         store[v.ObjectType][k].spawnName = v.spawnName
--         store[v.ObjectType][k].type = v.typeObject
--     end
-- end

RegisterNetEvent("drugsDeliveries:getHistoryOrderClient") 
AddEventHandler("drugsDeliveries:getHistoryOrderClient", function(history) 
    --print("hist", history)
    local most = {}
    local i = 1
    for k, v in pairs(history) do
        --print("Order1", v.crewName, v.date, v.total)
        if v.crewName == p:getCrew() then
            orders[i] = {}
            orders[i].date = v.date.."+02:00"
            orders[i].price = v.total
            orders[i].type = v.typeObject
            orders[i]["items"] = {}
            for key, order in pairs(v.order) do
                --print("Order2", order.name, order.quantity)
                orders[i]["items"][key] = {}
                orders[i]["items"][key].name = order.name
                orders[i]["items"][key].quantity = order.quantity
                if (most[order.name] == nil) then
                    most[order.name] = {}
                    most[order.name].nbr = 0
                    most[order.name].name = order.name
                end
                most[order.name].nbr = most[order.name].nbr + order.quantity
            end
            info.totalSpent = info.totalSpent + v.total
            info.totalCommands = info.totalCommands + 1
            i = i + 1
        end
    end
    --print("Total commands", info.totalCommands, info.totalSpent)
    local nbrMost = 0
    for k, v in pairs(most) do
        --print(v, json.encode(v))
        if v.nbr > nbrMost then 
            nbrMost = v.nbr
            info.mostOrdered = v.name
        end
    end
end)

function openIllegalTablet()
    getCrewInfo()
    --print("infoooooooooo", json.encode(orders),json.encode(info))
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'Tablette',
        data = {
            crewName = crewName,
            crewDesc = crewDesc,
            crewInitials = crewInitials,
            crewColor = crewColor,
            crewMotto = crewMotto,
            informations = info,
            crewLevel = crewLevel,
            orders = orders,
            shop = store
        }
    }));
end

function AllCheck()
    return true
end

RegisterNetEvent('drugsDeliveries:saveCommandReturn')
AddEventHandler('drugsDeliveries:saveCommandReturn', function(value, order, total, typeObject)
    --print(value)
    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))
    if value == true then
        if typeObject == "weapons" then
            --print(json.encode(order))
            TriggerServerEvent("core:AddWeaponListCrew", p:getCrew(), order)
        end
        --print(math.tointeger(total))
        --print(p:getCrew(), math.floor(math.tointeger(total)/100*2))
        TriggerServerEvent("core:addCrewExp", p:getCrew(), math.floor(math.tointeger(total) / 100 * 2), "tablet")

        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'Tablette',
            data = {
                crewName = crewName,
                crewDesc = crewDesc,
                crewInitials = crewInitials,
                crewColor = crewColor,
                crewMotto = crewMotto,
                informations = info,
                crewLevel = crewLevel,
                orders = orders,
                shop = store,
                force = "Logout"
            }
        }));
    else
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'Tablette',
            data = {
                crewName = crewName,
                crewDesc = crewDesc,
                crewInitials = crewInitials,
                crewColor = crewColor,
                crewMotto = crewMotto,
                informations = info,
                crewLevel = crewLevel,
                orders = orders,
                shop = store,
                errorMessage = value,
                force = "Shop"
            }
        }));
    end
end)

RegisterNUICallback("TabletteIllegale", function(data)
    -- local command = {}
    local typeObject = data.order[1].type
    ---- print(typeObject)
    ---- print(data.time)
    ---- print(data.total)
    -- for key, value in pairs(data.order) do
    ----     print(value.price)
    ----     print(value.quantity)
    ----     print(value.spawnName)
    ----     print('-----------')
    -- end
    ---- print(data.total)
    if AllCheck() then
        if p:pay(data.total) then
            --print('pay')
            TriggerServerEvent("drugsDeliveries:saveCommand", token, data, crewName, typeObject)
            --await return of drugsDeliveries:saveCommandReturn
            --TriggerServerEvent("drugsDeliveries:start", data.order, crewName, typeObject)
        else
            SendNuiMessage(json.encode({
                type = 'closeWebview',
            }))
            --print('nopay')
            SendNuiMessage(json.encode({
                type = 'openWebview',
                name = 'Tablette',
                data = {
                    crewName = crewName,
                    crewDesc = crewDesc,
                    crewInitials = crewInitials,
                    crewColor = crewColor,
                    crewMotto = crewMotto,
                    informations = info,
                    crewLevel = crewLevel,
                    orders = orders,
                    shop = store,
                    errorMessage = "pas assez de moula",
                    force = "Shop"
                }
            }));       
        end
    else
        --print('backStore')
        SendNuiMessage(json.encode({
            type = 'closeWebview',
        }))
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'Tablette',
            data = {
                crewName = crewName,
                crewDesc = crewDesc,
                crewInitials = crewInitials,
                crewColor = crewColor,
                crewMotto = crewMotto,
                informations = info,
                crewLevel = crewLevel,
                orders = orders,
                shop = store,
                errorMessage = "erreur dans le traitement",
                force = "Shop"
            }
        }));
    end
end)
