function load_sprites()
    spritesheet = love.graphics.newImage("assets/spritesheet_colored_transparent_packed.png")
    sprites = {}

    for x = 0, spritesheet:getWidth() - 15, 16 do
        for y = 0, spritesheet:getHeight() - 15, 16 do
            sprite = love.graphics.newQuad(x, y, 16, 16, spritesheet)
            table.insert(sprites, sprite)
        end
    end

    player = {}
    player.sprite = sprites[551]
    player.x = 2
    player.y = 2

    brick_wall = {}
    brick_wall.sprite = sprites[146]
    brick_wall.x = 0
    brick_wall.y = 0

    white_doorframe = {}
    white_doorframe.sprite = sprites[187]
    white_doorframe.x = 0
    white_doorframe.y = 0

    empty = {}
    empty.sprite = sprites[1]
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