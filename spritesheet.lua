function load_sprites()
    spritesheet = love.graphics.newImage("assets/spritesheet_colored_transparent_packed.png")
    sprites = {}

    for x = 0, spritesheet:getWidth() - 15, 16 do
        for y = 0, spritesheet:getHeight() - 15, 16 do
            sprite = love.graphics.newQuad(x, y, 16, 16, spritesheet)
            table.insert(sprites, sprite)
        end
    end
end

