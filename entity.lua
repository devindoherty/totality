require("spritesheet")

-- 22 G_sprites[idx] between columns in same row
function G_load_entities()
    G_entities = {}

    local empty = {}
    empty.sprite = G_sprites[1]
    G_entities["empty"] = empty

    local player = {}
    player.sprite = G_sprites[551]
    player.x = 2
    player.y = 2
    player.name = "Player"
    player.stats = {
        health = 20,
        defense = 10
    }
    player.is_creature = true
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