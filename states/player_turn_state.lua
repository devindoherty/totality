PlayerTurnState = State:new()

function PlayerTurnState:init(params)
    self.turn = 0
    self.action = ""
    self.log = {}
    self.mouse = {
        x = love.mouse.getX(),
        y = love.mouse.getY()
    }

    self.player = Player:new()
    self.player:init()
end

function PlayerTurnState:enter(params)
    self.map = Map:new(params)
end

function PlayerTurnState:input(key)
    if key == "w" or key == "kp8" then
        -- y = player.y - 1
        self.action = "player_move_up"
    elseif key == "a" or key == "kp4" then
        -- x = self.x - 1
        self.action = "player_move_left"
    elseif key == "d" or key == "kp6" then
        -- x = self.x + 1
        self.action = "player_move_right"
    elseif key == "s" or key == "kp2" then
        -- y = self.y + 1
        self.action = "player_move_down"
    elseif key == "space" then
        self.action = "player_end_turn"
    elseif key == "e" then
        -- G_set_interacting(player, self.nearby_interactible["target"])
        self.action = "player_interact"
    end
end

function PlayerTurnState:update(dt)
    self.mouse.x, self.mouse.y = math.floor(self.mouse.x / 64), math.floor(self.mouse.y / 64)

    local x = self.player.x
    local y = self.player.y

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
    end

    -- G_gs:change("mob_turn_state")
end

function PlayerTurnState:render()
    self.map:render()
    self.player:render()
end

function PlayerTurnState:exit()
    self.turn = self.turn + 1
end