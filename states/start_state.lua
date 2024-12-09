StartState = State:new()

function StartState:init()
    self.old_font = love.graphics.getFont()
    self.font = love.graphics.newFont(42)
    self.title = "Path of Totality"
    self.action = ""
    self.player = Player:new()
    self.map = Map:new({tiles = G_area_one_tiles, mobs = G_area_one_mobs, items = G_area_one_items})
end

function StartState:enter(params)
    self.menu = Menu:new(
        (SCREEN_WIDTH / 2) - 175,
        (SCREEN_HEIGHT / 2) + 24,
        {
            Selection:new("New", function() G_gs:change("character_creation_state") end),
            Selection:new("Continue", function() G_gs:change("world_turn_state", {player = self.player, map = self.map}) end),
            Selection:new("Exit", function() love.event.quit(0) end),
        }
    )
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
    elseif
        self.action == "m" then
            G_gs:change("map_editor_state")
    end
end

function StartState:render()
    love.graphics.draw(G_start_screen_splash, 0, 0, 0, .80, .75)
    love.graphics.setFont(self.font)
    love.graphics.print(self.title, (SCREEN_WIDTH / 2) - 175, SCREEN_HEIGHT / 2, 0)
    love.graphics.setFont(self.old_font)
end

function StartState:exit() end

