Cfg = {}

---------------------------------------------------------------
---------------------------------------------------------------
---------------------------- Utils ----------------------------
---------------------------------------------------------------
---------------------------------------------------------------

-- Sends a screenshot of their screen when a player is banned or kicked by Anticheat
-- Envoie une capture d'écran de son écran lorsqu'un joueur est banni ou kick par l'anticheat

-- Make sure you have the lastest version of yarn and webpack for screenshot-basic
Cfg.Screenshot = true

-- Checks for screen menus every 10 secs (Recommended to leave this right here otherwise you'll get a lot of lag and high CPU usage. You can increase this time to like 30k if players are having CPU usage problems)
-- Vérifie les menus à l'écran toutes les 10 secondes (il est recommandé de laisser cela ici, sinon vous obtiendrez beaucoup de décalage et une utilisation élevée du processeur. Vous pouvez augmenter ce temps à 30 000 si les joueurs ont des problèmes d'utilisation du processeur)
Cfg.ReadScreen = false
Cfg.ReadScreenTime = 10000
Cfg.BlacklistedMenuWords = { -- (OnScreenMenuDetection) Words to check
	"fallout", "godmode", "god mode", "modmenu", "give armor", "aimbot", "triggerbot", "rage bot", "ragebot", "rapidfire", "freecam", "superjump",
	"ckgangisontop", "lumia1", "ISMMENU", "HydroMenu", "TAJNEMENUMenu", "rootMenu", "Outcasts666", "WaveCheat", "NacroxMenu", "MarketMenu", "FlexSkazaMenu", "SidMenu", "Lynx8", "LynxEvo", "Maestro",
	"Tiago menu", "fast run", "fast swim", "explosive ammo", "redEngine", "HamMafia", "HamHaxia", "Dopameme", "redMENU", "Desudo", "explode all", "Anticheat", "Tapatio", "Malossi", "RedStonia",
	"Chocohax", "Injected", "Inyection", "Inyected", "LUA Executor", "Executor", "Event Blocker", "Alokas66", "Rape Player", "Hacking System!", "Panic Button", "Destroy Menu", "Self Menu", "Teleport To", "Give Single Weapon", "Airstrike Player", "Taze Player",
    "ESX Server Crasher", "Nuke Server",
    -- ANTI RP SEX
    "ses seins", "ces seins", "ses fesses", "ces fesses"
}

Cfg.AntiTextures = false

-- Compte les ressources du client avec celles du serveur, si pas égal alors ban
Cfg.ResourceCount = false -- pas trop optimisé

Cfg.AntiExecutors = true

-- Set it to false if you uses a team system or if you have activated blips of players. It checks if a player have blips of other players.
-- Mettre sur false si vous utilisé un systeme de team ou si vous avez activé les blips des joueurs. Check si les joueurs ont des blips d'autres joueurs.
Cfg.AntiBlip = false

-- Ban the player if he use a cam to travel across the map
-- Ban un mec quand il utilise une cam pour traverser la map
Cfg.AntiFreecam = false 

Cfg.GetAdminGroup = function()
    local _src = source
    return exports.core:getPermission(_src)
end

Cfg.LowestGroup = function()
    return 0
end

---------------------------------------------------------------
---------------------------------------------------------------
---------------------------- PVP ------------------------------
---------------------------------------------------------------
---------------------------------------------------------------


-- Ban when someone has night vision and thermal vision
Cfg.AntiVisuals = false

-- Anti Force Gun for weapons, cannot multiply the emitted force of the weapons
-- Anti Force Gun pour les armes, ne peut pas multiplier la force émise des armes
Cfg.AntiForceGun = true 

-- Anti infinite roll
-- Anti roulade infinie
Cfg.AntiCombatRoll = true

-- Anti Aimbot and Triggerbot detects the number of shots in the head according to the coordinates of the head
-- Anti Aimbot et Triggerbot détecte le nombre de tir dans la tete selon les coordonnées de la tête
Cfg.AntiTriggerBotAimbot = true

-- Check life, armor, weapon damage modifier, vehicle god mode, player visibility, speed.
-- Check la vie, l'armure, armes dégats modifier, vehicle god mode, visibilité du joueur, vitesse.
Cfg.AntiCheatEngine = true
-- Maximum weapon damage modifier, weapon defense modifier and others...
Cfg.MaxModifier = 1.3

-- Check if the player has a "normal" size
-- Vérifie si le joueur a une taille "normale"
Cfg.AntiShrink = true
 
-- Can not fast run
-- Ne peut pas fast run
Cfg.AntiFastRun = true

