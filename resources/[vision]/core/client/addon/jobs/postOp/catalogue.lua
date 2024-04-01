local toSend = nil

-- Nourritures

local UwUcafe_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/header_uwucoffee.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',

    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/CatPat.webp',
            label= 'CatPat',
            givename= 'CatPat',
            category= 'Nourritures',
            price= 15,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Chat_Gourmand.webp',
            label= 'Chat Gourmand',
            givename= 'ChatGourmand',
            category= 'Nourritures',
            price=5,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Mochi.webp',
            label= 'Mochi',
            givename= 'Mochi',
            category= 'Nourritures',
            price=5,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Pocky.webp',
            label= 'Pocky',
            givename= 'Pocky',
            category= 'Nourritures',
            price=5,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/UwU_Burger-removebg-preview.webp',
            label= 'UwU Burger',
            givename= 'UwUBurger',
            category= 'Nourritures',
            price=15,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy.webp',
            label= 'Kitty Toy',
            category= 'Nourritures',
            price=5,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/melto.webp',
            label= 'Melto',
            givename= 'melto',
            category= 'Nourritures',
            price=15,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/lapinut.webp',
            label= 'Lapinut',
            givename= 'lapinut',
            category= 'Nourritures',
            price=15,
        },
    },

    elementsBoissons = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/BarbaMilk.webp',
            label= 'BarbaMilk',
            givename= 'BarbaMilk',
            category= 'Boissons',
            price=5,
        },
        {
            id=2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Chatmallow.webp',
            label= 'Chatmallow',
            givename= 'Chatmallow',
            category= 'Boissons',
            price=5,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Bubble_Tea.webp',
            label= 'Bubble Tea',
            givename= 'BubbleTea',
            category= 'Boissons',
            price=2,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Ice_Coffee.webp',
            label= 'Ice Coffee',
            givename= 'IceCoffee',
            category= 'Boissons',
            price=2,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/IceCream_Cat.webp',
            label= 'IceCream Cat',
            givename= 'IceCreamCat',
            category= 'Boissons',
            price=5,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Lailait_chaud.webp',
            label= 'Lailait chaud',
            givename= 'Lailaitchaud',
            category= 'Boissons',
            price=5,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Milkshake.webp',
            label= 'Milkshake',
            givename= 'Milkshake',
            category= 'Boissons',
            price=5,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/LatteMatcha.webp',
            label= 'LatteMatcha',
            givename= 'LatteMatcha',
            category= 'Boissons',
            price=5,
        },
    },

    elementsUtilitaires = {
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy_Arc_En_Ciel.webp',
            label= 'Kitty Toy Arc-en-ciel',
            givename= 'KittyToyArcEnCiel',
            category= 'Utilitaires',
            price=5,

        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy_Bleu.webp',
            label= 'Kitty Toy Bleu',
            givename= 'kitty2',
            category= 'Utilitaires',
            price=5,

        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy_Dark.webp',
            label= 'Kitty Toy Dark',
            givename= 'KittyToyDark',
            category= 'Utilitaires',
            price=5,
        },
        {
            id= 11,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy_Flower.webp',
            label= 'Kitty Toy Flower',
            givename= 'KittyToyFlower',
            category= 'Utilitaires',
            price=5,
        },
        {
            id= 12,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy_Gris.webp',
            label= 'Kitty Toy Gris',
            givename= 'KittyToyGris',
            category= 'Utilitaires',
            price=5,
        },
        {
            id= 13,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy_Jaune.webp',
            label= 'Kitty Toy Jaune',
            givename= 'KittyToyJaune',
            category= 'Utilitaires',
            price=5,
        },
        {
            id= 14,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy_Vert-removebg-preview.webp',
            label= 'Kitty Toy Vert',
            givename= 'KittyToyVert',
            category= 'Utilitaires',
            price=5,
        },
        {
            id= 15,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy.webp',
            label= 'Kitty Toy Rose',
            givename= 'kitty',
            category= 'Utilitaires',
            price=5,

        },
    }
}

-- Nourritures

local VanillaUnicorn_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/header_unicorn.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Aperitifs.webp',
            label= 'Apéritifs',
            givename= 'Aperitifs',
            category= 'Nourritures',
            price=10,
        },
    },

    elementsBoissons = {
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Limonade.webp',
            label= 'Limonade',
            givename= 'Limonade',
            category= 'Boissons',
            price=7,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Jus_de_fruits.webp',
            label= 'Jus de fruits',
            givename= 'Jusdefruits',
            category= 'Boissons',
            price=7,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Soda.webp',
            label= 'Soda',
            givename= 'Soda',
            category= 'Boissons',
            price=7,
        },
    },

    elementsAlcool = {
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Cool_Granny.webp',
            label= 'Cool Granny',
            givename= 'CoolGranny',
            category= 'Alcool',
            price=22,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Doudou.webp',
            label= 'Doudou',
            givename= 'Doudou',
            category= 'Alcool',
            price=22,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/French_Kiss.webp',
            label= 'French Kiss',
            givename= 'FrenchKiss',
            category= 'Alcool',
            price=22,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Red_Velvet.webp',
            label= 'Red Velvet',
            givename= 'RedVelvet',
            category= 'Alcool',
            price=22,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Sex_on_the_beach.webp',
            label= 'Sex On The Beach',
            givename= 'Sexonthebeach',
            category= 'Alcool',
            price=22,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Uni_tail.webp',
            label= 'Uni Tail',
            givename= 'Unitail',
            category= 'Alcool',
            price=37,
        },
    },
}

-- Nourritures

