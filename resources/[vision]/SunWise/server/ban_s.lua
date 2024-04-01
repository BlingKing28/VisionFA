local BanList = {}

CreateThread(function()
	while true do
		Wait(60000)
		loadBanList()
	end
end)


CreateThread(function()
    MySQL.Async.fetchAll('SELECT * FROM sunwisebans', {}, function (data)
        if #data ~= #BanList then
            BanList = {}

            for i=1, #data, 1 do
            table.insert(BanList, {
                license    = data[i].license,
                identifier = data[i].identifier,
				token      = data[i].token,
                liveid     = data[i].liveid,
                xblid      = data[i].xblid,
                discord    = data[i].discord,
                playerip   = data[i].playerip,
                reason     = data[i].reason,
                added      = data[i].added,
                expiration = data[i].expiration,
                permanent  = data[i].permanent,
				banid = data[i].banid
                })
            end
        loadBanListHistory()
        end
    end)
end)

function loadBanList()
	MySQL.Async.fetchAll(
		'SELECT * FROM sunwisebans',
		{},
		function (data)
		  BanList = {}

		  for i=1, #data, 1 do
			table.insert(BanList, {
				license    = data[i].license,
				identifier = data[i].identifier,
				token      = data[i].token,
				liveid     = data[i].liveid,
				xblid      = data[i].xblid,
				discord    = data[i].discord,
				playerip   = data[i].playerip,
				reason     = data[i].reason,
				expiration = data[i].expiration,
				permanent  = data[i].permanent,
				banid = data[i].banid
			  })
		  end
    end)
end

function loadBanListHistory()
	MySQL.Async.fetchAll(
		'SELECT * FROM sunwisebanhistory',
		{},
		function (data)
		  BanListHistory = {}

		  for i=1, #data, 1 do
			table.insert(BanListHistory, {
				license          = data[i].license,
				identifier       = data[i].identifier,
				token 			 = data[i].token,
				liveid           = data[i].liveid,
				xblid            = data[i].xblid,
				discord          = data[i].discord,
				playerip         = data[i].playerip,
				targetplayername = data[i].targetplayername,
				sourceplayername = data[i].sourceplayername,
				reason           = data[i].reason,
				added            = data[i].added,
				expiration       = data[i].expiration,
				permanent        = data[i].permanent,
				timeat           = data[i].timeat
			  })
		  end
    end)
end

function deletebanned(license)
	MySQL.Async.execute(
		'DELETE FROM sunwisebans WHERE license=@license',
		{
		  ['@license']  = license
		},
		function ()
			loadBanList()
	end)
end


BanSqlPlayer = function(target, duree, reason, BanId)
	local sourceplayername = "CONSOLE"
	local targetplayername = GetPlayerName(target)
	local license, identifier, liveid, xblid, discord, playerip, token = "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A"
	for k,v in ipairs(GetPlayerIdentifiers(target))do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
			identifier = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xblid  = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			playerip = v
		end
	end
	if Cfg.UseAtLeastBuild3335 == true then
		token = GetPlayerToken(target, 4)
	end
	if duree > 0 then		
		fonctionban(license,identifier,liveid,xblid,discord,playerip,targetplayername,"SunWise Anticheat",duree,reason, 0, token, BanId) --Timed ban
		DropPlayer(target, reason .. "\n\nBan ID: ".. BanId .."\n\nBanned by SunWise Anticheat")
	else
		fonctionban(license,identifier,liveid,xblid,discord,playerip,targetplayername,"SunWise Anticheat",duree,reason, 1, token, BanId) --Perm ban
		DropPlayer(target, reason .. "\n\nBan ID: ".. BanId .."\n\nBanned by SunWise Anticheat")
	end
end

