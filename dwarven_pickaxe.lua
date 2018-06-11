local holes = {9420, 9419, 9421, 9422}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local position = target:getPosition()
	local isInGhostMode = player:isInGhostMode()
	position:sendMagicEffect(CONST_ME_HITAREA, isInGhostMode and player)
    -- Shovel
    if isInArray(holes, target.itemid) == TRUE then
        doTransformItem(target.uid, 9727)
        doDecayItem(target.uid)
		player:say("Poof", TALKTYPE_MONSTER_SAY, false, nil, toPosition)
        return TRUE
    end
    return destroyItem(cid, target, toPosition)
end
 