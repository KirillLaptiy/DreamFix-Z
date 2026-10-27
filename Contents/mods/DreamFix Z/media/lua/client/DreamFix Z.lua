
function checkZombieInRoomWithPlayer()

    local player = getPlayer()

    if not player:isSeatedInVehicle() then

        if player:isAsleep() then
        
            local zombies = getCell():getZombieList()
            local oneroom = true

            for i = 0, zombies:size() - 1 do
                local zombie = zombies:get(i)
                local distance = zombie:DistTo(player)

                local zombieRoom = zombie:getCurrentSquare():getRoom()
                local playerRoom = player:getCurrentSquare():getRoom()

                if (zombieRoom or playerRoom) and zombieRoom ~= playerRoom then
                    oneroom = false
                else
                    oneroom = true
                end

                if oneroom and distance <= 1 then
                    applyZombieAttack(player)
                end
            end

        end
    end
end

function applyZombieAttack(player)

    local bodyParts = player:getBodyDamage():getBodyParts()

    local randomBodyPartIndex = ZombRand(0, bodyParts:size() - 1)
    local bodyPart = bodyParts:get(randomBodyPartIndex)

    bodyPart:AddDamage(40)
    bodyPart:SetBitten(true)
    bodyPart:setAdditionalPain(400)


    player:getEmitter():playSound("ZombieBite")
    player:forceAwake()

    local soundName = ""

    if player:isFemale() then
        soundName = "fscream1"
    else
        soundName = "scream2"
    end


    player:playSound(soundName)
    addSound(player, player:getX(), player:getY(), player:getZ(), ZombRand(61) + 90, ZombRand(11) + 120)

end

Events.EveryTenMinutes.Add(checkZombieInRoomWithPlayer)


-- function test123()

--     local player = getPlayer()
--         if player:isSeatedInVehicle() then
--             print("123")
--         end

--     if Core.GameMode ~= "Multiplayer" then
--         print("Game mode ~= Multiplayer")
--     end
    
-- end

-- Events.EveryOneMinute.Add(test123)
