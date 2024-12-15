-- Result if player health <= 0

GameOverState = State:new()

function GameOverState:init()
    self.old_font = love.graphics.getFont()
    self.font = love.graphics.newFont(42)
end

function GameOverState:enter(params)

end

function GameOverState:input(key)
    
end

function GameOverState:update(dt)

end

function GameOverState:render()
    love.graphics.setFont(self.font)
    love.graphics.print("GAME OVER", (SCREEN_WIDTH / 2) - 175, SCREEN_HEIGHT / 2, 0)
    love.graphics.setFont(self.old_font)
end

function GameOverState:exit() 

end

