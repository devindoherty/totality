function love.keypressed(key, scancode, isrepeat)
    if key == "q" or key == "escape" then
        love.event.quit(0)
    end
    if key == "right" then
        player.x = player.x + 50
    end
    if key == "left" then
        player.x = player.x - 50
    end
    if key == "up" then
        player.y = player.y - 50
    end
    if key == "down" then
        player.y = player.y + 50
    end

end

function player_movement(dt)
    if love.keyboard.isDown("w") then
        player.y = player.y - 100 * dt
    elseif love.keyboard.isDown("a") then
        player.x = player.x - 100 * dt
    elseif love.keyboard.isDown("s") then
        player.y = player.y + 100 * dt
    elseif love.keyboard.isDown("d") then
        player.x = player.x + 100 * dt
    end
end