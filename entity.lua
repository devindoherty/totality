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
    e.stats = {}
    return e
end

function Entity:set_stat(stat, value)
    self.stats[stat] = value
end

function G_load_entities()
    G_entities = {}

    local empty = Entity:new("empty", G_sprites[1], 0, 0, false)
    G_entities["empty"] = empty

    local player = Entity:new("player", G_sprites[551], 2, 2, true)
    player:set_stat("health", 20)
    player:set_stat("defense", 12)
    G_entities["player"] = player

    local rat = {}
    rat.sprite = G_sprites[691]
    rat.x = 12
    rat.y = 2
    rat.name = "Rat"
    rat.stats = {
        health = 20,
        defense = 3
    }
    rat.is_creature = true
    G_entities["rat"] = rat

    local croc = {}
    croc.sprite = G_sprites[647]
    croc.x = 12
    croc.y = 6
    croc.name = "Croc"
    croc.stats = {
        health = 20,
        defense = 3
    }
    croc.quips = {
        "Do you have the time?",
        "My teeth need a cleaning.",
        "Cold blooded doesn't mean coldhearted.",
    }
    croc.is_creature = true
    G_entities["croc"] = croc

    local lothar = {}
    lothar.sprite = G_sprites[529]
    lothar.x = 2
    lothar.y = 6
    lothar.is_creature = true
    lothar.name = "Lothar"
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