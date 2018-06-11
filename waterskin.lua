cfg = {globalStorage = 35173}


local function change1(pos)
    local item = Tile(pos):getItemById(3690)
    if item then
        item:transform(3694)
    end
end

local function change2(pos)
	Game.setStorageValue(cfg.globalStorage, 2)
    local item = Tile(pos):getItemById(3689)
    if item then
        item:transform(3693)
    end
end

local function change3(pos)
    local item = Tile(pos):getItemById(3694)
    if item then
        item:transform(3690)
    end
end

local function change4(pos, cid)
	Game.setStorageValue(cfg.globalStorage, 0)
	local player = Player(cid)
    local item = Tile(pos):getItemById(3693)
    if item then
        item:transform(3689)
    end
end


function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if Game.getStorageValue(cfg.globalStorage) == 1  and (toPosition == Position(1261, 1127, 7) or  toPosition == Position(1262, 1127, 7)) then
		if item then
			item:remove(1)
			addEvent(change1, 1000, Position(1262, 1127, 7))
			addEvent(change2, 1000, Position(1261, 1127, 7))
			addEvent(change3, 3*60*1000, Position(1262, 1127, 7))
			addEvent(change4, 3*60*1000, Position(1261, 1127, 7), player.uid)
		end
	elseif Game.getStorageValue(cfg.globalStorage) == 2 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "It's already in use")
	elseif ((not toPosition == Position(1261, 1127, 7)) or (not toPosition == Position(1262, 1127, 7))) then
		return false
	elseif Game.getStorageValue(cfg.globalStorage) == 0 then
		player:say("I think I have to set up a fire first", TALKTYPE_MONSTER_SAY)
	end
    return true
end

