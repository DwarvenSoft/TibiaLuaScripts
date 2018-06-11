local newOutfit = {
    lookType = 857,
    lookHead = 0,
    lookBody = 0,
    lookLegs = 0,
    lookFeet = 0
    }

function onStepIn(player, item, position, fromPosition)
	player:setOutfit(newOutfit)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "bla bla")
	return true
end
