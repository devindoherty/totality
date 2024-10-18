WorldTurnState = State:new()

function WorldTurnState:new(name)
    local state = {}
    setmetatable(state, self)
    self.__index = self
    self.name = name
    return state
end

function WorldTurnState:init()
    self.map = Map:new(Map, G_entities, G_entities)

end
function WorldTurnState:enter() end
function WorldTurnState:input() end
function WorldTurnState:update(dt) end
function WorldTurnState:render() end
function WorldTurnState:exit() end

