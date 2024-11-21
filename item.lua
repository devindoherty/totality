Item = {}

function Item:new(params, x, y)
    local item = {}
    setmetatable(item, self)
    self.__index = self
    item.x = x
    item.y = y
    item.name = params.name
    item.sprite = G_sprites[params.sprite]
    item.description = params.description
    return item
end

function Item:render()
    love.graphics.draw(G_spritesheet, self.sprite, (self.x-1) * DRAW_FACTOR, (self.y-1) * DRAW_FACTOR, 0, SCALE_FACTOR)
end