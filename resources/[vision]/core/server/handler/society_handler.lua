society = {}

local function LoadAllSociety()
	MySQL.Async.fetchAll('SELECT * FROM society', {}, function(result)
		for k, v in pairs(result) do
			society[result[k].name] = {}
			society[result[k].name].id = result[k].id
			society[result[k].name].name = result[k].name
			society[result[k].name].inventory = json.decode(result[k].inventory)
			if society[result[k].name].inventory.item == nil then -- Convetion ancine système inventaire
				local inv = society[result[k].name].inventory
				society[result[k].name].inventory = {}
				society[result[k].name].inventory.item = inv
				society[result[k].name].inventory.cloths = {}
			end
			if society[result[k].name].inventory.weapons == nil then -- Convetion ancine système inventaire
				society[result[k].name].inventory.weapons = {}
			end
			society[result[k].name].needSave = false
			society[result[k].name].employee = {}
			society[result[k].name].timeout = false
			CorePrint("Loaded society ^2" .. society[result[k].name].name .. "^7")
		end
		for k, v in pairs(jobs) do
			if society[v.name] == nil then
				society[v.name] = {}
				society[v.name].name = v.name
				society[v.name].inventory = { item = {}, cloths = {}, weapons = {}, perm = {recrute = 1,exclure = 1,editPerm = 1,editMembres = 1,sendDm = 1}}
				society[v.name].needSave = false
				society[v.name].employee = {}
				society[v.name].timeout = false
				MySQL.Async.insert("INSERT INTO society (name, inventory) VALUES (@1, @2)",
					{
						['1'] = society[v.name].name,
						['2'] = json.encode(society[v.name].inventory),
					},
					function(affectedRows)
						CorePrint("Society ^2" .. v.name .. "^7 inséré en BDD")
						CorePrint("Society ^2" .. affectedRows .. "^7 inséré en BDD")
						Bank.CreateSocietyCommonAccount(affectedRows)
					end)
			end
		end
	end)
end

LoadAllSociety()

function GetSocietyId(societys)
	return society[societys].id
end

local function SaveSociety(name)
	MySQL.Async.execute("UPDATE society SET inventory = @1 WHERE name = @name",
		{
			['@1'] = json.encode(society[name].inventory),
			['@name'] = society[name].name,
		},
		function(affectedRows)
			CorePrint("Society " .. society[name].name .. " saved. (" .. affectedRows .. ")")
		end)
	society[name].needSave = false
end

function MarkSocietyAsNotSaved(name)
	if society[name] ~= nil then
		society[name].needSave = true
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(15 * 60000)
		for k, v in pairs(society) do
			if v.needSave then
				SaveSociety(v.name)
				society[v.name].needSave = false
			end
			Wait(1000)
		end
	end
end)


function StartSocietyTimeout(name)
	Citizen.CreateThread(function()
		society[name].timeout = true
		Wait(10 * 1000)
		society[name].timeout = false
	end)
end

function GetSocietyEmployeeList(name)
	if society[name].timeout then
		return society[name].employee
	else
		society[name].employee = {}
		local result = MySQL.Sync.fetchAll('SELECT id, license, firstname, lastname, job_grade FROM players WHERE job = @1', {
			["@1"] = name,
		})
		for k, v in pairs(result) do
			local identity = json.decode(v.identity)
			table.insert(society[name].employee,
				{ id = v.id, license = v.license, nom = v.lastname, prenom = v.firstname, grade = v.job_grade })
		end
		CorePrint("Refreshed society ^2" .. name .. " employee list^7 (Request by job)")
		StartSocietyTimeout(name)

		return society[name].employee
	end
end

function GetSocietyVehList(name)
	local result = MySQL.Sync.fetchAll('SELECT * FROM vehicles WHERE job = @1', {
		["@1"] = name,
	})
	return result
end

function GetSocietyPropertyList(name)
	local result = MySQL.Sync.fetchAll('SELECT * FROM property WHERE crew = @1', {
		["@1"] = name,
	})
	return result