-- Anti https://www.youtube.com/watch?v=Kt7m3bD8w_E&ab_channel=LeJ
Cfg.AntiSoftAim = true

---------------------------------------------------------------
---------------------------------------------------------------
---------------------------- Other ----------------------------
---------------------------------------------------------------
---------------------------------------------------------------

-- Force the player not to be invinsible for the users
-- Force le joueur a ne pas être invincible pour les users
Cfg.ForceAntiGodMode = true

-- Example : https://www.youtube.com/watch?v=B718NRzmMko
-- Blocks the NUI dev tools which allows you to give yourself thanks to the HTML of certain scripts.
-- Bloque le NUI dev tools qui permet de se give grace au HTML de certains script.
Cfg.AntiNUIDevTools = true
Cfg.KickOrBanDevTools = "kick" -- "ban" or "kick" only. If value is not ban or kick it will be automatically be "kick"

-- Players will not be able to start or stop an resource
-- Les joueurs ne pourront pas stop ni start de ressources
Cfg.AntiResourceStopRestart = true 

-- Anti Super Jump (kick)
Cfg.JumpFlag = true

-- Check if any ped is blacklisted around a player. Also check if any players have a ped blacklist, if so it reverts to their old appearance, the list of blacklisted peds is in 
-- configlists.lua (Cfg.BlackListPedList)
--
-- Check si des peds sont blacklist autour d'un joueur. Check aussi si des joueurs ont un ped blacklist, si oui cela remet leur ancienne apparence, la liste des peds blacklist est 
-- dans configlists.lua (Cfg.BlackListPedList)
Cfg.BlackListPed = false

-- Delete all the peds exept the peds in -> -- configlists.lua (Cfg.WhiteListedPed)
-- Supprime tout les peds sauf ce dans -> -- configlists.lua (Cfg.WhiteListedPed)
Cfg.WhiteListPed = false

-- A "user" will not be able to spectate a player. List is Cfg.WhitelistedGroups
-- Un "user" ne pourra pas spectate de joueur. la liste est Cfg.WhitelistedGroups
Cfg.AntiSpec = true

-- Anti full stamina (Running without ever being tired). If your server uses it, deactivate this option
-- Anti full stamina (Courir sans jamais être fatigué). Si votre serveur l'utilise désactivez cette option
Cfg.AntiStamina = true

-- Kick when a player speedhack (Can never be sure so it kicks the player)
-- Kick quand un joueur speedhack (Ne peut jamais être sûr donc kick le joueur)
Cfg.SpeedHack = false

-- Cannot spawn blacklisted objects. List -> Cfg.BlacklistObject
-- Ne peut pas spawn d'objets blacklist. Liste -> Cfg.BlacklistObject
Cfg.AntiObj = false

-- Cannot spawn pickups, like money bags, armour...
-- Ne peut pas spawn des pickups, comme les sacs d'argent, armure...
Cfg.AntiPickups = true

-- Check if the car is "cheated", check if the speed is increased, it forces the earth's gravity, check if the handling is modified, forces the vehicle not to be invincible
-- Vérifiez si la voiture est "cheaté", la vitesse augmenté, force la pesanteur terrestre, check si l'handling est modifié, force le véhicule à ne pas être invincible
Cfg.AntiVehCheat = true 

-- Delete all the destroyed cars when there is no driver in it
-- Supprime tout les vehicules détruits quand il n'y a pas de conducteur dedant
Cfg.DeleteExplosedCars = false

-- A user can not use noclip
-- Un "users" ne pourra pas noclip
Cfg.AntiNoclip = true

-- Disable the vehicle's weapon (delete the opressor rocket for example)
-- Désactive les armes des véhicules (supprime les rockets des oppressors par exemple)
Cfg.DisableVehiclesWeapons = false
Cfg.AllowedVehs = {
    "watchtower",
    "watchtower2"
}

-- Anti Spawn Ped or Vehicles when the player shoots
-- Anti Spawn Ped ou Vehicules quand le joueur tire par terre
Cfg.AntiSpawnShoot = true

Cfg.BlacklistedClientEvent = {}

-----------------------------------------------------------------
---------------------------- IN DEV ----------------------------
--[[
Cfg.ScreenCasually = false -- envoi un screen de tout les joueurs toutes les 10 minutes dans un channel discord, les anciens screens sont supprimés quand de nouveaux arrives
Cfg.BlacklistCountry = false -- Pour interdire l'accès des joueurs qui viennent d'un pays blacklist (Liste Cfg.BlacklistIPList)
Cfg.BlacklistIPList = {
    "ru"
}]]

-----------------------------------------------------------------
-----------------------------------------------------------------
