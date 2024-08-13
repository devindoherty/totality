require("mob")

function G_move_player(key)
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
        x = player.x
        y = player.y
    end
    
    if G_empty_tile(x, y) and G_no_creature(x, y) then
        G_gamestate.player_moved = true
        player.x = x
        player.y = y
    else
        print("Tile blocker at: " .. x .. ", " .. y)
    end
end