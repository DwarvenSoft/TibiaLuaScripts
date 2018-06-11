local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_NONE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POFF)


function onCastSpell(creature, var)
	local current_time = os.time()
	local wait = 60 * 7
	local gameTimeStorage = 71515
	local gameStorage = Game.getStorageValue(gameTimeStorage)
	gameStorage = not gameStorage and 0 or gameStorage
	if gameStorage > current_time then
		return true
	end

	if creature:getHealth() <= creature:getMaxHealth()*0.5 then
		local bossPos = creature:getPosition()
		Game.setStorageValue(gameTimeStorage, os.time() + wait)	
		local item = Tile(Position(1294, 1048, 13)):getItemById(3687)
		if not item then
			local stairs = Game.createItem(3687, 1, Position(1294, 1048, 13)) 
		end
		local spec = Game.getSpectators(bossPos, false, false, 15, 15, 15, 15)
		if spec ~= nil then
			for _, s in pairs(spec) do
				if isMonster(s) or isPlayer(s) then		
					local pos = s:getPosition()
					local newPos = Position(pos.x, pos.y - 45 , pos.z)
					local dir = creature:getDirection()
					if isPlayer(s) then
						s:sendTextMessage(MESSAGE_INFO_DESCR, "Edit later.")
					end
					s:teleportTo(newPos)
					s:setDirection(dir)
				end
			end
		end		
	end

	return combat:execute(creature, var)
end