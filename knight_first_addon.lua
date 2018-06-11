function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(30100) == -1 then
		player:setStorageValue(30100, 1)
		player:addOutfitAddon(139, 1)
		player:addOutfitAddon(131, 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Congratz! You have just unlocked first knight addon.")
		if item then
			item:remove(1)
		end
	else 
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already used it.")
	end
    return true
end


