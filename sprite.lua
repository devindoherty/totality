Spritesheet = {}

function Spritesheet.load_sprites()
    G_spritesheet = love.graphics.newImage("assets/spritesheet_colored_transparent_packed.png")
    G_sprites = {}

    for y = 0, G_spritesheet:getHeight() - 15, 16 do
        for x = 0, G_spritesheet:getWidth() - 15, 16 do
            local sprite = love.graphics.newQuad(x, y, 16, 16, G_spritesheet)
            table.insert(G_sprites, sprite)
        end
    end
end

function Spritesheet.load_portraits()
    G_portraitsheet = love.graphics.newImage("assets/portraits.png")
    G_portraits = {}

    for y = 0, G_portraitsheet:getHeight() - 32, 32 do
        for x = 0, G_portraitsheet:getWidth() - 32, 32 do
            local portrait = love.graphics(x, y, 32, 32, G_portraitsheet)
            table.insert(G_portraits, portrait)
        end
    end 
end

