function G_init_entities()
    G_entities = {}

    local empty = Entity:new("empty", G_sprites[1], 0, 0, false)
    G_entities["empty"] = empty

    local grass = Entity:new("grass", G_sprites[111], 0, 0, false)
    G_entities["grass"] = grass

    local dirt = Entity:new("dirt", G_sprites[67], 0, 0, false)
    G_entities["dirt"] = dirt

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
        "My teeth need a cleaning.",
        "Cold blooded doesn't mean coldhearted.",
    }
    croc.quips["hello"] = "Do you have the time?"

    local yarl = Entity:new("yarl", G_sprites[685], 3, 10, true)
    yarl:set_stat("health", 25)
    yarl:set_stat("defense", 16)
    yarl.behavior = "neutral"
    yarl.is_friendly = true
    yarl.quips = {}
    yarl.quips["hello"] = "You're awake! Sit a while, if ya like. Took a nasty fall there."
    yarl.quips["intro"] = "I'm Yarl, this is my farm."
    yarl.quips["yarl"] = "That's my name, don't wear it thin. Been living on this farm since the sun died."
    yarl.quips["sun"] = "You must've really hit your head. The eclipse covered the sun some ten years ago, and never ended."
    yarl.quips["farm"] = "My little homestead. The crops are different since the sun died, but niteberries taste good enough."
    yarl.quips["fall"] = "You took quite a fall, there. Didn't break anything I hope. It's dangerous out there."
    yarl.quips["dangerous"] = "Aye, the eclipse-cursed lands aren't all smiles and rainbows. Fair share of darkins out there."
    yarl.quips["darkins"] = "Evil, dark creatures. Goblins and redcaps and all sorts of vile types. Since the eclipse, they've infested these lands."
    yarl.quips["offer"] = "I got a task for ya, if you're up to it."
    yarl.quips["task"] = "While I was out tending to you, a bunch of rats snuck into the larder downstairs. If you could ask em to leave, I'd pay you for your trouble."
    yarl.quips["rats"] = "Nasty vermin. Don't let 'em give you mouth."
    yarl.quips["leave"] = "I don't care where they go, as long as it ain't here. You can be nice or mean about it."
    yarl.quips["mean"] = "There's a butcher's knife lying around here somewheres."
    yarl.quips["pay"] = "How about 100 sols and I'll also teach you some herbalism?"

    local lothar = Entity:new("lothar", G_sprites[619], 18, 8, true)
    lothar:set_stat("health", 40)
    lothar:set_stat("defense", 16)
    lothar.behavior = "aggressive"
    lothar.is_friendly = false



    local kryll = Entity:new("kryll", G_sprites[620], 18, 8, true)


    
    G_entities["player"] = player
    G_entities[rat.name] = rat
    G_entities["croc"] = croc
    G_entities["yarl"] = yarl
    G_entities["lothar"] = lothar

    ------------ Terrain -----------------
    local brick_wall = {}
    brick_wall.name = "brick_wall"
    brick_wall.sprite = G_sprites[146]
    brick_wall.x = 0
    brick_wall.y = 0
    brick_wall.blocker = true
    G_entities["brick_wall"] = brick_wall

    local mudrock_wall = {}
    mudrock_wall.name = "mudrock_wall"
    mudrock_wall.sprite = G_sprites[244]
    mudrock_wall.x = 0
    mudrock_wall.y = 0
    mudrock_wall.blocker = true
    G_entities["mudrock_wall"] = mudrock_wall

    local white_door = {}
    white_door.name = "white_door"
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
    wooden_downstairs.x = 9
    wooden_downstairs.y = 6
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
    wooden_bed.x = 5
    wooden_bed.y = 5
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