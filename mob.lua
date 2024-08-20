-- Bresenham's line algorithm
function G_line_of_sight(observer, target)
    local x0 = observer.x
    local y0 = observer.y

    local x1 = target.x
    local y1 = target.y

    -- G_blocker.x = target.x
    -- G_blocker.y = target.y

    if math.abs(y1 - y0) < math.abs(x1 - x0) then
        if x0 > x1 then
            return G_line_of_sight_low(x1, y1, x0, y0)
        else
            return G_line_of_sight_low(x0, y0, x1, y1)
        end
    else
        if y0 > y1 then
            return G_line_of_sight_high(x1, y1, x0, y0)
        else
            return G_line_of_sight_high(x0, y0, x1, y1)
        end
    end
end

function G_line_of_sight_low(x0, y0, x1, y1)
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
        if not G_empty_tile(x, y) then
            G_blocker.x = x
            G_blocker.y = y
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

function G_line_of_sight_high(x0, y0, x1, y1)
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
        
        if not G_empty_tile(x, y) then
            local closest_blocker -- Test to see if global blocker abs is bigger, if not then return false
            G_blocker.x = x
            G_blocker.y = y
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

function G_draw_line_of_sight(observer, target)
    if observer.last_seen.x or observer.last_seen.y then
        love.graphics.setColor(1, 0, 0)
        love.graphics.line((observer.x + .5) * DRAW_FACTOR, (observer.y + .5) * DRAW_FACTOR, (observer.last_seen.x + .5) * DRAW_FACTOR, (observer.last_seen.y + .5) * DRAW_FACTOR)
    else
        love.graphics.setColor(0, 1, 0)
        love.graphics.line((observer.x + .5) * DRAW_FACTOR, (observer.y + .5) * DRAW_FACTOR, (target.x + .5) * DRAW_FACTOR, (target.y + .5) * DRAW_FACTOR)
    end
    love.graphics.setColor(255, 255, 255)
end

function G_draw_all_lines_of_sight()
    local player = G_entities["player"]
    for i, entity in pairs(G_entities) do
        if entity.is_creature and entity.name ~= "player" then
            G_draw_line_of_sight(entity, player)
        end
    end
end

local function move_toward_target(mob, target)
    local player = G_entities["player"]

    local x = mob.x
    local y = mob.y

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
        
        if G_empty_tile(x, y) and G_inbounds(x, y) and G_no_creature(x, y) and G_line_of_sight(mob, target) then
            mob.x = x
            mob.y = y
        elseif not G_no_creature(x, y) then
            local defender = G_get_creature_with_xy(x, y)
            G_set_attacking(mob, defender)
        end
    end
end

local function move_idly(mob)
    local player = G_entities["player"]

    local x = mob.x
    local y = mob.y

    local prob_move = love.math.random()
    local prob_x_y = love.math.random()
    local prob_dir = love.math.random()

    -- Whether moving at all
    if prob_move >= .5 then
        -- X or Y
        if prob_x_y >= .5 then
            if prob_dir >= .5 then
                x = x + 1
            else
                x = x - 1
            end
        else
            if prob_dir >= .5 then
                y = y + 1
            else
                y = y - 1
            end
        end
        if G_empty_tile(x, y) and G_no_creature(x, y) and G_inbounds(x, y) then
            mob.x = x
            mob.y = y
        end
    end
end

local function move_along_walls(mob)
end

local function move_aquatically()
end

local function do_nothing(mob)
    local x = mob.x
    local y = mob.y
    if G_inbounds(x, y) then
        
    end
end


local function select_quip(mob)
    if mob.quips then
        local quip_idx = love.math.random(1, #mob.quips)
        print(mob.quips[quip_idx])
    end
end

function G_mob_turn()
    local player = G_entities["player"]
    print("MOB TURN")
    for _i, entity in pairs(G_entities) do
        if entity.is_creature and entity.name ~= "player" then
            if not G_line_of_sight(entity, player) then
                entity.last_seen.x = G_blocker.x
                entity.last_seen.y = G_blocker.y
            else
                entity.last_seen.x = nil
                entity.last_seen.y = nil
            end
            if entity.behavior == "aggressive" then
                move_toward_target(entity, player)
            elseif entity.behavior == "loitering" then
                move_idly(entity)
            elseif entity.behavior == "skittish" then
                move_along_walls(entity)
            elseif entity.behavior == "neutral" then
                do_nothing(entity)
            else
                print(entity.name .. " does not have behavior.")
            end
        end
    end
end