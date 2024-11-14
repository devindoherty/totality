G_tiles = {
    [" "] = {
        name = "empty",
        glyph = " ",
        sprite = 1,
        solid = false,
    },
    ["#"] = {
        name = "brick_wall",
        glyph = "#",
        sprite = 146,
        solid = true,
    },
    ["T"] = {
        name = "tree",
        glyph = "T",
        sprite = 2,
        solid = true,
    },
    ["D"] = {
        name = "white_door",
        glyph = "D",
        sprite = 210,
        solid = true,
        openable = true,
    },
    ["O"] = {
        name = "white_doorframe",
        glyph = "O",
        sprite = 187,
        solid = false,
        openable = false,
    },
    ["~"] = {
        name = "water",
        glyph = "W",
        sprite = 199 - 18,
        solid = false,
    },
}