end

function GetSocietyInfoList(name)
	local result = MySQL.Sync.fetchAll('SELECT * FROM society WHERE name = @1', {
		["@1"] = name,
	})
	return result
end
-- function RefreshSocietyInventory(name)
-- 	local players = GetPlayerFromInventoryRefresh(name)
-- 	for k, v in pairs(players) do
-- 		TriggerClientEvent("inventory:refresh", k)
-- 	end
-- end

function AddMoneyToSociety(amount, name)
	local bank = Bank.GetSocietyAccountWithName(name)
	for k, v in pairs(bank) do
		local result = v.balance + amount
		Bank.setMoneyAccount(v.account_number, result)
		return
	end
end

exports('AddMoneyToSociety', AddMoneyToSociety)

function AddItemInventorySociety(societys, item, count, metadatas)
	AddItemToInventorySociety(societys, item, count, metadatas)
	-- RefreshSocietyInventory(societys)
	MarkSocietyAsNotSaved(societys)
end

function RemoveItemInventorySociety(societys, item, count, metadatas)
	RemoveItemFromInventorySociety(societys, item, count, metadatas)
	-- RefreshSocietyInventory(societys)
	MarkSocietyAsNotSaved(societys)
end

RegisterNetEvent("core:addItemToInventorySociety")
AddEventHandler("core:addItemToInventorySociety", function(token, societys, item, count, metadata)
	local source = source
	if CheckPlayerToken(source, token) then
		AddItemInventorySociety(societys, item, count, metadata)
	end
end)

RegisterNetEvent("core:RemoveItemToInventorySociety")
AddEventHandler("core:RemoveItemToInventorySociety", function(token, societys, item, count, metadata)
	local source = source
	if CheckPlayerToken(source, token) then
		RemoveItemInventorySociety(societys, item, count, metadata)
	end
end)

RegisterServerCallback("core:addItemToInventorySociety", function(source, token, societys, item, count, metadata)
	local source = source
	if CheckPlayerToken(source, token) then
		if getInventoryWeightSociety(societys) + getItemWeight(item) * count <= 500 then
			AddItemInventorySociety(societys, item, count, metadata)
			return true
		end
		return false
	end
end)

RegisterServerCallback("core:RemoveItemToInventorySociety", function(source, token, societys, item, count, metadata)
	local source = source
	if CheckPlayerToken(source, token) then
		local itemWeight = GetItemWeightWithCount(item, count)
		if getInventoryWeight(source) + itemWeight <= items.maxWeight then
			RemoveItemInventorySociety(societys, item, count, metadata)
			return true
		end
		return false
	end
end)

function RemoveMoneyToSociety(amount, name)
	local bank = Bank.GetSocietyAccountWithName(name)
	for key, value in pairs(bank) do
		local result = value.balance - amount
		Bank.setMoneyAccount(value.account_number, result)
		return true
	end
	return false
end

function PaySociety(source, amount, name)

	if RemoveItemToPlayerStaff(source, "money", tonumber(amount)) then
		AddItemToInventory(name, "money", tonumber(amount), {})
		RefreshSocietyInventory(name)
		MarkSocietyAsNotSaved(name)
	else
		--[[ Ancienne notification
		TriggerClientEvent("core:ShowNotification", source,
			"Erreur au moment du transfert de l'argent, merci de vérifier le montant.")
		--]]

		-- New notif
		TriggerClientEvent("__vision::createNotification", source, {
			type = 'ROUGE',
			-- duration = 5, -- In seconds, default:  4
			content = "Vérifiez le montant suite à une erreur de transfert de l'argent."
		})
		
	end
end

-- function SendItemToSociety(source, item, amount, name)
-- 	if RemoveItemToPlayerStaff(source, item, tonumber(amount)) then
-- 		AddItemToInventory(name, item, tonumber(amount), true)
-- 		RefreshSocietyInventory(name)
-- 		MarkSocietyAsNotSaved(name)
-- 	else
-- 		TriggerClientEvent("core:ShowNotification", source,
-- 			"Erreur au moment du transfert de l'item, merci de vérifier le montant.")
-- 	end
-- end

