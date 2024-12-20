-- Interact action looks for an interactible on call near the caller based on direction input

Interact = {}

function Interact:new(name, interactible, effect)
    local interact = {}
    setmetatable(interact, self)
    self.__index = self
    self.name = name
    self.interactible = interactible
    self.effect = function () end
end

function Interact:open_item(x, y)
    if G_tilemap[y][x] == 'D' then 
        G_tilemap[y][x] = 'O'
    end
end

-- TODO
function Interact:close_item(x, y)
    G_tilemap[y][x] = 'D'
end

function Interact.detect(interactor, interactibles)
    for x = interactor.x - 1, interactor.x + 1 do
        for y = interactor.y -1, interactor.y + 1 do
            for _i, entity in pairs(interactibles) do
                if entity.x == x and entity.y == y and entity.name ~= "player" then
                    if DEBUG then
                        print(entity.name .. " is interactible!")
                    end
                    if entity.is_creature and entity.is_friendly then
                        G_gamestate.nearby_interactible["creature"] = true
                        G_gamestate.nearby_interactible.target = entity
                        return
                    elseif entity.is_item then
                        G_gamestate.nearby_interactible["item"] = true
                        G_gamestate.nearby_interactible.target = entity
                        return
                    end
                else
                    for i, _state in pairs(G_gamestate.nearby_interactible) do
                        G_gamestate.nearby_interactible[i] = false
                    end
                end
            end
        end
    end
end

function Interact:render_detection()
    love.graphics.setColor(0, 0, 0, .5)
    love.graphics.rectangle("fill", SCREEN_HEIGHT / 2, SCREEN_WIDTH / 2, 400, 200)
    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle("line", SCREEN_HEIGHT / 2, SCREEN_WIDTH / 2, 400, 200)
    love.graphics.setColor(1, 1, 1)
    if G_gamestate.nearby_interactible["creature"] then
        love.graphics.print("Press E to Talk", SCREEN_HEIGHT / 2, SCREEN_WIDTH / 2, 0, 2)
    elseif G_gamestate.nearby_interactible["item"] then
        love.graphics.print("Press E to Interact", SCREEN_HEIGHT / 2, SCREEN_WIDTH / 2, 0, 2)
    end
end

function Interact:set(interactor, interactible)
    if interactible.is_creature and interactible.is_friendly then
        interactor.is_conversing = true
        interactible.is_known = true
        interactor.target = interactible
        if DEBUG then
            print(interactor.name .. " is conversing with " .. interactible.name)
        end
        G_gamestate.current_mode = "conversing"
        G_gamestate.nearby_interactible.target = interactible
    elseif interactible.is_item then
        -- print(interactible.flavor)
    
    end
end

function Interact:update()
    for key, value in pairs(G_gamestate.nearby_interactible.target.quips) do
        if G_gamestate.response.entered == key then
            G_gamestate.response.answer = value
        end
    end

end

function Interact:render()
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", SCREEN_WIDTH / 10, SCREEN_HEIGHT / 6, 800, 400)
    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle("line", SCREEN_WIDTH / 10, SCREEN_HEIGHT / 6, 800, 400)
    love.graphics.setColor(1, 1, 1)
    -- local j = 0
    -- for key, value in pairs(G_gamestate.nearby_interactible.target.quips) do
    --     love.graphics.printf(key .. ": " .. value, SCREEN_WIDTH / 10 + 6, SCREEN_HEIGHT / 6 + j, 800)
    --     j = j + 24
    -- end
    love.graphics.printf(G_gamestate.response.answer, SCREEN_WIDTH / 10 + 6, SCREEN_HEIGHT / 6, 800, "left")

    love.graphics.setColor(1, 0, 0)
    love.graphics.printf(G_gamestate.response.active, SCREEN_WIDTH / 10 + 6, SCREEN_HEIGHT / 2 + 200, 800, "left")
    love.graphics.setColor(1, 1, 1)
end