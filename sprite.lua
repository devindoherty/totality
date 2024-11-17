function G_load_sprites()
    G_spritesheet = love.graphics.newImage("assets/spritesheet_colored_transparent_packed.png")
    G_sprites = {}

    for x = 0, G_spritesheet:getWidth() - 15, 16 do
        for y = 0, G_spritesheet:getHeight() - 15, 16 do
            local sprite = love.graphics.newQuad(x, y, 16, 16, G_spritesheet)
            table.insert(G_sprites, sprite)
        end
    end
   
    G_start_screen_splash = love.graphics.newImage("assets/start_screen_splash.png")
end

