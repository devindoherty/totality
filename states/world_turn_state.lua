WorldTurnState = State:new()

function WorldTurnState:new()
    local state = {}
    setmetatable(state, self)
    self.__index = self
    self.map = Map:new(G_area_one_map)
    return state
end

function WorldTurnState:init()

end

function WorldTurnState:enter(params)
    self.map = params.map
    self.player = params.player
end

function WorldTurnState:input() end

function WorldTurnState:update(dt)
    G_gs:change("player_turn_state", {
        map = self.map,
        player = self.player
    })
end

function WorldTurnState:render()
    self.map:render()
    self.player:render()
end
function WorldTurnState:exit() end

