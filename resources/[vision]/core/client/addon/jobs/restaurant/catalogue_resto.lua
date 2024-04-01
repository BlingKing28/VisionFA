local toSend = nil

local UwUcafe_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/header_uwucoffee.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/BarbaMilk.webp',
            label= 'BarbaMilk',
            price=60,
            ItemCategory= 'Boissons',
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Bubble_Tea.webp',
            label= 'Bubble Tea',
            price=60,
            ItemCategory= 'Boissons',
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/CatPat.webp',
            label= 'CatPat',
            price=90,
            ItemCategory= 'Nourritures',
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Chat_Gourmand.webp',
            label= 'Chat Gourmand',
            ItemCategory= 'Nourritures',
            price=100,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Chatmallow.webp',
            label= 'Chatmallow',
            ItemCategory= 'Boissons',
            price=80,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Ice_Coffee.webp',
            label= 'Ice Coffee',
            ItemCategory= 'Boissons',
            price=50,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/IceCream_Cat.webp',
            label= 'IceCream Cat',
            ItemCategory= 'Boissons',
            price=80,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Lailait_chaud.webp',
            label= 'Lailait chaud',
            ItemCategory= 'Boissons',
            price=70,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Milkshake.webp',
            label= 'Milkshake',
            ItemCategory= 'Boissons',
            price=60,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Mochi.webp',
            label= 'Mochi',
            ItemCategory= 'Nourritures',
            price=70,
        },
        {
            id= 11,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Pocky.webp',
            label= 'Pocky',
            ItemCategory= 'Nourritures',
            price=60,
        },
        {
            id= 12,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/UwU_Burger-removebg-preview.webp',
            label= 'UwU Burger',
            ItemCategory= 'Nourritures',
            price=100,
        },
        {
            id= 13,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/melto.webp',
            label= 'Melto',
            ItemCategory= 'Nourritures',
            price=100,
        },
        {
            id= 14,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/lapinut.webp',
            label= 'Lapinut',
            ItemCategory= 'Nourritures',
            price=75,
        },
        {
            id= 15,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/LatteMatcha.webp',
            label= 'Latte Matcha',
            ItemCategory= 'Boissons',
            price=70,
        },
        {
            id= 16,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy.webp',
            label= 'Kitty Toy',
            ItemCategory= 'Utilitaires',
            price=7,
        },
        {
            id= 17,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy_Arc_En_Ciel.webp',
            label= 'Kitty Toy Arc-en-ciel',
            ItemCategory= 'Utilitaires',
            price=7,
        },
        {
            id= 18,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy_Bleu.webp',
            label= 'Kitty Toy Bleu',
            ItemCategory= 'Utilitaires',
            price=7,
        },
        {
            id= 19,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy_Dark.webp',
            label= 'Kitty Toy Dark',
            ItemCategory= 'Utilitaires',
            price=7,
        },
        {
            id= 20,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy_Flower.webp',
            label= 'Kitty Toy Flower',
            ItemCategory= 'Utilitaires',
            price=7,
        },
        {
            id= 21,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy_Gris.webp',
            label= 'Kitty Toy Gris',
            ItemCategory= 'Utilitaires',
            price=7,
        },
        {
            id= 22,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy_Jaune.webp',
            label= 'Kitty Toy Jaune',
            ItemCategory= 'Utilitaires',
            price=7,
        },
        {
            id= 23,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/uwu/Kitty_Toy_Vert-removebg-preview.webp',
            label= 'Kitty Toy Vert',
            ItemCategory= 'Utilitaires',
            price=7,
        },
    },
}

local VanillaUnicorn_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/header_unicorn.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Aperitifs.webp',
            label= 'Apéritifs',
            ItemCategory= 'Nourritures',
            price=20,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Cool_Granny.webp',
            label= 'Cool Granny',
            ItemCategory= 'Alcool',
            price=45,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Doudou.webp',
            label= 'Doudou',
            ItemCategory= 'Alcool',
            price=45,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/French_Kiss.webp',
            label= 'French Kiss',
            ItemCategory= 'Alcool',
            price=45,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Red_Velvet.webp',
            label= 'Red Velvet',
            ItemCategory= 'Alcool',
            price=45,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Sex_on_the_beach.webp',
            label= 'Sex On The Beach',
            ItemCategory= 'Alcool',
            price=45,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Uni_tail.webp',
            label= 'Uni Tail',
            ItemCategory= 'Alcool',
            price=75,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Limonade.webp',
            label= 'Limonade',
            ItemCategory= 'Boissons',
            price=10,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Jus_de_fruits.webp',
            label= 'Jus de fruits',
            ItemCategory= 'Boissons',
            price=10,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Soda.webp',
            label= 'Soda',
            ItemCategory= 'Boissons',
            price=10,
        },
    },
}

local BeanMachine_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/header_beanmachine.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Cafe_frappe.webp',
            label= 'Café frappé',
            ItemCategory= 'Boissons',
            price=5,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Cafe_praline.webp',
            label= 'Café praliné',
            ItemCategory= 'Boissons',
            price=5,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Cappuccino.webp',
            label= 'Cappuccino',
            ItemCategory= 'Boissons',
            price=5,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Caramel_macchiato.webp',
            label= 'Caramel macchiato',
            ItemCategory= 'Boissons',
            price=10,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Choco_guimauve.webp',
            label= 'Choco guimauve',
            ItemCategory= 'Boissons',
            price=10,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Theglace.webp',
            label= 'Thé glacé',
            ItemCategory= 'Boissons',
            price= 10,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Chocolat_viennois.webp',
            label= 'Chocolat viennois',
            ItemCategory= 'Boissons',
            price=10,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Cookie.webp',
            label= 'Cookie',
            ItemCategory= 'Nourritures',
            price=10,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Expresso.webp',
            label= 'Expresso',
            ItemCategory= 'Boissons',
            price=5,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Latte.webp',
            label= 'Latte',
            ItemCategory= 'Boissons',
            price=5,
        },
        {
            id= 11,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Muffin_choco.webp',
            label= 'Muffin choco',
            ItemCategory= 'Nourritures',
            price=10,
        },
        {
            id= 12,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Oeufsbacon.webp',
            label= 'Oeufs bacon',
            ItemCategory= 'Nourritures',
            price= 30,
        },
        {
            id= 13,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/donutc.webp',
            label= 'Donuts Chocolat',
            ItemCategory= 'Nourritures',
            price= 16,
        },
        {
            id= 14,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/donutn.webp',
            label= 'Donuts Nature',
            ItemCategory= 'Nourritures',
            price= 16,
        },
        {
            id= 15,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/Cheesecake.webp',
            label= 'Cheesecake',
            ItemCategory= 'Nourritures',
            price= 20,
        },
    },
}