local BeanMachine_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/header_beanmachine.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Cookie.webp',
            label= 'Cookie',
            givename= 'Cookie',
            category= 'Nourritures',
            price=5,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Muffin_choco.webp',
            label= 'Muffin choco',
            givename= 'Muffinchoco',
            category= 'Nourritures',
            price=5,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Oeufsbacon.webp',
            label= 'Oeufs Bacon',
            givename= 'OeufsBacon',
            category= 'Nourritures',
            price= 15,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/donutc.webp',
            label= 'Donuts Chocolat',
            givename= 'donutc',
            category= 'Nourritures',
            price= 8,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/donutn.webp',
            label= 'Donuts Nature',
            givename= 'donutn',
            category= 'Nourritures',
            price= 8,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Cheesecake.webp',
            label= 'Cheesecake',
            givename= 'Cheesecake',
            category= 'Nourritures',
            price= 10,
        },
    },

    elementsBoissons = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Cafe_frappe.webp',
            label= 'Café frappé',
            givename= 'Cafefrappe',
            category= 'Boissons',
            price=2,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Cafe_praline.webp',
            label= 'Café praliné',
            givename= 'Cafepraline',
            category= 'Boissons',
            price=2,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Cappuccino.webp',
            label= 'Cappuccino',
            givename= 'Cappuccino',
            category= 'Boissons',
            price=2,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Caramel_macchiato.webp',
            label= 'Caramel macchiato',
            givename= 'Caramelmacchiato',
            category= 'Boissons',
            price=5,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Choco_guimauve.webp',
            label= 'Choco guimauve',
            givename= 'Chocoguimauve',
            category= 'Boissons',
            price= 5,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Chocolat_viennois.webp',
            label= 'Chocolat viennois',
            givename= 'Chocolatviennois',
            category= 'Boissons',
            price= 5,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Expresso.webp',
            label= 'Expresso',
            givename= 'Expresso',
            category= 'Boissons',
            price=2,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Latte.webp',
            label= 'Latte',
            givename= 'Latte',
            category= 'Boissons',
            price=2,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Theglace.webp',
            label= 'Thé glacé',
            givename= 'Theglace',
            category= 'Boissons',
            price= 5,
        },
    },
}

-- Nourritures

local LeMiroir_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/header_lemiroir.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Fondant_chocolat.webp',
            label= 'Fondant au chocolat',
            givename= 'Fondantchocolat',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Waffle.webp',
            label= 'Gaufre',
            givename= 'Waffle',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Moules_frites.webp',
            label= 'Moules frites',
            givename= 'Moulesfrites',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Plateau_de_charcuterie.webp',
            label= 'Plateau de charcuterie',
            givename= 'Plateaudecharcuterie',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/escalope.webp',
            label= 'Escalope',
            givename= 'escalope',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/seafoodInWood.webp',
            label= 'Plateau des mers',
            givename= 'seafood-in-wood-',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/American_ribs.webp',
            label= 'American ribs',
            givename= 'Americanribs',
            category= 'Nourritures',
            price= 20,
        },

        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/caviar.webp',
            label= 'Caviar',
            givename= 'caviar',
            category= 'Nourritures',
            price= 10,
        },

        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/magret.webp',
            label= 'Magret',
            givename= 'magret',
            category= 'Nourritures',
            price= 20,
        },

        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/foiegras.webp',
            label= 'Foie Gras',
            givename= 'foiegras',
            category= 'Nourritures',
            price= 20,
        },
    },

    elementsBoissons = {
        {
            id= 11,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Limonade.webp',
            label= 'Limonade',
            givename= 'Limonade',
            category= 'Boissons',
            price= 7,
        },
        {
            id= 12,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Jus_de_fruits.webp',
            label= 'Jus de fruits',
            givename= 'Jusdefruits',
            category= 'Boissons',
            price= 7,
        },
        {
            id= 13,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Soda.webp',
            label= 'Soda',
            givename= 'Soda',
            category= 'Boissons',
            price= 7,
        },
    },

    elementsAlcool = {
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/champagne.webp',
            label= 'Champagne',
            givename= 'champagne',
            category= 'Alcool',
            price= 20,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Vin_blanc.webp',
            label= 'Vin Blanc',
            givename= 'Vinblanc',
            category= 'Alcool',
            price= 17,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Vin_rouge.webp',
            label= 'Vin Rouge',
            givename= 'Vinrouge',
            category= 'Alcool',
            price= 17,
        },
    },
}

-- Nourritures

local Tacos2Rancho_toSend = {
    headerImage = 'https://cdn.discordapp.com/attachments/1146829717597606119/1147487872258166834/Banner-Tacos2Rancho.jpg',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    elements = {
        {
            id= 10,
            image= 'https://media.discordapp.net/attachments/1146829717597606119/1147511638568742973/fajitas-the-frenchy-burger.png',
            label= 'Fajitas',
            givename= 'Fajitas',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 11,
            image= 'https://cdn.discordapp.com/attachments/1146829717597606119/1147511814939222087/menuthumbnail_breakfast_burrito-supersonic.png',
            label= 'Burritos',
            givename= 'Burritos',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 12,
            image= 'https://cdn.discordapp.com/attachments/1146829717597606119/1147512065838297118/KWC-Image-2018-Food-Quesadilla-Whole-Chicken-1a-4853_kf_hd51_09063-FNL.png',
            label= 'Quessadillas',
            givename= 'Quessadillas',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 13,
            image= 'https://cdn.discordapp.com/attachments/1146829717597606119/1147512360039362570/SINGLE-TACO.png',
            label= 'Tacos',
            givename= 'Tacos',
            category= 'Nourritures',
            price= 20,
        },
    },

    elementsBoissons = {
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Jus_de_fruits.webp',
            label= 'Jus',
            givename= 'Jusdefruits',
            category= 'Boissons',
            price= 5,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Soda.webp',
            label= 'Soda',
            givename= 'soda',
            category= 'Boissons',
            price= 5,
        },
        {
            id= 6,
            image= 'https://media.discordapp.net/attachments/1147903108442226779/1148218396383653888/laitchoco.png',
            label= 'Lait',
            givename= 'lait',
            category= 'Boissons',
            price= 5,
        },
        {
            id= 7,
            image= 'https://media.discordapp.net/attachments/1147903108442226779/1148218098520952842/caprisun.png',
            label= 'Capri-Sun',
            givename= 'caprisun',
            category= 'Boissons',
            price= 5,
        },
    },
}

local CluckinBell_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/header_cluckinbell.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_bucket.webp',
            label= 'Buckets',
            givename= 'gncluckinbucket',
            category= 'Nourritures',
            price= 15,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_burg.webp',
            label= 'Burger',
            givename= 'gncluckinburg',
            category= 'Nourritures',
            price= 15,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_fowl.webp',
            label= 'Volaille à croquer',
            givename= 'gncluckinfowl',
            category= 'Nourritures',
            price= 15,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_fries.webp',
            label= 'Frites',
            givename= 'gncluckinfries',
            category= 'Nourritures',
            price= 5,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_kids.webp',
            label= 'Menu Enfant',
            givename= 'gncluckinkids',
            category= 'Nourritures',
            price= 5,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_rings.webp',
            label= 'Onion Rings',
            givename= 'gncluckinrings',
            category= 'Nourritures',
            price= 5,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_salad.webp',
            label= 'Salade',
            givename= 'gncluckinsalad',
            category= 'Nourritures',
            price= 15,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_soup.webp',
            label= 'Soupe',
            givename= 'gncluckinsoup',
            category= 'Nourritures',
            price= 15,
        },
    },


    elementsBoissons = {
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_cup.webp',
            label= 'Soda',
            givename= 'gncluckincup',
            category= 'Boissons',
            price= 7,
        },
    },
}

