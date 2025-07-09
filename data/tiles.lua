-- Tile defs

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
        sprite = 782,
        solid = true,
        description = "A timber oaken wall."
    },
    ["T"] = {
        name = "tree",
        glyph = "T",
        sprite = 49,
        solid = true,
        description = "This tree flourishes despite the lack of sunlight."
    },
    ["D"] = {
        name = "wooden door",
        glyph = "D",
        sprite = 441,
        solid = true,
        openable = true,
        open_def = "O",
        description =  "A simple swinging door. This one is closed."
    },
    ["O"] = {
        name = "wooden doorframe",
        glyph = "O",
        sprite = 442,
        description = "An open doorway beckons you.",
        solid = false,
        openable = false,
        closable = true,
        close_def = "D"
    },
    ["~"] = {
        name = "water",
        glyph = "~",
        sprite = 249,
        solid = false,
    },
    ["r"] = {
        name = "rock wall",
        glyph = "r",
        sprite = 18,
        solid = true,
        description = "An earthen rock wall."
    }
}