local LeMiroir_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/header_lemiroir.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Fondant_chocolat.webp',
            label= 'Fondant au chocolat',
            ItemCategory= 'Nourritures',
            price=10,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Waffle.webp',
            label= 'Gaufre',
            ItemCategory= 'Nourritures',
            price=10,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Moules_frites.webp',
            label= 'Moules frites',
            ItemCategory= 'Nourritures',
            price=30,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Plateau_de_charcuterie.webp',
            label= 'Plateau de charcuterie',
            ItemCategory= 'Nourritures',
            price=10,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/escalope.webp',
            label= 'Escalope',
            ItemCategory= 'Nourritures',
            price=30,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/seafoodInWood.webp',
            label= 'Plateau des mers',
            ItemCategory= 'Nourritures',
            price=30,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/American_ribs.webp',
            label= 'American ribs',
            ItemCategory= 'Nourritures',
            price=30,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/champagne.webp',
            label= 'Champagne',
            ItemCategory= 'Alcool',
            price=50,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Vin_blanc.webp',
            label= 'Vin Blanc',
            ItemCategory= 'Alcool',
            price=45,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Vin_rouge.webp',
            label= 'Vin Rouge',
            ItemCategory= 'Alcool',
            price=45,
        },
        {
            id= 11,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Limonade.webp',
            label= 'Limonade',
            ItemCategory= 'Boissons',
            price=10,
        },
        {
            id= 12,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Jus_de_fruits.webp',
            label= 'Jus de fruits',
            ItemCategory= 'Boissons',
            price=10,
        },
        {
            id= 13,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Soda.webp',
            label= 'Soda',
            ItemCategory= 'Boissons',
            price=10,
        },
        
        {
            id= 14,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/caviar.webp',
            label= 'Caviar',
            ItemCategory= 'Nourritures',
            price= 20,
        },

        {
            id= 15,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/magret.webp',
            label= 'Magret',
            ItemCategory= 'Nourritures',
            price= 40,
        },

        {
            id= 16,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/foiegras.webp',
            label= 'Foie Gras',
            ItemCategory= 'Nourritures',
            price= 40,
        },
    },
}

local CluckinBell_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/header_cluckinbell.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_bucket.webp',
            label= 'Buckets',
            ItemCategory= 'Nourritures',
            price=30,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_burg.webp',
            label= 'Burger',
            ItemCategory= 'Nourritures',
            price=30,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_fowl.webp',
            label= 'Volaille à croquer',
            ItemCategory= 'Nourritures',
            price=10,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_fries.webp',
            label= 'Frites',
            ItemCategory= 'Nourritures',
            price=10,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_kids.webp',
            label= 'Menu Enfant',
            ItemCategory= 'Nourritures',
            price=30,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_rings.webp',
            label= 'Onion Rings',
            ItemCategory= 'Nourritures',
            price=10,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_salad.webp',
            label= 'Salade',
            ItemCategory= 'Nourritures',
            price=30,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_soup.webp',
            label= 'Soupe',
            ItemCategory= 'Nourritures',
            price=10,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/cluckinbell/gn_cluckin_cup.webp',
            label= 'Soda',
            ItemCategory= 'Boissons',
            price=10,
        },
    },
}

local BahamaMamas_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/header_bahamamamas.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Bloody_Mary.webp',
            label= 'Bloody Mary',
            ItemCategory= 'Alcool',
            price=45,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Blue-Mamas.webp',
            label= 'Blue-Mamas',
            ItemCategory= 'Alcool',
            price=75,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Gin.webp',
            label= 'Gin',
            ItemCategory= 'Alcool',
            price=45,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Jus_de_fruits.webp',
            label= 'Jus de fruits',
            ItemCategory= 'Boissons',
            price=10,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Limonade.webp',
            label= 'Limonade',
            ItemCategory= 'Boissons',
            price=10,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Mojito.webp',
            label= 'Mojito',
            ItemCategory= 'Alcool',
            price=45,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Punch.webp',
            label= 'Punch',
            ItemCategory= 'Alcool',
            price=45,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Soda.webp',
            label= 'Soda',
            ItemCategory= 'Boissons',
            price=10,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/White_Lady.webp',
            label= 'White Lady',
            ItemCategory= 'Alcool',
            price=45,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Tapas.webp',
            label= 'Tapas',
            ItemCategory= 'Nourritures',
            price=10,
        },
    },
}

local BayviewLodge_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/header_bayviewlodge.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Applepie.webp',
            label= 'Apple pie',
            ItemCategory= 'Nourritures',
            price=10,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Poutine.webp',
            label= 'Poutine',
            ItemCategory= 'Nourritures',
            price=30,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Saucisson.webp',
            label= 'Saucisson',
            ItemCategory= 'Nourritures',
            price=10,
        },
        
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Pancakes.webp',
            label= 'Pancakes',
            ItemCategory= 'Nourritures',
            price= 15,
        },

        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Entrecote.webp',
            label= 'Entrecôte',
            ItemCategory= 'Nourritures',
            price= 30,
        },

        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Oeufsbacon.webp',
            label= 'Oeufs bacon',
            ItemCategory= 'Nourritures',
            price= 30,
        },

        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Mac&cheese.webp',
            label= 'Mac & cheese',
            ItemCategory= 'Nourritures',
            price= 30,
        },

        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Jus_de_fruits.webp',
            label= 'Jus de fruits',
            ItemCategory= 'Boissons',
            price=10,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Limonade.webp',
            label= 'Limonade',
            ItemCategory= 'Boissons',
            price=10,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/BayviewBeer.webp',
            label= 'Bayview Beer',
            ItemCategory= 'Alcool',
            price=45,
        },
        {
            id= 11,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/DuffBeer.webp',
            label= 'Duff Beer',
            ItemCategory= 'Alcool',
            price=45,
        },
        {
            id= 13,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Blonde.webp',
            label= 'Bière Blonde',
            ItemCategory= 'Alcool',
            price=15,
        },
        {
            id= 14,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Hydromel.webp',
            label= 'Hydromel',
            givename= 'Hydromel',
            ItemCategory= 'Alcool',
            price= 20,
        },
    },
}

