CharacterCreationState = State:new()

function CharacterCreationState:init() 
    self.menu = Menu:new(10, 10, SCREEN_WIDTH, SCREEN_HEIGHT,
        {
            Selection:new("Might", function() end),
            Selection:new("Grace", function() end),
            Selection:new("Mind", function() end),
            Selection:new("Soul", function() end),
            Selection:new("Portrait", function() end),
            Selection:new("Name", function() end)
        },
        {
            background=false,
            font_size = 32,
            spacing = 20
        }
    )

    self.action=""
end

function CharacterCreationState:enter(params) 
    self.map = params.map
    self.player = params.player

end

function CharacterCreationState:input(key) 
    if key == "w" or key == "up" or key == "kp8" then
        self.action = "menu_up"
    elseif key == "s" or key == "down" or key == "kp2" then
        self.action = "menu_down"
    elseif key == "enter" or key == "return" then
        self.action = "menu_enter"
    end
end

function CharacterCreationState:update(dt) 
    self.menu:update(self.action)

    self.action=""
end

function CharacterCreationState:render() 
    self.menu:render()
end

function CharacterCreationState:exit() end