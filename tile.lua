Tile = {}

function Tile:new(params, x, y)
    local tile = {}
    setmetatable(tile, self)
    tile.__index = self
    tile.x = x
    tile.y = y

    tile.name = params.name
    tile.glyph = params.glyph
    tile.sprite = G_sprites[params.sprite]
    tile.solid = params.solid or false
    tile.openable = params.openable or false
    tile.open_def = params.open_def or nil
    tile.closable = params.closable or false
    tile.close_def = params.close_def or nil

    return tile
end
