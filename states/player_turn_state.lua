PlayerTurnState = State:new()

function PlayerTurnState:init(params)
    self.turn = 0
    self.action = nil
    self.log = {}
    self.mouse = {
        x = love.mouse.getX(),
        y = love.mouse.getY()
    }
    self.interacting = false
    self.looking = false
end

function PlayerTurnState:enter(params)
    self.player = params.player
    self.map = params.map
    self.interacting = params.interacting
    self.looking = params.looking

    self.action = nil

    G_bug:bugprint("player x on enter: ", self.player.x)
    G_bug:bugprint("player y on enter: ", self.player.y)
end

function PlayerTurnState:input(key)

    if self.interacting then
        if key == "w" or key == "kp8" then
            self.action = "player_interact_up"
        elseif key == "a" or key == "kp4" then
            self.action = "player_interact_left"
        elseif key == "d" or key == "kp6" then
            self.action = "player_interact_right"
        elseif key == "s" or key == "kp2" then
            self.action = "player_interact_down"
        end
        return
    end

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
        G_gs:change("player_turn_state", {map = self.map, player = self.player, interacting = true})
    end
end

function PlayerTurnState:update(dt)
    self.mouse.x, self.mouse.y = math.floor(self.mouse.x / 64), math.floor(self.mouse.y / 64)

    local x = self.player.x
    local y = self.player.y

    if self.action then
        if self.interacting then
            PlayerTurnState:update_interacting(x, y)
        else
            PlayerTurnState:update_movement(x, y)
        end
    end
end

function PlayerTurnState:update_movement(x, y)
    if self.action == "player_move_up" then
        y = y - 1
    elseif self.action == "player_move_down" then
        y = y + 1
    elseif self.action == "player_move_left" then
        x = x - 1
    elseif self.action == "player_move_right" then
        x = x + 1
    end

    if self.map:inbounds(x, y) and not self.map:solid(x, y) and
      not self.map:occupied(x, y) then
        self.player.x = x
        self.player.y = y
    elseif self.map:openable(x, y) then
        local tile = self.map.tiles[y][x]
        self.map:change_tile(x, y, Tile:new(G_tiles[tile.open_def], x, y))
    elseif self.map:occupied(x, y) and self.map:get_mob_with_xy(x, y).hostile then
        print("HOSTILE!!!")
    end
    G_gs:change("mob_turn_state", {map = self.map, player = self.player})
end


function PlayerTurnState:update_interacting(x, y)
    if self.action == "player_interact_up" then
        y = y - 1 
    elseif self.action == "player_interact_down" then
        y = y + 1
    elseif self.action == "player_interact_left" then
        x = x - 1
    elseif self.action == "player_interact_right" then
        x = x + 1
    end

    local tile = self.map.tiles[y][x]
    
    if self.map:closable(x, y) then
        self.map:change_tile(x, y, Tile:new(G_tiles[tile.close_def], x, y))
    elseif self.map:openable(x, y) then
        self.map:change_tile(x, y, Tile:new(G_tiles[tile.open_def], x, y))
    end
    
    G_gs:change("player_turn_state", {map = self.map, player = self.player, interacting = false})
end


function PlayerTurnState:render()
    if self.interacting then
        love.graphics.print("Interact in which direction? (WASD)", 0, 0)
    end
    self.player:camera()
    self.map:render()

    self.player:render()

end

function PlayerTurnState:exit()
    self.turn = self.turn + 1
end