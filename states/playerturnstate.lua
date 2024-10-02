PlayerTurnState = State:new("player_turn_state")

function PlayerTurnState:init(params)
    self.turn = 0
    self.end_turn = false
    self.player_moved = false
    self.nearby_interactible = {
        ["creature"] = false,
        ["item"] = false,
        target = nil
    }
    self.attack_queue = {}
    self.action_queue = {}
    self.log = {}
    self.current_dialog = "intro"
    self.mouse = {
        x = 0,
        y = 0
    }
    self.response = {
        active = "",
        entered = "intro",
        answer = ""
    }
end


function PlayerTurnState:input(key)
    local player = G_entities["player"]
    local x = player.x
    local y = player.y
    if key == "w" or key == "kp8" then
        y = player.y - 1
    elseif key == "a" or key == "kp4" then
        x = player.x - 1
    elseif key == "d" or key == "kp6" then
        x = player.x + 1
    elseif key == "s" or key == "kp2" then
        y = player.y + 1
    elseif key == "space" then
        self.end_turn = true
    elseif key == "e" then
        G_set_interacting(player, self.nearby_interactible["target"])
    end
    if not G_inbounds(x, y) then
        return
    elseif G_empty_tile(x, y) and G_no_creature(x, y) and G_inbounds(x, y) then
        self.player_moved = true
        player.x = x
        player.y = y
        return
    elseif not G_no_creature(x, y) then
        local defender = G_get_creature_with_xy(x, y)
        G_set_attacking(player, defender)
    elseif not G_empty_tile(x, y) then
        if G_openable_tile_adjacent(x, y) then
            G_open_item(x, y)
        end
    end
end

function PlayerTurnState:update(dt)

end
