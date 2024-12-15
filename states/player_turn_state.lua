PlayerTurnState = State:new()

function PlayerTurnState:init(params)
    self.action = nil
    self.log = {"You awaken in a small farmhouse..."}
    self.mouse = {
        x = love.mouse.getX(),
        y = love.mouse.getY()
    }
    self.interacting = false
    self.looking = false
    self.attacking = false
    self.menu = nil
    self.demo_win = false
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
    self.menu = nil
end

function PlayerTurnState:input(key)
    self.mouse.x, self.mouse.y = math.floor(self.mouse.x / 64), math.floor(self.mouse.y / 64)

    if key == "escape" and not self.menu then
        self.menu = Menu:new(SCREEN_WIDTH/2 - 32, SCREEN_HEIGHT/2, 75, 50, {
            Selection:new("Continue", function() G_gs:change("world_turn_state", {map = self.map, player = self.player, log=self.log}) return end),
            Selection:new("Help", function() G_gs:change("help_state", {origin="player_turn_state", player=self.player,map=self.map}) end),
            Selection:new("Quit", function() love.event.quit(0) end),
            },
            {
                background=true,
                font=12,
            })
        return
    elseif key == "escape" and self.menu then
        G_gs:change("world_turn_state", {map = self.map, player = self.player, log=self.log})
        return
    elseif self.menu then
        if key == "w" or key == "up" or key == "kp8" then
            self.action = "menu_up"
        elseif key == "s" or key == "down" or key == "kp2" then
            self.action = "menu_down"
        elseif key == "enter" or key == "return" then
            self.action = "menu_enter"
        end
        return
    end

    if self.interacting then
        if key == "w" or key == "up" or key == "kp8" then
            self.action = "player_interact_up"
        elseif key == "a" or key == "left" or key == "kp4" then
            self.action = "player_interact_left"
        elseif key == "d" or key == "right" or key == "kp6" then
            self.action = "player_interact_right"
        elseif key == "s" or key == "down" or key == "kp2" then
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

    if key == "up" or key == "w" or key == "kp8" then
        self.action = "player_move_up"
    elseif key == "left" or key == "a" or key == "kp4" then
        self.action = "player_move_left"
    elseif key == "right" or key == "d" or key == "kp6" then
        self.action = "player_move_right"
    elseif key == "down" or key == "s" or key == "kp2" then
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

    if self.demo_win == false then
        self:check_for_demo_win(self.map.mobs)
    end

    if self.menu then
        self.menu:update(self.action)
        self.action = ""
        return
    end
    
    if self.action then
        if self.action == "player_end_turn" then
            G_gs:change("mob_turn_state", {map = self.map, player = self.player, log=self.log})
        elseif self.interacting then
            PlayerTurnState:update_interacting(x, y)
        elseif self.looking then
            PlayerTurnState:update_looking(x, y)
        elseif self.attacking then
            self.attacking:update(dt)
            if self.attacking.frame > 2.5 then
                self.attacking = nil
                G_gs:change("mob_turn_state", {map = self.map, player = self.player, log=self.log})
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
            self.attacking = Attack:new("basic attack", x, y, self.player, occupier, {
                description = "hit",
                sprite = 553,
                frame = 0,
                damage = 5,
                condition = "none"
            })
            table.insert(self.log, "You attack the " .. self.attacking.defender.name .. " for " .. self.attacking.damage .. " damage.")
            return
        end
    end

    G_gs:change("mob_turn_state", {map = self.map, player = self.player, log=self.log})
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
        G_gs:change("mob_turn_state", {map = self.map, player = self.player, log=self.log})
        return
    elseif self.map:openable(x, y) then
        table.insert(self.log, "You open the " .. tile.name)
        self.map:change_tile(x, y, Tile:new(G_tiles[tile.open_def], x, y))
        self.interacting = false
        G_gs:change("mob_turn_state", {map = self.map, player = self.player, log=self.log})
        return
    elseif self.map:occupied(x, y) then
        local dialoger = self.map:get_mob_with_xy(x, y)
        self.interacting = false
        return G_gs:change("player_dialog_state", {map = self.map, player = self.player, dialoger = dialoger})
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
        local logline = "You see: "
        if target_mob then
            print(target_mob.description)
            logline = logline .. " " .. target_mob.name .. " "
        end
        if target_item then
            print(target_item.description)
            logline = logline .. " " .. target_item.name .. " "
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

function PlayerTurnState:check_for_demo_win(mobs)
    local rat_count = 0
    for _i, mob in pairs(mobs) do
        if mob.name == "Rat" then
            rat_count = rat_count + 1
        end
    end
    if rat_count == 0 then
        table.insert(self.log, "You have defeated all the rats! Feel free to play on and explore.")
        self.demo_win = true
    end
end


function PlayerTurnState:render_log()
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
    love.graphics.draw(G_portraitsheet, self.player.portrait, 0, SCREEN_HEIGHT - 64, 0, 2)
    love.graphics.print("Health: " .. self.player.stats["health"], 66, SCREEN_HEIGHT - 64)
    love.graphics.print("Magic: " .. self.player.stats["magic"], 66, SCREEN_HEIGHT - 52)

    if self.menu then
        self.menu:render()
    end
end

function PlayerTurnState:exit()

end