local BurgerShot_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/header_burgershot.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/fries_box.webp',
            label= 'Frites',
            ItemCategory= 'Nourritures',
            price= 10,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/chicken_wrap.webp',
            label= 'Wrap Poulet',
            ItemCategory= 'Nourritures',
            price= 30,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/the_simply_burger.webp',
            label= 'Fishburger',
            ItemCategory= 'Nourritures',
            price= 30,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/the_glorious_burger.webp',
            label= 'Cheeseburger',
            ItemCategory= 'Nourritures',
            price= 30,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/double_shot_burger.webp',
            label= 'Double Cheese',
            ItemCategory= 'Nourritures',
            price= 30,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/soda.webp',
            label= 'Soda',
            ItemCategory= 'Boissons',
            price= 10,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/soda.webp',
            label= 'Limonade',
            ItemCategory= 'Boissons',
            price= 10,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/soda.webp',
            label= 'Jus',
            ItemCategory= 'Boissons',
            price= 10,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/meteorite_icecream.webp',
            label= 'Glace Meteorite',
            ItemCategory= 'Nourritures',
            price= 10,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/orangotang_icecream.webp',
            label= 'Glace Orangotang',
            ItemCategory= 'Nourritures',
            price= 10,
        },
        {
            id= 11,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/goat_cheese_wrap.webp',
            label= 'Wrap Chèvre',
            ItemCategory= 'Nourritures',
            price= 30,
        },
        {
            id= 12,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/tacos.webp',
            label= 'Tacos',
            ItemCategory= 'Nourritures',
            price= 10,
        },
        {
            id= 13,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/the_fabulous_6lb_burger.webp',
            label= 'Fabulous Burger',
            ItemCategory= 'Nourritures',
            price= 30,
        },
        {
            id= 14,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/bleeder_burger.webp',
            label= 'Bleeder Burger',
            ItemCategory= 'Nourritures',
            price= 30,
        },
        {
            id= 15,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/prickly_burger.webp',
            label= 'Prickly Burger',
            ItemCategory= 'Nourritures',
            price= 30,
        },
    },
}

local domaine_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_vignoble.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image = 'assets/inventory/items/beer.png',
            label= 'Bière',
            ItemCategory= 'Alcool',
        },
        {
            id= 2,
            image = 'assets/inventory/items/jet27.png',
            label= 'Jet 27',
            ItemCategory= 'Alcool',
        },
        {
            id= 3,
            image = 'assets/inventory/items/vodka.png',
            label= 'Vodka',
            ItemCategory= 'Alcool',
        },
        {
            id= 4,
            image = 'assets/inventory/items/gin.png',
            label= 'Gin',
            ItemCategory= 'Alcool',
        },
        {
            id= 5,
            image = 'assets/inventory/items/rhum.png',
            label= 'Rhum',
            ItemCategory= 'Alcool',
        },
        {
            id= 6,
            image = 'assets/inventory/items/tequila.png',
            label= 'Tequila',
            ItemCategory= 'Alcool',
        },
        {
            id= 7,
            image = 'assets/inventory/items/Vinblanc.png',
            label= 'Vin blanc',
            ItemCategory= 'Alcool',
        },
        {
            id= 8,
            image = 'assets/inventory/items/Vinrouge.png',
            label= 'Vin rouge',
            ItemCategory= 'Alcool',
        },
        {
            id= 9,
            image = 'assets/inventory/items/whisky.png',
            label= 'Whisky',
            ItemCategory= 'Alcool',
        },
    },
}

local ComradesBar_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/header_comradesbar.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Aperitifs.webp',
            label= 'Apéritifs',
            price= 20,
            ItemCategory= 'Nourritures',
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Blonde.webp',
            label= 'Bière Blonde',
            price= 25,
            ItemCategory= 'Alcool',
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Camarade.webp',
            label= 'Camarade',
            price= 35,
            ItemCategory= 'Alcool',
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Irish_coffee.webp',
            label= 'Irish Coffee',
            price= 25,
            ItemCategory= 'Alcool',
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Jaggerbomb.webp',
            label= 'Jäggerbomb',
            ItemCategory= 'Alcool',
            price= 25,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Soda.webp',
            label= 'Soda',
            ItemCategory= 'Boissons',
            price= 10,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Limonade.webp',
            label= 'Limonade',
            ItemCategory= 'Boissons',
            price= 10,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Jus_de_fruits.webp',
            label= 'Jus de fruits',
            ItemCategory= 'Boissons',
            price= 10,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Vodka.webp',
            label= 'Vodka',
            ItemCategory= 'Alcool',
            price= 25,
        },
        {
            id= 11,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/comrades/Whisky.webp',
            label= 'Whisky',
            ItemCategory= 'Alcool',
            price= 25,
        },
        {
            id= 12,
            image = 'assets/inventory/items/rhum.png',
            label= 'Rhum',
            ItemCategory= 'Alcool',
            price= 27,
        },
        {
            id= 13,
            image = 'assets/inventory/items/tequila.png',
            label= 'Tequila',
            ItemCategory= 'Alcool',
            price= 25,
        },
    },
}