function SendItemFromSocietyToPlayerInventory(source, item, amount, countSee, name)
	if CanInventoryTakeItem(GetPlayer(source):getInventaire(), item, amount) then
		if RemoveItemFromInventory(society[name].inventory.item, item, amount, countSee) then
			AddItemToInventory(GetPlayer(source):getInventaire(), item, amount, {})
			RefreshSocietyInventory(name)
			MarkSocietyAsNotSaved(name)
			--RefreshPlayerData(source)
		else
			--[[ Ancienne notification
			TriggerClientEvent("core:ShowNotification", source,
				"Erreur au moment du transfert de l'item, merci de vérifier le montant.")
			--]]

			-- New notif
			TriggerClientEvent("__vision::createNotification", source, {
				type = 'ROUGE',
				-- duration = 5, -- In seconds, default:  4
				content = "Vérifiez le montant suite à une erreur de transfert de l'item."
			})
		end
	else
		-- TriggerClientEvent("core:ShowNotification", source, "Tu portes trop de choses.")

		-- New notif
		TriggerClientEvent("__vision::createNotification", source, {
			type = 'ROUGE',
			-- duration = 5, -- In seconds, default:  4
			content = "Tu portes trop de choses."
		})
	end
end

function SendWeaponToSociety(source, index, name, count, gxt)
	local player = GetPlayer(source)
	if player:HaveWeapon(name) then
		player:RemoveWeapon(name)

		AddWeaponToInventory(society[player:getJob()].inventory.weapons, name, count, gxt)
		RefreshSocietyInventory(player:getJob())
		MarkSocietyAsNotSaved(player:getJob())
		--RefreshPlayerData(source)
	end
end

function SendWeaponFromSocietyToPlayerInventory(source, index, name)
	local player = GetPlayer(source)
	if society[player:getJob()].inventory.weapons[index] ~= nil then
		if society[player:getJob()].inventory.weapons[index].name == name then
			if player:AddWeaponIfPossible(name, society[player:getJob()].inventory.weapons[index].count) then
				RemoveWeaponFromInventory(society[player:getJob()].inventory.weapons, index, name)
				RefreshSocietyInventory(player:getJob())
				MarkSocietyAsNotSaved(player:getJob())
				--RefreshPlayerData(source)
			else
				-- TriggerClientEvent("inventory:Notify", source, "Tu possède déja une arme similaire sur toi!", true)

				-- New notif
				TriggerClientEvent("__vision::createNotification", source, {
					type = 'ROUGE',
					-- duration = 5, -- In seconds, default:  4
					content = "Tu possède déjà une arme similaire sur toi !"
				})

			end
		end
	end
end

-- @events

Citizen.CreateThread(function()
	while RegisterServerCallback == nil do Wait(1000) end
	RegisterServerCallback("core:GetSocietyInventoryItem", function(source, name)
		-- local player = GetPlayer(source)
		-- AddPlayerToInventoryRefresh(player:getJob(), source)
		return society[name].inventory.item
	end)
end)

RegisterNetEvent("core:OpenSocietyInventory")
AddEventHandler("core:OpenSocietyInventory", function(name)
	if GetPlayer(source):getJob() == name then
		-- AddPlayerToInventoryRefresh(name, source)
		TriggerClientEvent("core:RefreshSocietyInventory", source, society[name].inventory)
	else
		-- TODO Ac detection
	end
end)

RegisterNetEvent("core:CloseSocietyInventory")
AddEventHandler("core:CloseSocietyInventory", function(name)
	if GetPlayer(source):getJob() == name then
		RemovePlayerFromInventoryRefresh(name, source)
	else
		-- TODO Ac detection
	end
end)

RegisterNetEvent("core:AddItemToSociety")
AddEventHandler("core:AddItemToSociety", function(token, item, amount, name)
	if GetPlayer(source):getJob() == name then
		if CheckPlayerToken(source, token) then
			SendItemToSociety(source, item, amount, name)
		end
	else
		-- TODO Ac detection
	end
end)

