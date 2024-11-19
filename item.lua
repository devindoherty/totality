Item = {}

function Item:new(x, y, params)
    local item = {}
    setmetatable(item, self)
    self.__index = self
    self.x = x
    self.y = y
    self.name = params.name
    self.sprite = params.sprite
    self.description = params.description
    return item
end

function Item:render()
    love.graphics.draw(G_spritesheet, self.sprite, (self.x-1) * DRAW_FACTOR, (self.y-1) * DRAW_FACTOR, 0, SCALE_FACTOR)
end