local PopsDiner_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/header_popsdiner.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/911.webp',
            label= '911',
            ItemCategory= 'Alcool',
            price= 15,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Cesar.webp',
            label= 'César',
            ItemCategory= 'Nourritures',
            price= 10,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Hot_dog.webp',
            label= 'Hot Dog',
            ItemCategory= 'Nourritures',
            price= 10,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Jus_de_fruits.webp',
            label= 'Jus de fruits',
            ItemCategory= 'Boissons',
            price= 10,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Limonade.webp',
            label= 'Limonade',
            ItemCategory= 'Boissons',
            price= 10,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Mozza_sticks.webp',
            label= 'Mozza Sticks',
            ItemCategory= 'Nourritures',
            price= 10,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Pancakes.webp',
            label= 'Pancakes',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/pizza-7945.webp',
            label= 'Pizza',
            ItemCategory= 'Nourritures',
            price= 30,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Pulled_Pork.webp',
            label= 'Pulled Pork',
            ItemCategory= 'Nourritures',
            price= 30,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Sandwich.webp',
            label= 'Sandwich',
            ItemCategory= 'Nourritures',
            price= 30,
        },
        {
            id= 11,
            image= 'https://cdn.discordapp.com/attachments/1145780120846614598/1145780120993407096/png_20230828_171524_0000.png',
            label= 'Panini',
            ItemCategory= 'Nourritures',
            price= 30,
        },
        {
            id= 12,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/popsdiner/Soda.webp',
            label= 'Soda',
            ItemCategory= 'Boissons',
            price= 10,
        },
        {
            id= 13,
            image= 'https://cdn.discordapp.com/attachments/1145780120846614598/1145780120993407096/png_20230828_171524_0000.png',
            label= 'Frite',
            ItemCategory= 'Nourritures',
            price= 20,
        },
        {
            id= 14,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Eggs_muffin.webp',
            label= 'Eggs Muffin',
            ItemCategory= 'Nourritures',
            price= 10,
        },
        {
            id= 15,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/beanmachine/donutn.webp',
            label= 'Donuts',
            ItemCategory= 'Nourritures',
            price= 8,
        },
        {
            id= 16,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/Glace.webp',
            label= 'Glace Vanille',
            ItemCategory= 'Nourritures',
            price= 10,
        },
        {
            id= 17,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Waffle.webp',
            label= 'Gaufre',
            ItemCategory= 'Nourritures',
            price= 10,
        },
        {
            id= 18,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Pancakes.webp',
            label= 'Crêpe',
            ItemCategory= 'Nourritures',
            price= 10,
        },
        {
            id= 19,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Granita_upnatom.webp',
            label= 'Granita',
            ItemCategory= 'Boissons',
            price=7,
        },
        {
            id= 20,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Milkshake_Hornys.webp',
            label= 'Milkshake',
            ItemCategory= 'Boissons',
            price=7,
        },
        {
            id= 21,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Coffee_Hornys.webp',
            label= 'Café',
            ItemCategory= 'Boissons',
            price=7,
        },
    },
}

local YellowJack_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/header_yellowjack.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Aperitifs.webp',
            label= 'Apéritifs',
            ItemCategory= 'Nourritures',
            price= 20,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Blonde.webp',
            label= 'Bière Blonde',
            ItemCategory= 'Alcool',
            price= 22,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Brune.webp',
            label= 'Bière Brune',
            ItemCategory= 'Alcool',
            price= 22,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Rousse.webp',
            label= 'Bière Rousse',
            ItemCategory= 'Alcool',
            price= 22,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Ambree.webp',
            label= 'Bière Ambrée',
            ItemCategory= 'Alcool',
            price= 22,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Pisse_d_ane.webp',
            label= 'Pisse d\'Âne',
            ItemCategory= 'Alcool',
            price= 35,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Shamrock.webp',
            label= 'Shamrock',
            ItemCategory= 'Alcool',
            price= 22,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/RhumCoke.webp',
            label= 'Rhum Coke',
            ItemCategory= 'Alcool',
            price= 22,
        },
        {
            id= 11,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Limonade.webp',
            label= 'Limonade',
            ItemCategory= 'Boissons',
            price= 10,
        },
        {
            id= 12,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Jus_de_fruits.webp',
            label= 'Jus de fruits',
            ItemCategory= 'Boissons',
            price= 10,
        },
        {
            id= 13,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/yellowjack/Soda.webp',
            label= 'Soda',
            ItemCategory= 'Boissons',
            price= 10,
        },
        {
            id = 14,
            image = 'assets/inventory/items/cigar.png',
            label = 'Cigar',
            price = 10,
            givename = "cigar",
            ItemCategory= 'Utilitaires'
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
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Sucette.webp',
            label = 'Sucette',
            price = 5,
            givename = "lollipop",
            ItemCategory = 'Nourritures'
        },
        {
            id = 2,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Glace_a_l_italienne.webp',
            label = 'Glace a l\'Italienne',
            price = 5,
            givename = "GlaceItalienne",
            ItemCategory = 'Nourritures'
        },
        {
            id = 3,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Barre_de_cereale.webp',
            label = 'Barre Céréales',
            price = 5,
            givename = "BarreCereale",
            ItemCategory = 'Nourritures'
        },
        {
            id = 4,
            image = 'assets/LTD/Chips.png',
            label = 'Chips',
            ItemCategory= 'Nourritures',
            price = 10,
            item = "tapas"
        },
        {
            id = 5,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Sandwich_triangle.webp',
            label = 'Sandwich Triangle',
            ItemCategory= 'Nourritures',
            price = 10,
            item = "tapas"
        },
        {
            id = 6,
            image = 'assets/LTD/cigarettes.png',
            label = 'Cigarette',
            ItemCategory= 'Utilitaires',
            price = 10,
            item = "cig"
        }, 
        {
            id = 7,
            image = 'assets/LTD/Ciseaux.png',
            label = 'Ciseaux',
            ItemCategory= 'Utilitaires',
            price = 50,
            item = "scisor"
        }, 
        --{
        --    id = 1,
        --    image = 'assets/LTD/ordinateur.png',
        --    label = 'Ordinateur',
        --    subCategory = 'CATALOGUE LTD',
        --    item = "laptop"
        --},
        {
            id = 8,
            image = 'assets/LTD/Pince_a_cheveux.png',
            label = 'Pince à cheveux',
            ItemCategory= 'Utilitaires',
            price = 30,
            item = "pince"
        }, 
