local cfg = {
	timer = TELEPORT_TIMER,
	pos = Position(POSITION_DEPO_TP_X, POSITION_DEPO_TP_Y, POSITION_DEPO_TP_Z),
	color = TELEPORT_COLOR,
	monster_name = "stonecracker",
	storage = TELEPORT_GLOBAL_STORAGE,
	teleport_storage = GHOULS_STORAGE,
	send_effect = TELEPORT_EFFECT
}

local function makeOgres(position)
	local spec = Game.getSpectators(position, false, false, 17, 17, 17, 17)
	if spec ~= nil then
		for _, s in pairs(spec) do
			if isMonster(s) then
				if s:getName():lower() == cfg.monster_name then
					Game.createMonster("ogre brute", Position(1289, 1045, 13))
					Game.createMonster("ogre shaman", Position(1298, 1045, 13))
				--	Game.createMonster("ogre savage", Position(1289, 1052, 13))
				--	Game.createMonster("ogre savage", Position(1296, 1053, 13))	
				end
			end
		end		
	end
end

function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end
	local current_time = os.time()
	local wait = 60 * 10
	local gameTimeStorage = 71513
	local gameStorage = Game.getStorageValue(gameTimeStorage)
	gameStorage = not gameStorage and 0 or gameStorage
	if gameStorage > current_time then
		return false
	else
	
	local spec = Game.getSpectators(position, false, false, 70, 70, 70, 70)
	if spec ~= nil then
		for _, s in pairs(spec) do
			if isMonster(s) then
				doRemoveCreature(s)
			end
		end
	end			
	
	Game.setStorageValue(gameTimeStorage, os.time() + wait)		
	local player = creature
	local bossPot = Position(1291, 1044, 13)
	local stairs = Tile(Position(1294, 1048, 13)):getItemById(3687)
	if stairs then
		stairs:remove(1)
	end
	Game.createMonster(cfg.monster_name, bossPot)
	Game.createMonster("ogre brute", Position(1289, 1045, 13))
	Game.createMonster("ogre shaman", Position(1298, 1045, 13))
--	Game.createMonster("ogre savage", Position(1289, 1052, 13))
--	Game.createMonster("ogre savage", Position(1296, 1053, 13))
	player:say("How dare you enter my cave?! Ogres alarm!", TALKTYPE_MONSTER_SAY, false, nil, bossPot)

	
	addEvent(makeOgres, 15000, position)
	addEvent(makeOgres, 30000, position)	
	end
    return true
end

