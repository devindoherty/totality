PlayerDialogState = State:new()

function PlayerDialogState:init()
    
end

function PlayerDialogState:enter(params)
    self.map = params.map
    self.player = params.player
    self.dialoger = params.dialoger
    self.word = ""
    self.action = ""
end

function PlayerDialogState:input(key)
    if key == "return" or key == "enter" then
        self.action = "submit_word"
        return
    elseif key == "space" then
        self.word = self.word .. " "
        return
    end

    self.word = self.word .. key
end

function PlayerDialogState:update(dt)
    self.dialoger.dialog:update(self.action, self.player)

    local idx = self.dialoger.dialog.prefix .. self.word
    if self.action == "submit_word" then
        if G_dialogs[idx] then
            self.dialoger.dialog.current = G_dialogs[idx]
            if self.dialoger.dialog.current.on_current then 
                self.dialoger.dialog.current.on_current(self.map, self.player)
                self.dialoger.dialog.current.on_current = nil
            end
            self.word = ""
        else
            self.word = ""
        end
    end

    self.action = ""
end

function PlayerDialogState:render()
    love.graphics.push()
    
    self.player:camera()

    if self.looking then
        love.graphics.setColor(1, 1, 1)
        love.graphics.setLineWidth(3)
        love.graphics.rectangle("line", (self.selector.x - 1) * DRAW_FACTOR, (self.selector.y - 1) * DRAW_FACTOR, 32, 32)
        love.graphics.setLineWidth(1)
        love.graphics.setColor(1, 1, 1)
    end
    self.map:render()

    self.player:render()

    if DEBUG then
        for _i, mob in pairs(self.map.mobs) do
            mob:draw_line_of_sight(self.player)
        end
    end

    love.graphics.pop()

    self.dialoger.dialog:render(self.word)
end

function PlayerDialogState:exit()
    
end
