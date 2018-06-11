function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end
	
	local current_time = os.time()
	local wait = 60*60
	local globalBossStorage = 29169
	local bossStorage = Game.getStorageValue(globalBossStorage)
	bossStorage = not bossStorage and 0 or bossStorage
 	if bossStorage > current_time then
       return true
	end	
	Game.setStorageValue(globalBossStorage, os.time() + wait)	
	
	
	creature:say("Whoo, there seem to be a loch under Rot Queen's holes", TALKTYPE_MONSTER_SAY, false, nil, position)
	return true
end
