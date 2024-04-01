Context = {
	MouseOnMenu = false,
	LiseretColor = { 3, 194, 252 },
	baseX = 0.85, -- gauche / droite ( plus grand = droite )
	baseY = 0.15, -- Hauteur ( Plus petit = plus haut )
	changedY = 0.15,
	changedX = 0.15,
	baseWidth = 0.10, -- Longueur
	baseHeight = 0.03, -- Epaisseur
	targetEntity = 0,
	title = "Contexte menu",
	allowedDistance = 1.5,

	buttons = {

	}
}

function Context.setTitle(title)
	Context.title = title
end

function Context.setTargetEntity(entity)
	Context.targetEntity = entity
end

function Context.setX(x)
	Context.baseX = x
end

function Context.upY(number)
	Context.baseY = Context.baseY - number
end

function Context.setY(y)
	Context.baseY = y
end

function Context.setButtons(button)
	Context.buttons = button
end

function Context.addButtons(button)
	table.insert(Context.buttons, button)
end

function Context.isMouseOnButton(position, buttonPos)

	return position.x >= buttonPos.x and position.y >= buttonPos.y and position.x < buttonPos.x + Context.baseWidth and
		position.y < buttonPos.y + Context.baseHeight
end

-- Returns:
-- 0 = no entity
-- 1 = ped
-- 2 = vehicle
-- 3 = object
---@param menu RubyUI
local contextOpen = false
function Context.GenerateMenuBasedOnEntity(entity) -- What a name lol
	local type = GetEntityType(entity)
	if type == 2 then -- Veh
		Context.allowedDistance = 3.5
		if GetDistanceBetweenCoords(p:pos(), GetEntityCoords(Context.targetEntity), true) <= Context.allowedDistance then
			local count = 0
			local tables = {}
			for k, v in pairs(GetContextActionForVeh(GetEntityModel(Context.targetEntity))) do
				count = count + 1
				table.insert(tables, {
					icon = v.icon,
					label = v.label,
					action = v.action,
					args = { entity }
				})
			end
			for k, v in pairs(GetContextVehActionByJob(pJob)) do
				count = count + 1
				table.insert(tables, {
					label = v.label,
					action = v.action,
					icon = v.icon,
					args = { entity }
				})
			end
			table.insert(tables, {
				
					icon = "car",
					label = "ID conducteur",
					action = "takeConducteurId",
					args = { entity }
				
			})
			if count == 0 then
				OpenContextMenu(
					{
						{
							icon = "car",
							label = "Rentrer dans le coffre",
							action = "putInTrunk",
							args = { entity }
						},
						{
							icon = "car",
							label = "Ouvrir le capot",
							action = "openHood",
							args = { entity }
						},
						{
							icon = "car",
							label = "Ouvrir le coffre",
							action = "openTrunk",
							args = { entity }
						},
						{
							icon = "car",
							label = "Verouiller / Déverouiller",
							action = "useKey",
							args = { entity }
						},
					})
			else
				OpenContextMenu({ table.unpack(tables) })
			end
		else
			--ShowNotification("Tu es trop loin")
			exports['vNotif']:createNotification({
				type = 'ROUGE',
				-- duration = 5, -- In seconds, default:  4
				content = 'Tu es trop loin'
			})
		end

	elseif type == 1 then
		Context.allowedDistance = 1.5
		if GetDistanceBetweenCoords(p:pos(), GetEntityCoords(Context.targetEntity), true) <= Context.allowedDistance then
			if PlayerPedId() == entity then
				if isPlayerPed() then 
					OpenContextMenu(
						{
							{
								icon = "move",
								label = "Désactiver le combat",
								action = "disableMelee",
								args = { entity }
							},
							{
								icon = "ramasser",
								label = "Détacher l'objet",
								action = "DetachObjet",
								args = { entity }
							},
							{
								icon = "Fouiller",
								label = "Retirer un props",
								action = "DetachProps",
								args = { entity }
							},
						}
					)
				else
					OpenContextMenu(
						{
							{
								icon = "move",
								label = "Désactiver le combat",
								action = "disableMelee",
								args = { entity }
							},
							{
								icon = "ramasser",
								label = "Détacher l'objet",
								action = "DetachObjet",
								args = { entity }
							},
						}
					)
				end
			end
			if IsPedAPlayer(entity) and PlayerPedId() ~= entity then
				local tables = {
				}
				local count = 0
				for k, v in pairs(GetContextPedActionByJob(pJob)) do
					count = count + 1
					table.insert(tables, {
						icon = v.icon,
						label = v.label,
						action = v.action,
						args = { entity }
					})
				end
				table.insert(tables,{
					icon = "move",
					label = "ID Joueur",
					action = "ShowIds",
					args = { entity }
				})
				if count == 0 then
					local player = NetworkGetPlayerIndexFromPed(entity)
					local sID = GetPlayerServerId(player)
					OpenContextMenu(
						{
							{
								icon = "Facture",
								label = "Facture personelle",
								action = "MakeBillingPlayer",
								args = { entity }
							},
							{
								icon = "move",
								label = "Suivant",
								action = "contextMenuPage2",
								args = { entity }
							},
							{
								icon = "move",
								label = "ID Joueur",
								action = "ShowIds",
								args = { entity }
							},
						})
				else
					OpenContextMenu({ table.unpack(tables) })
				end

			else

			end
		else
			-- ShowNotification("Tu es trop loin")

			exports['vNotif']:createNotification({
				type = 'ROUGE',
				-- duration = 5, -- In seconds, default:  4
				content = 'Tu es trop loin'
			})
		end
		-- end
	elseif type == 3 then
		Context.allowedDistance = 2.2
		if GetDistanceBetweenCoords(p:pos(), GetEntityCoords(Context.targetEntity), true) <= Context.allowedDistance then
			local tables = {}
			local count = 0
			-- 	menu:SetTitle("Objet")
			-- 	local count = 0
			-- 	for k, v in pairs(GetContextActionForObject(GetEntityModel(Context.targetEntity))) do
			-- 		count = count + 1
			-- 		menu:AddButton(v.text, {
			-- 			onClick = function()

			-- 				v.action(entity)
			-- 			end,
			-- 		})
			-- 	end

			for k, v in pairs(GetContextActionForObject(GetEntityModel(Context.targetEntity))) do
				count = count + 1
				table.insert(tables, {
					icon = v.icon,
					label = v.label,
					action = v.action,
					args = { entity }
				})
			end
			if count == 0 then
				OpenContextMenu(
					{
						-- {
						-- 	icon = "car",
						-- 	label = "Ouvrir le coffre",
						-- 	action = "test",
						-- 	args = { entity }
						-- },
					})
			else
				OpenContextMenu({ table.unpack(tables) })
			end
		else
			-- ShowNotification("Tu es trop loin")

			exports['vNotif']:createNotification({
				type = 'ROUGE',
				-- duration = 5, -- In seconds, default:  4
				content = 'Tu es trop loin'
			})
		end
		-- 		menu:AddButton("Aucune action", {
		-- 			onClick = function()

		-- 			end,
		-- 		})
		-- 	end
		-- else
		-- 	Context.setButtons({})
	end
