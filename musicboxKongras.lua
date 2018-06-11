local config = {
	['gorongra'] = {mountId = 81, tameMessage = 'You have tamed the gorongra.', sound = 'Whoao'},
	['noctungra'] = {mountId = 82, tameMessage = 'You have tamed the noctungra.', sound = 'Whoao'},
	['silverneck'] = {mountId = 83, tameMessage = 'You have tamed the silverneck.', sound = 'Whoao'}
}

local config2 = {
		fail = {
			{run = true, text = 'The animal ran away.'},
			{broke = true, text = 'Oh no! The item broke.'},
			{sound = 'GRRRRRRRRRRRR', text = 'The animal is trying to hit you with its claw.'}
		},
		success = {sound = 'Grrrrrrr', text = 'You tamed the animal.'}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target:isCreature() or not target:isMonster() or target:getMaster() then
		return false
	end

	local targetName = target:getName():lower()
	local monsterConfig = config[targetName]
	if not monsterConfig then
		return true
	end

	if player:hasMount(monsterConfig.mountId) then
		player:say('You already tamed a ' .. (monsterConfig.mountName or targetName) .. '.', TALKTYPE_MONSTER_SAY)
		return true
	else
	if math.random(100) > 65 then
		local action = config2.fail[math.random(#config2.fail)]
		if action.run then
			target:remove()
		elseif action.broke then
			item:remove(1)
		elseif action.destroyObject then
			addEvent(Game.createItem, 60 * 60 * 1000, target.itemid, 1, toPosition)
			target:remove()
		elseif action.removeTransformation then
			target:removeCondition(CONDITION_OUTFIT)
		end
		doCreatureSayWithRadius(player, action.text, TALKTYPE_MONSTER_SAY, 2, 2)
		if action.sound then
			player:say(action.sound, TALKTYPE_MONSTER_SAY, false, 0, toPosition)
		end
		return true
	end
		player:addMount(monsterConfig.mountId)
		player:say(monsterConfig.tameMessage, TALKTYPE_MONSTER_SAY)
		toPosition:sendMagicEffect(CONST_ME_SOUND_RED)

		target:say(monsterConfig.sound, TALKTYPE_MONSTER_SAY)
		target:remove()

		item:remove()
	end
	return true
end
