CfgSH = {}

-- Blacklist client-side events from Cfg.BlacklistedEvent (configlists.lua)
-- Blacklist les events côté client de Cfg.BlacklistedEvent (configlists.lua)
CfgSH.BanEvents = true

CfgSH.UseESX = false -- will soon be removed
CfgSH.SharedObjectTrigger = 'esx:getSharedObject'

-- Nobody can be kicked or banned
-- Personne ne peut être kick ou ban
CfgSH.DevMode = false

--------------------------------------------------
--------------------------------------------------
-------------------- BAN TEXT
--------------------------------------------------
--------------------------------------------------

CfgSH.TriggerSpam = "La personne a été détecté pour avoir exécuté trop d'events. %s triggers activés."
CfgSH.InjectionEvent2 = "La personne a été détecté pour avoir injecté un programme externe.\n\nRaison: %s"
CfgSH.JumpText = "La personne a été détecté pour avoir utilisé un grand saut."
CfgSH.GiveeventText = "La personne a été détecté pour avoir give des armes. (%s, %s)"
CfgSH.MaxParticleCountText = "La personne a été détecté pour spam des particules. (%s)"
CfgSH.MaxMassVehText = "La personne a été détecté pour spam de véhicules."
CfgSH.MaxMassPedText = "La personne a été détecté pour spam de peds. (x%s)"
CfgSH.MaxMassObjectsText = "La personne a été détecté pour avoir spam des objets. (x%s)"
CfgSH.AntiSoundText = "La personne a été détecté pour avoir créé des sons."
CfgSH.MaxTazeText = "La personne a été détecté pour spam le tazer."
CfgSH.ReasonResourceCount = "La personne a été détecté pour avoir injecté un programme externe."
CfgSH.ExplosionsText = "La personne a été détecté pour avoir utilisé des explosions blacklist."
CfgSH.ReasonCreatingObj = "La personne a été détecté pour avoir fais spawn des objets blacklist.\nModel : %s"
CfgSH.ReasonResourceStop = "La personne a été détecté pour avoir %s une ressource : %s." -- first %s is "stop" or "start"
CfgSH.ReasonCreatingVeh = "La personne a été détecté pour avoir fais spawn des véhicules blacklist."
CfgSH.ReasonFunction = "La personne a été détecté pour avoir utilisé des fonctions blacklist. Fonction blacklist : %s"
CfgSH.ReasonCreatingPeds = "La personne a été détecté pour avoir fais spawn des peds blacklist."
CfgSH.ReasonNUIDevTool = "La personne a été détecté pour avoir utilisé le NUI Dev Tools."
CfgSH.ReasonCE = "La personne a été détecté pour avoir utilisé Cheat Engine."
CfgSH.TasksEvent = "La personne a été détecté pour avoir injecté un programme externe. (Immediat : %s)"
CfgSH.BanExecution = "La personne a été détecté pour avoir injecté un programme externe.\nExecution : %s"
CfgSH.Welcome = "Bienvenue, nous vérifions vos fichiers..."

CfgSH.ExplosionsOccured = "Voici toutes les explosions lorsque l'anticheat était en mode \"slow\""
CfgSH.ExplosionsOccuredTitle = "Liste des explosions survenues en mode \"slow\""

CfgSH.Banned = "Vous avez été banni permanent : %s"
CfgSH.BannedFromSunWiseNetwork = "Vous avez été banni permanent par le Network de SunWise"

CfgSH.VpnKick = "Vous ne pouvez pas vous connecter avec un VPN. Veuillez désactiver votre réseau privé virtuel."
CfgSH.IsUsingVpn = "%s a tenté de se connecter avec un VPN."
CfgSH.WantToValidBan = "La console veut que **%s** soit banni du Network SunWise. Il sera banni de tous les serveurs qui utilisent cet anticheat si un staff SunWise accepte cette demande.\n\n**License**: %s\n**Identifier**: %s\n**Discord**:%s\n**Raison de son ban**: %s"

CfgSH.IsConnecting = "%s (%s) se connecte au serveur."
CfgSH.IsDisconnecting = "%s (%s) se déconnecte du serveur. Raison :%s."

CfgSH.WebHookTextBan = "**%s** a été détecté par l'anticheat pour : **%s**"
CfgSH.WebHookTextKick = "**%s** a été détecté par l'anticheat pour : **%s**"

---------------------------------------------------------------
---------------------------------------------------------------
------------------------- Whitelist ---------------------------
---------------------------------------------------------------
---------------------------------------------------------------

CfgSH.WhitelistedPlayers = {
    "discord:693840863868092487", -- Nicorrati
    "discord:395187741496836096", -- Flozii
    "discord:201317420449660928", -- Lala
    "discord:268402098209554432", -- Gamingo
    "discord:149576203479547904", -- Prestor
    "discord:297077339135803392", -- Zerkay
    "discord:353185852907585536", -- Palomba
    "discord:227104614493847552", -- Benjamin
    "discord:152592461317799947", -- Eadric
    "discord:485363572789215242", -- ach
    "discord:320092446644109322", -- noah
    "discord:141244258790277120", -- NSSK
    "discord:667854055913029641", -- kunah
}