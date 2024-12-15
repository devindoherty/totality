-- Our start screen origin state

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
    -- Main menu
    self.menu = Menu:new(
        (SCREEN_WIDTH / 2) - 175,
        (SCREEN_HEIGHT / 2) + 50,
        400,
        600,
        {
            Selection:new("New", function() G_gs:change("character_creation_state", {player=self.player, map=self.map}) end),
            Selection:new("Quick Start", function() G_gs:change("world_turn_state", {player = self.player, map = self.map}) end),
            -- Selection:new("Load", function(self) self.text="NOT YET" end),
            Selection:new("Help", function() G_gs:change("help_state", {origin="start_state"}) end),
            Selection:new("Exit", function() love.event.quit(0) end),
        },
        {
            background = false,
            spacing = 12,
            font = 15
        }
    )
end

function StartState:input(key)
    if key == "w" or key == "up" or key == "kp8" then
        self.action = "menu_up"
    elseif key == "s" or key == "down" or key == "kp2" then
        self.action = "menu_down"
    elseif key == "enter" or key == "return" then
        self.action = "menu_enter"
    elseif key == "m" then
        self.action = "map"
        G_gs:change("map_editor_state")
    else
        self.action = ""
    end
end

function StartState:update(dt)
    self.menu:update(self.action)
    self.action = ""
end

function StartState:render()
    love.graphics.draw(G_start_screen_splash, 0, 0, 0, .80, .75)
    love.graphics.setFont(self.font)
    love.graphics.print(self.title, (SCREEN_WIDTH / 2) - 175, SCREEN_HEIGHT / 2, 0)
    love.graphics.setFont(self.old_font)

    self.menu:render()
end

function StartState:exit()
    
end

