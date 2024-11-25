G_tiles = {
    [" "] = {
        name = "empty",
        glyph = " ",
        sprite = 1,
        solid = false,
        description = "Nothing but empty space."
    },
    ["#"] = {
        name = "wooden wall",
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
        name = "wooden door",
        glyph = "D",
        sprite = 98,
        solid = true,
        openable = true,
        open_def = "O",
        description =  "A simple swinging door. This one is closed."
    },
    ["O"] = {
        name = "wooden doorframe",
        glyph = "O",
        sprite = 142,
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