lmsConfigTable = {
    minPlayers = 10, --Min players req to start the event
    maxPlayers = 20, --Max players can join the event
    waitingMinutes = 1, --How long until the event start, after it get's annouced first time
    joinedStorage = 1000, --Use non used storage
    lmsArenaPostions = {
        Position(989, 1043, 8), --Top left corner of the arena
        Position(1009, 1057, 8) --Bottom right corner of the arena
    },
    joinedCountStorage = 101, --Use non used global storage
    waitingRoomPosition = {
        centerPos = Position(1032, 1036, 6),
        radiusX = 20,
        radiusY = 20
    },
    trophyId = 7369 --Itemid of the reward
}

local normalTile = 406
local firstLavaTile = 600
local secondLavaTile = 598
local amountOfTiles = 594
 
lmsStatesTable = {
    EVENT_STATE_STORAGE = 100, --Use none used global storage
    ['EVENT_STATE_INIT'] = 1,
    ['EVENT_STATE_STARTED'] = 2,
    ['EVENT_STATE_CLOSED'] = 3
}
 
lmsTeleportTable = {
    teleportId = 1387, --itemId of the teleport
    teleportUid = 5000, --Use none used Uid
    createTeleportPosition = Position(1042, 1027, 6) --The position where the teleport will be created
}
local randX
local randY
local randZ
 
local function backToNormal(pos)
	local item = Tile(pos):getItemById(firstLavaTile)
	local item2 = Tile(pos):getItemById(secondLavaTile)	
	if item then
		item:transform(normalTile)
	elseif item2 then
		item2:transform(normalTile)
	end
end 
 
local function changeToLava(pos)
	local item = Tile(pos):getItemById(normalTile)
	if item then
		if math.random(3) == 1 then
			item:transform(firstLavaTile)
		else
			item:transform(secondLavaTile)
		end
        pos:sendMagicEffect(7)
		addEvent(backToNormal, 120000, pos)
		local player, players = nil, Game.getPlayers()
		for i = 1, #players do
			player = players[i]
			if(Game.getStorageValue(lmsConfigTable.joinedCountStorage) == 1) then	 
				local winner = player
				local trophy = winner:addItem(lmsConfigTable.trophyId, 1)
				if trophy then
					trophy:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, winner:getName() ..' has won the floor is lava event.')
				end
				player:teleportTo(player:getTown():getTemplePosition())
				player:unregisterEvent('LMSOnDeath')
				player:addHealth(player:getMaxHealth())
				player:addMana(player:getMaxMana())
			--	player:changeSpeed(-playerSpeed+playerBaseSpeed-addSpeed/2)
				player:setStorageValue(lmsConfigTable.joinedStorage, 0)
				Game.broadcastMessage(player:getName() ..' Is the winner of the floor is lava event.', MESSAGE_STATUS_WARNING)
				resetLMSEvent()
				stopEvent(changeToLava)
			else
				playerPos = player:getPosition()
				if playerPos == pos then
					print(1)
					player:teleportTo(player:getTown():getTemplePosition())
					player:addHealth(player:getMaxHealth())
					player:addMana(player:getMaxMana())
					player:setStorageValue(lmsConfigTable.joinedStorage, 0)
					player:unregisterEvent('LMSOnDeath')
					stopEvent(changeToLava)
				--	player:changeSpeed(-playerSpeed+playerBaseSpeed-addSpeed/2)
					Game.setStorageValue(lmsConfigTable.joinedCountStorage, Game.getStorageValue(lmsConfigTable.joinedCountStorage) - 1)
				end
			end
		end
	end
end