function fonctionban(license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,permanent,token, BanId)
	if targetplayername == nil then
		return
	end
	if token == nil then
		token = "N/A"
	end
	MySQL.Async.fetchAll('SELECT * FROM sunwisebans WHERE targetplayername like @playername', 
	{
		['@playername'] = ("%"..targetplayername.."%")
	}, function(data)
		if not data[1] then
			local expiration = duree * 86400 --calcul total expiration (en secondes)
			local timeat     = os.time()
			local added      = os.date()

			if expiration < os.time() then
				expiration = os.time()+expiration
			end
			
			table.insert(BanList, {
				license    = license,
				identifier = identifier,
				liveid     = liveid,
				xblid      = xblid,
				discord    = discord,
				playerip   = playerip,
				reason     = reason,
				expiration = expiration,
				permanent  = permanent,
				token = token,
				banid = BanId
			  })

			MySQL.Async.execute(
					'INSERT INTO sunwisebans (license,identifier,token,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,expiration,timeat,permanent, banid) VALUES (@license,@identifier,@token,@liveid,@xblid,@discord,@playerip,@targetplayername,@sourceplayername,@reason,@expiration,@timeat,@permanent, @banid)',
					{ 
					['@license']          = license,
					['@identifier']       = identifier,
					['@token']			  = token,
					['@liveid']           = liveid,
					['@xblid']            = xblid,
					['@discord']          = discord,
					['@playerip']         = playerip,
					['@targetplayername'] = targetplayername,
					['@sourceplayername'] = sourceplayername,
					['@reason']           = reason,
					['@expiration']       = expiration,
					['@timeat']           = timeat,
					['@permanent']        = permanent,
					['@banid']		      = BanId,
					}, function ()
			end)

			MySQL.Async.execute(
					'INSERT INTO sunwisebanhistory (license,identifier,token,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,added,expiration,timeat,permanent) VALUES (@license,@identifier,@token,@liveid,@xblid,@discord,@playerip,@targetplayername,@sourceplayername,@reason,@added,@expiration,@timeat,@permanent)',
					{ 
					['@license']          = license,
					['@identifier']       = identifier,
					['@token']			  = token,
					['@liveid']           = liveid,
					['@xblid']            = xblid,
					['@discord']          = discord,
					['@playerip']         = playerip,
					['@targetplayername'] = targetplayername,
					['@sourceplayername'] = sourceplayername,
					['@reason']           = reason,
					['@added']            = added,
					['@expiration']       = expiration,
					['@timeat']           = timeat,
					['@permanent']        = permanent,
					},
					function ()
			end)
			
			BanListHistoryLoad = false
		end
	end)

	loadBanList()
end

local function OnPlayerConnecting222(name, setKickReason, deferrals)
	local license,steamID,liveid,xblid,discord,playerip, token  = "n/a","n/a","n/a","n/a","n/a","n/a", "n/a"
	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamID = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xblid  = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			playerip = v
		end
	end

	if Cfg.UseAtLeastBuild3335 == true then
		token = GetPlayerToken(source, 4)
	else
		token = ""
	end

	if (Banlist == {}) then
		Wait(1000)
	end

	if tostring(token) == "" or tostring(token) == "N/A" or tostring(token) == "n/a" then
		token = "caca"
	end

	for i = 1, #BanList, 1 do
		if ((tostring(BanList[i].license)) == tostring(license) or (tostring(BanList[i].identifier)) == tostring(steamID) or (tostring(BanList[i].liveid)) == tostring(liveid) or (tostring(BanList[i].xblid)) == tostring(xblid) or (tostring(BanList[i].discord)) == tostring(discord) or (tostring(BanList[i].playerip)) == tostring(playerip) or (tostring(BanList[i].token)) == tostring(token)) then
			if (tonumber(BanList[i].permanent)) == 1 then
				setKickReason(string.format(CfgSH.Banned, BanList[i].reason .. "\nBan ID: " ..BanList[i].banid .."\n\nSunWise Anticheat"))
				SWPrintDebug(name .. " banned. Ban ID: " .. BanList[i].banid)
				CancelEvent()
			elseif (tonumber(BanList[i].expiration)) > os.time() then
				local tempsrestant = tonumber(BanList[i].expiration - os.time())/60
				local txtminutes = math.ceil(tempsrestant)
				if tempsrestant > 0 then
					setKickReason(string.format(CfgSH.Banned, BanList[i].reason .. "\nTime left : ".. txtminutes .."\nBan ID: " ..BanList[i].banid .."\n\nSunWise Anticheat"))			
					CancelEvent()
				end
			elseif (tonumber(BanList[i].expiration)) < os.time() and (tonumber(BanList[i].permanent)) == 0 then
				deletebanned(license)
			end
		end
	end

	if Cfg.BanFromSunwiseNetwork == true then
		local function CheckBan(err,response, headers)
			if err == 200 then
				local data = json.decode(response)
				local blackplayer = utils_Set(data.blackplayers)
				if blackplayer[license] then					
					if Cfg.BanIntoMySQL == true then
						BanSqlPlayer(source, 0, CfgSH.BannedFromSunWiseNetwork)
					end
					setKickReason(CfgSH.BannedFromSunWiseNetwork .. "\n\nSunWise Anticheat")		
					CancelEvent()
				else
					SWPrintDebug(name .. " is connecting, he is not blacklisted from the SunWise Network")
				end
			else
				if err == 502 then
					printLang("[^3Warning^7] [SunWise Network] Nous n'avons pas pu check si " .. name .. " est blacklist par SunWise Network. Erreur : 502, le site est offline\nVous pouvez vérifié le status sur discord", "[^3Warning^7] [SunWise Network] We could not check if " .. name .. " is blacklist from the SunWise Network. Error : 502, the website is offline\nYou can check the status on our discord")
				else
					printLang("[^3Warning^7] [SunWise Network] Nous n'avons pas pu check si " .. name .. " est blacklist par SunWise Network. Erreur : " .. err, "[^3Warning^7] [SunWise Network] We could not check if " .. name .. " is blacklist from the SunWise Network. Error : " .. err)
				end
			end
		end

		PerformHttpRequest("https://pastebin.com/raw/wFz8mUcc", CheckBan, "GET")
	end	
end

AddEventHandler("playerConnecting", OnPlayerConnecting222)