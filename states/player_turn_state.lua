PlayerTurnState = State:new()

function PlayerTurnState:init(params)
    self.turn = 0
    self.action = ""
    self.log = {}
    self.player = Player:new()
    self.player:init()
end

function PlayerTurnState:enter()
    print("START OF TURN " .. self.turn)
end

function PlayerTurnState:input(key)
    print("psupdate")
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
        print("yooo")
        self.action = "player_move_down"
    elseif key == "space" then
        self.action = "player_end_turn"
    elseif key == "e" then
        -- G_set_interacting(player, self.nearby_interactible["target"])
        self.action = "player_move_up"
    end
end

function PlayerTurnState:update(dt)
    local x = self.player.x
    local y = self.player.y

        if self.action == "player_move_up" then
            print("Yo")
            y = y - 1
        elseif self.action == "player_move_down" then
            y = y + 1
        elseif self.action == "player_move_left" then
            x = x - 1
        elseif self.action == "player_move_right" then
            x = x + 1
        end
    
    self.player.x = x
    self.player.y = y

    -- self.action = ""
--     if not G_inbounds(x, y) then
--         return
--     elseif G_empty_tile(x, y) and G_no_creature(x, y) and G_inbounds(x, y) then
--         self.player_moved = true
--         self.x = x
--         self.y = y
--         return
--     elseif not G_no_creature(x, y) then
--         local defender = self.map:get_creature_with_xy(x, y)
--         self:set_attacking(player, defender)
--     elseif not G_empty_tile(x, y) then
--         if G_openable_tile_adjacent(x, y) then
--             G_open_item(x, y)
--         end
--     end
end




function PlayerTurnState:update_mouse_position()
    local mx, my = love.mouse.getPosition()
    G_gamestate.mouse.x, G_gamestate.mouse.y = math.floor(mx / 64), math.floor(my / 64)
end

function PlayerTurnState:render()
    self.player:render()
end

function PlayerTurnState:exit()
    self.turn = self.turn + 1
end