Dialog = {}

function Dialog:new(prefix)
    local dialog = {}
    setmetatable(dialog, self)
    self.__index = self
    dialog.prefix = prefix
    dialog.root = prefix .. "root"
    dialog.current = G_dialogs[dialog.root]
    return dialog
end

function Dialog:update() 

end

function Dialog:render()
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", SCREEN_HEIGHT / 2 + 64, SCREEN_WIDTH / 4, 300, #self.current.line / 2 + 15)
    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle("line", SCREEN_HEIGHT / 2 + 64, SCREEN_WIDTH / 4, 300, #self.current.line / 2 + 15)
    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(self.current.line, SCREEN_HEIGHT / 2 + 64, SCREEN_WIDTH / 4, 300, "left", 0, 1, 1)
    local y = 30
    
    for i = 1, #self.current.choices do
        love.graphics.printf(self.current.choices[i][1], SCREEN_HEIGHT / 2 + 64 , SCREEN_WIDTH / 4 + y, 300, "left", 0, 1, 1)
        y = y + 12
    end

end