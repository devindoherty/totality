function line_of_sight(observer, target)
    local delta_x = observer.x - target.x
    local delta_y = observer.y - target.y
    print("Delta X" .. delta_x)
    print("Delta Y" .. delta_y)

    steep = math.abs(target.y - observer.y) > math.abs(target.x - observer.x)
    slope = delta_x / delta_y
    print(slope)
    print(steep)

    -- for observer.x, target.x, -1 do
    --     print("test")
    -- end 


end

function move_toward_player()
    local x = rat.x
    local y = rat.y
    
    line_of_sight(rat, player)
    
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