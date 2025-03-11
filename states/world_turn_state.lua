-- Everything else that happens in the game world other than player and mob actions
-- Not much presently
WorldTurnState = State:new()

function WorldTurnState:new()
    local state = {}
    setmetatable(state, self)
    self.__index = self
    
    return state
end

function WorldTurnState:init()
    self.turn = 0
    self.log = {""}
end

function WorldTurnState:enter(params)
    self.map = params.map
    self.player = params.player
    self.log = params.log
end

function WorldTurnState:input() end

function WorldTurnState:update(dt)
    G_gs:change("player_turn_state", {
        map = self.map,
        player = self.player
    })
end

function WorldTurnState:render_log()
    local x = 0
    local y = SCREEN_HEIGHT - 100
    love.graphics.setColor(0, 0, 0, .5)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH / 4, SCREEN_HEIGHT)
    love.graphics.setColor(1, 1, 1)
    for i = #self.log, 1, -1 do
        love.graphics.printf(self.log[i], x, y, SCREEN_WIDTH / 4)
        if #self.log[i] > 30 then
            y = y - 24
        else
            y = y - 12
        end
    end
end

function WorldTurnState:render()
    love.graphics.push()
        self.player:camera()
        self.map:render()
        self.player:render()
    love.graphics.pop()
    self:render_log()
    love.graphics.draw(G_portraitsheet, self.player.portrait, 0, SCREEN_HEIGHT - 64, 0, 2)
    love.graphics.print("Health: " .. self.player.stats["health"], 66, SCREEN_HEIGHT - 64)
    love.graphics.print("Magic: " .. self.player.stats["magic"], 66, SCREEN_HEIGHT - 52)
end

function WorldTurnState:exit()
    self.turn = self.turn + 1
end