--[[         {
            id = 9,
            image = 'assets/LTD/Radio.png',
            label = 'Radio',
            ItemCategory= 'Utilitaires',
            price = 50,
            item = "radio"
        },  ]]
        {
            id = 10,
            image = 'assets/LTD/Recycleur.png',
            label = 'Recycleur',
            ItemCategory= 'Utilitaires',
            price = 700,
            item = "recycleur"
        }, 
        {
            id = 11,
            image = 'assets/LTD/Telephone.png',
            label = 'Téléphone',
            ItemCategory= 'Utilitaires',
            price = 50,
            item = "phone"
        }, 
        {
            id = 12,
            image = 'assets/inventory/items/boombox.png',
            label = 'Boombox',
            ItemCategory= 'Utilitaires',
            price = 75,
            item = "boombox"
        },
        {
            id= 13,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/lait_chocolat.webp',
            label= 'Lait Chocolat',
            givename= 'laitchoco',
            ItemCategory= 'Boissons',
            price= 5,
        },
        {
            id= 14,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Bouteille_petillante.webp',
            label= 'Eau Pétillante',
            givename= 'eaupetillante',
            ItemCategory= 'Boissons',
            price= 5,
        },

        {
            id= 15,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/bouteille_eau.webp',
            label= 'Bouteille d\'eau',
            givename= 'water',
            ItemCategory= 'Boissons',
            price= 5,
        },


        {
            id = 16,
            image = 'assets/inventory/items/umbrella.png',
            label = 'Parapluie',
            price = 30,
            givename = "umbrella",
            ItemCategory= 'Utilitaires'
        },

        {
            id = 17,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/bloc_note.webp',
            label = 'Bloc-note',
            price = 10,
            givename = "blocnote",
            ItemCategory= 'Utilitaires'
        },
        {
            id = 18,
            image = 'assets/inventory/items/jumelle.png',
            label = 'Jumelle',
            price = 200,
            givename = "jumelle",
            ItemCategory= 'Utilitaires'
        },
        {
            id = 19,
            image = 'assets/inventory/items/fishroad.png',
            label = 'Canne Pêche',
            price = 50,
            givename = "fishroad",
            ItemCategory= 'Utilitaires'
        },

        {
            id = 20,
            image = 'assets/inventory/items/cigar.png',
            label = 'Cigar',
            price = 10,
            givename = "cigar",
            ItemCategory= 'Utilitaires'
        },

--[[         {
            id = 21,
            image = 'assets/inventory/items/Gadget_parachute.png',
            label = 'Parachute',
            price = 700,
            givename = "Gadget_parachute",
            ItemCategory= 'Utilitaires'
        }, ]]

        {
            id = 22,
            image = 'assets/inventory/items/cleaner.png',
            label = 'Cleaner',
            price = 50,
            givename = "cleaner",
            ItemCategory= 'Utilitaires'
        },

        {
            id = 23,
            image = 'assets/inventory/items/sactete.png',
            label = 'Sacs',
            price = 250,
            givename = "sactete",
            ItemCategory= 'Utilitaires'
        },

        {
            id = 24,
            image = 'assets/inventory/items/gps.png',
            label = 'GPS',
            price = 50,
            givename = "gps",
            ItemCategory= 'Utilitaires'
        },

        {
            id = 25,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/malettecuir.webp',
            label = 'Malette en Cuir',
            price = 300,
            givename = "malettecuir",
            ItemCategory= 'Utilitaires'
        },

        {
            id = 26,
            image= 'assets/inventory/items/can.png',
            label = 'Canette Vide',
            price = 10,
            givename = "can",
            ItemCategory= 'Utilitaires'
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
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Sucette.webp',
            label = 'Sucette',
            price = 30,
            givename = "lollipop",
            ItemCategory= 'Nourritures'
        },
        {
            id = 2,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Glace_a_l_italienne.webp',
            label = 'Glace a l\'Italienne',
            price = 35,
            givename = "GlaceItalienne",
            ItemCategory= 'Nourritures'
        },
        {
            id = 3,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Barre_de_cereale.webp',
            label = 'Barre Céréales',
            price = 30,
            givename = "BarreCereale",
            ItemCategory= 'Nourritures'
        },
        {
            id = 4,
            image = 'assets/LTD/Chips.png',
            label = 'Chips',
            ItemCategory= 'Nourritures',
            price = 35,
            item = "tapas"
        },
        
        {
            id = 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/twinkies.webp',
            label = 'Twinkies',
            price = 40,
            givename = "twinkies",
            ItemCategory= 'Nourritures'
        },
        {
            id = 6,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Sandwich_triangle.webp',
            label = 'Sandwich Triangle',
            ItemCategory= 'Nourritures',
            price = 40,
            item = "tapas"
        },
        {
            id = 8,
            image = 'assets/LTD/cigarettes.png',
            label = 'Cigarette',
            ItemCategory= 'Utilitaires',
            price = 35,
            item = "cig"
        }, 
        {
            id = 9,
            image = 'assets/LTD/Ciseaux.png',
            label = 'Ciseaux',
            ItemCategory= 'Utilitaires',
            price = 225,
            item = "scisor"
        }, 
        --{
        --    id = 1,
        --    image = 'assets/LTD/ordinateur.png',
        --    label = 'Ordinateur',
        --    subCategory = 'CATALOGUE LTD',
        --    item = "laptop"
        --},
        {
            id = 10,
            image = 'assets/LTD/Pince_a_cheveux.png',
            label = 'Pince à cheveux',
            ItemCategory= 'Utilitaires',
            price = 125,
            item = "pince"
        }, 
--[[         {
            id = 11,
            image = 'assets/LTD/Radio.png',
            label = 'Radio',
            ItemCategory= 'Utilitaires',
            price = 50,
            item = "radio"
        },  ]]
