-- Used to see idx of spritesheet

MapEditorState = State:new()

function State:init() end
function State:enter(params) 
    love.window.setMode(1920, 800)
end
function State:input(key) end
function State:update(dt) end

function State:render() 
    local x = 0
    local y = 0
    for i = 1, #G_sprites do

        love.graphics.draw(G_spritesheet, G_sprites[i], x, y, 0, SCALE_FACTOR)
        love.graphics.setColor(252/255, 15/255, 192/255)
        love.graphics.print(i, x, y)
        love.graphics.setColor(1, 1, 1)
        x = x + 32
        if x >= 1532 then
            y = y + 34
            x = 0
        end
    end

end

function State:exit() end

