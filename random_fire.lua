local cfg = {
	timer = TELEPORT_TIMER,
	pos = Position(POSITION_DEPO_TP_X, POSITION_DEPO_TP_Y, POSITION_DEPO_TP_Z),
	color = TELEPORT_COLOR,
	monster_name = "fire elemental",
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
	local wait = 1 * 8
	local globalBossStorage = 29158
	local bossStorage = Game.getStorageValue(globalBossStorage)
	bossStorage = not bossStorage and 0 or bossStorage
 	if bossStorage > current_time then
       return true
	end	
	Game.setStorageValue(globalBossStorage, os.time() + wait)	
	local pos = position
	local pos1 = Position(pos.x-1, pos.y-1, pos.z)
	local pos2 = Position(pos.x-1, pos.y, pos.z)
	local pos3 = Position(pos.x-1, pos.y+1, pos.z)
	local pos4 = Position(pos.x+1, pos.y+1, pos.z)
	local pos5 = Position(pos.x+1, pos.y-1, pos.z)
	local pos6 = Position(pos.x+1, pos.y, pos.z)
	local pos7 = Position(pos.x, pos.y+1, pos.z)
	local pos8 = Position(pos.x, pos.y-1, pos.z)
	pos:sendMagicEffect(37)
	pos1:sendMagicEffect(37)
	pos2:sendMagicEffect(37)
	pos3:sendMagicEffect(37)
	pos4:sendMagicEffect(37)
	pos5:sendMagicEffect(37)
	pos6:sendMagicEffect(37)
	pos7:sendMagicEffect(37)
	pos8:sendMagicEffect(37)	
	local rand = math.random(4)
	if rand == 1 then
		Game.createMonster(cfg.monster_name, pos1)
		Game.createMonster(cfg.monster_name, pos4)
		Game.createMonster(cfg.monster_name, pos3)
		Game.createMonster(cfg.monster_name, pos5)	
	elseif rand == 2 then
		Game.createMonster(cfg.monster_name, pos2)
		Game.createMonster(cfg.monster_name, pos7)
		Game.createMonster(cfg.monster_name, pos3)
		Game.createMonster(cfg.monster_name, pos6)		
	elseif rand == 3 then
		Game.createMonster(cfg.monster_name, pos5)
		Game.createMonster(cfg.monster_name, pos2)
		Game.createMonster(cfg.monster_name, pos8)
		Game.createMonster(cfg.monster_name, pos4)		
	else
		Game.createMonster(cfg.monster_name, pos1)
		Game.createMonster(cfg.monster_name, pos8)
		Game.createMonster(cfg.monster_name, pos5)
		Game.createMonster(cfg.monster_name, pos7)		
	end


    return true
end

