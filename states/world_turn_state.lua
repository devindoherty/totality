WorldTurnState = State:new()

function WorldTurnState:new()
    local state = {}
    setmetatable(state, self)
    self.__index = self
    
    return state
end

function WorldTurnState:init()
    self.turn = 0
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
    self.player:camera()
    self.map:render()
    self.player:render()
end

function WorldTurnState:exit()
    self.turn = self.turn + 1
end

