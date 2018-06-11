local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_NONE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POFF)

local count_down = {}

local function unleashAttack(bossPos)
	local spec = Game.getSpectators(bossPos, false, true, 30, 30, 30, 30)
	if spec ~= nil then
		for _, s in pairs(spec) do
			if isPlayer(s) then		
				s:getPosition():sendMagicEffect(47)
				s:addHealth(-s:getMaxHealth()*0.1)
			end
		end
	end	
end
 

local function doSendAnimatedText2(fromPos, text, color, cid)
	local monster = Monster(cid)
	if monster then
		stopFor(monster.uid, 20000)		
		if tonumber(text) then
			text = tonumber(text)
			local item = Tile(fromPos):getItemById(7487)
			local monsterPos = monster:getPosition()
		--	if (playerPos == fromPos) then
			if item then
				for mw = 1, 20 do
					local o = 20 - mw
					stopEvent(count_down[mw])
					Creature.allowMovement(monster, true)	
					returnSpeed(monster.uid)	
					local item = Tile(fromPos):getItemById(7487)
					if item then
						item:remove(1)
					end					
					local spec = Game.getSpectators(fromPos, false, false, 15, 15, 15, 15)
					if spec ~= nil then
						for _, s in pairs(spec) do
							if isPlayer(s) then		
								s:sendTextMessage(MESSAGE_INFO_DESCR, "Boss got scared of the mouse and stopped unleashing the powerful attack.")
							end
						end
					end						
				end				
			elseif text >= 1 then
				monster:say(text, TALKTYPE_MONSTER_SAY, false, nil, fromPos)			
			elseif text == 0 then
				for k=1, 5 do
					addEvent(unleashAttack, k * 1000, monsterPos)
					Creature.allowMovement(monster, true)	
					returnSpeed(monster.uid)
				end
			else
				return false
			end
		--	else
		--		return
		--	end
		end
	end
end

function onCastSpell(creature, var)
	local current_time = os.time()
	local wait = 60 * 7
	local gameTimeStorage = 71516
	local gameStorage = Game.getStorageValue(gameTimeStorage)
	gameStorage = not gameStorage and 0 or gameStorage
	if gameStorage > current_time then
		return true
	end

	if creature:getHealth() <= creature:getMaxHealth()*0.4 then
		stopFor(creature.uid, 20000)
		Creature.allowMovement(creature, false)	
		local item = Game.createItem(7487, 1, Position(1287, 993, 13))
		Position(1287, 993, 13):sendMagicEffect(56)
		local bossPos = creature:getPosition()
		Game.setStorageValue(gameTimeStorage, os.time() + wait)	
		local spec = Game.getSpectators(bossPos, false, false, 15, 15, 15, 15)
		if spec ~= nil then
			for _, s in pairs(spec) do
				if isPlayer(s) then		
					s:sendTextMessage(MESSAGE_INFO_DESCR, "Quick! Monster is gathering energy to unleash a powerful attack. Take the toy mouse from the top of the cave and throw it under monster to scare him away!")
				end
			end
		end	
		for mw = 1, 20 do
			local o = 20 - mw		
			count_down[mw] = addEvent(doSendAnimatedText2, mw * 1000, bossPos, o >= 0 and tostring(o), TELEPORT_COLOR, creature.uid)
		end
	end

	return combat:execute(creature, var)
end