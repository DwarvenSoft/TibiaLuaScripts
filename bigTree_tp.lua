local cfg = {
	timer = TELEPORT_TIMER,
	pos = Position(POSITION_DEPO_TP_X, POSITION_DEPO_TP_Y, POSITION_DEPO_TP_Z),
	color = TELEPORT_COLOR,
	monster_name = "big tree",
	storage = TELEPORT_GLOBAL_STORAGE,
	teleport_storage = BIGTREE_STORAGE,
	send_effect = TELEPORT_EFFECT
}


local function doSendAnimatedText2(fromPos, text, color, cid)
	local player = Player(cid)
	if player then
		if tonumber(text) then
			text = tonumber(text)
			local playerPos = player:getPosition()
			if (playerPos == fromPos) then
				player:say(text, TALKTYPE_MONSTER_SAY, false, nil, fromPos)
				player:getPosition():sendMagicEffect(cfg.send_effect)
				if(text == 1) then
					player:teleportTo(cfg.pos, false)
					player:getPosition():sendMagicEffect(CONST_ME_ENERGYAREA)
					player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been teleported!")
				end
			else
				return
			end
		end
	end
end

local exhausted_storagevalue = 1259
local count_down = {}

function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end
	local player = creature:getPlayer()
	local playerPos = player:getPosition()
	if player:getStorageValue(cfg.teleport_storage) == -1 then
		player:setStorageValue(cfg.teleport_storage, 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Congratz! You have just unlocked "..cfg.monster_name.." tp.")
	else 
		if player:getStorageValue(exhausted_storagevalue) > os.time() then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "You still have to wait few more seconds before using it.")	
			for mw = 1, cfg.timer do
				stopEvent(count_down[mw])
			end		
		else
			player:setStorageValue(exhausted_storagevalue, os.time()+5)
			for mw = 1, cfg.timer do
				local o = cfg.timer - mw
				count_down[mw] = addEvent(doSendAnimatedText2, mw * 1000, playerPos, o > 0 and tostring(o), cfg.color, player.uid)
			end
		return true
		end
	end
	
    return true
end

function onStepOut(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end

	return true
end