RegisterNetEvent("core:RemoveItemFromSociety")
AddEventHandler("core:RemoveItemFromSociety", function(token, item, amount, countSee, name)
	if GetPlayer(source):getJob() == name then
		if CheckPlayerToken(source, token) then
			SendItemFromSocietyToPlayerInventory(source, item, amount, countSee, name)
		end
	else
		-- TODO Ac detection
	end
end)

RegisterNetEvent("core:SendWeaponToSociety")
AddEventHandler("core:SendWeaponToSociety", function(token, index, societyName, name, count, gxt)
	if GetPlayer(source):getJob() == societyName then
		if CheckPlayerToken(source, token) then
			SendWeaponToSociety(source, index, name, count, gxt)
		end
	else
		-- TODO Ac detection
	end
end)


RegisterNetEvent("core:SendWeaponFromSocietyToPlayerInventory")
AddEventHandler("core:SendWeaponFromSocietyToPlayerInventory", function(token, index, societyName, name)
	if GetPlayer(source):getJob() == societyName then
		if CheckPlayerToken(source, token) then
			SendWeaponFromSocietyToPlayerInventory(source, index, name)
		end
	else
		-- TODO Ac detection
	end
end)

RegisterNetEvent("core:RecruitPlayer")
AddEventHandler("core:RecruitPlayer", function(token, target, job, grade)
	local source = source
	if GetPlayer(source):getJob() == job then
		if CheckPlayerToken(source, token) then
			if jobs[GetPlayer(source):getJob()].grade[GetPlayer(source):getJobGrade()].gestion then
				ChangePlayerJob(target, job, grade)
				-- TriggerClientEvent("core:ShowNotification", source, "La personne a été recrutée.")

				-- New notif
				TriggerClientEvent("__vision::createNotification", source, {
					type = 'VERT',
					-- duration = 5, -- In seconds, default:  4
					content = "La personne a été ~s recrutée."
				})

			else
				-- TODO Ac detection
			end
		end
	else
		-- TODO Ac detection
	end
end)

RegisterNetEvent("core:KickPlayerFromJob")
AddEventHandler("core:KickPlayerFromJob", function(token, targetLicense, targetId, name)
	local source = source
	if GetPlayer(source):getJob() == name then
		if CheckPlayerToken(source, token) then
			--if jobs[GetPlayer(source):getJob()].grade[GetPlayer(source):getJobGrade()].gestion then
				local player = GetPlayerFromLicenseIfExist(targetLicense)
				if player ~= false then -- Connected
					ChangePlayerJob(player, "aucun", 1)
				else -- Not connected
					ChangePlayerJobOffline(targetId, "aucun", 1)
				end
				
				-- TriggerClientEvent("core:ShowNotification", source, "La personne a été virée.")

				-- New notif
				TriggerClientEvent("__vision::createNotification", source, {
					type = 'VERT',
					-- duration = 5, -- In seconds, default:  4
					content = "La personne a été ~s virée."
				})

				for k, v in pairs(society[name].employee) do
					if v.license == targetLicense then
						table.remove(society[name].employee, k)
						break
					end
				end

				TriggerClientEvent("core:GetEmployeeList", source, society[name].employee)
			--else
				-- TODO Ac detection
			--end
		end
	else
		-- TODO Ac detection
	end
end)

