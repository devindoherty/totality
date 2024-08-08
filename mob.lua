function line_of_sight(observer, target)
    local delta_x = target.x - observer.x
    local delta_y = target.y - observer.y
    print("Delta X " .. delta_x)
    print("Delta Y " .. delta_y)
    step = 2 * delta_y - delta_x
    print("Step: " .. step)
    blocker.x = 0
    blocker.y = 0
    
    local y = observer.y
    if delta_x > 0 then
        i = 1
    else
        i = -1
    end

    for x = observer.x, target.x, i do
        print("("..x..", "..y..")", empty_tile(x, y))
        if not empty_tile(x, y) then
            blocker.x = x
            blocker.y = y
            print("blocker" .. blocker.x .. blocker.y)
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

function draw_line_of_sight(observer, target)
    if blocker.x > 0 and blocker.y > 0 then
        love.graphics.setColor(1, 0, 0)
        love.graphics.line((rat.x + .5) * DRAW_FACTOR, (rat.y + .5) * DRAW_FACTOR, (blocker.x + .5) * DRAW_FACTOR, (blocker.y + .5) * DRAW_FACTOR)    
    else
        love.graphics.setColor(0, 1, 0)
        love.graphics.line((rat.x + .5) * DRAW_FACTOR, (rat.y + .5) * DRAW_FACTOR, (player.x + .5) * DRAW_FACTOR, (player.y + .5) * DRAW_FACTOR)
    end
    love.graphics.setColor(255, 255, 255)
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
        end
        if not empty_tile(x, y) then
            print("Path blocked")
        end
        if not no_creature(x, y) then
            print("Path occupied")
        end
        if not line_of_sight(rat, player) then
            print("Path sightless")
        end
    end
end

function mob_turn()
    move_toward_player()
end