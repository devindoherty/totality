PlayerDialogState = State:new()

function PlayerDialogState:init()
    
end

function PlayerDialogState:enter(params)
    self.map = params.map
    self.player = params.player
    self.dialoger = params.dialoger
    self.action = ""
end

function PlayerDialogState:input(key)
    if key == "up" or key == "w" or key == "kp8" then
        self.action = "menu_up"
    elseif key == "down" or key == "s" or key == "kp2" then
        self.action = "menu_down"
    elseif key == "left" or key == "a" or key == "kp4" then
        self.action = "menu_left"
    elseif key == "right" or key == "d" or key == "kp6" then
        self.action = "menu_right"
    elseif key == "return" or key == "enter" then
        self.action = "menu_select"
    end
end

function PlayerDialogState:update(dt)
    self.dialoger.dialog:update(self.action)

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

    if self.attacking then
        self.attacking:render()
    end

    if DEBUG then
        for _i, mob in pairs(self.map.mobs) do
            mob:draw_line_of_sight(self.player)
        end
    end

    love.graphics.pop()

    self.dialoger.dialog:render()
end

function PlayerDialogState:exit()
    
end

