require("mob")

function love.keypressed(key, scancode, isrepeat)
    if key == "q" or key == "escape" then
        love.event.quit(0)
    end
    
    local x = player.x
    local y = player.y

    if key == "w" or key == "kp8" then
        y = player.y - 1
    elseif key == "a" or key == "kp4" then
        x = player.x - 1
    elseif key == "d" or key == "kp6" then
        x = player.x + 1
    elseif key == "s" or key == "kp2" then
        y = player.y + 1
    elseif key == "space" then
        x = player.x
        y = player.y
    end
    
    if empty_tile(x, y) and no_creature(x, y) then
        player.x = x
        player.y = y
    else
        print("Tile blocker at: " .. x .. ", " .. y)
    end

    if turn % 2 == 0 then
        mob_turn()
    end

    print("Player X: " .. player.x)
    print("Player Y: " .. player.y)
    print("Rat X: " .. rat.x)
    print("Rat Y: " .. rat.y)

    print("END OF TURN ".. turn)
    print("####################")
    turn = turn + 1
end

-- function player_movement(dt)
--     if love.keyboard.isDown("w") then
--         player.y = player.y - 100 * dt
--     elseif love.keyboard.isDown("a") then
--         player.x = player.x - 100 * dt
--     elseif love.keyboard.isDown("s") then
--         player.y = player.y + 100 * dt
--     elseif love.keyboard.isDown("d") then
--         player.x = player.x + 100 * dt
--     end
-- end