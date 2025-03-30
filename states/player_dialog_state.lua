-- Fires after player interacts with conversant

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
    elseif key == "escape" then
        G_gs:change("player_turn_state", {map=self.map, player=self.player})
    end

    for i=1, #ALPHABET do
        if key == string.sub(ALPHABET, i, i) then
            self.word = self.word .. key
        end
    end
end

-- Looks for matching input keywords in dialog def
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
    love.graphics.draw(G_spritesheet, self.dialoger.portrait, SCREEN_WIDTH / 4 + 200, SCREEN_HEIGHT / 4, 0, 4)
    love.graphics.draw(G_portraitsheet, self.player.portrait, (SCREEN_WIDTH / 4) + 4, (SCREEN_HEIGHT / 4) + 230, 0, 2)
end

function PlayerDialogState:exit()

end