--[[         {
            id = 10,
            image = 'assets/LTD/Recycleur.png',
            label = 'Recycleur',
            ItemCategory= 'Utilitaires',
            price = 700,
            item = "recycleur"
        },  ]]
        {
            id = 12,
            image = 'assets/LTD/Telephone.png',
            label = 'Téléphone',
            ItemCategory= 'Utilitaires',
            price = 200,
            item = "phone"
        }, 
        {
            id = 13,
            image = 'assets/inventory/items/boombox.png',
            label = 'Boombox',
            ItemCategory= 'Utilitaires',
            price = 250,
            item = "boombox"
        },
        {
            id= 14,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/lait_chocolat.webp',
            label= 'Lait Chocolat',
            givename= 'laitchoco',
            ItemCategory= 'Boissons',
            price= 45,
        },
        {
            id= 15,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Bouteille_petillante.webp',
            label= 'Eau Pétillante',
            givename= 'eaupetillante',
            ItemCategory= 'Boissons',
            price= 40,
        },

        {
            id= 16,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/bouteille_eau.webp',
            label= 'Bouteille d\'eau',
            givename= 'water',
            ItemCategory= 'Boissons',
            price= 25,
        },


        {
            id = 17,
            image = 'assets/inventory/items/umbrella.png',
            label = 'Parapluie',
            price = 30,
            givename = "umbrella",
            ItemCategory= 'Utilitaires'
        },

        {
            id = 18,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/bloc_note.webp',
            label = 'Bloc-note',
            price = 50,
            givename = "blocnote",
            ItemCategory= 'Utilitaires'
        },
        {
            id = 19,
            image = 'assets/inventory/items/jumelle.png',
            label = 'Jumelle',
            price = 750,
            givename = "jumelle",
            ItemCategory= 'Utilitaires'
        },
        {
            id = 20,
            image = 'assets/inventory/items/fishroad.png',
            label = 'Canne Pêche',
            price = 220,
            givename = "fishroad",
            ItemCategory= 'Utilitaires'
        },

        {
            id = 21,
            image = 'assets/inventory/items/cigar.png',
            label = 'Cigar',
            price = 40,
            givename = "cigar",
            ItemCategory= 'Utilitaires'
        },

        {
            id = 22,
            image = 'assets/inventory/items/Gadget_parachute.png',
            label = 'Parachute',
            price = 700,
            givename = "gadget_parachute",
            ItemCategory= 'Utilitaires'
        },

        {
            id = 23,
            image = 'assets/inventory/items/cleaner.png',
            label = 'Produit nettoyant',
            price = 200,
            givename = "cleaner",
            ItemCategory= 'Utilitaires'
        },

        {
            id = 24,
            image = 'assets/inventory/items/sactete.png',
            label = 'Sacs',
            price = 900,
            givename = "sactete",
            ItemCategory= 'Utilitaires'
        },

        {
            id = 25,
            image = 'assets/inventory/items/gps.png',
            label = 'GPS',
            price = 200,
            givename = "gps",
            ItemCategory= 'Utilitaires'
        },
        
        {
            id = 26,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/malettecuir.webp',
            label = 'Malette en Cuir',
            price = 800,
            givename = "malettecuir",
            ItemCategory= 'Utilitaires'
        },

        {
            id = 27,
            image= 'assets/inventory/items/can.png',
            label = 'Canette Vide',
            price = 30,
            givename = "can",
            ItemCategory= 'Utilitaires'
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
            price= 20,
            ItemCategory= 'Nourritures',
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bayviewlodge/Bretzel.webp',
            label= 'Bretzel',
            ItemCategory= 'Nourritures',
            price=10,
        },
        {
            id= 3,
            image = 'assets/inventory/items/beer.png',
            label= 'Bière',
            ItemCategory= 'Alcool',
            price=15,
        },
        {
            id= 4,
            image = 'assets/inventory/items/vodka.png',
            label= 'Vodka',
            ItemCategory= 'Alcool',
            price= 25,
        },
        {
            id= 5,
            image = 'assets/inventory/items/gin.png',
            label= 'Gin',
            ItemCategory= 'Alcool',
            price=45,
        },
        {
            id= 6,
            image = 'assets/inventory/items/rhum.png',
            label= 'Rhum',
            ItemCategory= 'Alcool',
            price= 27,
        },
        {
            id= 7,
            image = 'assets/inventory/items/whisky.png',
            label= 'Whisky',
            ItemCategory= 'Alcool',
            price= 25,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/unicorn/Limonade.webp',
            label= 'Limonade',
            ItemCategory= 'Boissons',
            price=10,
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
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/pizzamarghe.webp',
            label= 'Pizza Margherita',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/pizza4fromage.webp',
            label= 'Pizza 4 fromages',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/pizzachevre.webp',
            label= 'Pizza Chèvre Miel',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/crostini.webp',
            label= 'Crostini',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/tiramisu.webp',
            label= 'Tiramisu',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/pizzaburata.webp',
            label= 'Salade Burata',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/pizzanutella.webp',
            label= 'Pizza Nutella',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pizzeria/saladedefruit.webp',
            label= 'Salade de fruits',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/bouteille_eau.webp',
            label= 'Eau',
            ItemCategory= 'Boissons',
            price=5,
        },
        {
            id=11,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/soda.webp',
            label= 'Sprunk',
            ItemCategory= 'Boissons',
            price=5,
        },
        {
            id= 12,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/burgershot/soda.webp',
            label= 'E-cola',
            ItemCategory= 'Boissons',
            price=2,
        },
        {
            id= 13,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Limonade.webp',
            label= 'Limonade',
            ItemCategory= 'Boissons',
            price=2,
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
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/Cocktail.webp',
            label= 'Cocktail',
            ItemCategory= 'Boissons',
            price= 15,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/Crevettes.webp',
            label= 'Crevettes',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/FishBowl.webp',
            label= 'FishBowl',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/Huitres.webp',
            label= 'Huitres',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/Moules.webp',
            label= 'Moules',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/Fruits_de_mer.webp',
            label= 'Plateau des mers',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/Tarte_au_Citron.webp',
            label= 'Tarte au Citron',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/pearl/Glace.webp',
            label= 'Glace Vanille',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Limonade.webp',
            label= 'Limonade',
            ItemCategory= 'Boissons',
            price= 15,
        },
        {
            id= 10,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Vin_blanc.webp',
            label= 'Vin Blanc',
            ItemCategory= 'Alcool',
            price=45,
        },
        {
            id= 11,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/lemiroir/Vin_rouge.webp',
            label= 'Vin Rouge',
            ItemCategory= 'Alcool',
            price=45,
        },
    }
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
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Batonspoulet_Hornys.webp',
            label= 'Batons de Poulet',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Burgerpoulet_Hornys.webp',
            label= 'Burger Poulet',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Wrappoulet_Hornys.webp',
            label= 'Wrap Poulet',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Pignonpoulet_Hornys.webp',
            label= 'Pignon de Poulet',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Donut_Hornys.webp',
            label= 'Donut',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Milkshake_Hornys.webp',
            label= 'Milkshake',
            ItemCategory= 'Boissons',
            price= 15,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Coffee_Hornys.webp',
            label= 'Café',
            ItemCategory= 'Boissons',
            price= 15,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/hornys/Soda_Hornys.webp',
            label= 'Soda',
            ItemCategory= 'Boissons',
            price= 15,
        },
    }
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
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Onion_rings.webp',
            label= 'Onion Rings',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Eggs_muffin.webp',
            label= 'Eggs Muffin',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Black_burger.webp',
            label= 'Black Burger',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Burger_Uranus.webp',
            label= 'Saturne Burger',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 6,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Burger_earth.webp',
            label= 'Earth Burger',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 7,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Cup_space.webp',
            label= 'Cup Space',
            ItemCategory= 'Nourritures',
            price= 15,
        },
        {
            id= 8,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Granita_upnatom.webp',
            label= 'Granita',
            ItemCategory= 'Boissons',
            price= 15,
        },
        {
            id= 9,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/upnatom/Ice_cup.webp',
            label= 'Ice Cup',
            ItemCategory= 'Boissons',
            price= 15,
        },
    }
}

