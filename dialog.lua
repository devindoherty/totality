Dialog = {}

function Dialog:new(prefix)
    local dialog = {}
    setmetatable(dialog, self)
    self.__index = self
    dialog.prefix = prefix
    dialog.root = prefix .. "root"
    dialog.current = G_dialogs[dialog.root]
    dialog.menu = Menu:new(
        SCREEN_HEIGHT / 2 + 64, 
        SCREEN_WIDTH / 4 + 30,
        100,
        400,
        {}
    )
    return dialog
end

function Dialog:update(action, player)
    if action == "menu_select" then
        self.current = G_dialogs
    end
end

function Dialog:render(response)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", SCREEN_HEIGHT / 2 + 64, SCREEN_WIDTH / 4, 500, 300)
    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle("line", SCREEN_HEIGHT / 2 + 64, SCREEN_WIDTH / 4, 500, 300)
    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(self.current.line, SCREEN_HEIGHT / 2 + 64, SCREEN_WIDTH / 4, 500, "left", 0, 1, 1)

    love.graphics.printf(response, SCREEN_HEIGHT / 2 + 64 , SCREEN_WIDTH / 4 + 30, 500, "left", 0, 1, 1)
end