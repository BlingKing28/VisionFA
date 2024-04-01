ammunation = {
    ["ui"] = {
        whiteweap = {
            {
                label = "background_weap",
                x = 0.5,
                y = 0.5,
                hoverTexture = "background_hoveredbuy",
                pixel = {440,40},
                dev = true
            },
        },
        weapons = {

        },
        acces = {

        },
    },
    ["accessories"] = {
        ["WEAPON_PISTOL"] = {
            {
                type = "Chargeur",
                name = "Par défaut",
                hash = "COMPONENT_PISTOL_CLIP_01",
                price = 2000,
                owned = false,
                equipped = false
            },
            {
                type = "Chargeur",
                name = "grande capacité",
                hash = "COMPONENT_PISTOL_CLIP_02",
                price = 2000,
                owned = false,
                equipped = false
            },
        },
        ["WEAPON_SNSPISTOL"] = {
            {
                type = "Chargeur",
                name = "Par défaut",
                hash = "COMPONENT_SNSPISTOL_CLIP_01",
                price = 2000,
                owned = false,
                equipped = false
            },
            {
                type = "Chargeur",
                name = "grande capacité",
                hash = "COMPONENT_SNSPISTOL_CLIP_02",
                price = 2000,
                owned = false,
                equipped = false
            },
        }
    },
    ["weapons"] = {
        nibard = {
            {
                name=  "MOUSQUET",
                category = "ARME A FEU",
                hash = "WEAPON_MUSKET",
                picture = "assets/ammunation/WEAPON_MUSKET.png",
                price = 3500,
                features = {
                    {
                        name= "Dégâts",
                        percentage= 97,
                    },
                    {
                        name= "Cadence",
                        percentage= 10,
                    },
                    {
                        name= "Précision",
                        percentage= 65,
                    },
                    {
                        name= "Portée",
                        percentage= 85,
                    },
                },

            },
            {
                name=  "COUTEAU",
                category = "ARME BLANCHE",
                hash = "WEAPON_KNIFE",
                picture = "assets/ammunation/WEAPON_KNIFE.png",
                price = 2000,
                features = {
                    {
                        name= "Dégâts",
                        percentage= 15,
                    },
                    {
                        name= "Cadence",
                        percentage= 20,
                    },
                    {
                        name= "Précision",
                        percentage= 100,
                    },
                    {
                        name= "Portée",
                        percentage= 1,
                    },
                },

            },
            {
                name=  "LAMPE DE POCHE",
                category = "ARME BLANCHE",
                hash = "WEAPON_FLASHLIGHT",
                picture = "assets/ammunation/WEAPON_FLASHLIGHT.png",
                price = 2000,
                features = {
                    {
                        name= "Dégâts",
                        percentage= 15,
                    },
                    {
                        name= "Cadence",
                        percentage= 20,
                    },
                    {
                        name= "Précision",
                        percentage= 100,
                    },
                    {
                        name= "Portée",
                        percentage= 1,
                    },
                },

            },
        },
        shotgun_list = {
            {
                name=  "MOUESQUET",
                category = "ARME A FEU",
                hash = "WEAPON_MUSKET",
                picture = "assets/ammunation/WEAPON_MUSKET.png",
                price = 3500,
                features = {
                    {
                        name= "Dégâts",
                        percentage= 97,
                    },
                    {
                        name= "Cadence",
                        percentage= 10,
                    },
                    {
                        name= "Précision",
                        percentage= 65,
                    },
                    {
                        name= "Portée",
                        percentage= 85,
                    },
                },

            },
        },
        
        melee_list = {
            {
                name=  "COUTEAU",
                category = "ARME BLANCHE",
                hash = "WEAPON_KNIFE",
                picture = "assets/ammunation/WEAPON_KNIFE.png",
                price = 2000,
                features = {
                    {
                        name= "Dégâts",
                        percentage= 15,
                    },
                    {
                        name= "Cadence",
                        percentage= 20,
                    },
                    {
                        name= "Précision",
                        percentage= 100,
                    },
                    {
                        name= "Portée",
                        percentage= 1,
                    },
                },

            },
            {
                name=  "MARTEAU",
                category = "ARME BLANCHE",
                hash = "WEAPON_HAMMER",
                picture = "assets/ammunation/WEAPON_HAMMER.png",
                price = 1000,
                features = {
                    {
                        name= "Dégâts",
                        percentage= 10,
                    },
                    {
                        name= "Cadence",
                        percentage= 15,
                    },
                    {
                        name= "Précision",
                        percentage= 100,
                    },
                    {
                        name= "Portée",
                        percentage= 1,
                    },
                },

            },
            {   
                name=  "BATTE DE BASEBALL",
                category = "ARME BLANCHE",
                hash = "WEAPON_BAT",
                picture = "assets/ammunation/WEAPON_BAT.png",
                price = 1700,
                features = {
                    {
                        name= "Dégâts",
                        percentage= 20,
                    },
                    {
                        name= "Cadence",
                        percentage= 10,
                    },
                    {
                        name= "Précision",
                        percentage= 100,
                    },
                    {
                        name= "Portée",
                        percentage= 1,
                    },
                },

            },
            {
                name=  "PIED DE BICHE",
                category = "ARME BLANCHE",
                hash = "WEAPON_CROWBAR",
                picture = "assets/ammunation/WEAPON_CROWBAR.png",
                price = 1200,
                features = {
                    {
                        name= "Dégâts",
                        percentage= 10,
                    },
                    {
                        name= "Cadence",
                        percentage= 15,
                    },
                    {
                        name= "Précision",
                        percentage= 100,
                    },
                    {
                        name= "Portée",
                        percentage= 1,
                    },
                },

            },
            {
                name=  "CLUB DE GOLF",
                category = "ARME BLANCHE",
                hash = "WEAPON_GOLFCLUB",
                picture = "assets/ammunation/WEAPON_GOLFCLUB.png",
                price = 1600,
                features = {
                    {
                        name= "Dégâts",
                        percentage= 20,
                    },
                    {
                        name= "Cadence",
                        percentage= 10,
                    },
                    {
                        name= "Précision",
                        percentage= 100,
                    },
                    {
                        name= "Portée",
                        percentage= 1,
                    },
                },

            },
            {
                name=  "LAMPE DE POCHE",
                category = "ARME BLANCHE",
                hash = "WEAPON_FLASHLIGHT",
                picture = "assets/ammunation/WEAPON_FLASHLIGHT.png",
                price = 2000,
                features = {
                    {
                        name= "Dégâts",
                        percentage= 15,
                    },
                    {
                        name= "Cadence",
                        percentage= 20,
                    },
                    {
                        name= "Précision",
                        percentage= 100,
                    },
                    {
                        name= "Portée",
                        percentage= 1,
                    },
                },

            },
            {
                name=  "QUEUE DE BILLARD",
                category = "ARME BLANCHE",
                hash = "WEAPON_POOLCUE",
                picture = "assets/ammunation/WEAPON_POOLCUE.png",
                price = 1500,
                features = {
                    {
                        name= "Dégâts",
                        percentage= 20,
                    },
                    {
                        name= "Cadence",
                        percentage= 10,
                    },
                    {
                        name= "Précision",
                        percentage= 100,
                    },
                    {
                        name= "Portée",
                        percentage= 0,
                    },
                },

            },
            {
                name=  "ClE ANGLAISE",
                category = "ARME BLANCHE",
                hash = "WEAPON_WRENCH",
                picture = "assets/ammunation/WEAPON_WRENCH.png",
                price = 1400,
                features = {
                    {
                        name= "Dégâts",
                        percentage= 10,
                    },
                    {
                        name= "Cadence",
                        percentage= 15,
                    },
                    {
                        name= "Précision",
                        percentage= 100,
                    },
                    {
                        name= "Portée",
                        percentage= 0,
                    },
                },

            },
            {
                name=  "BOUTEILLE",
                category = "ARME BLANCHE",
                hash = "WEAPON_BOTTLE",
                picture = "assets/ammunation/WEAPON_BOTTLE.png",
                price = 2000,
                features = {
                    {
                        name= "Dégâts",
                        percentage= 20,
                    },
                    {
                        name= "Cadence",
                        percentage= 15,
                    },
                    {
                        name= "Précision",
                        percentage= 100,
                    },
                    {
                        name= "Portée",
                        percentage= 1,
                    },
                },

            },
            {
                name=  "PELLE",
                category = "ARME BLANCHE",
                hash = "WEAPON_PELLE",
                picture = "assets/ammunation/WEAPON_PELLE.png",
                price = 1200,
                features = {
                    {
                        name= "Dégâts",
                        percentage= 10,
                    },
                    {
                        name= "Cadence",
                        percentage= 15,
                    },
                    {
                        name= "Précision",
                        percentage= 100,
                    },
                    {
                        name= "Portée",
                        percentage= 1,
                    },
                },

            },
            {
                name=  "PIOCHE",
                category = "ARME BLANCHE",
                hash = "WEAPON_PICKAXE",
                picture = "assets/ammunation/WEAPON_PICKAXE.png",
                price = 1200,
                features = {
                    {
                        name= "Dégâts",
                        percentage= 10,
                    },
                    {
                        name= "Cadence",
                        percentage= 15,
                    },
                    {
                        name= "Précision",
                        percentage= 100,
                    },
                    {
                        name= "Portée",
                        percentage= 1,
                    },
                },

            },
        }
    }
}