-- Nourritures

local BahamaMamas_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/header_bahamamamas.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    elements = {
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Tapas.webp',
            label= 'Tapas',
            givename= 'Tapas',
            category= 'Nourritures',
            price= 10,
        },
    },

    elementsBoissons = {
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Jus_de_fruits.webp',
            label= 'Jus de fruits',
            givename= 'Jusdefruits',
            category= 'Boissons',
            price= 7,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Limonade.webp',
            label= 'Limonade',
            givename= 'Limonade',
            category= 'Boissons',
            price= 7,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Soda.webp',
            label= 'Soda',
            givename= 'Soda',
            category= 'Boissons',
            price= 7,
        },
    },

    elementsAlcool = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Bloody_Mary.webp',
            label= 'Bloody Mary',
            givename= 'BloodyMary',
            category= 'Alcool',
            price= 22,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Blue-Mamas.webp',
            label= 'Blue-Mamas',
            givename= 'Blue-Mamas',
            category= 'Alcool',
            price= 37,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Gin.webp',
            label= 'Gin',
            givename= 'Gin',
            category= 'Alcool',
            price= 22,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Mojito.webp',
            label= 'Mojito',
            givename= 'Mojito',
            category= 'Alcool',
            price= 22,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Punch.webp',
            label= 'Punch',
            givename= 'Punch',
            category= 'Alcool',
            price= 22,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/White_Lady.webp',
            label= 'White Lady',
            givename= 'WhiteLady',
            category= 'Alcool',
            price= 22,
        },
    },
}

-- Nourritures

local BayviewLodge_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/header_bayviewlodge.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Applepie.webp',
            label= 'Apple pie',
            givename= 'Applepie',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Poutine.webp',
            label= 'Poutine',
            givename= 'Poutine',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Saucisson.webp',
            label= 'Saucisson',
            givename= 'Saucisson',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Pancakes.webp',
            label= 'Pancakes',
            givename= 'Pancakes',
            category= 'Nourritures',
            price= 10,
        },

        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Entrecote.webp',
            label= 'Entrecôte',
            givename= 'Entrecote',
            category= 'Nourritures',
            price= 20,
        },

        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Oeufsbacon.webp',
            label= 'Oeufs Bacon',
            givename= 'OeufsBacon',
            category= 'Nourritures',
            price= 20,
        },

        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Mac&cheese.webp',
            label= 'Mac & cheese',
            givename= 'Mac&cheese',
            category= 'Nourritures',
            price= 20,
        },
    },

    elementsBoissons = {
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Jus_de_fruits.webp',
            label= 'Jus de fruits',
            givename= 'Jusdefruits',
            category= 'Boissons',
            price= 7,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Limonade.webp',
            label= 'Limonade',
            givename= 'Limonade',
            category= 'Boissons',
            price= 7,
        },
    },

    elementsAlcool = {
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/BayviewBeer.webp',
            label= 'Bayview Beer',
            givename= 'BayviewBeer',
            category= 'Alcool',
            price= 10,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/DuffBeer.webp',
            label= 'Duff Beer',
            givename= 'DuffBeer',
            category= 'Alcool',
            price= 10,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Blonde.webp',
            label= 'Bière Blonde',
            givename= 'Blonde',
            category= 'Alcool',
            price= 10,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Hydromel.webp',
            label= 'Hydromel',
            givename= 'Hydromel',
            category= 'Alcool',
            price= 12,
        },
    },
}

-- Nourritures

local BurgerShot_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/header_burgershot.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/fries_box.webp',
            label= 'Frites',
            givename= 'friesbox',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/chicken_wrap.webp',
            label= 'Wrap Poulet',
            givename= 'chickenwrap',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/the_simply_burger.webp',
            label= 'Fishburger',
            givename= 'fishburger',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/the_glorious_burger.webp',
            label= 'Cheeseburger',
            givename= 'thegloriousburger',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/double_shot_burger.webp',
            label= 'Double Cheese',
            givename= 'doubleshotburger',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/meteorite_icecream.webp',
            label= 'Glace Meteorite',
            givename= 'meteoriteicecream',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/orangotang_icecream.webp',
            label= 'Glace Orangotang',
            givename= 'orangotangicecream',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/goat_cheese_wrap.webp',
            label= 'Wrap Chèvres',
            givename= 'goatcheesewrap',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/tacos.webp',
            label= 'Tacos',
            givename= 'tacos',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/the_fabulous_6lb_burger.webp',
            label= 'Fabulous Burger',
            givename= 'thefabulous6lbburger',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 11,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/bleeder_burger.webp',
            label= 'Bleeder Burger',
            givename= 'bleederburger',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 12,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/prickly_burger.webp',
            label= 'Prickly Burger',
            givename= 'pricklyburger',
            category= 'Nourritures',
            price= 20,
        },
    },

    elementsBoissons = {
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/soda.webp',
            label= 'Soda',
            givename= 'bssoda',
            category= 'Boissons',
            price= 7,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/Limonade.webp',
            label= 'Limonade',
            givename= 'Limonade',
            category= 'Boissons',
            price= 7,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/Jus_de_fruits.webp',
            label= 'Jus',
            givename= 'Jusdefruits',
            category= 'Boissons',
            price= 7,
        },
    },
}

-- Nourritures

local ComradesBar_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/header_comradesbar.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Aperitifs.webp',
            label= 'Apéritifs',
            givename= 'Aperitifs',
            category= 'Nourritures',
            price= 10,
        },
    },

    elementsBoissons = {
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Soda.webp',
            label= 'Soda',
            givename= 'Soda',
            category= 'Boissons',
            price= 7,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Limonade.webp',
            label= 'Limonade',
            givename= 'Limonade',
            category= 'Boissons',
            price= 7,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Jus_de_fruits.webp',
            label= 'Jus de fruits',
            givename= 'Jusdefruits',
            category= 'Boissons',
            price= 7,
        },
    },

    elementsAlcool = {
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Blonde.webp',
            label= 'Bière Blonde',
            givename= 'Blonde',
            price= 15,
            category= 'Alcool',
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Irish_coffee.webp',
            label= 'Irish Coffee',
            givename= 'irishc',
            category= 'Alcool',
            price= 15,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Camarade.webp',
            label= 'Camarade',
            givename= 'Camarade',
            category= 'Alcool',
            price= 17,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Jaggerbomb.webp',
            label= 'Jäggerbomb',
            givename= 'Jaggerbomb',
            category= 'Alcool',
            price= 15,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Vodka.webp',
            label= 'Vodka',
            givename= 'Vodka',
            category= 'Alcool',
            price= 15,
        },
        {
            id= 11,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Whisky.webp',
            label= 'Whisky',
            givename= 'Whisky',
            category= 'Alcool',
            price= 15,
        },
        {
            id= 12,
            image = 'assets/inventory/items/rhum.png',
            label= 'Rhum',
            givename= 'rhum',
            category= 'Alcool',
            price= 17,
        },
        {
            id= 13,
            image = 'assets/inventory/items/tequila.png',
            label= 'Tequila',
            givename= 'tequila',
            category= 'Alcool',
            price= 15,
        },
    },
}

