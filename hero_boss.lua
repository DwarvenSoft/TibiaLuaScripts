function onUse(cid, item, fromPosition, itemEx, toPosition)
 
local fromPos = {x = toPosition.x - 10, y = toPosition.y - 10, z = toPosition.z}
local toPos = {x = toPosition.x + 10, y = toPosition.y + 10, z = toPosition.z}



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

	local current_time = os.time()
	local wait = 1 * 60
	local globalBossStorage = 29100
	local bossStorage = Game.getStorageValue(globalBossStorage)
	bossStorage = not bossStorage and 0 or bossStorage
 	if bossStorage > current_time then
		 doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You must wait ".. showTimeLeft(bossStorage - os.time(), true) ..", before you can summon another boss.")
       return false
	end
 
    if amount >= 1 then
        doSendMagicEffect(getThingPos(cid), CONST_ME_POFF)
        doPlayerSendCancel(cid, "You need to kill Infernalist first before you can summen one again.")
        return true
    else
	    doSummonCreature("Infernalist", {x = toPosition.x - 1, y = toPosition.y + 1, z = toPosition.z})
		doSummonCreature("Hero", {x = toPosition.x - 1, y = toPosition.y, z = toPosition.z})
        doSummonCreature("Hero", {x = toPosition.x - 1, y = toPosition.y - 1, z = toPosition.z})
		doSummonCreature("Hero", {x = toPosition.x - 1, y = toPosition.y - 2, z = toPosition.z})
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have summened Infernalist.")

		Game.setStorageValue(globalBossStorage, os.time() + wait)
        doSendMagicEffect(getThingPos(cid), CONST_ME_MAGIC_BLUE)
    end
        return true
end
 