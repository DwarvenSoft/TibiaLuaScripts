local cfg = {
	storage = ANGRY_CITIZENS_BRIDGE_GLOBAL_STORAGE,
	posStart = Position(641, 1446, 8),
	posCenter = Position(644, 1439, 8),
	xWidth = 5,
	tileID = 3153,
	wait = 70
}

local function returnToNormal(pos)
		local item = Tile(pos):getItemById(459)
		if item then
			item:transform(3153)
		end	
end

local function removeTiles(numY)
	local spec = Game.getSpectators(cfg.posCenter, false, false, 10, 10, 18, 18)
	local pos = Position(cfg.posStart.x, numY, cfg.posStart.z)
	for k = 0, cfg.xWidth+1 do
		local newPos = Position(pos.x + k, pos.y, pos.z)
		local item = Tile(newPos):getItemById(3153)
		if item then
			item:transform(459)
		end

		if spec ~= nil then
			for _, s in pairs(spec) do
				if isPlayer(s) then
					s:say("Poof", TALKTYPE_MONSTER_SAY, false, nil, newPos)
				end
				if s:getPosition() == newPos then
					s:teleportTo(Position(newPos.x, newPos.y, newPos.z+1))
					if isPlayer(s) then
						s:sendTextMessage(MESSAGE_INFO_DESCR, "You fell")				
					end
				end
			end
		end

		addEvent(returnToNormal, 60000, newPos)
		
	end

end

function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end
	
	local current_time = os.time()
	local globalBossStorage = cfg.storage
	local bossStorage = Game.getStorageValue(globalBossStorage)
	bossStorage = not bossStorage and 0 or bossStorage
 	if bossStorage > current_time then
       return true
	end
	Game.setStorageValue(globalBossStorage, os.time() + cfg.wait)
	local player = creature:getPlayer()
	local playerPos = player:getPosition()
	local first = 0
	
	for i = 0, 12 do
		if first == 0 then
			addEvent(removeTiles, 3500, cfg.posStart.y + 1 - i)
			first = 1
		else
			addEvent(removeTiles, 3500+1000*i, cfg.posStart.y + 1 - i)
		end
	end
	player:say("The bridge is starting to collapse!", TALKTYPE_MONSTER_SAY, false, nil, Position(644, 1446, 8))
	
    return true
end

