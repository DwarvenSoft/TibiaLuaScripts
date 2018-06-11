local arena = {
      posLeft = Position(1123, 1047, 10), --Top left corner of the arena
      posRight = Position(1136, 1054, 10) --Bottom right corner of the arena
}

local bossName = "Half-Blood Prince"

local function makeMonsters()
	local rand = math.random(2)
	for i = 1, rand do
        randX = math.random(arena.posLeft.x, arena.posRight.x)
        randY = math.random(arena.posLeft.y, arena.posRight.y)
        randZ = math.random(arena.posLeft.z, arena.posRight.z)
		local pos = Position(randX, randY, randZ)
		local item = Tile(pos):getItemById(407)
		while not item do
			randX = math.random(arena.posLeft.x, arena.posRight.x)
			randY = math.random(arena.posLeft.y, arena.posRight.y)
			randZ = math.random(arena.posLeft.z, arena.posRight.z)
			pos = Position(randX, randY, randZ)
			item = Tile(pos):getItemById(407)		
		end
		if rand ==1 then
			Game.createMonster("vampire", pos)
		else
			Game.createMonster("vampire bride", pos)
		end
	end
end

local function makeDmgTiles(pos, cid)
	local player = Player(cid)
	if player then
		if (player:getPosition() == pos) then
			player:addHealth(player:getMaxHealth()*0.25)
		end
	end
end

local function makeEffects()
	local player, players = nil, Game.getPlayers()
	for i = 1, 15 do
        randX = math.random(arena.posLeft.x, arena.posRight.x)
        randY = math.random(arena.posLeft.y, arena.posRight.y)
        randZ = math.random(arena.posLeft.z, arena.posRight.z)
		local pos = Position(randX, randY, randZ)
		local item = Tile(pos):getItemById(407)
		while not item do
			randX = math.random(arena.posLeft.x, arena.posRight.x)
			randY = math.random(arena.posLeft.y, arena.posRight.y)
			randZ = math.random(arena.posLeft.z, arena.posRight.z)
			pos = Position(randX, randY, randZ)
			item = Tile(pos):getItemById(407)		
		end

		for i = 1, #players do
			player = players[i]
			doSendMagicEffect(pos, 63)			
			addEvent(makeDmgTiles, 1000, pos, player.uid)
		end
	end
end


function onUse(cid, item, fromPosition, itemEx, toPosition)
 
local fromPos = {x = toPosition.x - 15, y = toPosition.y - 15, z = toPosition.z}
local toPos = {x = toPosition.x + 15, y = toPosition.y + 15, z = toPosition.z}

    local amount = 0
    for x = fromPos.x, toPos.x do
        for y = fromPos.y, toPos.y do
            for z = fromPos.z, toPos.z do
                local monster = getTopCreature({x=x,y=y,z=z}).uid
                if(isCreature(monster) == TRUE) then
                    if getCreatureName(monster) == "hydra" then
                        amount = amount+1
                    end
                end
            end
        end
    end

	local current_time = os.time()
	local wait = 1 * 60
	local globalBossStorage = 29164
	local bossStorage = Game.getStorageValue(globalBossStorage)
	bossStorage = not bossStorage and 0 or bossStorage
 	if bossStorage > current_time then
		 doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You must wait ".. showTimeLeft(bossStorage - os.time(), true) ..", before you can summon another boss.")
       return false
	end
 
    if amount >= 1 then
        doSendMagicEffect(getThingPos(cid), CONST_ME_POFF)
        doPlayerSendCancel(cid, "You need to kill "..bossName.." first before you can summen one again.")
        return true
    else
	    doSummonCreature("arachir the ancient one", {x = toPosition.x - 1, y = toPosition.y + 1, z = toPosition.z})
		doSummonCreature("vampire", {x = toPosition.x + 1, y = toPosition.y, z = toPosition.z})
        doSummonCreature("vampire", {x = toPosition.x - 1, y = toPosition.y + 2, z = toPosition.z})
		doSummonCreature("vampire", {x = toPosition.x - 1, y = toPosition.y + 3, z = toPosition.z})
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have summened "..bossName.." .")
		local item = Tile(Position(1124, 1052, 10)):getItemById(3687)
		if item then
			item:remove(1)
		end
		Game.setStorageValue(globalBossStorage, os.time() + wait)
        doSendMagicEffect(getThingPos(cid), CONST_ME_MAGIC_BLUE)
		for k=1, 6 do
			addEvent(makeMonsters, k*5000)
		end
		for k=1, 15 do		
			addEvent(makeEffects, k*3000)
		end
    end
        return true
		
end
 