PlayerTurnState = State:new()

function PlayerTurnState:init(params)
    self.action = nil
    self.log = {"123456789012345678901234567890"}
    self.mouse = {
        x = love.mouse.getX(),
        y = love.mouse.getY()
    }
    self.interacting = false
    self.looking = false
    self.attacking = false
    
end

function PlayerTurnState:enter(params)
    self.player = params.player
    self.map = params.map
    self.map.player = self.player
    self.interacting = params.interacting
    
    self.looking = params.looking
    self.selector = {x = self.player.x, y = self.player.y}

    self.attacking = params.attacking
    
    self.action = nil

    G_bug:bugprint("player x on enter: ", self.player.x)
    G_bug:bugprint("player y on enter: ", self.player.y)
end

function PlayerTurnState:input(key)
    self.mouse.x, self.mouse.y = math.floor(self.mouse.x / 64), math.floor(self.mouse.y / 64)

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
    elseif self.looking then
        if key == "w" or key == "kp8" then
            self.action = "selector_move_up"
        elseif key == "a" or key == "kp4" then
            self.action = "selector_move_left"
        elseif key == "d" or key == "kp6" then
            self.action = "selector_move_right"
        elseif key == "s" or key == "kp2" then
            self.action = "selector_move_down"
        elseif key == "enter" or key == "return" then
            self.action = "selector_select"
        end
        return
    elseif self.attacking then
        self.action = "player_attack"
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
        table.insert(self.log, "Interact in which direction? (WASD)")
        G_gs:change("player_turn_state", {map = self.map, player = self.player, interacting = true})
    elseif key == "x" or key == "l" then
        self.action = "player_look"
        G_gs:change("player_turn_state", {map = self.map, player = self.player, looking = true})
    end
end

function PlayerTurnState:update(dt)
    local x = self.player.x
    local y = self.player.y

    
    if self.player:die() then
        G_gs:change("game_over_state")
    end
    
    if self.action then
        if self.action == "player_end_turn" then
            G_gs:change("mob_turn_state", {map = self.map, player = self.player})
        elseif self.interacting then
            PlayerTurnState:update_interacting(x, y)
        elseif self.looking then
            PlayerTurnState:update_looking(x, y)
        elseif self.attacking then
            self.attacking:update(dt)
            if self.attacking.frame > 2.5 then
                self.attacking = nil
                G_gs:change("mob_turn_state", {map = self.map, player = self.player})
            end
        else
            PlayerTurnState:update_movement_or_bump(x, y)
        end
    end

    for _i, mob in pairs(self.map.mobs) do
        if mob.stats["health"] <= 0 then
            mob:die()
        end
    end 
end

function PlayerTurnState:update_movement_or_bump(x, y)
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
      not self.map:occupied(x, y) and not self.map:blocked(x, y) then
        self.player.x = x
        self.player.y = y
    elseif self.map:openable(x, y) then
        local tile = self.map.tiles[y][x]
        table.insert(self.log, "You open the " .. tile.name)
        self.map:change_tile(x, y, Tile:new(G_tiles[tile.open_def], x, y))
    elseif self.map:occupied(x, y) then
        local occupier = self.map:get_mob_with_xy(x, y)
        if occupier.hostile then
            print(occupier.name)
            self.attacking = Attack:new("basic attack", x, y, self.player, occupier, {
                description = "hit",
                sprite = 553,
                frame = 0,
                damage = 5,
                condition = "none"
            })
            return
        end
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
        table.insert(self.log, "You close the door in the " .. tile.name)
        self.map:change_tile(x, y, Tile:new(G_tiles[tile.close_def], x, y))
        self.interacting = false
        G_gs:change("mob_turn_state", {map = self.map, player = self.player})
        return
    elseif self.map:openable(x, y) then
        table.insert(self.log, "You open the " .. tile.name)
        self.map:change_tile(x, y, Tile:new(G_tiles[tile.open_def], x, y))
        self.interacting = false
        G_gs:change("mob_turn_state", {map = self.map, player = self.player})
        return
    end
    
    G_gs:change("player_turn_state", {map = self.map, player = self.player, interacting = false})
end

function PlayerTurnState:update_looking(x, y)
    if self.action == "selector_move_up" then
        self.selector.y = self.selector.y - 1
    elseif self.action == "selector_move_down" then
        self.selector.y = self.selector.y + 1
    elseif self.action == "selector_move_left" then
        self.selector.x = self.selector.x - 1
    elseif self.action == "selector_move_right" then
        self.selector.x = self.selector.x + 1
    elseif self.action == "selector_select" then
        local target_mob = self.map:get_mob_with_xy(self.selector.x, self.selector.y)
        local target_item = self.map:get_item_with_xy(self.selector.x, self.selector.y)
        local target_tile = self.map:get_tile_with_xy(self.selector.x, self.selector.y)
        local logline = "You see "
        if target_mob then
            print(target_mob.description)
            logline = logline .. ", " .. target_mob.name .. " "
        end
        if target_item then
            print(target_item.description)
            logline = logline .. ", " .. target_item.name .. " "
        end
        if target_tile then
            if target_tile.description == "Nothing but empty space." and target_item or target_mob then
            
            else
                print(target_tile.description)
                logline = logline .. " " .. target_tile.name .. " "
            end
        end
        
        table.insert(self.log, logline)
        G_gs:change("player_turn_state", {map = self.map, player = self.player, looking = false})
    end
    self.action = nil
end

function PlayerTurnState:render_log()
    local x = 0
    local y = SCREEN_HEIGHT - 64 - 12
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

function PlayerTurnState:render()
    love.graphics.push()
    
    self.player:camera()

    if self.looking then
        love.graphics.setColor(1, 1, 1)
        love.graphics.setLineWidth(3)
        love.graphics.rectangle("line", (self.selector.x - 1) * DRAW_FACTOR, (self.selector.y - 1) * DRAW_FACTOR, 32, 32)
        love.graphics.setLineWidth(1)
        love.graphics.setColor(1, 1, 1)
    end
    self.map:render()

    self.player:render()

    if self.attacking then
        self.attacking:render()
    end

    if DEBUG then
        for _i, mob in pairs(self.map.mobs) do
            mob:draw_line_of_sight(self.player)
        end
    end


    love.graphics.pop()

    PlayerTurnState:render_log()
    love.graphics.draw(G_portraitsheet, G_portraits[1], 0, SCREEN_HEIGHT - 64, 0, 2)
    love.graphics.print("Health: " .. self.player.stats["health"], 66, SCREEN_HEIGHT - 64)
    love.graphics.print("Magic: " .. self.player.stats["magic"], 66, SCREEN_HEIGHT - 52)

end

function PlayerTurnState:exit()
    G_bug:bugprint("player x on exit: ", self.player.x)
    G_bug:bugprint("player y on exit: ", self.player.y)
end