Attack = {}

function Attack:new(name, attacker, defender, params)
    local attack = {}
    setmetatable(attack, self)
    self.__index = self
    self.name = name
    self.attacker = attacker
    self.target = defender
    self.sprite = params.sprite or nil
    self.frames = params.frames or nil
    return attack
end

function Attack:update(dt)

    self.defender:inflict_damage(5)
    print(self.attacker.name .. " is attacking " .. self.defender.name)
    print(self.defender.name, self.defender.stats["health"] .. " health")
end

function Attack:update_draws(dt)
    for i, attack in pairs(G_gamestate.attack_queue) do
        print("Updating Attack " .. attack.name, attack.animation_frame)
        print("Number of attacks " .. #G_gamestate.attack_queue)
        attack.animation_frame = attack.animation_frame + 10 * dt
        if attack.animation_frame >= 4 then
            G_gamestate.attack_queue[i] = nil
        end
    end
end

function Attack:draw()
    for _i, attack in pairs(G_gamestate.attack_queue) do
        print("Drawing: " .. attack.name, attack.animation_frame)
        love.graphics.draw(G_spritesheet, attack.sprite, (attack.x - 1) * DRAW_FACTOR, (attack.y - 1) * DRAW_FACTOR, 0, attack.animation_frame)
    end
end

function Attack:log(dt)
    if G_log_text then
        love.graphics.print(G_log_text, SCREEN_HEIGHT / 2, SCREEN_WIDTH / 2, 0, 2)
    end
end