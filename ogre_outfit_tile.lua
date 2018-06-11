function onStepIn(player, item, position, fromPosition)
	if player:getStorageValue(STORAGEVALUE_OGRE_ENTER) == -1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You are not allowed to enter")
		player:teleportTo(fromPosition, true)
		return false
--	else
	--	player:sendTextMessage(MESSAGE_INFO_DESCR, "Welcome to our cave our precious friend")	
	end
	
	return true
end
