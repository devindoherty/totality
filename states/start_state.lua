StartState = State:new()

function StartState:init()
    self.old_font = love.graphics.getFont()
    self.font = love.graphics.newFont(42)
    self.greeting = "Path of Totality"
    self.direction = "Press Enter to Continue"
    self.action = ""
    self.player = Player:new()
    self.map = Map:new({tiles = G_area_one_tiles, mobs = G_mobs, items = G_items})
    
end

function StartState:enter(params)

end

function StartState:input(key)
    self.action = key
end

function StartState:update(dt)
    if self.action == "return" then
        G_gs:change("world_turn_state", {
            player = self.player,
            map = self.map,
        })
    end
end

function StartState:render()
    love.graphics.draw(G_start_screen_splash, 0, 0, 0, .80, .75)
    love.graphics.setFont(self.font)
    love.graphics.print(self.greeting, (SCREEN_WIDTH / 2) - 175, SCREEN_HEIGHT / 2, 0)
    love.graphics.setFont(self.old_font)
    love.graphics.print(self.direction, (SCREEN_WIDTH / 2) - 175, SCREEN_HEIGHT / 2 + 50, 0)
    
end

function StartState:exit() end

