Death = {}
Death.GetAllDamagePed = {}
Death.GetBonesType = {
    ["Dos"] = { 0, 23553, 56604, 57597 },
    ["Crâne"] = { 1356, 11174, 12844, 17188, 17719, 19336, 20178, 20279, 20623, 21550, 25260, 27474, 29868, 31086,
        35731, 43536, 45750, 46240, 47419, 47495, 49979, 58331, 61839, 39317 },
    ["Coude droit"] = { 2992 },
    ["Coude gauche"] = { 22711 },
    ["Main gauche"] = { 4089, 4090, 4137, 4138, 4153, 4154, 4169, 4170, 4185, 4186, 18905, 26610, 26611, 26612, 26613,
        26614, 60309 },
    ["Main droite"] = { 6286, 28422, 57005, 58866, 58867, 58868, 58869, 58870, 64016, 64017, 64064, 64065, 64080, 64081,
        64096, 64097, 64112, 64113 },
    ["Bras gauche"] = { 5232, 45509, 61007, 61163 },
    ["Bras droit"] = { 28252, 40269, 43810 },
    ["Jambe droite"] = { 6442, 16335, 51826, 36864 },
    ["Jambe gauche"] = { 23639, 46078, 58271, 63931 },
    ["Pied droit"] = { 20781, 24806, 35502, 52301 },
    ["Pied gauche"] = { 2108, 14201, 57717, 65245 },
    ["Poîtrine"] = { 10706, 64729, 24816, 24817, 24818 },
    ["Ventre"] = { 11816 }
}

Death.GetDeathType = { "Non-Identifiée", "Dégâts de mêlée", "Blessure par balle", "Chute", "Dégâts explosifs",
    "Feu", "Chute", "Éléctrique", "Écorchure", "Gaz", "Gaz", "Eau" }

Death.GetValueWithTable = function(value, table, number)
    if not value or not table or type(value) ~= "table" then
        return
    end
    for k, v in pairs(value) do
        if number and v[number] == table or v == table then
            return true, k
        end
    end
end

local meleeWeapon = {
    GetHashKey("weapon_flashlight"),
    GetHashKey("weapon_bat"),
    GetHashKey("weapon_bottle"),
    GetHashKey("weapon_crowbar"),
    GetHashKey("weapon_golfclub"),
    GetHashKey("weapon_hatchet"),
    GetHashKey("weapon_knuckle"),
    GetHashKey("weapon_machete"),
    GetHashKey("weapon_nightstick"),
    GetHashKey("weapon_wrench"),
    GetHashKey("weapon_knife"),
    GetHashKey("weapon_switchblade"),
    GetHashKey("weapon_battleaxe"),
    GetHashKey("weapon_poolcue"),
    GetHashKey("weapon_molotov"),
    GetHashKey("weapon_snowball"),
    GetHashKey("weapon_ball"),
    GetHashKey("weapon_petrolcan"),
    GetHashKey("weapon_fireextinguisher"),
    GetHashKey("gadget_parachute"),
    GetHashKey("weapon_dagger"),
    GetHashKey("weapon_canette"),
    GetHashKey("weapon_bouteille"),
    GetHashKey("weapon_pelle"),
    GetHashKey("weapon_pickaxe"),
    GetHashKey("weapon_sledgehammer"),
    GetHashKey("weapon_katana"),
    GetHashKey("weapon_nailgun"),
    GetHashKey("weapon_beambag"),
}

local function CEventNetworkEntityDamage(victim, victimDied)
	if not IsPedAPlayer(victim) then return end
	local player = PlayerId()
    local killer, killerWeapon = NetworkGetEntityKillerOfPlayer(player)
	local playerPed = PlayerPedId()
	if victimDied and NetworkGetPlayerIndexFromPed(victim) == player and (IsPedDeadOrDying(victim, true) or IsPedFatallyInjured(victim)) then
        local killerEntity = GetPedSourceOfDeath(playerPed)
        local killerServerId = NetworkGetPlayerIndexFromPed(killerEntity)
        if killerEntity ~= playerPed and killerServerId and NetworkIsPlayerActive(killerServerId) then
            PlayerKilledByPlayer(GetPlayerServerId(killerServerId), killerServerId, killerWeapon)
        else
            PlayerKilled()
        end
	end
end

AddEventHandler('gameEventTriggered', function(event, data)
	if event ~= 'CEventNetworkEntityDamage' then return end
    --print("CEventNetworkEntityDamage")
    CEventNetworkEntityDamage(data[1], data[4])
end)

function PlayerKilledByPlayer(killerServerId, killerClientId, killerWeapon)
    local knockout = false
    local victimCoords = GetEntityCoords(PlayerPedId())
    local killerCoords = GetEntityCoords(GetPlayerPed(killerClientId))
    local distance = GetDistanceBetweenCoords(victimCoords, killerCoords, true)

    local data = {
        victimCoords = {
            x = math.round(victimCoords.x, 1),
            y = math.round(victimCoords.y, 1),
            z = math.round(victimCoords.z, 1)
        },
        killerCoords = {
            x = math.round(killerCoords.x, 1),
            y = math.round(killerCoords.y, 1),
            z = math.round(killerCoords.z, 1)
        },
        causeDeath = table.pack(p:GetAllCauseOfDeath()),
        killedByPlayer = true,
        deathCause = GetEntityModel(killerWeapon),
        distance = math.round(distance, 1),

        killerServerId = killerServerId,
        killerClientId = killerClientId
    }
    for k, v in pairs(meleeWeapon) do
        if killerWeapon == GetHashKey(v) then
            knockout = true
        end
    end
    if not knockout then
        TriggerEvent('core:onPlayerDeath', data)
        TriggerServerEvent('core:onPlayerDeath', data)
    else
        p:setHealth(20)
        SetPlayerInvincible(p:ped(), true)
        SetPedToRagdoll(p:ped(), 1000, 1000, 0, 0, 0, 0)
        -- ShowNotification("~r~Vous êtes KO")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'JAUNE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Vous êtes KO"
        })

        Modules.UI.RealWait(15 * 1000)
        SetPlayerInvincible(p:ped(), false)
    end
end

function PlayerKilled()
    local playerPed = p:ped()
    local victimCoords = p:pos()

    local data = {
        victimCoords = {
            x = math.round(victimCoords.x, 1),
            y = math.round(victimCoords.y, 1),
            z = math.round(victimCoords.z, 1)
        },

        killedByPlayer = false,
        deathCause = GetPedCauseOfDeath(playerPed)
    }

    TriggerEvent('core:onPlayerDeath', data)
    TriggerServerEvent('core:onPlayerDeath', data)
end

AddEventHandler('baseevents:onPlayerKilled', function(event, data)
	if event ~= 'CEventNetworkEntityDamage' then return end
    --print("CEventNetworkEntityDamage")
    CEventNetworkEntityDamage(data[1], data[4])
end)