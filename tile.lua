Tile = {}

function Tile:new(params, x, y)
    local tile = {}
    setmetatable(tile, self)
    self.__index = self
    
    tile.x = x
    tile.y = y

    tile.name = params.name
    tile.glyph = params.glyph
    tile.sprite = G_sprites[params.sprite]
    tile.description = params.description or "Unremarkable."
    
    tile.solid = params.solid or false
    
    tile.openable = params.openable or false
    tile.open_def = params.open_def or nil
    tile.closable = params.closable or false
    tile.close_def = params.close_def or nil
    
    tile.locked = params.locked or false

    return tile
end

function Tile:render()
    love.graphics.draw(G_spritesheet, self.sprite, (self.x-1) * DRAW_FACTOR, (self.y-1) * DRAW_FACTOR, 0, SCALE_FACTOR)
end