end

function DrawRectangle(position, size, color)
	local pos = (position + size / 2.0)
	DrawRect(pos[1], pos[2], size[1], size[2], color[1], color[2], color[3], color[4])
end

function Context.render()
	local posX = GetControlNormal(0, 239)
	local posY = GetControlNormal(0, 240)


	local y = Context.baseY + (0.032 * #Context.buttons)
	local toRemove
	Context.changedX = Context.baseX
	if y >= 0.97 then
		toRemove = y - 0.97
		Context.changedX = Context.baseX + 0.010
	else
		toRemove = 0.0
	end
	Context.changedY = Context.baseY - toRemove


	Context.MouseOnMenu = false


	for i = 1, #Context.buttons do

		if Context.isMouseOnButton({ x = posX, y = posY }, { x = Context.changedX, y = Context.changedY + (0.032 * i) }) then
			Context.MouseOnMenu = true
			if IsControlJustReleased(0, 24) then

				if GetDistanceBetweenCoords(p:pos(), GetEntityCoords(Context.targetEntity), true) <= Context.allowedDistance then
					ClosetContextMenu()
					Context.buttons[i].action(Context.targetEntity)
				else
					-- ShowNotification("Tu es trop loin")

					exports['vNotif']:createNotification({
						type = 'ROUGE',
						-- duration = 5, -- In seconds, default:  4
						content = 'Tu es trop loin'
					})
				end
			end
		end

	end

end

local function OpenContextMenu(table)
	if not contextOpen then
		contextOpen = true
		CreateThread(function()
			while contextOpen do
				Wait(0)
				DisableControlAction(0, 1, contextOpen)
				DisableControlAction(0, 2, contextOpen)
				DisableControlAction(0, 142, contextOpen)
				DisableControlAction(0, 18, contextOpen)
				DisableControlAction(0, 322, contextOpen)
				DisableControlAction(0, 106, contextOpen)
				DisableControlAction(0, 24, true) -- disable attack
				DisableControlAction(0, 25, true) -- disable aim
				DisableControlAction(0, 263, true) -- disable melee
				DisableControlAction(0, 264, true) -- disable melee
				DisableControlAction(0, 257, true) -- disable melee
				DisableControlAction(0, 140, true) -- disable melee
				DisableControlAction(0, 141, true) -- disable melee
				DisableControlAction(0, 142, true) -- disable melee
				DisableControlAction(0, 143, true) -- disable melee
			end
		end)
		SetNuiFocusKeepInput(true)
		SetNuiFocus(true, true)
		CreateThread(function()
			SendNuiMessage(json.encode({
				type = 'openWebview',
				name = 'Interaction',
				data = {
					position = { x = GetControlNormal(0, 239), y = GetControlNormal(0, 240) },
					interactions = table
				}
			}));
		end)
	else
		contextOpen = false
		SetNuiFocusKeepInput(false)
		EnableControlAction(0, 1, true)
		EnableControlAction(0, 2, true)
		EnableControlAction(0, 142, true)
		EnableControlAction(0, 18, true)
		EnableControlAction(0, 322, true)
		EnableControlAction(0, 106, true)
		SetNuiFocus(false, false)
		SendNuiMessage(json.encode({
			type = 'closeWebview',
		}))
		return
	end
end

RegisterNUICallback("focusOut", function(data, cb)
	-- ExecuteCommand("e c")
	if contextOpen then
		contextOpen = false
		EnableControlAction(0, 1, true)
		EnableControlAction(0, 2, true)
		EnableControlAction(0, 142, true)
		EnableControlAction(0, 18, true)
		EnableControlAction(0, 322, true)
		EnableControlAction(0, 106, true)
	end
	cb({})
end)
