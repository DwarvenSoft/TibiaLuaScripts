local newOutfit = {
    lookType = 857,
    lookHead = 0,
    lookBody = 0,
    lookLegs = 0,
    lookFeet = 0
}

local newOutfit2 = {
    lookType = 858,
    lookHead = 0,
    lookBody = 0,
    lookLegs = 0,
    lookFeet = 0
}

local newOutfit3 = {
    lookType = 859,
    lookHead = 0,
    lookBody = 0,
    lookLegs = 0,
    lookFeet = 0
}

local previousOutfit

local function event(cid)
	local player = Player(cid)
	player:setOutfit(previousOutfit)
	player:setStorageValue(STORAGEVALUE_OGRE_ENTER, -1)	
end



function onUse(player, item, fromPosition, itemEx, toPosition)
		if itemEx.uid == 31618 then
			previousOutfit = player:getOutfit()
			local rand = math.random(3)
			if rand == 1 then
				player:setOutfit(newOutfit)
			elseif rand == 2 then
				player:setOutfit(newOutfit2)
			else
				player:setOutfit(newOutfit3)
			end
			player:setStorageValue(STORAGEVALUE_OGRE_ENTER, 1)
			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been transformed into an Ogre")	
			addEvent(event, 2*60*1000, player.uid)
			item:remove(1)
		end
        return true
end
 