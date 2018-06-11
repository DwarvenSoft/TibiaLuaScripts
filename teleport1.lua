local cfg = {
	pos = Position(995, 1054, 7)
}

function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	else
		local player = creature:getPlayer()
		player:teleportTo(cfg.pos, false)
		return true
	end
end




