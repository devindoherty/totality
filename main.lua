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
    -- player_movement(dt)
end

function love.draw()
    
    draw_map()
    love.graphics.draw(spritesheet, rat.sprite, rat.x * 64, rat.y * 64, 0, 4)
    love.graphics.draw(spritesheet, player.sprite, player.x * 64, player.y * 64, 0, 4)
end