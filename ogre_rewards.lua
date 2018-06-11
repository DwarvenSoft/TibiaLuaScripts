local cfg = {
	pos = Position(1344, 1041, 13)
}


function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end
	local player = creature:getPlayer()
	player:teleportTo(cfg.pos, false)
    return true
end




