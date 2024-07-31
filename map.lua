require("mob")


function load_map()
    tilemap = {
        {1, 1, 1, 1, 1, 1,   1, 1, 1, 1, 1, 1,   1},
        {1, 0, 0, 0, 0, 0,   1, 0, 0, 0, 0, 0,   1},
        {1, 0, 0, 0, 0, 0,   1, 0, 0, 0, 0, 0,   1},
        {1, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 'D'},
        {1, 0, 0, 0, 0, 1,   0, 0, 0, 0, 0, 0,   1},
        {1, 0, 0, 0, 0, 1,   0, 0, 0, 0, 0, 0,   1},
        {1, 1, 1, 1, 1, 1,   1, 1, 1, 1, 1, 1,   1},
    }

end

function draw_map()
    for y = 1, #tilemap do
        for x = 1, #tilemap[y] do
            if tilemap[y][x] == 1 then
                love.graphics.draw(spritesheet, brick_wall.sprite, x * 64, y * 64, 0, 4)
            elseif tilemap[y][x] == 'O' then
                love.graphics.draw(spritesheet, white_doorframe.sprite, x * 64, y * 64, 0, 4)
            elseif tilemap[y][x] == 'D' then
                love.graphics.draw(spritesheet, white_door.sprite, x * 64, y * 64, 0, 4)
            else
                love.graphics.draw(spritesheet, empty.sprite, x * 64, y * 64, 0, 4)
                -- love.graphics.rectangle("line", x * 32, y * 32, 32, 32)
            end
        end
    end
end

function empty_tile(x, y)
    return tilemap[y][x] == 0 or tilemap[y][x] == 'O'
end

function no_creature(x, y)
    if x == rat.x and y == rat.y then
        return false
    elseif 
       x == player.x and y == player.y then
        return false 
    else
        return tilemap[y][x]
    end
end