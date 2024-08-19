require("mob")
require("actions")

function G_player_input(key)
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
        G_gamestate.end_turn = true
        print("spacebar pressed")
        return
    end
    
    if not G_inbounds(x, y) then
        return
    elseif G_empty_tile(x, y) and G_no_creature(x, y) and G_inbounds(x, y) then
        G_gamestate.player_moved = true
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