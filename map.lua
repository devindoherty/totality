require("mob")

function G_load_map()
    local D = 'D'
    local W = 'W'
    G_tilemap = {
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, D},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, W, W, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, W, W, W, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    }

end

function G_draw_map()
    local brick_wall = G_entities["brick_wall"]
    local white_doorframe = G_entities["white_doorframe"]
    local white_door = G_entities["white_door"]
    local empty = G_entities["empty"]
    local water = G_entities["water"]
    local tile_sprite = empty

    for y = 1, #G_tilemap do
        for x = 1, #G_tilemap[y] do
            if G_tilemap[y][x] == 1 then
                tile_sprite = brick_wall.sprite
            elseif G_tilemap[y][x] == 'O' then
                tile_sprite = white_doorframe.sprite
            elseif G_tilemap[y][x] == 'D' then
                tile_sprite = white_door.sprite
            elseif G_tilemap[y][x] == 'W' then
                tile_sprite = water.sprite
            else
                tile_sprite = empty.sprite
            end
            love.graphics.draw(G_spritesheet, tile_sprite, x * DRAW_FACTOR, y * DRAW_FACTOR, 0, SCALE_FACTOR)
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

function G_creature_adjacent(x, y)
    for _i, entity in pairs(G_entities) do
        if entity.x == x and entity.y == y then
            if entity.is_creature == true then
                return true
            end
        end
    end
    return false
end

function G_get_creature_with_xy(x, y)
    for _i, entity in pairs(G_entities) do
        if entity.x == x and entity.y == y then
            if entity.is_creature == true then
                return entity
            end
        end
    end
end