local bennys_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_bennys.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/weapon_petrolcan.webp',
            label= 'Bidon d\'essence',
            price= 100,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/spray.webp',
            label= 'Bombe de peinture',
            price= 25,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/repairkit.webp',
            label= 'Kit de réparation',
            price= 500,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/cleankit.webp',
            label= 'Kit de nettoyage',
            price= 30,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/sangle.webp',
            label= 'Sangle',
            price= 300,
            ItemCategory= 'Utilitaires',
        },
    },
}

local sunshine_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_sunshine.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/weapon_petrolcan.webp',
            label= 'Bidon d\'essence',
            price= 100,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/spray.webp',
            label= 'Bombe de peinture',
            price= 25,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/repairkit.webp',
            label= 'Kit de réparation',
            price= 500,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/cleankit.webp',
            label= 'Kit de nettoyage',
            price= 30,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/sangle.webp',
            label= 'Sangle',
            price= 300,
            ItemCategory= 'Utilitaires',
        },
    },
}


local harmony_toSend = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_harmonyrepair.webp',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/weapon_petrolcan.webp',
            label= 'Bidon d\'essence',
            price= 100,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/spray.webp',
            label= 'Bombe de peinture',
            price= 25,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/repairkit.webp',
            label= 'Kit de réparation',
            price= 500,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/cleankit.webp',
            label= 'Kit de nettoyage',
            price= 30,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/sangle.webp',
            label= 'Sangle',
            price= 300,
            ItemCategory= 'Utilitaires',
        },
    },
}

local hayes_toSend = {
    headerImage = 'https://media.discordapp.net/attachments/1142829822821797929/1146736570037194752/Ban_Hayes_Final.png',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/weapon_petrolcan.webp',
            label= 'Bidon d\'essence',
            price= 100,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/spray.webp',
            label= 'Bombe de peinture',
            price= 25,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/repairkit.webp',
            label= 'Kit de réparation',
            price= 500,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/cleankit.webp',
            label= 'Kit de nettoyage',
            price= 30,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/sangle.webp',
            label= 'Sangle',
            price= 300,
            ItemCategory= 'Utilitaires',
        },
    },
}

local beekers_toSend = {
    headerImage = 'https://media.discordapp.net/attachments/1142829822821797929/1146736522419249223/Ban_Beekers_Final.png',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    hoverStyle = 'fill-black stroke-black',
    elements = {
        {
            id= 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/weapon_petrolcan.webp',
            label= 'Bidon d\'essence',
            price= 100,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 2,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/spray.webp',
            label= 'Bombe de peinture',
            price= 25,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 3,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/repairkit.webp',
            label= 'Kit de réparation',
            price= 500,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 4,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/cleankit.webp',
            label= 'Kit de nettoyage',
            price= 30,
            ItemCategory= 'Utilitaires',
        },
        {
            id= 5,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/sangle.webp',
            label= 'Sangle',
            price= 300,
            ItemCategory= 'Utilitaires',
        },
    },
}

local Tacos2Rancho_toSend = {
    headerImage = 'https://cdn.discordapp.com/attachments/1146829717597606119/1147487872258166834/Banner-Tacos2Rancho.jpg',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    elements = {
        {
            id= 10,
            image= 'https://media.discordapp.net/attachments/1146829717597606119/1147511638568742973/fajitas-the-frenchy-burger.png',
            label= 'Fajitas',
            ItemCategory= 'Nourritures',
            price= 40,
        },
        {
            id= 11,
            image= 'https://cdn.discordapp.com/attachments/1146829717597606119/1147511814939222087/menuthumbnail_breakfast_burrito-supersonic.png',
            label= 'Burritos',
            ItemCategory= 'Nourritures',
            price= 40,
        },
        {
            id= 12,
            image= 'https://cdn.discordapp.com/attachments/1146829717597606119/1147512065838297118/KWC-Image-2018-Food-Quesadilla-Whole-Chicken-1a-4853_kf_hd51_09063-FNL.png',
            label= 'Quessadillas',
            ItemCategory= 'Nourritures',
            price= 40,
        },
        {
            id= 13,
            image= 'https://cdn.discordapp.com/attachments/1146829717597606119/1147512360039362570/SINGLE-TACO.png',
            label= 'Tacos',
            ItemCategory= 'Nourritures',
            price= 40,
        },
        {
            id= 14,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Jus_de_fruits.webp',
            label= 'Jus',
            ItemCategory= 'Boissons',
            price= 10,
        },
        {
            id= 15,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/bahamas/Soda.webp',
            label= 'Soda',
            ItemCategory= 'Boissons',
            price= 10,
        },
        {
            id= 16,
            image= 'https://media.discordapp.net/attachments/1147903108442226779/1148218396383653888/laitchoco.png',
            label= 'Lait',
            ItemCategory= 'Boissons',
            price= 10,
        },
        {
            id= 17,
            image= 'https://media.discordapp.net/attachments/1147903108442226779/1148218098520952842/caprisun.png',
            label= 'Capri-Sun',
            ItemCategory= 'Boissons',
            price= 10,
        },
    },
}


