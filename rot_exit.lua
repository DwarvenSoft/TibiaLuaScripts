local tpPositions = {
	{x = 931, y = 974, z = 9},
	{x = 899, y = 976, z = 9},
	{x = 926, y = 950, z = 9},
	{x = 918, y = 1062, z = 9}
}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	player:teleportTo(tpPositions[math.random(4)], false)
	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have successfully got back to the rowtworms!")
end