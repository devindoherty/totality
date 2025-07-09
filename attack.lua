-- Attack class

Attack = {}

function Attack:new(name, x, y, attacker, defender, params)
    local attack = {}
    setmetatable(attack, self)
    self.__index = self
    attack.name = name
    attack.x = x
    attack.y = y
    attack.attacker = attacker
    attack.defender = defender
    attack.description = params.description or ""
    attack.sprite = G_sprites[params.sprite] or nil
    attack.frame = params.frame or nil
    attack.max_frame = 2.5
    attack.damage = params.damage or 0
    attack.condition = params.condition or nil
    return attack
end

-- Loops through frames for the attack animation
function Attack:update(dt)
    if self.frame == 0 then 
        self.defender:inflict_damage(self.damage)
    end
    if DEBUG then
        print(self.attacker.name .. " is attacking " .. self.defender.name .. " on x " .. self.x .. " and y " .. self.y)
    end
    self:update_frames(dt)
end

-- Looping frames
function Attack:update_frames(dt)
    self.frame = self.frame + 10 * dt
end

function Attack:render()
    love.graphics.draw(G_spritesheet, self.sprite, (self.x - 1) * DRAW_FACTOR, (self.y - 1) * DRAW_FACTOR, 0, self.frame)
end

function Attack:log(log)
    local logline = self.attacker.name .. " " .. self.description.name .. " " .. self.defender.name .. " for " .. self.damage .. " damage."
    table.insert(log, logline)
end