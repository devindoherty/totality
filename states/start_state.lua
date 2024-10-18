StartState = State:new()

function StartState:init()
    self.greeting = "Path of Totality"
    self.direction = "Press Enter to Continue"
    self.action = ""
end

function StartState:enter(params)

end

function StartState:input(key)
    print("Yes")
    print(key)
    self.action = key
end

function StartState:update(dt)
    if self.action == "return" then
        print("gs change")
        G_gs:change("player_turn_state")
    end
end

function StartState:render()
    love.graphics.print(self.greeting, (SCREEN_WIDTH / 2) - 100, 0, 0, 2, 2)
    love.graphics.print(self.direction, (SCREEN_WIDTH / 2) - 150, SCREEN_HEIGHT / 2, 0, 2, 2)
end

function StartState:exit() end

