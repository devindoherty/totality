PlayerTurnState = State:new()

function PlayerTurnState:init(params)
    self.turn = 0
    self.action = nil
    self.log = {}
    self.mouse = {
        x = love.mouse.getX(),
        y = love.mouse.getY()
    }
end

function PlayerTurnState:enter(params)
    self.player = params.player
    self.map = params.map

    self.action = nil
    G_bug:bugprint("player x on enter: ", self.player.x)
    G_bug:bugprint("player y on enter: ", self.player.y)
end

function PlayerTurnState:input(key)
    if key == "w" or key == "kp8" then
        self.action = "player_move_up"
    elseif key == "a" or key == "kp4" then
        self.action = "player_move_left"
    elseif key == "d" or key == "kp6" then
        self.action = "player_move_right"
    elseif key == "s" or key == "kp2" then
        self.action = "player_move_down"
    elseif key == "space" then
        self.action = "player_end_turn"
    elseif key == "e" then
        self.action = "player_interact"
    end
end

function PlayerTurnState:update(dt)
    self.mouse.x, self.mouse.y = math.floor(self.mouse.x / 64), math.floor(self.mouse.y / 64)

    local x = self.player.x
    local y = self.player.y

    if self.action then
        if self.action == "player_move_up" then
            y = y - 1
        elseif self.action == "player_move_down" then
            y = y + 1
        elseif self.action == "player_move_left" then
            x = x - 1
        elseif self.action == "player_move_right" then
            x = x + 1
        end

        if self.map:inbounds(x, y) then
            self.player.x = x
            self.player.y = y
            G_gs:change("mob_turn_state", {map = self.map, player = self.player})
        end
    end
end

function PlayerTurnState:render()
    self.map:render()
    self.player:render()
    self.player:camera()
end

function PlayerTurnState:exit()
    self.turn = self.turn + 1
end