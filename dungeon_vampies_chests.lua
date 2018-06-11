local configBP = {
	backpackId = 10522,
    itemsInside = {
        {id = 2160, amount = 1}
    }
}

local config = {
	vampDustID = 5905,
	vampTokenID = 9020,
	vampShieldID = 2534,
	expFromChest = 25000,
	wait = 0,
	chest1_storage = VAMPIRE_DUNGEON_CHEST1_STORAGE,
	chest2_storage = VAMPIRE_DUNGEON_CHEST2_STORAGE,
	chest3_storage = VAMPIRE_DUNGEON_CHEST3_STORAGE,
	chest4_storage = VAMPIRE_DUNGEON_CHEST4_STORAGE,
	chest5_storage = VAMPIRE_DUNGEON_CHEST5_STORAGE,
	chest6_storage = VAMPIRE_DUNGEON_CHEST6_STORAGE
}

local function addBackpack(cid)
	local player = Player(cid)
	local backpack = Container(doCreateItemEx(configBP.backpackId))
	for i = 1, #configBP.itemsInside do
		backpack:addItem(configBP.itemsInside[i].id, configBP.itemsInside[i].amount)
	end
	player:addItemEx(backpack)
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local current_time = os.time()
	local playerStorageTimer, playerStorage



		
		if item.uid == config.chest1_storage then
			playerStorageTimer = config.chest1_storage
			playerStorage = player:getStorageValue(playerStorageTimer)
			playerStorage = not playerStorage and 0 or playerStorage
			if playerStorage > current_time then
				doPlayerSendTextMessage(player, MESSAGE_INFO_DESCR, "You must wait ".. showTimeLeft(playerStorage - os.time(), true) ..", before you can get this daily reward again.")
				return true
			end
			player:setStorageValue(playerStorageTimer, os.time() + config.wait)		
			local randomNumber = math.random(5)
			
			if randomNumber == 5 then
				player:addExperience(config.expFromChest + math.random(25000), true)
			elseif randomNumber == 4 then
				addBackpack(player.uid)
			elseif randomNumber == 3 then
				player:addItem(config.vampTokenID, 1)
			elseif randomNumber == 2 then
				player:addItem(config.vampDustID, math.random(4))
			elseif randomNumber == 1 then
				player:addItem(config.vampShieldID, 1)
			end
			return true
		elseif item.uid == config.chest2_storage then
			playerStorageTimer = config.chest2_storage
			playerStorage = player:getStorageValue(playerStorageTimer)
			playerStorage = not playerStorage and 0 or playerStorage
			if playerStorage > current_time then
				doPlayerSendTextMessage(player, MESSAGE_INFO_DESCR, "You must wait ".. showTimeLeft(playerStorage - os.time(), true) ..", before you can get this daily reward again.")
				return true
			end
			player:setStorageValue(playerStorageTimer, os.time() + config.wait)		
			randomNumber = math.random(5)
			
			if randomNumber == 5 then
				player:addExperience(config.expFromChest, true)
			elseif randomNumber == 4 then
				addBackpack(player.uid)
			elseif randomNumber == 3 then
				player:addItem(config.vampTokenID, 1)
			elseif randomNumber == 2 then
				player:addItem(config.vampDustID, math.random(4))
			elseif randomNumber == 1 then
				player:addItem(config.vampShieldID, 1)
			end
			return true
		elseif item.uid == config.chest3_storage then
			playerStorageTimer = config.chest3_storage
			playerStorage = player:getStorageValue(playerStorageTimer)
			playerStorage = not playerStorage and 0 or playerStorage
			if playerStorage > current_time then
				doPlayerSendTextMessage(player, MESSAGE_INFO_DESCR, "You must wait ".. showTimeLeft(playerStorage - os.time(), true) ..", before you can get this daily reward again.")
				return true
			end
			player:setStorageValue(playerStorageTimer, os.time() + config.wait)		
			randomNumber = math.random(5)
			
			if randomNumber == 5 then
				player:addExperience(config.expFromChest, true)
			elseif randomNumber == 4 then
				addBackpack(player.uid)
			elseif randomNumber == 3 then
				player:addItem(config.vampTokenID, 1)
			elseif randomNumber == 2 then
				player:addItem(config.vampDustID, math.random(4))
			elseif randomNumber == 1 then
				player:addItem(config.vampShieldID, 1)
			end
			return true
		elseif item.uid == config.chest4_storage then
			playerStorageTimer = config.chest4_storage
			playerStorage = player:getStorageValue(playerStorageTimer)
			playerStorage = not playerStorage and 0 or playerStorage
			if playerStorage > current_time then
				doPlayerSendTextMessage(player, MESSAGE_INFO_DESCR, "You must wait ".. showTimeLeft(playerStorage - os.time(), true) ..", before you can get this daily reward again.")
				return true
			end
			player:setStorageValue(playerStorageTimer, os.time() + config.wait)		
			randomNumber = math.random(5)
			
			if randomNumber == 5 then
				player:addExperience(config.expFromChest, true)
			elseif randomNumber == 4 then
				addBackpack(player.uid)
			elseif randomNumber == 3 then
				player:addItem(config.vampTokenID, 1)
			elseif randomNumber == 2 then
				player:addItem(config.vampDustID, math.random(4))
			elseif randomNumber == 1 then
				player:addItem(config.vampShieldID, 1)
			end
			return true
		elseif item.uid == config.chest5_storage then
			playerStorageTimer = config.chest5_storage
			playerStorage = player:getStorageValue(playerStorageTimer)
			playerStorage = not playerStorage and 0 or playerStorage
			if playerStorage > current_time then
				doPlayerSendTextMessage(player, MESSAGE_INFO_DESCR, "You must wait ".. showTimeLeft(playerStorage - os.time(), true) ..", before you can get this daily reward again.")
				return true
			end
			player:setStorageValue(playerStorageTimer, os.time() + config.wait)		
			randomNumber = math.random(5)
			
			if randomNumber == 5 then
				player:addExperience(config.expFromChest, true)
			elseif randomNumber == 4 then
				addBackpack(player.uid)
			elseif randomNumber == 3 then
				player:addItem(config.vampTokenID, 1)
			elseif randomNumber == 2 then
				player:addItem(config.vampDustID, math.random(4))
			elseif randomNumber == 1 then
				player:addItem(config.vampShieldID, 1)
			end
			return true
		elseif item.uid == config.chest6_storage then
			playerStorageTimer = config.chest6_storage
			playerStorage = player:getStorageValue(playerStorageTimer)
			playerStorage = not playerStorage and 0 or playerStorage
			if playerStorage > current_time then
				doPlayerSendTextMessage(player, MESSAGE_INFO_DESCR, "You must wait ".. showTimeLeft(playerStorage - os.time(), true) ..", before you can get this daily reward again.")
				return true
			end
			player:setStorageValue(playerStorageTimer, os.time() + config.wait)		
			randomNumber = math.random(5)
			
			if randomNumber == 5 then
				player:addExperience(config.expFromChest, true)
			elseif randomNumber == 4 then
				addBackpack(player.uid)
			elseif randomNumber == 3 then
				player:addItem(config.vampTokenID, 1)
			elseif randomNumber == 2 then
				player:addItem(config.vampDustID, math.random(4))
			elseif randomNumber == 1 then
				player:addItem(config.vampShieldID, 1)
			end
			return true
		end
		
    return true
end


