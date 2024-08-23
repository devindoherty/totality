Entity = {}
function Entity:new(name, sprite, x, y, is_creature)
    local entity = {}
    setmetatable(entity, self)
    self.__index = self
    entity.name = name
    entity.sprite = sprite
    entity.x = x
    entity.y = y
    entity.is_creature = is_creature
    entity.is_item = false
    entity.is_openable = false
    entity.is_effect = false
    entity.is_conversing = false
    entity.is_attacking = false
    entity.is_defending = false
    entity.is_friendly = false
    entity.target = {}
    if entity.name ~= "player" then
        entity.last_seen = {
            x = 0,
            y = 0
        }
        entity.los = {
            x = 0,
            y = 0
        }
    end
    entity.stats = {}
    return entity
end

function Entity:set_stat(stat, value)
    self.stats[stat] = value
end

function Entity:inflict_damage(damage)
    self.stats["health"] = self.stats["health"] - damage
end

function Entity:draw_stats()
    local health = self.stats["health"]
    local defense = self.stats["defense"]
    
    -- love.math.colorFromBytes(0,191,255)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", 0, 0, 128, 64) -- TODO MAKE WORD
    love.graphics.setColor(255, 255, 255)

    love.graphics.print("Health: " .. health, 0, 0, 0)
    love.graphics.print("Defense: " .. defense, 0, 13, 0)
end

function Entity:draw_quip(topic)
    love.graphics.setColor(0, 0, 1, .75)
    love.graphics.rectangle("fill", self.x * DRAW_FACTOR + 25, self.y * DRAW_FACTOR - 35, 225, 36, 15, 15)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(self.quips[topic], self.x * DRAW_FACTOR + 25, self.y * DRAW_FACTOR - 35, 225)
    love.graphics.setColor(255, 255, 255)
end

function Entity:draw_injured()
    if self.stats["health"] < 10 then
        -- TODO self.sprite
    end
end



function G_draw_creatures()
    for _i, entity in pairs(G_entities) do
        if entity.is_creature == true then
            love.graphics.draw(G_spritesheet, entity.sprite, entity.x * DRAW_FACTOR, entity.y * DRAW_FACTOR, 0, SCALE_FACTOR)
        end
    end
end

function G_draw_items()
    for _i, entity in pairs(G_entities) do
        if entity.is_item == true then
            love.graphics.draw(G_spritesheet, entity.sprite, entity.x * DRAW_FACTOR, entity.y * DRAW_FACTOR, 0, SCALE_FACTOR)
        end
    end
end

function G_player_camera()
    local player = G_entities["player"]
    love.graphics.translate((-player.x * DRAW_FACTOR) + (SCREEN_WIDTH / 2) -32, (-player.y * DRAW_FACTOR) + (SCREEN_HEIGHT / 2) - 16)
end

function G_update_dead_creatures()
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