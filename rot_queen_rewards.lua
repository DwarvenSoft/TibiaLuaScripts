function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:hasOutfit(574, 0) and not player:hasOutfit(575, 0) then
		player:addOutfitAddon(575, 0)
		player:addOutfitAddon(574, 0)
		player:setStorageValue(31100, 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Congratz! You have just unlocked cave explorer outfit.")
	else 
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already used it.")
	end
    return true
end


