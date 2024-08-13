require("mob")


function G_load_map()
    local D = 'D'
    local W = 'W'
    G_tilemap = {
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, D},
        {1, 0, 0, 0, 0, W, W, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, W, W, W, 0, 0, 0, 0, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    }

end

function G_draw_map()
    local brick_wall = G_entities["brick_wall"]
    local white_doorframe = G_entities["white_doorframe"]
    local white_door = G_entities["white_door"]
    local empty = G_entities["empty"]
    local water = G_entities["water"]

    for y = 1, #G_tilemap do
        for x = 1, #G_tilemap[y] do
            if G_tilemap[y][x] == 1 then
                love.graphics.draw(G_spritesheet, brick_wall.sprite, x * 64, y * 64, 0, 4)
            elseif G_tilemap[y][x] == 'O' then
                love.graphics.draw(G_spritesheet, white_doorframe.sprite, x * 64, y * 64, 0, 4)
            elseif G_tilemap[y][x] == 'D' then
                love.graphics.draw(G_spritesheet, white_door.sprite, x * 64, y * 64, 0, 4)
            elseif G_tilemap[y][x] == 'W' then
                love.graphics.draw(G_spritesheet, water.sprite, x * 64, y * 64, 0, 4)
            else
                love.graphics.draw(G_spritesheet, empty.sprite, x * 64, y * 64, 0, 4)
                -- love.graphics.rectangle("line", x * 32, y * 32, 32, 32)
            end
        end
    end
end

function G_empty_tile(x, y)
    return G_tilemap[y][x] == 0 or G_tilemap[y][x] == 'O' or G_tilemap[y][x] == 'W'
    -- TODO return map_tile.blocker == false
end

function G_no_creature(x, y)
    for _i, j in pairs(G_entities) do
        if x == j.x and y == j.y and j.is_creature == true then
            return false
        end
    end

    return G_tilemap[y][x]
end