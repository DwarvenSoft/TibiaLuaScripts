local cfg = {
	timer = TELEPORT_TIMER,
	pos = Position(POSITION_DEPO_TP_X, POSITION_DEPO_TP_Y, POSITION_DEPO_TP_Z),
	color = TELEPORT_COLOR,
	monster_name = "stonecracker",
	storage = TELEPORT_GLOBAL_STORAGE,
	teleport_storage = GHOULS_STORAGE,
	send_effect = TELEPORT_EFFECT
}

arena = {
    pos1 = Position(620, 1391, 7), --Top left corner of the arena
    pos2 = Position(668, 1418, 7) --Bottom right corner of the arena
}

local function startFirerain()
	for k = 1, 15 do
		randX = math.random(arena.pos1.x, arena.pos2.x)
		randY = math.random(arena.pos1.y, arena.pos2.y)
		randZ = math.random(arena.pos1.z, arena.pos2.z)	
		local pos = Position(randX, randY, randZ)
		pos:sendMagicEffect(37)
		local rand = math.random(3)
		if rand == 1 then
			Game.createItem(1492, 1, pos)
		elseif rand == 2 then
			Game.createItem(1493, 1, pos)	
		else
			Game.createItem(1494, 1, pos)	
		end
	end
end


function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end
	local current_time = os.time()
	local wait = 15 * 60
	local globalBossStorage = 29157
	local bossStorage = Game.getStorageValue(globalBossStorage)
	bossStorage = not bossStorage and 0 or bossStorage
 	if bossStorage > current_time then
       return false
	end	
	Game.setStorageValue(globalBossStorage, os.time() + wait)
	for i=1, 50 do
		addEvent(startFirerain, i*5000)
	end

    return true
end

