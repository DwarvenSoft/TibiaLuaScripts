function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if ((not player:hasOutfit(575, 3)) and (not player:hasOutfit(574, 3))) and (player:hasOutfit(575, 0) or player:hasOutfit(574, 0)) then
		player:addOutfitAddon(575, 3)
		player:addOutfitAddon(574, 3)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Congratz! You have just unlocked cave explorer addons.")
		if item then
			item:remove(1)
		end
	elseif player:hasOutfit(575, 3) or player:hasOutfit(574, 3) then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already used it.")
	else 
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You don't have cave explorer outfit.")
	end
    return true
end


