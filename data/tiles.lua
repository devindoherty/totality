G_tiles = {
    [" "] = {
        name = "empty",
        glyph = " ",
        sprite = 1,
        solid = false,
        description = "Nothing but empty space."
    },
    ["#"] = {
        name = "wooden_wall",
        glyph = "#",
        sprite = 303,
        solid = true,
        description = "A timber oaken wall."
    },
    ["T"] = {
        name = "tree",
        glyph = "T",
        sprite = 2,
        solid = true,
        description = "This tree flourishes despite the lack of sunlight."
    },
    ["D"] = {
        name = "white_door",
        glyph = "D",
        sprite = 210,
        solid = true,
        openable = true,
        open_def = "O",
        description =  "A simple swinging door. This one is closed."
    },
    ["O"] = {
        name = "white_doorframe",
        glyph = "O",
        sprite = 187,
        description = "An open doorway beckons you.",
        solid = false,
        openable = false,
        closable = true,
        close_def = "D"
    },
    ["~"] = {
        name = "water",
        glyph = "W",
        sprite = 199 - 18,
        solid = false,
    },
}