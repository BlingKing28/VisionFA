logs = {
    ["connexion"] = {
        hook = "achanger",--
        color = 0x03fc20,
        title = "Connexion",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\nIdenfiants:\n%s",
    },
    ["deconnexion"] = {
        hook = "achanger",--
        color = 0xf44336,
        title = "Déconnexion",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\nRaison: **%s**\nIdenfiants:\n%s",
    },
    ["vetement"] = {
        hook = "achanger",
        color = 0x03fc20,
        title = "Vêtement data",
        text = "Id: %d\nData: \n%s",
    },
    ["screenshot"] = {
        hook = "achanger",--
        color = 0x03fc20,
        title = "Screen Admin",
        text = "Id du joueur: %d\nNom prénom RP: %s\nLicense du joueur: %s\nImage: \n%s \nScreen fait par: %s",
    },
    ["sms"] = {
        hook = "achanger",
        color = 0x03fc20,
        title = "SMS",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\nNuméro: **%s**\nDestinataire: **%s**\nContenu: \n**%s**",
    },
    ["call"] = {
        hook = "achanger",
        color = 0x03fc20,
        title = "Appel",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\nNuméro: **%s**\nDestinataire: **%s**",
    },
    ["withdraw"] = {
        hook = "achanger",--
        color = 0xf44336,
        title = "Retrait",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\nCompte: **%s**\nMontant: **%d$**\nCatégorie: **%s**",
    },
    ["deposit"] = {
        hook = "achanger",--
        color = 0x03fc20,
        title = "Dépôt",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\nCompte: **%s**\nMontant: **%d$**\nCatégorie: **%s**",
    },
    ["transfer"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Transfert",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\nCompte: **%s**\nDestinataire: **%s**\nMontant: **%d$**",
    },
    ["tablet"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Commande tablette",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\nCrew: **%s**\nCommande: **%s**",
    },
    ["ban"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Ban",
        text = "Id joueur banni: **%d**\nDiscord joueur banni: <@%s>\nNom prénom RP joueur banni: **%s**\nId modo: **%d**\nDiscord modo: <@%s>\nNom prénom RP modo: **%s**\nraison: **%s**\ndate fin: **%s**\nid du ban: **%s**",
    },
    ["kick"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Kick",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\n Kick par: **%s**\n Raison: **%s**",
    },
    ["killPlayer"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Mort/Kill",
        text = "**Victime**: \nId du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\n Cause de la mort: **%s**\n Pos: **%s** \n **Tueur**: \n Id du joueur: **%s**\nDiscord: <@%s>\nNom prénom RP: **%s** Armes: **%s**\n Pos: **%s**\n Distance: **%s**"
    },
    ["killSuicide"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Mort/Kill",
        text = "**Victime**: \nId du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\n Pos: **%s** \n **Tueur**: Suicide ou PNJ"
    },
    ["announceModo"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Annonce",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\n Annonce: **%s**",
    },
    ["give"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Give joueur à joueur",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\receveur:\n Id du joueur: **%s**\nDiscord: <@%s>\nNom prénom RP: **%s** \n Item: **%s**\n Quantité: **%s**",
    },
    ["wipe"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Wipes ig",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\n Wipe par: **%s**\nDiscord: <@%s>",
    },
    ["dutyon"] = {
        hook = "achanger",--
        color = 0x038500,
        title = "Service",
        text = "Type: **%s**\nId du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\n Job: **%s**",
    },
    ["dutyoff"] = {
        hook = "achanger",--
        color = 0xff0000,
        title = "Service",
        text = "Type: **%s**\nId du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\n Job: **%s**",
    },
    ["hook"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Crochetage",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\n Pos: **%s** \n Véhicule: **%s**\n Plaque: **%s**",
    },
    ["reviveems"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Réanimation",
        text = "Id de l'EMS: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\n Pos: **%s** \n Victime: **%s**\nDiscord: <@%s>",
    },
    ["heist"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Cambriolage",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\n Pos: **%s** \n ID de propriété: **%s**",
    },
    ["immo"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Location / Vente",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\nClient: **%s**\nDiscord du client:<@%s>\nID: **%s** \n Nom: **%s** \n Pos: **%s** \n Data:%s \n Type: **%s ---- %s**\n Durée: **%s**",
    },
    ["casse"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Casse",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\n Plaque: **%s** \n Modèle: **%s** \n Prix: **%s** \n \n Type de véhicule: **%s**",
    },
    ["staffAction"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Staff Action",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\n Action: **%s** \n Data: **%s**",
    },
    ["acteur"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Acteur",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\n Action: **%s** \n Data: **%s**",
    },
    ["3DME"] = {
        hook = "achanger",
        color = 0xff7f00,
        title = "Logs /me",
        text = "Id du joueur: **%d**\n Discord: <@%s>\n Nom prénom RP: **%s**\n Contenu: **%s**",
    },
    ["plate"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Logs plaque",
        text = "Id du joueur: **%d**\n Discord: <@%s>\n Nom prénom RP: **%s**\n Modèle: **%s**\n Ancienne plaque: **%s**\n Nouvelle plaque: **%s**",
    },
    ["additem"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Logs additem",
        text = "Id du joueur: **%d**\n Discord: <@%s>\n Nom prénom RP: **%s**\n Item: **%s**\n Quantité: **%s**\n Cible: **%s**\n Discord: <@%s>",
    },
    ["messadmin"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Logs messadmin",
        text = "Id du joueur: **%d**\n Discord: <@%s>\n Nom prénom RP: **%s**\n Message: **%s**\n Cible: **%s**\n Discord: <@%s>",
    },
    ["entreprise"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Logs entreprise",
        text = "Id du joueur: **%d**\n Discord: <@%s>\n Nom prénom RP: **%s**\n Job: **%s** \n Contenu: **%s**",
    },
    ["radio"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Fréquences radio",
        text = "Id du joueur: **%d**\n Discord: <@%s>\n Nom prénom RP: **%s**\n Fréquence: **%s**",
    },
    ["perquisition"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Logs perquisition",
        text = "Id du joueur: **%d**\n Discord: <@%s>\n Nom prénom RP: **%s**\n Property id: **%s** \n property name: **%s** \n property owner: **%s** \n property crew: **%s**",
    },
    ["sprayLog"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "spray",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\nx: **%d**, y: **%d**\ntexte: **%s**",
    },
    ["superette"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "superette",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\nmontant: **%s**\nemplacement: **%s**\nraison fin: **%s**",
    },
    ["penalty"] = {
        hook = "achanger",
        color = 0xff7f00,
        title = "penalty",
        text = "Id joueur lspd: **%d**\nDiscord joueur lspd: <@%s>\nNom prénom RP joueur lspd: **%s**\nId du joueur amendé: **%d**\nDiscord joueur amendé: <@%s>\nNom prénom RP joueur amendé: **%s**\nmontant: **%s**\njob: **%s**\nraison: **%s**",
    },
    ["casier"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "casier",
        text = "Id joueur: **%d**\nDiscord joueur: <@%s>\nNom prénom RP: **%s**\nJob: %s\n%s",
    },
    ["facture"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "facture",
        text = "Id joueur demandeur: **%d**\nDiscord joueur demandeur: <@%s>\nNom prénom RP joueur demandeur: **%s**\nId du joueur payeur: **%d**\nDiscord joueur payeur: <@%s>\nNom prénom RP joueur payeur: **%s**\nMontant: **%d$**\nentreprise: **%s**",
    },
    ["factureIRS"] = {
        hook = "achanger",
        color = 0x007fff, -- blue cian
        title = "IRS Watcher facture",
        text = "Id joueur demandeur: **%d**\nDiscord joueur demandeur: <@%s>\nNom prénom RP joueur demandeur: **%s**\nId du joueur payeur: **%d**\nDiscord joueur payeur: <@%s>\nNom prénom RP joueur payeur: **%s**\nMontant: **%d$**\nentreprise: **%s**",
    },
    ["withdrawIRS"] = {
        hook = "achanger",
        color = 0x007fff,
        title = "IRS Watcher retrait",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\nCompte: **%s**\nMontant: **%d$**\nCatégorie: **%s**",
    },
    ["depositIRS"] = {
        hook = "achanger",
        color = 0x007fff,
        title = "IRS Watcher dépôt",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\nCompte: **%s**\nMontant: **%d$**\nCatégorie: **%s**",
    },
    ["transferIRS"] = {
        hook = "achanger",
        color = 0x007fff,
        title = "IRS Watcher transfert",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\nCompte: **%s**\nDestinataire: **%s**\nMontant: **%d$**",
    },
    ["whitelist"] = {
        hook = "achanger",
        color = 0xff7f00,
        title = "Whitelist",
        text = "Id de la personne qui whitelist: **%s**\nNom de la personne qui whitelist: **%s**\n\nNom de la personne whitelist: **%s**\nID Unique de la personne whitelist: **%s**\nLicense de la personne whitelist: **%s**",
    },
    ["wheather"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "wheather",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\nType: **%s**\nData: **%s**",
    },
    ["cardealerTryVeh"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "essai vehicule",
        text = "Id joueur concess: **%d**\nDiscord joueur concess: <@%s>\nNom prénom RP joueur concess: **%s**\nId du joueur en essai: **%d**\nDiscord joueur en essai: <@%s>\nNom prénom RP joueur en essai: **%s**\nvehicule: **%s**\njob: **%s**",
    },
    ["xp"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "xp",
        text = "Id du joueur: **%d**\nDiscord: <@%s>\nNom prénom RP: **%s**\ncrew: **%s**\nxpadd: **%d**\norigine: **%s**",
    },
    ["PostOP-NewCommande"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Nouvelle commande",
        text = "Entreprise cible : `%s`\nÉtat de la commande : `%s`\nEntreprise demanderesse : `%s`\nNuméro de téléphone du joueur : `%s`\nMontant: `%s$`\n\n**Contenance :** `%s`",
    },
    ["PostOP-TakItems"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Nouvelle prise d'item",
        text = "ID Du joueur : `%d`\nDiscord joueur : <@%s>\nNom prénom RP joueur : `%s`\nPrix total du give : `%s`\nEntreprise joueur : `%s`\nItems :\n`%s`",
    },
    ["addmoney"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Give Money",
        text = "ID Du joueur : `%d`\nDiscord joueur : <@%s>\nNom prénom RP joueur : `%s`\nTotal du addmoney : %s",
    },
    ["pawnshop"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "pawnshop action",
        text = "Id joueur pawnshop: **%d**\nDiscord joueur pawnshop: <@%s>\nNom prénom RP joueur pawnshop: **%s**\nId du joueur pawnshopé: **%d**\nDiscord joueur pawnshopé: <@%s>\nNom prénom RP joueur pawnshopé: **%s**\nAction: **%s**\nPlate: **%s**\n<Id ancien proprio(vente) ou actuel(coowner): **%s**",
    },

    ["Ammunation-TakeItem"] = {
        hook = "achanger",--
        color = 0xff7f00,
        title = "Nouvelle prise d'arme",
        text = "ID Du joueur : `%d`\nDiscord joueur : <@%s>\nNom prénom RP joueur : `%s`\nPrix total du give : `%s`\nEntreprise joueur : `%s`\nItems :\n`%s`",
    },
}
--TODO: faire toutes les logs
