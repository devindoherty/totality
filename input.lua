require("mob")

function love.keypressed(key, scancode, isrepeat)
    if key == "q" or key == "escape" then
        love.event.quit(0)
    end
    
    local x = player.x
    local y = player.y

    local ratx = rat.x
    local raty = rat.y

    if key == "d" then
        x = player.x + 1
    elseif key == "a" then
        x = player.x - 1
    elseif key == "w" then
        y = player.y - 1
    elseif key == "s" then
        y = player.y + 1
    end
    
    if empty_tile(x, y) and no_mob(x, y) then
        player.x = x
        player.y = y
    else
        print("Tile blocker at: " .. x .. ", " .. y)
    end

    move_toward_player(ratx, raty)

    if empty_tile(ratx, raty) then
        print("Rat X: " .. rat.x)
        print("Rat Y: " .. rat.y)
    end


    print("Player X: " .. player.x)
    print("Player Y: " .. player.y)

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