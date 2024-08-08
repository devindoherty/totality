function line_of_sight(observer, target)
    local x0 = observer.x
    local y0 = observer.y

    local x1 = target.x
    local y1 = target.y

    blocker.x = target.x
    blocker.y = target.y

    if math.abs(y1 - y0) < math.abs(x1 - x0) then
        if x0 > x1 then
            return line_of_sight_low(x1, y1, x0, y0)
        else
            return line_of_sight_low(x0, y0, x1, y1)
        end
    else
        if y0 > y1 then
            return line_of_sight_high(x1, y1, x0, y0)
        else
            return line_of_sight_high(x0, y0, x1, y1)
        end
    end
end

function line_of_sight_low(x0, y0, x1, y1)
    local dx = x1 - x0
    local dy = y1 - y0
    local yi = 1
    if dy < 0 then
        yi = -1
        dy = -dy
    end
    local D = (2 * dy) - dx
    local y = y0
    for x = x0, x1 do
        if not empty_tile(x, y) then
            blocker.x = x
            blocker.y = y
            return false
        end
        if D > 0 then
            y = y + yi
            D = D + (2 * (dy - dx))
        else 
            D = D + 2 * dy
        end
    end

    return true
end

function line_of_sight_high(x0, y0, x1, y1)
    local dx = x1 - x0
    local dy = y1 - y0
    local xi = 1
    if dx < 0 then
        xi = -1
        dx = -dx
    end
    local D = (2 * dx) - dy
    local x = x0
    for y = y0, y1 do
        if not empty_tile(x, y) then
            blocker.x = x
            blocker.y = y
            return false
        end
        if D > 0 then
            x = x + xi
            D = D + (2 * (dx - dy))
        else 
            D = D + 2 * dx
        end
    end
    return true
end

function draw_line_of_sight(observer, target)
    if blocker.x ~= target.x or blocker.y ~= target.y then
        love.graphics.setColor(1, 0, 0)
        love.graphics.line((observer.x + .5) * DRAW_FACTOR, (observer.y + .5) * DRAW_FACTOR, (blocker.x + .5) * DRAW_FACTOR, (blocker.y + .5) * DRAW_FACTOR)    
    else
        love.graphics.setColor(0, 1, 0)
        love.graphics.line((observer.x + .5) * DRAW_FACTOR, (observer.y + .5) * DRAW_FACTOR, (target.x + .5) * DRAW_FACTOR, (target.y + .5) * DRAW_FACTOR)
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