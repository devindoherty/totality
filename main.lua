require("input")
require("spritesheet")
require("map")

GAMESTATES = {"player_turn", "enemy_turn"}

DRAW_FACTOR = 64
SCALE_FACTOR = 4

function love.load()
    love.window.setMode(1920 / 2, 1080 / 2)
    love.window.setTitle("Totality")
    icon = love.image.newImageData("assets/eclipse.png")
    love.window.setIcon(icon)
    love.graphics.setDefaultFilter("nearest", "nearest")
    load_sprites()
    load_map()
end

function love.update()
    -- player_movement(dt)
end

function love.draw()
    
    draw_map()
    love.graphics.draw(spritesheet, rat.sprite, rat.x * DRAW_FACTOR, rat.y * DRAW_FACTOR, 0, SCALE_FACTOR)
    love.graphics.draw(spritesheet, player.sprite, player.x * DRAW_FACTOR, player.y * DRAW_FACTOR, 0, SCALE_FACTOR)
end