zone.addZone(
    "catalogue_UwUcafe",
    vector3(-583.4012, -1062.261, 22.34),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('UwUcafe')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255
)

zone.addZone(
    "catalogue_BeanMachine1",
    vector3(-633.04455566406, 235.64749145508, 80.881454467773),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('BeanMachine')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255
)

zone.addZone(
    "catalogue_don",
    vector3(162.21119689941, 6640.8286132813, 30.6988697052),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('don')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255
)

zone.addZone(
    "catalogue_BeanMachine2",
    vector3(-629.89373779297, 233.71368408203, 80.881477355957),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('BeanMachine')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255
)

zone.addZone(
    "catalogue_LeMiroir",
    vector3(1116.68, -641.5269, 56.817),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('LeMiroir')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255
)

zone.addZone(
    "catalogue_Unicorn",
    vector3(96.637916564941, -1274.2564697266, 20.110975265503),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('Unicorn')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255
)

zone.addZone(
    "catalogue_BayviewLodge",
    vector3(-689.65716552734, 5796.2998046875, 16.331018447876),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('BayviewLodge')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255
)

zone.addZone(
    "catalogue_BurgerShot1",
    vector3(1590.0395507813, 3749.9719238281, 34.437118530273),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('BurgerShot')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255
)

zone.addZone(
    "catalogue_Comrades",
    vector3(-1587.8231201172, -996.45562744141, 13.075222969055),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('Comrades')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255
)

zone.addZone(
    "catalogue_Pops",
    vector3(1588.6284179688, 6455.5844726563, 26.0140209198),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('PopsDiner')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255
)

zone.addZone(
    "catalogue_YellowJack",
    vector3(1985.2114257813, 3050.6540527344, 47.215091705322),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('YellowJack')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255
)

zone.addZone(
    "catalogue_Bahamas1",
    vector3(-1403.4389648438, -603.44555664063, 30.319976806641),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('Bahamas')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255
)

zone.addZone(
    "catalogue_Bahamas2",
    vector3(-1397.8175048828, -599.91839599609, 30.319980621338),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('Bahamas')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255
)

zone.addZone(
    "catalogue_CluckinBell",
    vector3(-147.96556091309, -262.91122436523, 43.59912109375),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('CluckinBell')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255, 4.0
)

zone.addZone(
    "catalogue_domaine",
    vector3(-1877.85546875, 2063.8474121094, 134.91502380371),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('domaine')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255, 4.0
)

zone.addZone(
    "catalogue_blackwood",
    vector3(-305.09658813477, 6265.2685546875, 30.526918411255),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('blackwood')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255, 2.0
)

zone.addZone(
    "catalogue_pizzeria",
    vector3(810.19549560547, -751.40350341797, 26.78084564209),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('pizzeria')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255, 2.0
)

zone.addZone(
    "catalogue_pearl",
    vector3(-1838.0902099609, -1197.8659667969, 13.309239387512),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('pearl')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255, 2.0
)

zone.addZone(
    "catalogue_hornys",
    vector3(1249.5009765625, -360.32119750977, 69.082145690918),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('hornys')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255, 2.0
)

zone.addZone(
    "catalogue_upnatom",
    vector3(88.720268249512, 287.28649902344, 110.20943450928),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('upnatom')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255, 2.0
)

zone.addZone(
    "catalogue_TacosRancho",
    vector3(417.93206787109, -1913.4464111328, 24.471214294434),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('tacosrancho')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255
)

zone.addZone(
    "catalogue_TacosRancho",
    vector3(416.1467590332, -1915.3057861328, 24.471214294434),
    "Appuyer sur ~INPUT_CONTEXT~ pour accéder au catalogue",
    function()
        OpenCatalogue('tacosrancho')
    end,
    false,
    36, 0.5, { 255, 0, 0 }, 255
)

function OpenCatalogue(catChoice)
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
    elseif catChoice == 'domaine' then
        toSend = domaine_toSend
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
    elseif catChoice == 'sunshine' then
        toSend = sunshine_toSend
    elseif catChoice == 'harmony' then
        toSend = harmony_toSend
    elseif catChoice == 'beekers' then
        toSend = beekers_toSend
    elseif catChoice == 'hayes' then
        toSend = hayes_toSend
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

function GetCatalogueItems(job)
    local toSend;
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
    elseif job == 'pizzeria' then
        toSend = Pizzeria_toSend
    elseif job == 'pearl' then
        toSend = Pearl_toSend
    elseif job == 'upnatom' then
        toSend = Upnatom_toSend
    elseif job == 'hornys' then
        toSend = Hornys_toSend
    elseif job == 'bahamas' then
        toSend = BahamaMamas_toSend
    elseif job == 'comrades' then
        toSend = ComradesBar_toSend
    elseif job == "domaine" then 
        toSend = domaine_toSend
    elseif job == "ltdsud" then 
        toSend = LTD_toSend
    elseif job == "ltdmirror" then 
        toSend = LTD_toSend
    elseif job == "don" then 
        toSend = Dons_toSend
    elseif job == "blackwood" then 
        toSend = blackwood_toSend
    elseif job == 'bennys' then
        toSend = bennys_toSend
    elseif job == 'sunshine' then
        toSend = sunshine_toSend
    elseif job == 'harmony' then
        toSend = harmony_toSend
    elseif job == 'beekers' then
        toSend = beekers_toSend
    elseif job == 'hayes' then
        toSend = hayes_toSend
    elseif job == 'tacosrancho' then
        toSend = Tacos2Rancho_toSend
    end

    return toSend
end