function load_sprites()
    spritesheet = love.graphics.newImage("assets/spritesheet_colored_transparent_packed.png")
    sprites = {}

    for x = 0, spritesheet:getWidth(), 16 do
        for y = 0, spritesheet:getHeight(), 16 do
            sprite = love.graphics.newQuad(x, y, 16, 16, spritesheet)
            table.insert(sprites, sprite)
        end
    end

    player = {}
    player.sprite = sprites[576]
    player.x = 0
    player.y = 0
end

function load_map()
    tilemap = {
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    }

end

function draw_map()
    for y = 1, #tilemap do
        for x = 1, #tilemap[y] do
            if tilemap[y][x] then
                love.graphics.rectangle("line", x * 16, y * 16, 16, 16)
            end
        end
    end
end

function draw_spritesheet()
    x = 0
    y = 0
    -- for i = 1, #sprites do
    --     love.graphics.print(i, x, y)
    --     love.graphics.draw(spritesheet, sprites[i], x + 16, y)
    --     y = y + 16
    --     if y > love.graphics.getHeight() - 16 then
    --         x = x + 32
    --         y = 0
    --     end
    -- end
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


function love.load()
    love.window.setMode(1920 / 2, 1080 / 2)
    love.graphics.setDefaultFilter("nearest", "nearest")
    load_sprites()
    load_map()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "q" or "escape" then
        love.event.quit(0)
    end
end

function love.update(dt)
    player_movement(dt)
end

function love.draw()
    
    draw_map()
    love.graphics.draw(spritesheet, player.sprite, player.x, player.y, 0)
end