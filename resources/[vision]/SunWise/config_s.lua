Cfg.Webhook = {
    ["CheckIP"] = "achanger",
    ["ValidBans"] = "achanger",
    ["UnBan"] = "achanger",
    ["Connections"] = "achanger",
    ["Disconnects"] = "achanger",
    ["SpamTrigger"] = "achanger",
    ["Injections"] = "achanger",
    ["SuperJump"] = "achanger",
    ["Gives"] = "achanger",
    ["Particles"] = "achanger",
    ["BlackListedPeds"] = "",
    ["SpamTazer"] = "achanger",
    ["ResourcesCount"] = "achanger",
    ["Explosions"] = "achanger",
    ["ObjectCreation"] = "achanger",
    ["SoundCreation"] = "achanger",
    ["ResourceStop"] = "achanger",
    ["VehiclesCreation"] = "achanger",
    ["BlacklistedFunctions"] = "achanger",
    ["PedCreations"] = "achanger",
    ["NUIDevTools"] = "achanger",
    ["CheatEngine"] = "achanger",
    ["VpnBlacklist"] = "achanger",

    -- Others
    ["AntiShrink"] = "achanger",
    ["AntiTextures"] = "achanger",
    ["AntiBlips"] = "achanger",
    ["AntiFreecam"] = "achanger",
    ["AntiVisual"] = "achanger",
    ["AntiForceGun"] = "achanger",
    ["AntiCombatRoll"] = "achanger",
    ["AntiAimbot"] = "achanger",
    ["AntiFastRun"] = "achanger",
    ["AntiGodMode"] = "achanger",
    ["AntiSpectate"] = "achanger",
    ["AntiStamina"] = "achanger",
    ["AntiSpeedhack"] = "achanger",
    ["AntiVehicleCheats"] = "achanger",
    ["AntiExplodedcar"] = "achanger",
    ["AntiNoclip"] = "achanger",
    ["AntiSpawnShoot"] = "achanger",
    ["AntiDisableWeaponVehicle"] = "achanger",
    ["AntiResquestControl"] = "achanger",
    ["AntiXSSInjection"] = "achanger",
    ["AntiRPFEditor"] = "achanger",
}

-- Anti give weapons for "users"
-- Anti give d'armes pour les "users"
Cfg.AntiGive = false
Cfg.AntiSpamGive = true
Cfg.WhitelistedWeaponsGive = {
    1074790547,
    2017895192,
    -494615257,
    171789620,
    -1074790547,
    324215364
}

Cfg.Lang = "FR" -- "FR" or "EN"

-- Debug mode -> print all suspicious events and print when someone connects with a VPN or proxy, print when someone is banned or kicked
-- Debug mode -> print tous les événements suspects, print quand quelqu'un se connecte avec un VPN ou un proxy, print quand qqun est ban ou kick
Cfg.DebugInfo = true

-- Never getting banned neither getting ban
-- Ne se ferra jamais ban, ni kick, seulement logs
Cfg.OnlyLogs = true

-- Never getting banned, change all the ban texts
-- Ne se ferra jamais ban, seulement kick, pensez a changer les textes de ban ! (BAN TEXT)
Cfg.OnlyKick = false

-- Only work if you type the command "netbanaccept (identifier)"
-- Ban players who has cheated on other servers using then Sunwise Anticheat. When a ban append with the anticheat on your server the player will also be banned on the other server which uses this anticheat.
-- Ban les joueurs qui ont cheat sur d'autres serveur utilisant le Sunwise Anticheat. Lors d'un ban sur votre serveur le joueur serra aussi ban sur les autres serveur qui utilise cet anticheat.
Cfg.BanFromSunwiseNetwork = true 

-- Only if Cfg.BanFromSunwiseNetwork is set to true
-- Ban the player in your SQL if someone is banned from the SunWise Network, can be usefull if the main website is offline
-- Ban le joueur dans votre SQL si la personne est banni de SunWise Network, peut etre utilise lorsque le site est offline
Cfg.BanIntoMySQL = true

-- Block the connection if the person is using a vpn
-- Bloque la connexion si la personne utilise un vpn
Cfg.AntiVpn = true

-- Disable the ability to remove someone from a car
-- Désactive la possibilité de sortir quelqu'un d'une voiture
Cfg.AntiRequestControl = true 
Cfg.RequestControlKickBan = "kick"

