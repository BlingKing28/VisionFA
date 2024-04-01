local TrustedPlayers = {}
CreateThread(function()
    local Trusted = LoadResourceFile(GetCurrentResourceName(), 'trustfactor.json')
	TrustedPlayers = Trusted and json.decode(Trusted) or {}
    Wait(5000)
    while true do 
        Wait(60000*5)        
	    SaveResourceFile(GetCurrentResourceName(), 'trustfactor.json', json.encode(TrustedPlayers))
    end
end)

local function UpdatePlayerTrustFactor(ply)
    local license = "N/A"
    local found = false
    for k,v in ipairs(GetPlayerIdentifiers(ply))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end
    end
    Wait(200)
    for k,v in pairs(TrustedPlayers) do 
        if v.license == license then 
            v.trustFactor = v.trustFactor + 1
            found = true
        end
        Wait(10)
    end
    Wait(1000)
    if not found then 
        table.insert(TrustedPlayers, {license = license, trustFactor = 1})
    end
end

RegisterNetEvent("swac:playerActive", function()
    local src = source 
    UpdatePlayerTrustFactor(source)
end)