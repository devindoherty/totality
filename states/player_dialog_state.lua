PlayerDialogState = State:new()

function PlayerDialogState:init()
    
end

function PlayerDialogState:enter(params)
    self.map = params.map
    self.player = params.player
    self.dialoger = params.dialoger
end

function PlayerDialogState:input(key)

end

function PlayerDialogState:update(dt)
    
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

