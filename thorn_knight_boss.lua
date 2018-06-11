function onUse(cid, item, fromPosition, itemEx, toPosition)
 
local fromPos = {x = toPosition.x - 50, y = toPosition.y - 50, z = toPosition.z}
local toPos = {x = toPosition.x + 50, y = toPosition.y + 50, z = toPosition.z}



    local amount = 0
    for x = fromPos.x, toPos.x do
        for y = fromPos.y, toPos.y do
            for z = fromPos.z, toPos.z do
                local monster = getTopCreature({x=x,y=y,z=z}).uid
                if(isCreature(monster) == TRUE) then
                    if getCreatureName(monster) == "Thorn Knight" then
                        amount = amount+1
                    end
                end
            end
        end
    end

	local current_time = os.time()
	local wait = 1 * 30
	local globalBossStorage = 29101
	local bossStorage = Game.getStorageValue(globalBossStorage)
	bossStorage = not bossStorage and 0 or bossStorage
 	if bossStorage > current_time then
		 doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You must wait ".. showTimeLeft(bossStorage - os.time(), true) ..", before you can summon another boss.")
       return false
	end
 
    if amount >= 1 then
        doSendMagicEffect(getThingPos(cid), CONST_ME_POFF)
        doPlayerSendCancel(cid, "You need to kill a Thorn Knight first before you can summen one again.")
        return true
    else
	    doSummonCreature("Thorn Knight", {x = toPosition.x - 1, y = toPosition.y + 1, z = toPosition.z})
		doSummonCreature("Angry Citizen", {x = toPosition.x - 1, y = toPosition.y, z = toPosition.z})
        doSummonCreature("Angry Citizen", {x = toPosition.x - 1, y = toPosition.y - 1, z = toPosition.z})
		doSummonCreature("Angry Citizen", {x = toPosition.x - 1, y = toPosition.y - 2, z = toPosition.z})
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have summened a Thorn Knight.")

		Game.setStorageValue(globalBossStorage, os.time() + wait)
        doSendMagicEffect(getThingPos(cid), CONST_ME_MAGIC_BLUE)
    end
        return true
end
 