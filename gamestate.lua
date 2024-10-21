Gamestate = {}

function Gamestate:new(states)
    local gamestate = {}
    setmetatable(gamestate, self)
    self.__index = self
    self.empty = {
        init = function() end,
		enter = function() end,
        input = function() end,
		update = function() end,
		render = function() end,
		exit = function() end
	}
    self.states = states or {}
    
    for k, state in pairs(self.states) do
        self.current = self.states[k]()
        self.current:init()
    end

    self.current = self.empty
    return gamestate
end

function Gamestate:input(key)
    self.current:input(key)
end

function Gamestate:update(dt)
    self.current:update(dt)
end

function Gamestate:render()
    self.current:render()
end

function Gamestate:change(state, params)
    self.current:exit()
    self.current = self.states[state]()
    G_bug:bugprint("entering state ", state)
    self.current:enter(params)
end

