local function doSendAnimatedText2(fromPos, text, color, cid)
	local player = Player(cid)
	if player then
		if tonumber(text) then
			text = tonumber(text)
			local playerPos = player:getPosition()
			if (player:setOutfit(text) ~= null) then
				player:say("/looktype "..text.."", TALKTYPE_MONSTER_SAY, false, nil, fromPos)

			else
				return 
			end
		end
	end
end


function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local playerPos = player:getPosition()
			for mw = 680, 685 do
				addEvent(doSendAnimatedText2, mw * 500, playerPos, tostring(mw), TEXTCOLOR_BLUE, player.uid)
			end
end

