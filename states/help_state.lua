-- Help screen state for new players accessed from start or player turn

HelpState = State:new()

function HelpState:init() 
    self.text = [[
        Path of Totality is a topdown RPG where you control your character in the fantasy world of the eclipse cursed lands.
        > 'wasd' can be used to move north, west, south, and east respectively. You can walk into doors to open them and other
           characters to attack them.
        > 'x' to enter examine mode and 'wasd' to move a cursor around to look at items. Enter selects the item(s) to look at.
        > 'e' is used to interact with objects and characters in the world.
        > Talking to characters uses a free type keyword system. Keywords are highlighted in green.
    ]]

end

function HelpState:enter(params) 
    -- Keep track of where we're coming from
    self.origin = params.origin
    self.player = params.player
    self.map = params.map

end

function HelpState:input(key) 
    if key then
        G_gs:change(self.origin, {player=self.player, map=self.map})
    end
end

function HelpState:update(dt) end

function HelpState:render() 
    love.graphics.print("Help", SCREEN_WIDTH / 2, 0)
    love.graphics.printf(self.text, 10, 16, SCREEN_WIDTH - 10, "left")
    love.graphics.print({GREEN, "      Press any key to continue..."}, 10, 116)


end

function HelpState:exit() end