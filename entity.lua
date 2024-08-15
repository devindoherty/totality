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
    e.is_attacking = false
    e.is_friendly = false
    e.target = {}
    e.stats = {}
    return e
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
    love.graphics.print("Health: " .. health .. "    Defense: " .. defense, SCREEN_WIDTH / 14, SCREEN_HEIGHT + 30, 0, 2)
end

function G_init_entities()
    G_entities = {}

    local empty = Entity:new("empty", G_sprites[1], 0, 0, false)
    G_entities["empty"] = empty

    local player = Entity:new("player", G_sprites[551], 2, 2, true)
    player:set_stat("health", 100)
    player:set_stat("defense", 12)
    

    local rat = Entity:new("rat", G_sprites[691], 14, 2, true)
    rat:set_stat("health", 20)
    rat:set_stat("defense", 3)
    rat.behavior = "aggressive"
    

    local croc = Entity:new("croc", G_sprites[647], 14, 7, true)
    croc:set_stat("health", 20)
    croc:set_stat("defense", 15)
    croc.behavior = "neutral"
    croc.quips = {
        "Do you have the time?",
        "My teeth need a cleaning.",
        "Cold blooded doesn't mean coldhearted.",
    }

    local lothar = Entity:new("lothar", G_sprites[529], 2, 7, true)
    lothar:set_stat("health", 25)
    lothar:set_stat("defense", 16)
    lothar.behavior = "neutral"
    lothar.is_friendly = true
    
    G_entities["player"] = player
    G_entities[rat.name] = rat
    G_entities["croc"] = croc
    G_entities["lothar"] = lothar

    ------------ Structures -----------------
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
    G_entities["white_door"] = white_door

    local white_doorframe = {}
    white_doorframe.sprite = G_sprites[187]
    white_doorframe.x = 0
    white_doorframe.y = 0
    G_entities["white_doorframe"] = white_doorframe

    local water = {}
    water.sprite = G_sprites[182]
    water.alt_sprites = {}
    water.x = 0
    water.y = 0
    G_entities["water"] = water

end

function G_draw_creatures()
    for _i, entity in pairs(G_entities) do
        if entity.is_creature == true then
            love.graphics.draw(G_spritesheet, entity.sprite, entity.x * DRAW_FACTOR, entity.y * DRAW_FACTOR, 0, SCALE_FACTOR)
        end
    end
end

function G_player_camera()
    local player = G_entities["player"]
    love.graphics.translate(-player.x + 600, -player.y + 400)
end

