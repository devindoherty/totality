StartState = State:new()

function StartState:init()
    self.greeting = "Path of Totality"
    self.direction = "Press Enter to Continue"
    self.action = ""

    self.params = {
        tiles = G_area_one_map
    }
    
end

function StartState:enter(params)

end

function StartState:input(key)
    self.action = key
end

function StartState:update(dt)
    if self.action == "return" then
        G_gs:change("player_turn_state", self.params)
    end
end

function StartState:render()
    love.graphics.print(self.greeting, (SCREEN_WIDTH / 2) - 100, 0, 0, 2, 2)
    love.graphics.print(self.direction, (SCREEN_WIDTH / 2) - 150, SCREEN_HEIGHT / 2, 0, 2, 2)
end

function StartState:exit() end

