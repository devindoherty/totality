Map = {}

function Map:new(params)
    local map = {}
    setmetatable(map, self)
    self.__index = self

    self.tiles = {}
    self.items = {}
    self.mobs = {}

    self.player = nil
    
    -- Reading our map data strings to Tile objects
    for y = 1, #params.tiles do
        table.insert(self.tiles, {})
        for x = 1, #params.tiles[y] do
            local type = G_tiles[string.sub(params.tiles[y], x, x)]
            local tile = Tile:new(type, x, y)
            table.insert(self.tiles[y], tile)
        end
    end

    -- Getting the items defs from the maps data
    for _k, itemdef in pairs(params.items) do
        local item = Item:new(itemdef[1], itemdef[2], itemdef[3], map)
        table.insert(self.items, item)
    end

    -- Getting the mob defs from the maps data
    for i, mobdef in pairs(params.mobs) do
        local mob = Mob:new(mobdef[1], mobdef[2], mobdef[3], map, i)
        table.insert(self.mobs, mob)
    end

    return map
end

function Map:update()

end

function Map:render()
    for y = 1, #self.tiles do
        for x = 1, #self.tiles[y] do
            local tile = self.tiles[y][x]
            if tile.name == "empty" then
                -- Pass
            else
                -- love.graphics.draw(G_spritesheet, tile.sprite, (tile.x-1) * DRAW_FACTOR, (tile.y-1) * DRAW_FACTOR, 0, SCALE_FACTOR)
                tile:render()
            end
        end
    end

    for _i, item in pairs(self.items) do
        item:render()
    end

    for _i, mob in pairs(self.mobs) do
        mob:render()
    end
end

-- Is a tile passable
function Map:solid(x, y)
    return self.tiles[y][x].solid
end

-- Inbounds of map area
function Map:inbounds(x, y)
    if y < 1 or x < 1 then
         return false
    elseif y > MAP_HEIGHT or x > MAP_WIDTH then
        return false
    else
        return true
    end
end

-- Is the tile stood on by a mob
function Map:occupied(x, y)
    if x == self.player.x and y == self.player.y then
        return true
    end
    for _i, mob in pairs(self.mobs) do
        if x == mob.x and y == mob.y then
            return true
        end
    end
end

-- Checks if there's solid items like furnishings
function Map:blocked(x, y)
    for _i, item in pairs(self.items) do
        if x == item.x and y == item.y then
            if item.blocker then
                return true
            end
        end
    end
end

-- Checks for doorways
function Map:openable(x, y)
    return self.tiles[y][x].openable
end

-- Checks for open doorways to close
function Map:closable(x, y)
    return self.tiles[y][x].closable
end

-- Updating tiles
function Map:change_tile(x, y, new_tile)
    self.tiles[y][x] = new_tile
end

-- Gets a mob's location via x y coords
function Map:get_mob_with_xy(x, y)
    for _i, mob in pairs(self.mobs) do
        if mob.x == x and mob.y == y then
            return mob
        end
    end
    return false
end

-- Gets items with x y coords
function Map:get_item_with_xy(x, y)
    for _i, item in pairs(self.items) do
        if item.x == x and item.y == y then
            return item
        end
    end
    return false
end

-- Gets tile with x y coords
function Map:get_tile_with_xy(x, y)
    return self.tiles[y][x]
end

-- Not used at present
function Map:get_distance_between_two_points(point1, point2)
    local x1 = point1.x
    local y1 = point1.y

    local x2 = point2.x
    local y2 = point2.y

    return math.sqrt(((x2 - x1) ^ 2) + ((y2 - y1) ^ 2))
end

-- Creates and item and inserts into map table
function Map:create_item(item)
    table.insert(self.items, item)
end