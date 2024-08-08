function line_of_sight(observer, target)
    local delta_x = target.x - observer.x
    local delta_y = target.y - observer.y
    print("Delta X " .. delta_x)
    print("Delta Y " .. delta_y)

    step = 2 * delta_y - delta_x
    print("Step: " .. step)

    local y = observer.y
    if delta_x > 0 then
        i = 1
    else
        i = -1
    end

    for x = observer.x, target.x, i do
        print("("..x..", "..y..")", empty_tile(x, y))
        if not empty_tile(x, y) then
            return false
        end
        if step > 0 then
            y = y + 1
            step = step - 2 * delta_x
        end
        step = step + 2 * delta_y
    end
    
    return true 
end

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
        
        if empty_tile(x, y) and no_creature(x, y) and line_of_sight(rat, player) then
            rat.x = x  
            rat.y = y
        elseif not empty_tile(x, y) and not no_creature(x, y) then
            print("Path lost")
        end
    end
end

function mob_turn()
    move_toward_player()
end