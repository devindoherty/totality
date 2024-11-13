Map = {}

function Map:new(params)
    local map = {}
    setmetatable(map, self)
    self.__index = self

    self.tiles = {}
    self.objects = {}
    self.mobs = {}
    
    for y = 1, #params.tiles do
        table.insert(self.tiles, {})
        for x = 1, #params.tiles[y] do
            local type = G_tiles[string.sub(params.tiles[y], x, x)]
            local tile = Tile:new(type, x-1, y-1)
            table.insert(self.tiles[y], tile)
        end
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
                love.graphics.draw(G_spritesheet, tile.sprite, tile.x * DRAW_FACTOR, tile.y * DRAW_FACTOR, 0, SCALE_FACTOR)
            end
        end
    end
end

function Map:solid(x, y)
    local x = x + 1
    local y = y + 1
    return self.tiles[y][x].solid
end

function Map:inbounds(x, y)
    if y < 0 or x < 0 then
         return false
    elseif y > MAP_HEIGHT or x > MAP_WIDTH then
        return false
    else
        return true
    end
end

function Map:no_creature(x, y)
    for _i, mob in pairs(self.mob) do
        if x == mob.x and y == mob.y and mob.is_creature == true then
            return false
        end
    end

    return self.tiles[y][x]
end

function Map:openable(x, y)
    local x = x + 1
    local y = y + 1
    return self.tiles[y][x].openable
end

function Map:change_tile(x, y, new_tile)
    local x = x + 1
    local y = y + 1

    self.tiles[y][x] = new_tile
end

function Map:get_creature_with_xy(x, y)
    for _i, entity in pairs(G_entities) do
        if entity.x == x and entity.y == y then
            if entity.is_creature == true then
                return entity
            end
        end
    end
end

function Map:get_distance_between_two_points(point1, point2)
    local x1 = point1.x
    local y1 = point1.y

    local x2 = point2.x
    local y2 = point2.y

    return math.sqrt(((x2 - x1) ^ 2) + ((y2 - y1) ^ 2))
end

function Map:draw_creatures()
    for _i, entity in pairs(G_entities) do
        if entity.is_creature == true then
            love.graphics.draw(G_spritesheet, entity.sprite, entity.x * DRAW_FACTOR, entity.y * DRAW_FACTOR, 0, SCALE_FACTOR)
        end
    end
end

function Map:draw_items()
    for _i, entity in pairs(G_entities) do
        if entity.is_item == true then
            love.graphics.draw(G_spritesheet, entity.sprite, entity.x * DRAW_FACTOR, entity.y * DRAW_FACTOR, 0, SCALE_FACTOR)
        end
    end
end

function Map:update_dead_creatures()
    for _i, entity in pairs(G_entities) do
        if entity.is_creature then
            if entity.stats["health"] <= 0 then
                G_entities[entity.name] = nil
                local bones = Entity:new("bones", G_sprites[16], entity.x, entity.y, false)
                bones.is_item = true
                G_entities[#G_entities+1] = bones
            end
        end
    end
end