-- Nourritures

local PopsDiner_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/header_popsdiner.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    elements = {
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Cesar.webp',
            label= 'César',
            givename= 'Cesar',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Hot_dog.webp',
            label= 'Hot Dog',
            givename= 'Hotdog',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Mozza_sticks.webp',
            label= 'Mozza Sticks',
            givename= 'Mozzasticks',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Pancakes.webp',
            label= 'Pancakes',
            givename= 'Pancakes',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/pizza-7945.webp',
            label= 'Pizza',
            givename= 'pizza-7945',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Pulled_Pork.webp',
            label= 'Pulled Pork',
            givename= 'PulledPork',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Sandwich.webp',
            label= 'Sandwich',
            givename= 'Sandwich',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 11,
            image= 'https://cdn.discordapp.com/attachments/1145780120846614598/1145780120993407096/png_20230828_171524_0000.png',
            label= 'Panini',
            givename= 'panini',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 12,
            image= 'https://cdn.discordapp.com/attachments/1145780120846614598/1145780120993407096/png_20230828_171524_0000.png',
            label= 'Frite',
            givename= 'frite',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 13,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Eggs_muffin.webp',
            label= 'Eggs Muffin',
            givename= 'Eggs_muffin',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 14,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/donutn.webp',
            label= 'Donuts',
            givename= 'donutn',
            category= 'Nourritures',
            price= 8,
        },
        {
            id= 15,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/Glace.webp',
            label= 'Glace Vanille',
            givename= 'vanilaicecream',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 16,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Waffle.webp',
            label= 'Gaufre',
            givename= 'Waffle',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 17,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Pancakes.webp',
            label= 'Crêpe',
            givename= 'Pancakes',
            category= 'Nourritures',
            price= 10,
        },
    },

    elementsBoissons = {
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Jus_de_fruits.webp',
            label= 'Jus de fruits',
            givename= 'Jusdefruits',
            category= 'Boissons',
            price= 7,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Limonade.webp',
            label= 'Limonade',
            givename= 'Limonade',
            category= 'Boissons',
            price= 7,
        },
        {
            id= 11,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Soda.webp',
            label= 'Soda',
            givename= 'Soda',
            category= 'Boissons',
            price= 7,
        },
        {
            id= 12,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Granita_upnatom.webp',
            label= 'Granita',
            givename= 'Granita_upnatom',
            category= 'Boissons',
            price=7,
        },
        {
            id= 13,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Milkshake_Hornys.webp',
            label= 'Milkshake',
            givename= 'Milkshake_Hornys',
            category= 'Boissons',
            price=7,
        },
        {
            id= 14,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Coffee_Hornys.webp',
            label= 'Café',
            givename= 'Coffee_Hornys',
            category= 'Boissons',
            price=7,
        },
    },

    elementsAlcool = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/911.webp',
            label= '911',
            givename= '911',
            category= 'Alcool',
            price= 12,
        },
        {
            id= 2,
            image = 'assets/inventory/items/beer.png',
            label= 'Bière',
            givename= 'beer',
            category= 'Alcool',
            price=11,
        },
    },
}

-- Boissons

-- Nourritures

local YellowJack_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/header_yellowjack.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Aperitifs.webp',
            label= 'Apéritifs',
            givename= 'Aperitifs',
            category= 'Nourritures',
            price= 10,
        },
    },

    elementsBoissons = {
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Limonade.webp',
            label= 'Limonade',
            givename= 'Limonade',
            category= 'Boissons',
            price= 7,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Jus_de_fruits.webp',
            label= 'Jus de fruits',
            givename= 'Jusdefruits',
            category= 'Boissons',
            price= 7,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Soda.webp',
            label= 'Soda',
            givename= 'Soda',
            category= 'Boissons',
            price= 7,
        },
    },

    elementsAlcool = {
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Blonde.webp',
            label= 'Bière Blonde',
            givename= 'Blonde',
            category= 'Alcool',
            price= 11,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Brune.webp',
            label= 'Bière Brune',
            givename= 'Brune',
            category= 'Alcool',
            price= 11,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Rousse.webp',
            label= 'Bière Rousse',
            givename= 'Rousse',
            category= 'Alcool',
            price= 11,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Ambree.webp',
            label= 'Bière Ambrée',
            givename= 'Ambree',
            category= 'Alcool',
            price= 11,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Shamrock.webp',
            label= 'Shamrock',
            givename= 'Shamrock',
            category= 'Alcool',
            price= 11,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/RhumCoke.webp',
            label= 'Rhum Coke',
            givename= 'RhumCoke',
            category= 'Alcool',
            price= 11,
        },
        {
            id= 11,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Pisse_d_ane.webp',
            label= 'Pisse d\'Âne',
            givename= 'Pissedane',
            category= 'Alcool',
            price= 17,
        },
    },

    elementsUtilitaires = {
        {
            id = 1,
            image = 'assets/LTD/cigar.png',
            label = 'Cigar',
            price = 5,
            givename = "cigar",
            category= 'Utilitaires'
        },
    },
}



