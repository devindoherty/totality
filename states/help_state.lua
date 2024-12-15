HelpState = State:new()

function HelpState:init() 
    self.help_text = [[
        Path of Totality is a topdown RPG where you control your character in the fantasy world of the eclipse cursed lands.
        > 'wasd' can be used to move north, west, south, and east respectively. You can walk into doors to open them and other
           characters to attack them.
        > 'x' can be used to move a cursor around to look at items. Enter selects the item(s) to look at.
        > 'e' is used to interact with objects and characters in the world.
    ]]

end

function HelpState:enter() end
function HelpState:input() end

function HelpState:update(dt) end

function HelpState:render() end

function HelpState:exit() end