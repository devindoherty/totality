require("input")
require("spritesheet")
require("map")

function love.load()
    love.window.setMode(1920 / 2, 1080 / 2)
    love.graphics.setDefaultFilter("nearest", "nearest")
    load_sprites()
    load_map()
end

function love.update(dt)
    player_movement(dt)
end

function love.draw()
    
    -- draw_map()
    love.graphics.draw(spritesheet, brick_wall.sprite, brick_wall.x, brick_wall.y, 0, 4)
    love.graphics.draw(spritesheet, player.sprite, player.x, player.y, 0, 4)
end