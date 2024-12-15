-- Dialog class, sets a prefix for the def to look at when looking for keyword matches

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

function Dialog:update(action, player)

end

function Dialog:render(response)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", SCREEN_WIDTH / 4, SCREEN_HEIGHT / 4, 500, 300)
    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle("line", SCREEN_WIDTH / 4, SCREEN_HEIGHT / 4, 500, 300)
    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(self.current.line, (SCREEN_WIDTH / 4) + 12, (SCREEN_HEIGHT / 4) + 72, 480, "left", 0, 1, 1)

    love.graphics.printf(response, (SCREEN_WIDTH / 4) + 76, (SCREEN_HEIGHT / 4) + 230, 390, "left", 0, 1, 1)
end