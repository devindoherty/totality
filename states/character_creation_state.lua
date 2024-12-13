CharacterCreationState = State:new()

function CharacterCreationState:init() 
    self.menus = {}
    self.current = #self.menus
    local stats_menu = Menu:new(10, 10, SCREEN_WIDTH, SCREEN_HEIGHT,
        {
            Selection:new("Might", function() end),
            Selection:new("Grace", function() end),
            Selection:new("Mind", function() end),
            Selection:new("Soul", function() end),
        },
        {background=false}
    )

    table.insert(self.menus, stats_menu)
end

function CharacterCreationState:enter() end
function CharacterCreationState:input() end

function CharacterCreationState:update(dt) end

function CharacterCreationState:render() 
    for i=1, #self.menus do
        self.menus[i]:render()
    end
end

function CharacterCreationState:exit() end