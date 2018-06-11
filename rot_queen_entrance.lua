local toPosition = {
	{x = 982, y = 958, z = 9}
}

local config = {
	chance = 20
}

function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end
	local player = creature:getPlayer()
	
	local current_time = os.time()
	local wait = 3*60
	local globalBossStorage = 29174
	local bossStorage = Game.getStorageValue(globalBossStorage)
	bossStorage = not bossStorage and 0 or bossStorage
 	if bossStorage > current_time then
       return true
	end	

	
	if math.random(100) <= config.chance and creature:getPlayer():getStorageValue(31100) == -1 then
	Game.setStorageValue(globalBossStorage, os.time() + wait)
	player:teleportTo(toPosition[1], false)

	local fromPos = {x = toPosition[1].x - 7, y = toPosition[1].y - 7, z = toPosition[1].z}
	local toPos = {x = toPosition[1].x + 7, y = toPosition[1].y + 7, z = toPosition[1].z}
    local amount = 0
    for x = fromPos.x, toPos.x do
        for y = fromPos.y, toPos.y do
            for z = fromPos.z, toPos.z do
                local monster = getTopCreature({x=x,y=y,z=z}).uid
                if(isCreature(monster) == TRUE) then
                    if getCreatureName(monster) == "Rotworm Queen" then
                        amount = amount+1
                    end
                end
            end
        end
    end
	
	player:sendTextMessage(MESSAGE_STATUS_WARNING, "Whops, angry Rotworm Queen has digged under you and you fell into her cave.")
    if amount >= 1 then
        return true
    else
	    doSummonCreature("Rotworm Queen", {x = toPosition[1].x - 1, y = toPosition[1].y + 1, z = toPosition[1].z})
		doSummonCreature("Carrion Worm", {x = toPosition[1].x - 1, y = toPosition[1].y, z = toPosition[1].z})
        doSummonCreature("Carrion Worm", {x = toPosition[1].x - 1, y = toPosition[1].y - 1, z = toPosition[1].z})
		doSummonCreature("Carrion Worm", {x = toPosition[1].x - 1, y = toPosition[1].y - 2, z = toPosition[1].z})
		doSummonCreature("Rotworm", {x = toPosition[1].x - 1, y = toPosition[1].y + 1, z = toPosition[1].z})
        doSummonCreature("Rotworm", {x = toPosition[1].x - 2, y = toPosition[1].y + 1, z = toPosition[1].z})
		doSummonCreature("Rotworm", {x = toPosition[1].x - 2, y = toPosition[1].y - 1, z = toPosition[1].z})
    end
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	return true
end