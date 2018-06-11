function onUse(player, item, fromPosition, target, toPosition, isHotkey)
		local playerPos = player:getPosition()
		if not player:hasMount(76) then
				player:say("You have obtained a Venompaw mount", TALKTYPE_MONSTER_SAY, false, nil, playerPos)		
				player:addMount(76)
				if item then
					item:remove(1)
				end
		elseif not player:hasMount(75) then
				player:say("You have obtained a Flitterkatzen mount", TALKTYPE_MONSTER_SAY, false, nil, playerPos)		
				player:addMount(75)
				if item then
					item:remove(1)
				end
		elseif not player:hasMount(77) then
				player:say("You have obtained a Batcat mount", TALKTYPE_MONSTER_SAY, false, nil, playerPos)		
				player:addMount(77)
				if item then
					item:remove(1)
				end
		else
				player:say("You have already obtained all mounts from it", TALKTYPE_MONSTER_SAY, false, nil, playerPos)	
		end
	return true;	
end