dofile('data/lmsLib.lua')
 
function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end
 
    if Game.getStorageValue(lmsStatesTable.EVENT_STATE_STORAGE) ~= lmsStatesTable.EVENT_STATE_INIT then
        player:sendTextMessage(MESSAGE_INFO_DESCR, 'Floor is lava event has started or not started yet.')
        player:teleportTo(fromPosition, true)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end
 
    local joinedCountStorage = Game.getStorageValue(lmsConfigTable.joinedCountStorage)
    if joinedCountStorage and joinedCountStorage > lmsConfigTable.maxPlayers then
        player:sendTextMessage(MESSAGE_INFO_DESCR, 'Floor is lava event is already full.')
        player:teleportTo(fromPosition, true)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end
 
    fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
    player:teleportTo(lmsConfigTable.waitingRoomPosition.centerPos)
    lmsConfigTable.waitingRoomPosition.centerPos:sendMagicEffect(CONST_ME_TELEPORT)
    Game.setStorageValue(lmsConfigTable.joinedCountStorage, joinedCountStorage + 1)
    player:setStorageValue(lmsConfigTable.joinedStorage, 1)
    return true
end