-- Block bots that crashes your server
-- Désactive les bots qui font crash le serveur
Cfg.AntiXSSInjection = false
Cfg.BlacklistedNames = { -- blacklisted names
    "lynx"
}

-- The following resources will not be checked by the anticheat to see if the files were modified
Cfg.WhiteListedResources = {
    "rpemotes",
    "vMenu"
}

-- désactiver toutes les particules
Cfg.DisableParticules = false

Cfg.AntiSpamParticules = false
Cfg.MaxParticleCountTime = 5000
Cfg.MaxParticleCount = 15
Cfg.WhiteListedParticles = {
    1431282941, -- fireworks
}

Cfg.AntiPlaySound = true

Cfg.AntiSpamTaze = true
Cfg.MaxTaze = 3 -- Max taze per secondes

Cfg.AntiSpawnMassVeh = true
Cfg.MaxMassVeh = 6 
Cfg.MaxMassVehTime = 2000 -- 5s

Cfg.AntiSpawnMassPed = true
Cfg.MaxMassPed = 7
Cfg.MaxMassPedTime = 5000 -- 5s

Cfg.AntiSpawnMassObjects = true
Cfg.MaxMassObjects = 20
Cfg.MaxMassObjectsTime = 2000 -- 2s
Cfg.IgnoreCustomRoutingBuckets = true

-- Delete all the peds exept the peds in -> -- configlists.lua (Cfg.WhiteListedPed)
-- Supprime tout les peds sauf ce dans -> -- configlists.lua (Cfg.WhiteListedPed)
Cfg.WhiteListPed = false

-- Anti blacklisted explosions and "silent" explosions
-- Anti explosions blacklist et explosions "silencieuse"
Cfg.Explosions = true 
Cfg.DisableAllExplosions = false

-- Will log explosions only if the anticheat is in "active" mode
-- When active mode is activated, the anticheat will send the log of explosions that occured when it was in "slow" mode
Cfg.ExplosionsOnlyOnActive = true

Cfg.AntiSilentExplosions = true

-- If you use a build higher than 3334 then set it to true, it permits to enhanced the ban logic and it disable the ban evade risks.
-- Si vous utilisez un build supérieur à 3334, mettez en true, cela permet d'améliorer la logique de ban et de supprimer les risques du ban evade.
Cfg.UseAtLeastBuild3335 = true

-- Can not be banned
-- Ne peut pas etre ban
Cfg.WhitelistedGroups = { 
    3,4,5
}
 
Cfg.DefaultMode = "slow"

Cfg.GetAdminGroup = function(source) -- Standalone
    return exports.core:GetPlayerPerm(source)
end

Cfg.HttpStoreImages = "http://imageserver.visionrp.fr/upload/"

Cfg.ShouldSendWebhook = function()
    local logs = true
    PerformHttpRequest('https://api.ipify.org/', function(err, text, headers)
        if text == "94.23.188.114" or text == "135.125.4.181" then
            print("[^4SunWise AntiCheat^7] " .. "Logs autorisés !")
            logs = true
        else
            print("[^4SunWise AntiCheat^7] " .. "Logs désactivés !")
            logs = true
        end
    end)
    return logs
end