local LTD_toSend = {
    headerImage = 'assets/LTD/header_ltd.jpg',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    elements = {
        {
            id = 1,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Chips.webp',
            label = 'Chips',
            price = 5,
            givename = "Chips",
            category= 'Nourritures'
        },
        {
            id = 2,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Sandwich_triangle.webp',
            label = 'Sandwich Triangle',
            price = 5,
            givename = "triangle",
            category= 'Nourritures'
        },
        {
            id = 3,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Sucette.webp',
            label = 'Sucette',
            price = 5,
            givename = "lollipop",
            category= 'Nourritures'
        },
        {
            id = 4,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Glace_a_l_italienne.webp',
            label = 'Glace a l\'Italienne',
            price = 5,
            givename = "GlaceItalienne",
            category= 'Nourritures'
        },
        {
            id = 5,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Barre_de_cereale.webp',
            label = 'Barre Céréales',
            price = 5,
            givename = "BarreCereale",
            category= 'Nourritures'
        },
    },

    elementsBoissons = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/lait_chocolat.webp',
            label= 'Lait Chocolat',
            givename= 'laitchoco',
            category= 'Boissons',
            price= 2,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Bouteille_petillante.webp',
            label= 'Eau Pétillante',
            givename= 'eaupetillante',
            category= 'Boissons',
            price= 2,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/bouteille_eau.webp',
            label= 'Bouteille d\'eau',
            givename= 'water',
            category= 'Boissons',
            price= 2,
        },
    },

    elementsUtilitaires = {
        {
            id = 1,
            image = 'assets/LTD/cigarettes.png',
            label = 'Cigarette',
            price = 5,
            givename = "cig",
            category= 'Utilitaires'
        },
        {
            id = 2,
            image = 'assets/LTD/Ciseaux.png',
            label = 'Ciseaux',
            price = 25,
            givename = "scissors",
            category= 'Utilitaires'
        }, 
        --{
        --    id = 1,
        --    image = 'assets/LTD/ordinateur.png',
        --    label = 'Ordinateur',
        --    price= 100,
        --    subCategory = 'CATALOGUE LTD',
        --    givename = "laptop"
        --},
        {
            id = 3,
            image = 'assets/LTD/Pince_a_cheveux.png',
            label = 'Pince à cheveux',
            givename = "pince",
            category= 'Utilitaires',
            price= 15
        },

        {
            id = 4,
            image = 'assets/inventory/items/can.png',
            label = 'Canette Vide',
            price = 5,
            givename = "can",
            category= 'Utilitaires'
        },

        {
            id = 5,
            image = 'assets/LTD/Recycleur.png',
            label = 'Recycleur',
            price = 325,
            givename = "recycleur",
            category= 'Utilitaires'
        }, 
        {
            id = 6,
            image = 'assets/LTD/Telephone.png',
            label = 'Téléphone',
            price = 25,
            givename = "phone",
            category= 'Utilitaires'
        }, 
        {
            id = 7,
            image = 'assets/inventory/items/boombox.png',
            label = 'Boombox',
            price = 50,
            givename = "boombox",
            category= 'Utilitaires'
        },

        {
            id = 8,
            image = 'assets/inventory/items/umbrella.png',
            label = 'Parapluie',
            price = 15,
            givename = "umbrella",
            category= 'Utilitaires'
        },

        {
            id = 9,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/bloc_note.webp',
            label = 'Bloc-note',
            price = 5,
            givename = "blocnote",
            category= 'Utilitaires'
        },
        {
            id = 10,
            image = 'assets/inventory/items/jumelle.png',
            label = 'Jumelle',
            price = 100,
            givename = "jumelle",
            category= 'Utilitaires'
        },
        {
            id = 11,
            image = 'assets/inventory/items/fishroad.png',
            label = 'Canne Pêche',
            price = 25,
            givename = "fishroad",
            category= 'Utilitaires'
        },
        {
            id = 12,
            image = 'assets/LTD/cigar.png',
            label = 'Cigar',
            price = 5,
            givename = "cigar",
            category= 'Utilitaires'
        },

--[[         {
            id = 13,
            image = 'assets/LTD/parachute.png',
            label = 'Parachute',
            price = 325,
            givename = "Gadget_parachute",
            category= 'Utilitaires'
        }, ]]


        {
            id = 14,
            image = 'assets/inventory/items/cleaner.png',
            label = 'Cleaner',
            price = 5,
            givename = "cleaner",
            category= 'Utilitaires'
        },

        {
            id = 15,
            image = 'assets/inventory/items/sactete.png',
            label = 'Sacs',
            price = 150,
            givename = "sactete",
            category= 'Utilitaires'
        },

        {
            id = 16,
            image = 'assets/inventory/items/gps.png',
            label = 'GPS',
            price = 25,
            givename = "gps",
            category= 'Utilitaires'
        },

        {
            id = 17,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/malettecuir.webp',
            label = 'Malette en Cuir',
            price = 150,
            givename = "malettecuir",
            category= 'Utilitaires'
        },
        {
            id = 18,
            image = 'assets/LTD/Radio.png',
            label = 'Radio',
            price = 25,
            givename = "radio",
            category= 'Utilitaires'
        }, 

    },
}

