require("mob")

function G_init_map()
    local D = 'D'
    local W = 'W'
    local O = 'O'
    local T = 'T'
    
    local P = 'player'
    local L = 'lothar'
    local R = 'rat'
    local C = 'croc'

    G_tilemap = {
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, W, W},
        {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, W, W},
        {0, 1, P, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, R, 1, 0, 0, W, W},
        {0, 1, 0, 0, 0, 1, 0, 0, D, 0, D, 0, 0, 0, 0, 1, 0, 0, W, W},
        {0, 1, 1, D, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, W, W},
        {0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, D, 1, 1, 1, 0, 0, W, W},
        {0, 1, 0, 0, 0, D, 0, 0, 0, 0, 0, 0, 0, 0, 0, D, 0, 0, W, W},
        {0, 1, 0, 0, 0, 1, 1, 1, 1, D, 1, 1, D, 1, 1, 1, 0, W, W, C},
        {0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, W, W, 0},
        {0, 1, L, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, W, W, 0},
        {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, W, W, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, W, W, 0},
        {0, 0, 0, 0, 0, 0, T, 0, 0, 0, 0, 0, T, 0, 0, 0, W, W, W, 0},
        {0, 0, 0, T, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, W, W, W, W, 0},
        {0, 0, 0, 0, 0, 0, 0, T, 0, 0, 0, T, 0, 0, 0, W, W, W, 0, 0},
        {0, 0, T, 0, T, 0, T, 0, 0, 0, 0, T, 0, 0, T, W, W, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, W, W, 0, 0, 0},
        {0, 0, 0, T, 0, T, 0, 0, 0, 0, 0, 0, 0, 0, W, W, W, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, W, W, 0, 0, 0, 0},
    }


    G_init_creature_locations()
end

function G_init_creature_locations()
    for y = 1, #G_tilemap do
        for x = 1, #G_tilemap[y] do
            for i, entity in pairs(G_entities) do
                if G_tilemap[y][x] == i then
                    G_entities[i].x = x
                    G_entities[i].y = y
                end
            end
        end
    end
end

function G_draw_map()
    local brick_wall = G_entities["brick_wall"]
    local white_doorframe = G_entities["white_doorframe"]
    local white_door = G_entities["white_door"]
    local empty = G_entities["empty"]
    local water = G_entities["water"]
    local tree = G_entities["tree"]
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
            elseif G_tilemap[y][x] == 'T' then
                tile_sprite = tree.sprite
            else
                G_tilemap[y][x] = 0
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

function G_inbounds(x, y)
    if y < 1 or x < 1 then return false end
    if x > #G_tilemap[y] then return false end
    if y >= #G_tilemap then return false end
    return true
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

function G_openable_tile_adjacent(x, y)
    -- TODO: Maptile as entity rewrite
    -- for _i, entity in pairs(G_entities) do
    --     if entity.x == x and entity.y == y then
    --         if entity.is_item and entity.is_openable then
    --             return true
    --         end
    --     end
    -- end
    print("test openable")
    print(G_tilemap[y][x])
    return G_tilemap[y][x] == 'D'
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