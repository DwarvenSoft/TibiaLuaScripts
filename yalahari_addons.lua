function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:hasOutfit(324, 3) or not player:hasOutfit(325, 3) then
		player:addOutfitAddon(324, 3)
		player:addOutfitAddon(325, 3)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Congratz! You have just unlocked yalahari outfit and addons.")
		if item then
			item:remove(1)
		end
	else 
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already used it.")
	end
    return true
end


