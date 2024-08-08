require("spritesheet")    

function load_entities()
    entities = {}

    empty = {}
    empty.sprite = sprites[1]

    player = {}
    player.sprite = sprites[551]
    player.x = 2
    player.y = 2
    player.stats = {
        defense = 10
    }

    entities["player"] = player

    rat = {}
    rat.sprite = sprites[691]
    rat.x = 12
    rat.y = 5
    rat.stats = {
        defense = 3
    }
    
    brick_wall = {}
    brick_wall.sprite = sprites[146]
    brick_wall.x = 0
    brick_wall.y = 0

    white_door = {}
    white_door.sprite = sprites[210]
    white_door.x = 0
    white_door.y = 0

    white_doorframe = {}
    white_doorframe.sprite = sprites[187]
    white_doorframe.x = 0
    white_doorframe.y = 0
end