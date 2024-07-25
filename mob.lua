function move_toward_player(x, y)
    print(x, y)
    if x ~= player.x and y ~= player.y then
        if x < player.x then
            rat.x = x + 1
        else
            rat.x = x - 1
        end
        if y < player.y then
            rat.y = y + 1
        else
            rat.y = y - 1
        end
    end
end
