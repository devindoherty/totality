require("spritesheet")

Entity = {}
function Entity:new(name, sprite, x, y, is_creature)
    local e = {}
    setmetatable(e, self)
    self.__index = self
    e.name = name
    e.sprite = sprite
    e.x = x
    e.y = y
    e.is_creature = is_creature
    e.is_item = false
    e.is_openable = false
    e.is_effect = false
    e.is_attacking = false
    e.is_defending = false
    e.is_friendly = false
    e.target = {}
    if e.name ~= "player" then
        e.last_seen = {
            x = 0,
            y = 0
        }
    end
    e.stats = {}
    return e
end

function Entity:set_stat(stat, value)
    self.stats[stat] = value
end

function Entity:draw_stats()
    local health = self.stats["health"]
    local defense = self.stats["defense"]
    
    love.graphics.setColor(love.math.colorFromBytes(0,191,255))
    love.graphics.rectangle("fill", 0, 0, 128, 64) -- TODO MAKE WORD
    love.graphics.setColor(255, 255, 255)

    love.graphics.print("Health: " .. health, 0, 0, 0)
    love.graphics.print("Defense: " .. defense, 0, 13, 0)
end

function Entity:inflict_damage(damage)
    self.stats["health"] = self.stats["health"] - damage
end

function Entity:draw_injured()
    if self.stats["health"] < 10 then
        -- TODO self.sprite
    end
end

function G_init_entities()
    G_entities = {}

    local empty = Entity:new("empty", G_sprites[1], 0, 0, false)
    G_entities["empty"] = empty

    local player = Entity:new("player", G_sprites[551], 3, 3, true)
    player:set_stat("health", 100)
    player:set_stat("defense", 12)
    

    local rat = Entity:new("rat", G_sprites[691], 15, 3, true)
    rat:set_stat("health", 20)
    rat:set_stat("defense", 3)
    rat.behavior = "aggressive"
    

    local croc = Entity:new("croc", G_sprites[647], 18, 7, true)
    croc:set_stat("health", 20)
    croc:set_stat("defense", 15)
    croc.behavior = "loitering"
    croc.quips = {
        "Do you have the time?",
        "My teeth need a cleaning.",
        "Cold blooded doesn't mean coldhearted.",
    }

    local lothar = Entity:new("lothar", G_sprites[685], 3, 10, true)
    lothar:set_stat("health", 25)
    lothar:set_stat("defense", 16)
    lothar.behavior = "neutral"
    lothar.is_friendly = true
    
    G_entities["player"] = player
    G_entities[rat.name] = rat
    G_entities["croc"] = croc
    G_entities["lothar"] = lothar

    ------------ Terrain -----------------
    local brick_wall = {}
    brick_wall.sprite = G_sprites[146]
    brick_wall.x = 0
    brick_wall.y = 0
    brick_wall.blocker = true
    G_entities["brick_wall"] = brick_wall

    local white_door = {}
    white_door.sprite = G_sprites[210]
    white_door.x = 0
    white_door.y = 0
    white_door.is_openable = true
    G_entities["white_door"] = white_door

    local white_doorframe = {}
    white_doorframe.sprite = G_sprites[187]
    white_doorframe.x = 0
    white_doorframe.y = 0
    G_entities["white_doorframe"] = white_doorframe

    local wooden_downstairs = {}
    wooden_downstairs.sprite = G_sprites[73]
    wooden_downstairs.x = 7
    wooden_downstairs.y = 4
    wooden_downstairs.is_item = true
    G_entities["wooden_downstairs"] = wooden_downstairs

    local water = {}
    water.sprite = G_sprites[182]
    water.alt_sprites = {}
    water.x = 0
    water.y = 0
    G_entities["water"] = water

    local tree = {}
    tree.sprite = G_sprites[2]
    tree.x = 0
    tree.y = 0
    G_entities["tree"] = tree

    local bush = {}
    bush.sprite = G_sprites[25]
    bush.x = 0
    bush.y = 0
    G_entities["bush"] = bush

    local dirt_road = {}
    dirt_road.sprite = G_sprites[67]
    dirt_road.x = 0
    dirt_road.y = 0
    G_entities["dirt_road"] = dirt_road

--------------Furniture---------------
    local wooden_bed = {}
    wooden_bed.sprite = G_sprites[119]
    wooden_bed.x = 3
    wooden_bed.y = 3
    wooden_bed.blocker = false
    wooden_bed.is_creature = false
    wooden_bed.is_item = true
    G_entities["wooden_bed"] = wooden_bed


--------------Effects----------------

    -- local slash = {}
    -- slash.sprite = G_sprites[540]
    -- slash.x = 5
    -- slash.y = 5
    -- slash.is_effect = true
    -- slash.animation_frame = 1
    -- G_entities["slash"] = slash

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
    love.graphics.translate((-player.x * DRAW_FACTOR) + (SCREEN_WIDTH / 2) -32, (-player.y * DRAW_FACTOR) + (SCREEN_HEIGHT / 2) -32)
end

function G_update_dead_creatures()
    for _i, entity in pairs(G_entities) do
        if entity.is_creature then
            if entity.stats["health"] <= 0 then
                G_entities[entity.name] = nil
            end
        end
    end
end