local function makeLava()
    randX = math.random(lmsConfigTable.lmsArenaPostions[1].x, lmsConfigTable.lmsArenaPostions[2].x)
    randY = math.random(lmsConfigTable.lmsArenaPostions[1].y, lmsConfigTable.lmsArenaPostions[2].y)
    randZ = math.random(lmsConfigTable.lmsArenaPostions[1].z, lmsConfigTable.lmsArenaPostions[2].z)	
	local pos = Position(randX, randY, randZ)
	local item = Tile(pos):getItemById(normalTile)
	while not item do
		randX = math.random(lmsConfigTable.lmsArenaPostions[1].x, lmsConfigTable.lmsArenaPostions[2].x)
		randY = math.random(lmsConfigTable.lmsArenaPostions[1].y, lmsConfigTable.lmsArenaPostions[2].y)
		randZ = math.random(lmsConfigTable.lmsArenaPostions[1].z, lmsConfigTable.lmsArenaPostions[2].z)	
		pos = Position(randX, randY, randZ)
		item = Tile(pos):getItemById(normalTile)		
	end	
	-- 5815
	if item then
		addEvent(changeToLava, 2000, pos)
	    pos:sendMagicEffect(57)

	end
end
	
 
function startLMSEvent()
    local joinedCount = Game.getStorageValue(lmsConfigTable.joinedCountStorage)
    if not joinedCount or (joinedCount < lmsConfigTable.minPlayers) then
        local specs = Game.getSpectators(lmsConfigTable.waitingRoomPosition.centerPos, false, true, 0, lmsConfigTable.waitingRoomPosition.radiusX, 0, lmsConfigTable.waitingRoomPosition.radiusY)
        for i = 1, #specs do
            if specs[i]:getStorageValue(lmsConfigTable.joinedStorage) == 1 then
                specs[i]:teleportTo(specs[i]:getTown():getTemplePosition())
                specs[i]:setStorageValue(lmsConfigTable.joinedStorage, 0)
            end
        end
 
        Game.broadcastMessage('Floor is lava event did not start! There was not enough of participants.', MESSAGE_STATUS_WARNING)
        resetLMSEvent()
        return true
    end
 
    local player, players = nil, Game.getPlayers()
    for i = 1, #players do
        randX = math.random(lmsConfigTable.lmsArenaPostions[1].x, lmsConfigTable.lmsArenaPostions[2].x)
        randY = math.random(lmsConfigTable.lmsArenaPostions[1].y, lmsConfigTable.lmsArenaPostions[2].y)
        randZ = math.random(lmsConfigTable.lmsArenaPostions[1].z, lmsConfigTable.lmsArenaPostions[2].z)
		local pos = Position(randX, randY, randZ)
		local item = Tile(pos):getItemById(normalTile)
		while not item do
			randX = math.random(lmsConfigTable.lmsArenaPostions[1].x, lmsConfigTable.lmsArenaPostions[2].x)
			randY = math.random(lmsConfigTable.lmsArenaPostions[1].y, lmsConfigTable.lmsArenaPostions[2].y)
			randZ = math.random(lmsConfigTable.lmsArenaPostions[1].z, lmsConfigTable.lmsArenaPostions[2].z)	
			pos = Position(randX, randY, randZ)
			item = Tile(pos):getItemById(normalTile)		
		end
	    player = players[i]

		
        if player:getStorageValue(lmsConfigTable.joinedStorage) == 1 then
            player:teleportTo(Position(randX, randY, randZ))
            player:registerEvent('LMSOnDeath')
            print(randX, randY, randZ)
        end
    end
	for l = 1, 594 do
		local m = 594 - l
		addEvent(makeLava, l*500) 
	end	
 
    Game.setStorageValue(lmsStatesTable.EVENT_STATE_STORAGE, lmsStatesTable.EVENT_STATE_STARTED)
    Game.broadcastMessage('Floor is lava event has started with '.. Game.getStorageValue(lmsConfigTable.joinedCountStorage) ..' players.', MESSAGE_STATUS_WARNING)
end
 
function resetLMSEvent()
    Game.setStorageValue(lmsStatesTable.EVENT_STATE_STORAGE, lmsStatesTable.EVENT_STATE_CLOSED)
    Game.setStorageValue(lmsConfigTable.joinedCountStorage, 0)
end