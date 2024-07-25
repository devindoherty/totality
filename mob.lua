function move_toward_player()
    local x = rat.x
    local y = rat.y
    
    
    if x ~= player.x or y ~= player.y then
        if math.abs(player.x - x) > math.abs(player.y - y) then
            if x <= player.x then
                x = x + 1
            else
                x = x - 1
            end
        else
            if y <= player.y then
                y = y + 1
            else
                y = y - 1
            end
        end
        
        if empty_tile(x, y) and no_creature(x, y) then
            print("Rat blocked")
            rat.x = x  
            rat.y = y
        elseif not empty_tile(x, y) and no_creature(x, y) then
            print("Path lost")
        end
    end
end

function mob_turn()
    move_toward_player()
end