RegisterNetEvent("core:PromotePlayer")
AddEventHandler("core:PromotePlayer", function(token, targetLicense, targetId, job, grade)
	local source = source
	if GetPlayer(source):getJob() == job then
		if CheckPlayerToken(source, token) then
			--if jobs[GetPlayer(source):getJob()].grade[GetPlayer(source):getJobGrade()].gestion then
				local player = GetPlayerFromLicenseIfExist(targetLicense)
				if player ~= false then -- Connected
					ChangePlayerJob(player, job, grade)
				else -- Not connected
					ChangePlayerJobOffline(targetId, job, grade)
				end
				-- TriggerClientEvent("core:ShowNotification", source, "La personne a été promue.")

				-- New notif
				TriggerClientEvent("__vision::createNotification", source, {
					type = 'VERT',
					-- duration = 5, -- In seconds, default:  4
					content = "La personne a été ~s promue."
				})
				
				for k, v in pairs(society[job].employee) do
					if v.license == targetLicense then
						society[job].employee[k].grade = grade
						break
					end
				end
				TriggerClientEvent("core:GetEmployeeList", source, society[job].employee)
			--else
				-- TODO Ac detection
			--end
		end
	else
		-- TODO Ac detection
	end
end)

RegisterNetEvent("core:GetEmployeeList")
AddEventHandler("core:GetEmployeeList", function(token, name)
	local source = source
	if GetPlayer(source):getJob() == name then
		if CheckPlayerToken(source, token) then
			TriggerClientEvent("core:GetEmployeeList", source, GetSocietyEmployeeList(name))
		end
	else
		-- TODO Ac detection
	end
end)

RegisterNetEvent("core:getJobVeh")
AddEventHandler("core:getJobVeh", function(token, name)
	local source = source
	if GetPlayer(source):getJob() == name then
		if CheckPlayerToken(source, token) then
			TriggerClientEvent("core:getJobVeh", source, GetSocietyVehList(name))
		end
	else
		-- TODO Ac detection
	end
end)

RegisterNetEvent("core:getJobProperty")
AddEventHandler("core:getJobProperty", function(token, name)
	local source = source
	if GetPlayer(source):getJob() == name then
		if CheckPlayerToken(source, token) then
			TriggerClientEvent("core:getJobProperty", source, GetSocietyPropertyList(name))
		end
	else
		-- TODO Ac detection
	end
end)

RegisterNetEvent("core:getJobInfo")
AddEventHandler("core:getJobInfo", function(token, name)
	local source = source
	if GetPlayer(source):getJob() == name then
		if CheckPlayerToken(source, token) then
			TriggerClientEvent("core:getJobInfo", source, GetSocietyInfoList(name))
		end
	else
		-- TODO Ac detection
	end
end)

CreateThread(function()
	while RegisterServerCallback == nil do Wait(0) end
	RegisterServerCallback("core:getEmployees", function(source, token)
		if CheckPlayerToken(source, token) then
			local player = GetPlayer(source)
			if player:getJob() ~= "aucun" then
				return GetSocietyEmployeeList(player:getJob())
			end
			return {}
		end
	end)
end)

RegisterNetEvent("core:AddClothToSociety")
AddEventHandler("core:AddClothToSociety", function(token, name, key)
	if GetPlayer(source):getJob() == name then
		if CheckPlayerToken(source, token) then
			cloths.transferToInv(source, society[name].inventory.cloths, key)
			RefreshSocietyInventory(name)
			MarkSocietyAsNotSaved(name)
		end
	else
		-- TODO Ac detection
	end
end)

RegisterNetEvent("core:RemoveClothFromSociety")
AddEventHandler("core:RemoveClothFromSociety", function(token, name, key)
	if GetPlayer(source):getJob() == name then
		if CheckPlayerToken(source, token) then
			cloths.transferFromInvToPlayer(source, society[name].inventory.cloths, key)
			RefreshSocietyInventory(name)
			MarkSocietyAsNotSaved(name)
		end
	else
		-- TODO Ac detection
	end
end)

RegisterNetEvent("core:changePermsJob")
AddEventHandler("core:changePermsJob", function(token, jobName, perms)
    if CheckPlayerToken(source, token) then
        MySQL.Async.execute("UPDATE society SET perm = @perm WHERE name = @job"
            , {
                ['@perm'] = json.encode(perms),
                ['@job'] = jobName,
            }, function(affectedRows)
            CorePrint("job perms modyfied")
        end)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
	for k, v in pairs(society) do
		SaveSociety(v.name)
		society[v.name].needSave = false
	end
end)