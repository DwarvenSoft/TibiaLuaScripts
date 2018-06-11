local function doSendAnimatedText2(fromPos, text, color, cid)
	local player = Player(cid)
			local playerPos = player:getPosition()
			if  (player:setOutfit(text) ~= null) then
				player:say("/looktype "..text.."", TALKTYPE_SAY, false, nil, playerPos)
				local lookType = tonumber(text)
				local playerOutfit = player:getOutfit()
				playerOutfit.lookType = lookType
				player:setOutfit(playerOutfit)

			else
				return 
	end
end


function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	local playerPos = player:getPosition()
			for mw = 650, 1200 do
				addEvent(doSendAnimatedText2, mw * 50, playerPos, tostring(mw), TEXTCOLOR_BLUE, player.uid)
			end
    return true
end


