require("mob")

function G_init_map()
    local D = 'D'
    local W = 'W'
    local O = 'O'
    local T = 'T'
    local B = 'B'
    local S = 'S'
    
    local P = 'player'
    local Y = 'yarl'
    local R = 'rat'
    local C = 'croc'
    local L = 'lothar'

    G_tilemap = {
        {T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, 4, 4, 4, 4, 4, 4, 4, 4, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T},
        {T, 2, 2, 2, T, 2, 2, T, 2, 2, 2, T, T, 2, 2, 2, 2, 2, 2, W, 4, 4, W, 2, 2, 2, 2, T, 2, 2, T, T, 2, 2, T, T, T, 2, 2, 2, 2, 2, 2, T},
        {T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, W, W, W, W, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T, 2, 2, 2, 2, T, 2, 2, T},
        {T, T, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, W, W, T, 2, 2, 2, T, 2, T, 2, 2, T, T, 2, 2, 2, 2, 2, T, 2, 2, 2, 2, T},
        {T, T, 2, 3, P, 0, 0, 3, 0, 0, 3, 0, 3, 0, 0, 0, R, 3, 2, 2, W, W, 2, 2, 2, 2, T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T, T, T},
        {T, T, 2, 3, 0, 0, 0, 3, 0, 0, D, 0, D, 0, 0, 0, 0, 3, 2, 2, W, W, 2, T, 2, T, T, T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T, T, 2, T},
        {T, 2, 2, 3, 3, D, 3, 3, 0, 0, 3, 0, 3, 0, 0, 0, 0, 3, 2, T, W, W, 2, 2, 2, 2, T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T, 2, T},
        {T, 2, 2, 3, 0, 0, 0, 3, 3, 3, 3, 0, 3, 3, D, 3, 3, 3, 2, 2, W, W, T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T},
        {T, 2, 2, 3, 0, 0, 0, D, 0, 0, 0, 0, 0, 0, 0, 0, 0, D, 2, W, W, W, 2, 2, 2, T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T, T},
        {T, T, 2, 3, 0, 0, 0, 3, 3, 3, 3, D, 3, 3, D, 3, 3, 3, 2, W, W, W, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T},
        {T, T, 2, 3, 0, 0, 0, 3, 0, 0, 0, 0, 3, 0, 0, 0, 0, 3, 2, W, W, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T, T, T},
        {T, T, 2, 3, Y, 0, 0, 3, 0, 0, 0, 0, 3, 0, 0, 0, 0, 3, 2, W, W, 2, T, 2, 2, T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T, T},
        {T, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, W, W, 2, 2, 2, T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T, 2, 2, T},
        {T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, W, W, T, 2, 2, 2, 2, T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T, T, T, T},
        {T, 2, 2, B, 2, B, 2, B, 2, B, 2, B, 2, B, 2, 2, 2, 2, W, W, W, 2, 2, 2, 2, T, T, T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T},
        {T, 2, 2, B, 2, B, 2, B, 2, B, 2, B, 2, B, 2, 2, 2, W, W, W, W, 2, 2, T, 2, 2, 2, T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T},
        {T, 2, 2, B, 2, B, 2, B, 2, B, 2, B, 2, B, 2, 2, 2, W, W, W, 2, T, 2, 2, 2, 2, 2, T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T, T},
        {T, 2, 2, B, 2, B, 2, B, 2, B, 2, B, 2, B, 2, 2, 2, W, W, 2, 2, 2, T, 2, T, 2, T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T, T, T},
        {T, T, 2, B, 2, B, 2, B, 2, B, 2, B, 2, B, 2, 2, 2, W, W, 2, T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T, T},
        {T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, W, W, W, 2, 2, T, 2, T, 2, 2, T, 2, 2, 2, 2, 2, 2, T, T, 2, 2, 2, T, 2, 2, 2, 2, T},
        {T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, W, W, 2, T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T, 2, 2, T, 2, 2, T, 2, 2, T},
        {T, T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, W, W, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T, T, 2, T, 2, 2, 2, 2, 2, 2, 2, T, T},
        {T, T, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, W, W, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, T, 2, T, 2, 2, 2, 2, T, 2, 2, 2, T},
        {T, 2, 4, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, W, W, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, T, 0, T, T, 0, T, T, 0, 0, 0, 0, T},
        {4, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, W, W, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, T, T, 0, 0, T, 0, 0, T, 0, T, 0, T, T},
        {4, 4, 4, 4, 4, 0, 0, 0, 4, 4, 4, 4, 4, 4, 0, 0, W, W, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, T, T, T, T, 0, T, 0, 0, 0, 0, 0, 0, 0, T},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, W, W, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 4, 0, 0, 0, 0, 0, 4, 0, T},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, W, W, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, D, 4, 4, 4, 4, 4, 4, 4, 0, T},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, W, W, 0, 4, 4, 4, 4, 0, 0, L, 0, 0, 0, 4, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 0, T},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, W, W, 0, 4, 4, 4, 4, 0, 0, W, W, 0, 0, 4, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 0, T},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, W, W, 0, 4, 4, 4, 4, 0, 0, W, W, 0, 0, 4, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 0, T},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, W, W, 0, 4, 4, 4, 4, 0, 0, 0, W, 0, 0, 4, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, T, T},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, W, W, 0, 4, 4, 4, 4, 4, 4, 0, W, 4, 4, 4, 4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4, 4, T, T},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, C, W, W, 0, 0, 4, 4, 4, 4, 4, W, W, 4, 4, 4, 4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4, 4, 4, T},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, W, W, W, 0, 4, 4, 4, 4, 4, W, 0, 4, 4, 4, 4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, W, W, 0, 4, 4, 4, 4, 4, W, 0, 4, 4, 4, 4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, W, W, 0, 4, 4, 4, 4, 4, W, 0, 0, 0, 0, 0, 4, 4, 4, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, W, W, W, 0, 0, W, W, W, W, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, W, W, W, W, W, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, W, W, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, W, W, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
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
    local grass = G_entities["grass"]
    local dirt = G_entities["dirt"]
    local water = G_entities["water"]
    local tree = G_entities["tree"]
    local bush = G_entities["bush"]
    local wooden_downstairs = G_entities["wooden_downstairs"]
    local dirt_road = G_entities["dirt_road"]
    local mudrock_wall = G_entities["mudrock_wall"]

    
    local tile_sprite = empty

    for y = 1, #G_tilemap do
        for x = 1, #G_tilemap[y] do
            if G_tilemap[y][x] == 1 then
                tile_sprite = dirt.sprite   
            elseif G_tilemap[y][x] == 2 then
                tile_sprite = grass.sprite
            elseif G_tilemap[y][x] == 3 then
                tile_sprite = brick_wall.sprite
            elseif G_tilemap[y][x] == 4 then
                tile_sprite = mudrock_wall.sprite
            elseif G_tilemap[y][x] == 'O' then
                tile_sprite = white_doorframe.sprite
            elseif G_tilemap[y][x] == 'D' then
                tile_sprite = white_door.sprite
            elseif G_tilemap[y][x] == 'W' then
                tile_sprite = water.sprite
            elseif G_tilemap[y][x] == 'T' then
                tile_sprite = tree.sprite
            elseif G_tilemap[y][x] == 'B' then
                tile_sprite = bush.sprite
            elseif G_tilemap[y][x] == 'S' then
                tile_sprite = wooden_downstairs.sprite
            else
---@diagnostic disable-next-line: assign-type-mismatch
                G_tilemap[y][x] = 0
                tile_sprite = empty.sprite
            end
            love.graphics.draw(G_spritesheet, tile_sprite, x * DRAW_FACTOR, y * DRAW_FACTOR, 0, SCALE_FACTOR)
        end
    end
end

function G_empty_tile(x, y)
    return G_tilemap[y][x] == 0 or G_tilemap[y][x] == 1 or G_tilemap[y][x] == 2 or G_tilemap[y][x] == 'O' or G_tilemap[y][x] == 'W'
    -- TODO return map_tile.blocker == false
end

function G_inbounds(x, y)
    if y < 1 or x < 1 then return false end
    if y >= #G_tilemap + 1 then return false end
    if x > #G_tilemap[y] then return false end
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

function G_get_distance_between_two_points(point1, point2)
    local x1 = point1.x
    local y1 = point1.y

    local x2 = point2.x
    local y2 = point2.y

    return math.sqrt(((x2 - x1) ^ 2) + ((y2 - y1) ^ 2))

end