local cfg = {
	pos = Position(1237, 1039, 10)
}


function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end
	local player = creature:getPlayer()
	player:teleportTo(cfg.pos, false)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have returned to the ogre cave")
    return true
end