local config = {
    requiredLevel = 50,
	teleportLeverUID = 31690,
	bookUID = 31691,
	centerDungPos = Position(374, 1197, 8),
	mainBossPos = Position(318, 1186, 10),
	mainBossName = "the pale count",
	extraRangeForCheck = 15,
	chanceToSummonMiniBoss = 25,
	monstersPerPerson = 75,
	wait = VAMPIRE_DUNGEON_TIME_STORAGE,
	playerDungeonStorage = VAMPIRE_DUNGEON_STORAGE,
    leftTopCornerPos = Position(339, 1186, 8),
	rightBottomCornerPos = Position(426, 1227, 8),
	minPplToStart = 1,
    playerPositions = {
        Position(1140, 1068, 13),
        Position(1139, 1068, 13),
        Position(1138, 1068, 13),
        Position(1137, 1068, 13)
    },
    newPositions = {
        Position(391, 1214, 8),
        Position(392, 1214, 8),
        Position(391, 1215, 8),
        Position(392, 1215, 8)
    },
	miniBossPositions = {
		Position(397, 1189, 8),
		Position(360, 1228, 8),
		Position(424, 1208, 8),
		Position(325, 1185, 9)	
	},
	miniBossNames = {
		"sir valorcrest",
		"diblis the fair",
		"arachir the ancient one",
		"zevelon duskbringer"
	},
	normalMonsterNames = {
		"vampire",
		"vampire bride"
	},
	chestPercent = 30,
	chestTypes = {
		1739,
		1741,
		1738,
		1740
	},
	chestRoomsTopLeftPos = {
		Position(383, 1202, 8)
	},
	chestRoomsBottomRightPos = {
		Position(386, 1205, 8)
	},
	chestsUIDs = {
		VAMPIRE_DUNGEON_CHEST1_STORAGE,
		VAMPIRE_DUNGEON_CHEST2_STORAGE,
		VAMPIRE_DUNGEON_CHEST3_STORAGE,
		VAMPIRE_DUNGEON_CHEST4_STORAGE,
		VAMPIRE_DUNGEON_CHEST5_STORAGE,
		VAMPIRE_DUNGEON_CHEST6_STORAGE
	}
}
	
	
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local current_time = os.time()
    if item.uid == config.teleportLeverUID then
        local storePlayers, playerTile = {}
		
        local specs, spec = Game.getSpectators(config.centerDungPos, true, true, 100, 100, 100, 100)
        for i = 1, #specs do
            spec = specs[i]
            if spec:isPlayer() then
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Wait untill other team finish the dungeon.")
                return true
            end
            spec:remove()
        end
		local counter = 0
		if Tile(config.playerPositions[1]):getTopCreature() then
			counter = counter + 1
		end
		if Tile(config.playerPositions[2]):getTopCreature() then
			counter = counter + 1
		end	
		if Tile(config.playerPositions[3]):getTopCreature() then
			counter = counter + 1
		end	
		if Tile(config.playerPositions[4]):getTopCreature() then
			counter = counter + 1
		end			
	
		if counter < config.minPplToStart then
		    player:sendTextMessage(MESSAGE_INFO_DESCR, "You can only enter dungeon with 2-4 people")
			return true
		end
		
		local totalMobs = config.monstersPerPerson * counter
	
        for i = 1, counter do
            playerTile = Tile(config.playerPositions[i]):getTopCreature()
			if not playerTile or not playerTile:isPlayer() then
                player:sendTextMessage(MESSAGE_INFO_DESCR, "All players need to stay in their spots from right to left.")
                return true
            end

            if playerTile:getLevel() < config.requiredLevel then
                player:sendTextMessage(MESSAGE_INFO_DESCR, "All the players need to be level ".. config.requiredLevel .." or higher.")
                return true
            end

            storePlayers[#storePlayers + 1] = playerTile
        end
		
		local playero, playeroPos
		local k = 0
        for i = 1, #storePlayers do
            playero = storePlayers[i]
            playeroPos = playero:getPosition()
			local bossStorage = playero:getStorageValue(config.playerDungeonStorage)	
			bossStorage = not bossStorage and 0 or bossStorage
			if bossStorage > current_time then
				player:sendTextMessage(MESSAGE_INFO_DESCR, "Someone in your team got cooldown")
				return true
			end			

		end
		
		-- remove chests --
		local chestPos
		local d = 0
		local amountOfChests = #config.chestRoomsTopLeftPos
		local chestWithUID
		
		for i=1, amountOfChests do
			local fromPos = config.chestRoomsTopLeftPos[i]
			local toPos = config.chestRoomsBottomRightPos[i]
			for x = fromPos.x, toPos.x do
				for y = fromPos.y, toPos.y do
					for z = fromPos.z, toPos.z do
						local chestToRemove = Tile(Position(x, y, z)):getItemById(config.chestTypes[1])
						if chestToRemove then
							if chestToRemove.uid == config.chestsUIDs[i] then
								chestToRemove:remove(1)
							end
						end
						local chestToRemove2 = Tile(Position(x, y, z)):getItemById(config.chestTypes[2])
						if chestToRemove2 then
							if chestToRemove2.uid == config.chestsUIDs[i] then
								chestToRemove2:remove(1)
							end
						end
						local chestToRemove3 = Tile(Position(x, y, z)):getItemById(config.chestTypes[3])
						if chestToRemove3 then
							if chestToRemove3.uid == config.chestsUIDs[i] then
								chestToRemove3:remove(1)
							end
						end
						local chestToRemove4 = Tile(Position(x, y, z)):getItemById(config.chestTypes[4])
						if chestToRemove4 then
							if chestToRemove4.uid == config.chestsUIDs[i] then
								chestToRemove4:remove(1)
							end
						end
					end
				end
			end	
		end

		local spec = Game.getSpectators(config.centerDungPos, true, false, 100, 100, 100, 100)
		if spec ~= nil then
			for _, s in pairs(spec) do
				if isMonster(s) then
					doRemoveCreature(s)
				end
			end
		end		
		
		local fromPos, toPos
		local amountOfMonsters = 0
		
		Game.createMonster(config.mainBossName, config.mainBossPos)
        for i = 1, #config.miniBossPositions do
			if math.random(100) <= config.chanceToSummonMiniBoss then
				Game.createMonster(config.miniBossNames[i], config.miniBossPositions[i])
			end
		end
		local typesOfNormalMobs = #config.normalMonsterNames
		local randX, randY, randZ, normalMonsterPos
		while amountOfMonsters < totalMobs do
		    randX = math.random(config.leftTopCornerPos.x, config.rightBottomCornerPos.x)
			randY = math.random(config.leftTopCornerPos.y, config.rightBottomCornerPos.y)
			normalMonsterPos = Position(randX, randY, 7 + math.random(3))
			if isPathable(normalMonsterPos) then
				Game.createMonster(config.normalMonsterNames[math.random(typesOfNormalMobs)], normalMonsterPos)
				amountOfMonsters = amountOfMonsters + 1
			end
		
		end

		-- Random chests --

		for i = 1, amountOfChests do
			local chestRand, chestId
		    randX = math.random(config.chestRoomsTopLeftPos[i].x, config.chestRoomsBottomRightPos[i].x)
			randY = math.random(config.chestRoomsTopLeftPos[i].y, config.chestRoomsBottomRightPos[i].y)			
			randZ = math.random(config.chestRoomsTopLeftPos[i].z, config.chestRoomsBottomRightPos[i].z)	
			chestPos = Position(randX, randY, randZ)
			d = 0
			chestId = config.chestTypes[math.random(4)]
			chestRand = math.random(100)
			if isPathable(chestPos) then
				if chestRand <= config.chestPercent then
					chestWithUID = Game.createItem(chestId, 1, chestPos)
					if chestWithUID then
						chestWithUID:setAttribute(ITEM_ATTRIBUTE_UNIQUEID, config.chestsUIDs[i])
					end
				end
			else
				while d == 0 do
					randX = math.random(config.chestRoomsTopLeftPos[i].x, config.chestRoomsBottomRightPos[i].x)
					randY = math.random(config.chestRoomsTopLeftPos[i].y, config.chestRoomsBottomRightPos[i].y)			
					randZ = math.random(config.chestRoomsTopLeftPos[i].z, config.chestRoomsBottomRightPos[i].z)	
					chestPos = Position(randX, randY, randZ)	
					if isPathable(chestPos) then
						if chestRand <= config.chestPercent then
							chestWithUID = Game.createItem(chestId, 1, chestPos)
							if chestWithUID then
								chestWithUID:setAttribute(ITEM_ATTRIBUTE_UNIQUEID, config.chestsUIDs[i])
							end
						end				
						d = 1
					end
				end
			end
		end


        local players
        for i = 1, #storePlayers do
            players = storePlayers[i]
            config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
            players:teleportTo(config.newPositions[i])
            config.newPositions[i]:sendMagicEffect(CONST_ME_ENERGYAREA)
			players:setStorageValue(config.playerDungeonStorage, os.time() + config.wait)
            players:setDirection(DIRECTION_EAST)
			players:sendTextMessage(MESSAGE_INFO_DESCR, "Welcome in the dungeon.")
			players:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
		end
    elseif item.uid == config.bookUID then
			local bossStorage = player:getStorageValue(config.playerDungeonStorage)	
			bossStorage = not bossStorage and 0 or bossStorage
			local playerPosition = player:getPosition()
			if bossStorage > current_time then
				player:say("You must wait ".. showTimeLeft(bossStorage - os.time(), true) .."", TALKTYPE_MONSTER_SAY, false, nil, playerPosition)
				return true
			else
				player:say("You can enter", TALKTYPE_MONSTER_SAY, false, nil, playerPosition)			
			end
            
            return true
    end

    item:transform(item.itemid == 1945 and 1946 or 1945)
    return true
end