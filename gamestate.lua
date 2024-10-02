Gamestate = {}

function Gamestate:init(states)
    self.states = states
    self.current = states[1]
end

function Gamestate:change(state, params)
    self.current:exit()
    self.current = self.states[state]()
    self.current:enter(params)
end

function Gamestate:input()
    self.current:input()
end

function Gamestate:update(dt)
    self.current:update(dt)
end

function Gamestate:render()
    self.current:render()
end
