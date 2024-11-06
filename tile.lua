Tile = {}

function Tile:new(name, glyph, sprite, solid, x, y)
    local tile = {}
    setmetatable(tile, self)
    tile.__index = self
    tile.name = name
    tile.glyph = glyph
    tile.sprite = sprite
    tile.x = x
    tile.y = y
    tile.solid = solid

    return tile
end
