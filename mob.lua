Mob = {}

function Mob:new(params, x, y, map, id)
    local mob = {}
    setmetatable(mob, self)
    self.__index = self
    
    mob.name = params.name
    mob.sprite = G_sprites[params.sprite]
    mob.portrait = G_sprites[params.portrait]
    mob.description = params.description or "Unremarkable."
    
    mob.x = x
    mob.y = y
    mob.map = map
    mob.id = id

    mob.stats = {
        health = params.stats.health or 10,
        defense = params.stats.defense or 10,
        might = params.stats.might or 10,
        grace = params.stats.grace or 10,
        mind = params.stats.mind or 10,
        soul = params.stats.soul or 10,
    }

    mob.dialog = params.dialog

    mob.behavior = params.behavior
    mob.hostile = params.hostile or false
    mob.sightline = {x = mob.x, y = mob.y}

    mob.attack = nil

    return mob
end

-- Bresenham's line algorithm
function Mob:line_of_sight(target)
    local x0 = self.x
    local y0 = self.y

    local x1 = target.x
    local y1 = target.y

    local function line_of_sight_low(x0, y0, x1, y1)
        local dx = x1 - x0
        local dy = y1 - y0
        local yi = 1
        if dy < 0 then
            yi = -1
            dy = -dy
        end
        local D = (2 * dy) - dx
        local y = y0
        for x = x0, x1 do
            if self.map:solid(x, y) then
                self.sightline.x = x
                self.sightline.y = y
                return false
            end
            if D > 0 then
                y = y + yi
                D = D + (2 * (dy - dx))
            else
                D = D + 2 * dy
            end
            self.sightline.x = target.x
            self.sightline.y = target.y
        end
        return true
    end

    local function line_of_sight_high(x0, y0, x1, y1)
        local dx = x1 - x0
        local dy = y1 - y0
        local xi = 1
        if dx < 0 then
            xi = -1
            dx = -dx
        end
        local D = (2 * dx) - dy
        local x = x0
        for y = y0, y1 do
            if self.map:solid(x, y) then
                self.sightline.x = x
                self.sightline.y = y
                return false
            end
            if D > 0 then
                x = x + xi
                D = D + (2 * (dx - dy))
            else
                D = D + 2 * dx
            end
            self.sightline.x = target.x
            self.sightline.y = target.y
        end
        return true
    end

    if math.abs(y1 - y0) < math.abs(x1 - x0) then
        if x0 > x1 then
            return line_of_sight_low(x1, y1, x0, y0)
        else
            return line_of_sight_low(x0, y0, x1, y1)
        end
    else
        if y0 > y1 then
            return line_of_sight_high(x1, y1, x0, y0)
        else
            return line_of_sight_high(x0, y0, x1, y1)
        end
    end
end

function Mob:draw_line_of_sight(target)
    if self.sightline.x == target.x and self.sightline.y == target.y then
        love.graphics.setColor(0, 1, 0)
        love.graphics.line((self.x - .5) * DRAW_FACTOR, (self.y - .5) * DRAW_FACTOR, (target.x - .5) * DRAW_FACTOR, (target.y - .5) * DRAW_FACTOR)
    else 
        love.graphics.setColor(1, 0, 0)
        love.graphics.line((self.x - .5) * DRAW_FACTOR, (self.y - .5) * DRAW_FACTOR, (self.sightline.x - .5) * DRAW_FACTOR, (self.sightline.y - .5) * DRAW_FACTOR)
    end
    love.graphics.setColor(255, 255, 255)
end

function Mob:move_toward_target(target)
    local x = self.x
    local y = self.y

    if x ~= target.x or y ~= target.y then
        if math.abs(target.x - x) > math.abs(target.y - y) then
            if x < target.x then
                x = x + 1
            else
                x = x - 1
            end
        else
            if y <= target.y then
                y = y + 1
            else
                y = y - 1
            end
        end
        
        if self.map:inbounds(x, y) and not self.map:solid(x, y) and 
        not self.map:occupied(x, y) then
            print("rat move")
            self.x = x
            self.y = y
        elseif x == target.x and y == target.y then
            print("ATTACK")
            print(target.x)
            print(target.y)
            self.attack = Attack:new("basic attack", x, y, self, target, {
                description = "hit",
                sprite = 553,
                frame = 0,
                damage = 5,
                condition = "none"
            })
        end
    end
end

function Mob:move_idly()

    local x = self.x
    local y = self.y

    local prob_move = love.math.random()
    local prob_x_y = love.math.random()
    local prob_dir = love.math.random()

    -- Whether moving at all
    if prob_move >= .5 then
        -- X or Y
        if prob_x_y >= .5 then
            if prob_dir >= .5 then
                x = x + 1
            else
                x = x - 1
            end
        else
            if prob_dir >= .5 then
                y = y + 1
            else
                y = y - 1
            end
        end
        if G_empty_tile(x, y) and G_no_creature(x, y) and G_inbounds(x, y) then
            self.x = x
            self.y = y
        end
    end
end

function Mob:move_along_walls()
end

function Mob:move_aquatically()
end

function Mob:do_nothing(target)
    if self:line_of_sight(target) then
        local x = self.x
        local y = self.y
    end
end

function Mob:check_movement()
    self.action = ""
    if not self.map:inbounds(x, y) then
        return false
    elseif self.map:empty_tile(x, y) and G_no_creature(x, y) and G_inbounds(x, y) then
        return
    elseif not G_no_creature(x, y) then
        local defender = self.map:get_creature_with_xy(x, y)
        self:set_attacking(player, defender)
    elseif not G_empty_tile(x, y) then
        if G_openable_tile_adjacent(x, y) then
            G_open_item(x, y)
        end
    end
end


function Mob:select_quip()
    if self.quips then
        local quip_idx = love.math.random(1, #self.quips)
        print(self.quips[quip_idx])
    end
end

function Mob:set_attacking(defender)
    if self == defender then
        return
    elseif defender.is_friendly then
        return
    else
        self.is_attacking = true
        self.target = defender
    end
end

function Mob:render()
    love.graphics.draw(G_spritesheet, self.sprite, (self.x-1) * DRAW_FACTOR, (self.y-1) * DRAW_FACTOR, 0, SCALE_FACTOR)
    if self.attack then
        self.attack:render()
    end
end

function Mob:draw_quip(topic)
    love.graphics.setColor(0, 0, 1, .75)
    love.graphics.rectangle("fill", self.x * DRAW_FACTOR + 25, self.y * DRAW_FACTOR - 35, 225, 36, 15, 15)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(self.quips[topic], self.x * DRAW_FACTOR + 25, self.y * DRAW_FACTOR - 35, 225)
    love.graphics.setColor(255, 255, 255)
end

function Mob:set_stat(stat, value)
    self.stats[stat] = value
end

function Mob:inflict_damage(damage)
    self.stats.health = self.stats.health - damage
end

function Mob:inflict_condition(condition)

end

function Mob:die()
    for i, mob in pairs(self.map.mobs) do
        if self.id == mob.id then
            idx = i
        end
    end
    table.remove(self.map.mobs, idx)
    remains = Item:new(G_items["remains"], self.x, self.y, self.map)
    table.insert(self.map.items, remains)
end