local Dons_toSend = {
    headerImage = 'assets/headers/header_donscountrystore.jpg',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    elements = {
        {
            id = 1,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Chips.webp',
            label = 'Chips',
            price = 5,
            givename = "Chips",
            category= 'Nourritures'
        },
        {
            id = 2,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Sandwich_triangle.webp',
            label = 'Sandwich Triangle',
            price = 5,
            givename = "triangle",
            category= 'Nourritures'
        },
        {
            id = 3,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Sucette.webp',
            label = 'Sucette',
            price = 5,
            givename = "lollipop",
            category= 'Nourritures'
        },
        {
            id = 4,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Glace_a_l_italienne.webp',
            label = 'Glace a l\'Italienne',
            price = 5,
            givename = "GlaceItalienne",
            category= 'Nourritures'
        },
        {
            id = 5,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Barre_de_cereale.webp',
            label = 'Barre Céréales',
            price = 5,
            givename = "BarreCereale",
            category= 'Nourritures'
        },

        {
            id = 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/twinkies.webp',
            label = 'Twinkies',
            price = 5,
            givename = "twinkies",
            category= 'Nourritures'
        },
    },

    elementsBoissons = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/lait_chocolat.webp',
            label= 'Lait Chocolat',
            givename= 'laitchoco',
            category= 'Boissons',
            price= 2,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Bouteille_petillante.webp',
            label= 'Eau Pétillante',
            givename= 'eaupetillante',
            category= 'Boissons',
            price= 2,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/bouteille_eau.webp',
            label= 'Bouteille d\'eau',
            givename= 'water',
            category= 'Boissons',
            price= 2,
        },
    },

    elementsUtilitaires = {
        {
            id = 1,
            image = 'assets/LTD/cigarettes.png',
            label = 'Cigarette',
            price = 5,
            givename = "cig",
            category= 'Utilitaires'
        },
        {
            id = 2,
            image = 'assets/LTD/Ciseaux.png',
            label = 'Ciseaux',
            price = 25,
            givename = "scissors",
            category= 'Utilitaires'
        }, 
        --{
        --    id = 1,
        --    image = 'assets/LTD/ordinateur.png',
        --    label = 'Ordinateur',
        --    price= 100,
        --    subCategory = 'CATALOGUE LTD',
        --    givename = "laptop"
        --},
        {
            id = 3,
            image = 'assets/LTD/Pince_a_cheveux.png',
            label = 'Pince à cheveux',
            givename = "pince",
            category= 'Utilitaires',
            price= 15
        },
        {
            id = 4,
            image = 'assets/LTD/Radio.png',
            label = 'Radio',
            price = 25,
            givename = "radio",
            category= 'Utilitaires'
        }, 
--[[         {
            id = 5,
            image = 'assets/LTD/Recycleur.png',
            label = 'Recycleur',
            price = 325,
            givename = "recycleur",
            category= 'Utilitaires'
        },  ]]
        {
            id = 5,
            image = 'assets/inventory/items/can.png',
            label = 'Canette Vide',
            price = 5,
            givename = "can",
            category= 'Utilitaires'
        },

        {
            id = 6,
            image = 'assets/LTD/Telephone.png',
            label = 'Téléphone',
            price = 25,
            givename = "phone",
            category= 'Utilitaires'
        }, 
        {
            id = 7,
            image = 'assets/inventory/items/boombox.png',
            label = 'Boombox',
            price = 50,
            givename = "boombox",
            category= 'Utilitaires'
        },

        {
            id = 8,
            image = 'assets/inventory/items/umbrella.png',
            label = 'Parapluie',
            price = 15,
            givename = "umbrella",
            category= 'Utilitaires'
        },

        {
            id = 9,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/bloc_note.webp',
            label = 'Bloc-note',
            price = 5,
            givename = "blocnote",
            category= 'Utilitaires'
        },
        {
            id = 10,
            image = 'assets/inventory/items/jumelle.png',
            label = 'Jumelle',
            price = 100,
            givename = "jumelle",
            category= 'Utilitaires'
        },
        {
            id = 11,
            image = 'assets/inventory/items/fishroad.png',
            label = 'Canne Pêche',
            price = 100,
            givename = "fishroad",
            category= 'Utilitaires'
        },
        {
            id = 12,
            image = 'assets/LTD/cigar.png',
            label = 'Cigar',
            price = 5,
            givename = "cigar",
            category= 'Utilitaires'
        },

        {
            id = 13,
            image = 'assets/LTD/parachute.png',
            label = 'Parachute',
            price = 325,
            givename = "gadget_parachute",
            category= 'Utilitaires'
        },


        {
            id = 14,
            image = 'assets/inventory/items/cleaner.png',
            label = 'Cleaner',
            price = 5,
            givename = "cleaner",
            category= 'Utilitaires'
        },

        {
            id = 15,
            image = 'assets/inventory/items/sactete.png',
            label = 'Sacs',
            price = 150,
            givename = "sactete",
            category= 'Utilitaires'
        },

        {
            id = 16,
            image = 'assets/inventory/items/gps.png',
            label = 'GPS',
            price = 25,
            givename = "gps",
            category= 'Utilitaires'
        },

        {
            id = 17,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/malettecuir.webp',
            label = 'Malette en Cuir',
            price = 150,
            givename = "malettecuir",
            category= 'Utilitaires'
        },


    },
}

local blackwood_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_blackwood.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Aperitifs.webp',
            label= 'Apéritifs',
            givename= 'Aperitifs',
            price= 10,
            category= 'Nourritures',
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Bretzel.webp',
            label= 'Bretzel',
            givename= 'Bretzel',
            category= 'Nourritures',
            price=10,
        },
    },

    elementsAlcool = {
        {
            id= 3,
            image = 'assets/inventory/items/beer.png',
            label= 'Bière',
            givename= 'beer',
            category= 'Alcool',
            price=11,
        },
        {
            id= 4,
            image = 'assets/inventory/items/vodka.png',
            label= 'Vodka',
            givename= 'Vodka',
            category= 'Alcool',
            price= 15,
        },
        {
            id= 5,
            image = 'assets/inventory/items/gin.png',
            label= 'Gin',
            givename= 'Gin',
            category= 'Alcool',
            price=22,
        },
        {
            id= 6,
            image = 'assets/inventory/items/rhum.png',
            label= 'Rhum',
            givename= 'rhum',
            category= 'Alcool',
            price= 17,
        },
        {
            id= 7,
            image = 'assets/inventory/items/whisky.png',
            label= 'Whisky',
            givename= 'Whisky',
            category= 'Alcool',
            price= 15,
        },
    },

    elementsBoissons = {
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Limonade.webp',
            label= 'Limonade',
            givename= 'Limonade',
            category= 'Boissons',
            price=7,
        },
    },
}

-- MECANO

local bennys_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_bennys.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elementsUtilitaires = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/weapon_petrolcan.webp',
            label= 'Bidon d\'essence',
            givename= 'weapon_petrolcan',
            price= 50,
            category= 'Utilitaires',
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/spray.webp',
            label= 'Bombe de peinture',
            givename= 'spray',
            price= 15,
            category= 'Utilitaires',
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/repairkit.webp',
            label= 'Kit de réparation',
            givename= 'repairkit',
            price= 250,
            category= 'Utilitaires',
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/cleankit.webp',
            label= 'Kit de nettoyage',
            givename= 'cleankit',
            price= 15,
            category= 'Utilitaires',
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/sangle.webp',
            label= 'Sangle',
            givename= 'sangle',
            price= 150,
            category= 'Utilitaires',
        },
    },
}

local hayesauto_toSend = {
    headerImage = 'https://media.discordapp.net/attachments/1142829822821797929/1146736570037194752/Ban_Hayes_Final.png',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elementsUtilitaires = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/weapon_petrolcan.webp',
            label= 'Bidon d\'essence',
            givename= 'weapon_petrolcan',
            price= 50,
            category= 'Utilitaires',
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/spray.webp',
            label= 'Bombe de peinture',
            givename= 'spray',
            price= 15,
            category= 'Utilitaires',
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/repairkit.webp',
            label= 'Kit de réparation',
            givename= 'repairkit',
            price= 250,
            category= 'Utilitaires',
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/cleankit.webp',
            label= 'Kit de nettoyage',
            givename= 'cleankit',
            price= 15,
            category= 'Utilitaires',
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/sangle.webp',
            label= 'Sangle',
            givename= 'sangle',
            price= 150,
            category= 'Utilitaires',
        },
    },
}

