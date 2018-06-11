function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local current_time = os.time()
	local wait = 60 * 60 * 18
	local playerStorageTimer = 71512
	local playerStorage = player:getStorageValue(playerStorageTimer)
	playerStorage = not playerStorage and 0 or playerStorage
	if playerStorage > current_time then
		doPlayerSendTextMessage(player, MESSAGE_INFO_DESCR, "You must wait ".. showTimeLeft(playerStorage - os.time(), true) ..", before you can get daily reward again.")
	return true
	else
		
	local rand = math.random(4) + 2
	local randDoll = math.random(4)
	player:addItem(9020, rand)
	player:setStorageValue(playerStorageTimer, os.time() + wait)	
	if randDoll == 1 then
		player:addItem(9019, 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got "..rand.." vampire tokens and a vampire doll today")
	else 
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got "..rand.." vampire tokens today")
	end

	end
    return true
end