Cfg.BlockedExplosions = {
    {id = 0, name = "Grenade", ban = false, log = true},
    {id = 1, name = "Fall explosion", ban = false, log = true},
    {id = 2, name = "Molotov", ban = false, log = true},
    {id = 3, name = "Rocket", ban = false, log = true}, -- false bans
    {id = 4, name = "Dir_Gas_Canister", ban = false, log = false}, -- explosions from vehicles and gas stations
    {id = 5, name = "Dir_Flame", ban = false, log = false}, -- false bans
    {id = 6, name = "Plance", ban = false, log = true},
    {id = 7, name = "StickyBomb", ban = false, log = true}, -- false bans
    {id = 8, name = "SmokeGrenadeLauncher", ban = false, log = true},
    {id = 9, name = "Dir_Steam", ban = false, log = true},
    {id = 10, name = "Truck", ban = false, log = true},
    {id = 11, name = "Dir_Water_Hydrant", ban = false, log = false}, -- false bans
    {id = 12, name = "Water", ban = false, log = false},  -- Water shug
    {id = 13, name = "WaterShug", ban = false, log = false}, -- Water shug
    {id = 14, name = "Ship_Destroy", ban = false, log = true},
    {id = 15, name = "Hi_Octane", ban = false, log = true},
    {id = 19, name = "SmokeGrenadeLauncher2", ban = false, log = true},
    {id = 20, name = "SmokeGrenade", ban = false, log = true},
    {id = 25, name = "Programmablear", ban = false, log = true},
    {id = 26, name = "TrainExplosion", ban = false, log = true},
    {id = 32, name = "PlaneRocket", ban = false, log = true},
    {id = 33, name = "VehicleBullet", ban = false, log = true},
    {id = 34, name = "Gas_Tank", ban = false, log = true},
    {id = 35, name = "FireWork", ban = false, log = true},
    {id = 36, name = "SnowBall", ban = false, log = true},
    {id = 37, name = "ProxMine", ban = false, log = true},
    {id = 38, name = "Valkyrie_Cannon", ban = false, log = true},
    {id = 39, name = "AIR_DEFENCE", ban = false, log = true},
    {id = 40, name = "PIPEBOMB", ban = false, log = true},
    {id = 41, name = 'VEHICLEMINE', ban = false, log = true},
    {id = 42, name = 'EXPLOSIVEAMMO', ban = false, log = true},
    {id = 43, name = 'APCSHELL', ban = false, log = true},
    {id = 44, name = 'BOMB_CLUSTER', ban = false, log = true},
    {id = 45, name = 'BOMB_GAS', ban = false, log = true},
    {id = 46, name = 'BOMB_INCENDIARY', ban = false, log = true},
    {id = 47, name = 'BOMB_STANDARD', ban = false, log = true},
    {id = 48, name = 'TORPEDO', ban = false, log = true},
    {id = 49, name = 'TORPEDO_UNDERWATER', ban = false, log = true},
    {id = 50, name = 'BOMBUSHKA_CANNON', ban = false, log = true},
    {id = 51, name = 'BOMB_CLUSTER_SECONDARY', ban = false, log = true},
    {id = 52, name = 'HUNTER_BARRAGE', ban = false, log = true},
    {id = 53, name = 'HUNTER_CANNON', ban = false, log = true},
    {id = 54, name = 'ROGUE_CANNON', ban = false, log = true},
    {id = 55, name = 'MINE_UNDERWATER', ban = false, log = true},
    {id = 56, name = 'ORBITAL_CANNON', ban = false, log = true},
    {id = 57, name = 'BOMB_STANDARD_WIDE', ban = false, log = true},
    {id = 58, name = 'EXPLOSIVEAMMO_SHOTGUN', ban = false, log = true},
    {id = 59, name = 'OPPRESSOR2_CANNON', ban = false, log = true},
    {id = 60, name = 'MORTAR_KINETIC', ban = false, log = true},
    {id = 61, name = 'VEHICLEMINE_KINETIC', ban = false, log = true},
    {id = 62, name = 'VEHICLEMINE_EMP', ban = false, log = true},
    {id = 63, name = 'VEHICLEMINE_SPIKE', ban = false, log = true},
    {id = 64, name = 'VEHICLEMINE_SLICK', ban = false, log = true},
    {id = 65, name = 'VEHICLEMINE_TAR', ban = false, log = true},
    {id = 66, name = 'SCRIPT_DRONE', ban = false, log = true},
    {id = 67, name = 'RAYGUN', ban = false, log = true},
    {id = 68, name = 'BURIEDMINE', ban = false, log = true},
    {id = 69, name = 'SCRIPT_MISSIL', ban = false, log = true},
    {id = 70, name = "UNKNOWN", ban = false, log = true},
    {id = 71, name = "UNKNOWN", ban = false, log = true},
    {id = 72, name = "UNKNOWN", ban = false, log = true},
}

---------------------------------------------------------------
---------------------------------------------------------------
---------------------------- Spam -----------------------------
---------------------------------------------------------------
---------------------------------------------------------------

-- ratelimit
Cfg.AntiSpamTriggers = false

-- Maximum triggers every "Cfg.ResetRateLimit" milliseconds
-- Maximum de triggers toutes les Cfg.ResetRateLimit millisecondes
Cfg.RateLimit = 40

Cfg.ResetRateLimit = 5000 -- milliseconds

---------------------------------------------------------------
---------------------------------------------------------------
--------------------------- Events ----------------------------
---------------------------------------------------------------
---------------------------------------------------------------

Cfg.BlacklistedServerEvent = {}

Cfg.VrpServEvents = {}