local beekersgarage_toSend = {
    headerImage = 'https://media.discordapp.net/attachments/1142829822821797929/1146736522419249223/Ban_Beekers_Final.png',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elementsUtilitaires = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/weapon_petrolcan.webp',
            label= 'Bidon d\'essence',
            givename= 'weapon_petrolcan',
            price= 50,
            category= 'Utilitaires',
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/spray.webp',
            label= 'Bombe de peinture',
            givename= 'spray',
            price= 15,
            category= 'Utilitaires',
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/repairkit.webp',
            label= 'Kit de réparation',
            givename= 'repairkit',
            price= 250,
            category= 'Utilitaires',
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/cleankit.webp',
            label= 'Kit de nettoyage',
            givename= 'cleankit',
            price= 15,
            category= 'Utilitaires',
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/sangle.webp',
            label= 'Sangle',
            givename= 'sangle',
            price= 150,
            category= 'Utilitaires',
        },
    },
}

local sunshine_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_sunshine.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elementsUtilitaires = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/weapon_petrolcan.webp',
            label= 'Bidon d\'essence',
            givename= 'weapon_petrolcan',
            price= 50,
            category= 'Utilitaires',
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/spray.webp',
            label= 'Bombe de peinture',
            givename= 'spray',
            price= 15,
            category= 'Utilitaires',
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/repairkit.webp',
            label= 'Kit de réparation',
            givename= 'repairkit',
            price= 250,
            category= 'Utilitaires',
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/cleankit.webp',
            label= 'Kit de nettoyage',
            givename= 'cleankit',
            price= 15,
            category= 'Utilitaires',
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/sangle.webp',
            label= 'Sangle',
            givename= 'sangle',
            price= 150,
            category= 'Utilitaires',
        },
    },
}

local harmony_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_harmonyrepair.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elementsUtilitaires = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/weapon_petrolcan.webp',
            label= 'Bidon d\'essence',
            givename= 'weapon_petrolcan',
            price= 50,
            category= 'Utilitaires',
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/spray.webp',
            label= 'Bombe de peinture',
            givename= 'spray',
            price= 15,
            category= 'Utilitaires',
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/repairkit.webp',
            label= 'Kit de réparation',
            givename= 'repairkit',
            price= 250,
            category= 'Utilitaires',
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/cleankit.webp',
            label= 'Kit de nettoyage',
            givename= 'cleankit',
            price= 15,
            category= 'Utilitaires',
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/sangle.webp',
            label= 'Sangle',
            givename= 'sangle',
            price= 150,
            category= 'Utilitaires',
        },
    },
}

local Pizzeria_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_pizzeria.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/pizzaburata.webp',
            label= 'Pizza Burata',
            givename= 'pizzaburata',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/pizzamarghe.webp',
            label= 'Pizza Margherita',
            givename= 'pizzamarghe',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/pizza4fromage.webp',
            label= 'Pizza 4 fromages',
            givename= 'pizza4fromage',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/pizzachevre.webp',
            label= 'Pizza Chèvre Miel',
            givename= 'pizzachevre',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/crostini.webp',
            label= 'Crostini',
            givename= 'crostini',
            category= 'Nourritures',
            price= 15,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/tiramisu.webp',
            label= 'Tiramisu',
            givename= 'tiramisu',
            category= 'Nourritures',
            price= 15,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/pizzaburata.webp',
            label= 'Salade Burata',
            givename= 'saladeburata',
            category= 'Nourritures',
            price= 15,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/pizzanutella.webp',
            label= 'Pizza Nutella',
            givename= 'pizzanutella',
            category= 'Nourritures',
            price= 15,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/saladedefruit.webp',
            label= 'Salade de fruits',
            givename= 'saladedefruit',
            category= 'Nourritures',
            price= 15,
        },
    },

    elementsBoissons = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/bouteille_eau.webp',
            label= 'Eau',
            givename= 'water',
            category= 'Boissons',
            price=5,
        },
        {
            id=2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/soda.webp',
            label= 'Sprunk',
            givename= 'sprunk',
            category= 'Boissons',
            price=7,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/soda.webp',
            label= 'E-cola',
            givename= 'ecola',
            category= 'Boissons',
            price=7,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Limonade.webp',
            label= 'Limonade',
            givename= 'Limonade',
            category= 'Boissons',
            price=7,
        },

    }
}

local Pearl_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_pearl.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/Crevettes.webp',
            label= 'Crevettes',
            givename= 'Crevettes',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/FishBowl.webp',
            label= 'FishBowl',
            givename= 'FishBowl',
            category= 'Nourritures',
            price= 7,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/Huitres.webp',
            label= 'Huitres',
            givename= 'Huitres',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/Moules.webp',
            label= 'Moules',
            givename= 'Moules',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/Fruits_de_mer.webp',
            label= 'Plateau des mers',
            givename= 'seafood-in-wood-',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/Tarte_au_Citron.webp',
            label= 'Tarte au Citron',
            givename= 'Tarte_au_Citron',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/Glace.webp',
            label= 'Glace Vanille',
            givename= 'vanilaicecream',
            category= 'Nourritures',
            price= 10,
        },
    },

    elementsBoissons = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Limonade.webp',
            label= 'Limonade',
            givename= 'Limonade',
            category= 'Boissons',
            price=7,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/Cocktail.webp',
            label= 'Cocktail',
            givename= 'Cocktail',
            category= 'Boissons',
            price= 15,
        },
    },

    elementsAlcool = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Vin_blanc.webp',
            label= 'Vin Blanc',
            givename= 'Vinblanc',
            category= 'Boissons',
            price=17,
        },
        {
            id=2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Vin_rouge.webp',
            label= 'Vin Rouge',
            givename= 'Vinrouge',
            category= 'Boissons',
            price=17,
        },
    },
}

