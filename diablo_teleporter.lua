function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	player:registerEvent("ModalWindow_Teleporter")
 
    local title = "Pick your destination!"
    local message = "Select a place when you want to teleport"
 
    local window = ModalWindow(1000, title, message)
 
    window:addButton(100, "Confirm")
    window:addButton(101, "Cancel")
	window:addChoice(1, "1 - Carrion Worms")
	
	if player:getStorageValue(GHOULS_STORAGE) == 1 then
	 window:addChoice(2, "2 - Ghouls")
	end
	if player:getStorageValue(CULTS_STORAGE) == 1 then
	 window:addChoice(3, "3 - Cults")
	end
	if player:getStorageValue(OGRES_STORAGE) == 1 then
	 window:addChoice(4, "4 - Ogres")
	end
	if player:getStorageValue(LONELYBEACH_STORAGE) == 1 then
	 window:addChoice(5, "5 - Lonely Beach")
	end
	if player:getStorageValue(BIGTREE_STORAGE) == 1 then
	 window:addChoice(6, "6 - Big Tree")
	end
	if player:getStorageValue(VAMPIRES_STORAGE) == 1 then
	 window:addChoice(7, "7 - Vampires")
	end
	if player:getStorageValue(FISH_STORAGE) == 1 then
	 window:addChoice(8, "8 - Fish")
	end
	if player:getStorageValue(MOUNTAINISLAND_STORAGE) == 1 then
	 window:addChoice(9, "9 - Mountain Island")
	end
	if player:getStorageValue(SPIDERSDEEP_STORAGE) == 1 then
	 window:addChoice(10, "10 - Spiders [deep]")
	end	
	if player:getStorageValue(HEROTOWER_STORAGE) == 1 then
	 window:addChoice(11, "11 - Hero Tower")
	end	
	if player:getStorageValue(SWAMPSHOMUNG_STORAGE) == 1 then
	 window:addChoice(12, "12 - Deep Swampland")
	end		
 
    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
 
    window:sendToPlayer(player)
    return true
end


