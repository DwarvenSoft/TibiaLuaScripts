cfg = {globalStorage = 35173}


local function change1(pos)
    local item = Tile(pos):getItemById(3691)
    if item then
        item:transform(3695)
    end
end

local function change2(pos)
    local item = Tile(pos):getItemById(3692)
    if item then
        item:transform(3696)
    end
end

local function change3(pos)
    local item = Tile(pos):getItemById(3695)
    if item then
        item:transform(3691)
    end
end

local function change4(pos, cid)
	Game.setStorageValue(cfg.globalStorage, 0)
	local player = Player(cid)
    local item = Tile(pos):getItemById(3696)
    if item then
        item:transform(3692)
    end
	player:say("Seems like the fire run out", TALKTYPE_MONSTER_SAY)
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if Game.getStorageValue(cfg.globalStorage) == 0 and (toPosition == Position(1261, 1128, 7) or  toPosition == Position(1262, 1128, 7)) then
		Game.setStorageValue(cfg.globalStorage, 1)
		player:say("Fire is rapidly growing", TALKTYPE_MONSTER_SAY)
		if item then
			item:remove(1)
			addEvent(change1, 5*1000, Position(1261, 1128, 7))
			addEvent(change2, 5*1000, Position(1262, 1128, 7))
			addEvent(change3, 3*60*1000, Position(1261, 1128, 7))
			addEvent(change4, 3*60*1000, Position(1262, 1128, 7), player.uid)
		end
	elseif toPosition ~= Position(1261, 1128, 7) or toPosition ~= Position(1262, 1128, 7) then
		return false
	else 
		player:sendTextMessage(MESSAGE_INFO_DESCR, "It's already in use")
	end
    return true
end