local Hornys_toSend = {
    headerImage = 'https://media.discordapp.net/attachments/1119362132639748167/1145877303549755483/bannierehornys.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Frites_Hornys.webp',
            label= 'Frites',
            givename= 'Frites_Hornys',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Batonspoulet_Hornys.webp',
            label= 'Batons de Poulet',
            givename= 'Batonspoulet_Hornys',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Burgerpoulet_Hornys.webp',
            label= 'Burger Poulet',
            givename= 'Burgerpoulet_Hornys',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Wrappoulet_Hornys.webp',
            label= 'Wrap Poulet',
            givename= 'Wrappoulet_Hornys',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Pignonpoulet_Hornys.webp',
            label= 'Pignon de Poulet',
            givename= 'Pignonpoulet_Hornys',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Donut_Hornys.webp',
            label= 'Donut',
            givename= 'Donut_Hornys',
            category= 'Nourritures',
            price= 10,
        },
    },

    elementsBoissons = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Milkshake_Hornys.webp',
            label= 'Milkshake',
            givename= 'Milkshake_Hornys',
            category= 'Boissons',
            price=7,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Coffee_Hornys.webp',
            label= 'Café',
            givename= 'Coffee_Hornys',
            category= 'Boissons',
            price=7,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Soda_Hornys.webp',
            label= 'Soda',
            givename= 'Soda_Hornys',
            category= 'Boissons',
            price=7,
        },
    },
}
local Upnatom_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_upnatom.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Frites_zigzag.webp',
            label= 'Frites Zigzag',
            givename= 'Frites_zigzag',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Onion_rings.webp',
            label= 'Onion Rings',
            givename= 'Onion_rings',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Eggs_muffin.webp',
            label= 'Eggs Muffin',
            givename= 'Eggs_muffin',
            category= 'Nourritures',
            price= 10,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Black_burger.webp',
            label= 'Black Burger',
            givename= 'Black_burger',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Burger_Uranus.webp',
            label= 'Saturne Burger',
            givename= 'Burger_Uranus',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Burger_earth.webp',
            label= 'Earth Burger',
            givename= 'Burger_earth',
            category= 'Nourritures',
            price= 20,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Cup_space.webp',
            label= 'Cup Space',
            givename= 'Cup_space',
            category= 'Nourritures',
            price= 10,
        },
    },

    elementsBoissons = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Granita_upnatom.webp',
            label= 'Granita',
            givename= 'Granita_upnatom',
            category= 'Boissons',
            price=7,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Ice_cup.webp',
            label= 'Ice Cup',
            givename= 'Ice_cup',
            category= 'Boissons',
            price=7,
        },
    },
}

function OpenPostOPCatalogue(catChoice)
    if catChoice == 'UwUcafe' then
        toSend = UwUcafe_toSend
    elseif catChoice == 'BeanMachine' then
        toSend = BeanMachine_toSend
    elseif catChoice == 'LeMiroir' then
        toSend = LeMiroir_toSend
    elseif catChoice == 'Unicorn' then
        toSend = VanillaUnicorn_toSend
    elseif catChoice == 'CluckinBell' then
        toSend = CluckinBell_toSend
    elseif catChoice == 'PopsDiner' then
        toSend = PopsDiner_toSend
    elseif catChoice == 'BurgerShot' then
        toSend = BurgerShot_toSend
    elseif catChoice == 'YellowJack' then
        toSend = YellowJack_toSend
    elseif catChoice == 'BayviewLodge' then
        toSend = BayviewLodge_toSend
    elseif catChoice == 'pizzeria' then
        toSend = Pizzeria_toSend
    elseif catChoice == 'pearl' then
        toSend = Pearl_toSend
    elseif catChoice == 'upnatom' then
        toSend = Upnatom_toSend
    elseif catChoice == 'hornys' then
        toSend = Hornys_toSend
    elseif catChoice == 'Bahamas' then
        toSend = BahamaMamas_toSend
    elseif catChoice == 'Comrades' then
        toSend = ComradesBar_toSend
    elseif catChoice == 'ltdsud' then
        toSend = LTD_toSend
    elseif catChoice == 'ltdmirror' then
        toSend = LTD_toSend
    elseif catChoice == 'don' then
        toSend = Dons_toSend
    elseif catChoice == 'blackwood' then
        toSend = blackwood_toSend
    elseif catChoice == 'bennys' then
        toSend = bennys_toSend
    elseif catChoice == 'hayes' then
        toSend = hayesauto_toSend
    elseif catChoice == 'beekers' then
        toSend = beekersgarage_toSend
    elseif catChoice == 'sunshine' then
        toSend = sunshine_toSend
    elseif catChoice == 'harmony' then
        toSend = harmony_toSend
    elseif catChoice == 'tacosrancho' then
        toSend = Tacos2Rancho_toSend
    end

    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'MenuCatalogue',
        data = toSend
    }));
    forceHideRadar()
end

RegisterNUICallback("focusOut", function (data, cb)
    TriggerScreenblurFadeOut(0.5)
    DisplayHud(true)
    openRadarProperly()
end)

function GetCataloguePostOPItems(job)
    local toSend;

    -- print('TEST OUAIS', json.encode(job))

    if job == 'uwu' then
        toSend = UwUcafe_toSend
    elseif job == 'beanmachine' then
        toSend = BeanMachine_toSend
    elseif job == 'lemiroir' then
        toSend = LeMiroir_toSend
    elseif job == 'unicorn' then
        toSend = VanillaUnicorn_toSend
    elseif job == 'cluckinbell' then
        toSend = CluckinBell_toSend
    elseif job == 'popsdiner' then
        toSend = PopsDiner_toSend
    elseif job == 'burgershot' then
        toSend = BurgerShot_toSend
    elseif job == 'yellowjack' then
        toSend = YellowJack_toSend
    elseif job == 'bayviewLodge' then
        toSend = BayviewLodge_toSend
    elseif job == 'bahamas' then
        toSend = BahamaMamas_toSend
    elseif job == 'comrades' then
        toSend = ComradesBar_toSend
    elseif job == 'ltdsud' then
        toSend = LTD_toSend
    elseif job == 'ltdmirror' then
        toSend = LTD_toSend
    elseif job == 'don' then
        toSend = Dons_toSend
    elseif job == 'blackwood' then
        toSend = blackwood_toSend
    elseif job == 'bennys' then
        toSend = bennys_toSend
    elseif job == 'hayes' then
        toSend = hayesauto_toSend
    elseif job == 'beekers' then
        toSend = beekersgarage_toSend
    elseif job == 'sunshine' then
        toSend = sunshine_toSend
    elseif job == 'harmony' then
        toSend = harmony_toSend
    elseif job == 'pizzeria' then
        toSend = Pizzeria_toSend
    elseif job == 'pearl' then
        toSend = Pearl_toSend
    elseif job == 'upnatom' then
        toSend = Upnatom_toSend
    elseif job == 'hornys' then
        toSend = Hornys_toSend
    elseif job == 'tacosrancho' then
        toSend = Tacos2Rancho_toSend
    end

    return toSend
end