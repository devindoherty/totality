Tile = Entity:new()

function Tile:new(name, glyph, sprite, x, y)
    self.name = name
    self.glyph = glyph
    self.sprite = sprite
    self.x = x
    self.y = y
end
