local function attackPlayer(cid)
	local player = Player(cid)
	local playerPos = player:getPosition()
	local dmgToPlayer = player:getMaxHealth()*0.18	
	
	player:addHealth(-dmgToPlayer)
	player:getPosition():sendMagicEffect(CONST_ME_BIGPLANTS)
end

local function doSendAnimatedText2(fromPos, text, color, cid)
	local player = Player(cid)
	if player then
		if tonumber(text) then
			text = tonumber(text)
			local playerPos = player:getPosition()
			if playerPos == fromPos then
				player:say(text, TALKTYPE_MONSTER_SAY, false, nil, fromPos)
				if(text == 0) then
					addEvent(attackPlayer, 100, player.uid)
				end
			else
				return
			end
		end
	end
end

local count_down = {}
local exhausted_storagevalue = 12592

function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end
	local player = creature:getPlayer()
	local playerPos = player:getPosition()
	
	local spec = Game.getSpectators(position, false, false, 5, 5, 5, 5)
	if spec ~= nil then
		for _, s in pairs(spec) do
			if isMonster(s) then
				if s:getName():lower() == "rotworm queen" then			
					if player:getStorageValue(exhausted_storagevalue) > os.time() then
						for mw = 0, 5 do
							stopEvent(count_down[mw])
						end		
					else
						player:setStorageValue(exhausted_storagevalue, os.time()+2)
						player:say("How dare you step on my child", TALKTYPE_MONSTER_SAY, false, nil, s:getPosition())
						player:sendTextMessage(MESSAGE_INFO_DESCR, "You have stepped on Rot Queen's child. You have 5 seconds to move from this spot.")							
						for mw = 0, 5 do
							local o = 5 - mw
							count_down[mw] = addEvent(doSendAnimatedText2, mw * 1000, position, o >= 0 and tostring(o), TEXTCOLOR_BLUE, player.uid)
						end
					end
				end
			end
		end
	end			
	
    return true
end




