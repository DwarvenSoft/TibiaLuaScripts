local cfg = {
	pos = Position(996, 1054, 7)
}


function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end
	local player = creature:getPlayer()
	player:teleportTo(cfg.pos, false)
    return true
end




