local config = {
    backpackId = 18394,
    itemsInside = {
        {id = 2086, amount = 1},
        {id = 2160, amount = 3}
    }
}

function onUse(player, item, fromPosition, itemEx, toPosition)
		if item.uid == 31688 then
			if player:getItemCount(9020) >= 14 then
				player:removeItem(9020, 14)
				player:addItem(9955, 1)
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You have bought a vampiric crest")	
			else
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You don't have enough vampire tokens")		
			end
		elseif item.uid == 31687 then
			if player:getItemCount(9020) >= 21 then
				player:removeItem(9020, 21)
				player:addItem(9019, 1)
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You have bought a vampire doll")	
			else
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You don't have enough vampire tokens")	
			end
		elseif item.uid == 31686 then
			if player:getItemCount(9020) >= 27 then
				player:removeItem(9020, 27)
				player:addItem(21252, 1)
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You have bought a vampire's signet ring")	
			else
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You don't have enough vampire tokens")	
			end
		elseif item.uid == 31685 then
			if player:getItemCount(9020) >= 40 then
				player:removeItem(9020, 40)
				local backpack = Container(doCreateItemEx(config.backpackId))
				for i = 1, #config.itemsInside do
					backpack:addItem(config.itemsInside[i].id, config.itemsInside[i].amount)
				end
				player:addItemEx(backpack)
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You have bought a crystal backpack")	
			else
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You don't have enough vampire tokens")	
			end
		end
		
        return true
end
 