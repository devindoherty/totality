Dialog = {}

function Dialog:new(text)
    local dialog = {}
    setmetatable(dialog, self)
    self.__index = self
    self.text = text
    return dialog
end

function Dialog:draw()
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", SCREEN_HEIGHT / 2 + 64, SCREEN_WIDTH / 4, 300, #self.text / 2 + 15)
    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle("line", SCREEN_HEIGHT / 2 + 64, SCREEN_WIDTH / 4, 300, #self.text / 2 + 15)
    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(self.text, SCREEN_HEIGHT / 2 + 64, SCREEN_WIDTH / 4, 300, "left", 0, 1, 1)

end