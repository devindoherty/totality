-- Goes through all mobs and decides what they're going to do

MobTurnState = State:new()

function MobTurnState:init(params)

end

function MobTurnState:enter(params)
    self.map = params.map
    self.player = params.player
    self.map.player = self.player
    self.log = params.log
end

function MobTurnState:input(key)
    -- pass
end

-- Loops through mobs according to behaviour and then decides on basic AI pathfinding or attacking
function MobTurnState:update(dt)
    for _i, mob in pairs(self.map.mobs) do
        if mob.attack then
            if mob.attack.frame > 2.5 then
                mob.attack = nil
                return
            else
                mob.attack:update(dt)
                return
            end
        end
        
        if math.abs(self.player.x - mob.x) <= 16 and math.abs(self.player.y - mob.y) <= 8 then
            if mob:line_of_sight(self.player) then
                if mob.behavior == "aggressive" then
                    mob:move_toward_target(self.player)
                elseif mob.behavior == "loitering" then
                    mob:move_idly(self.player)
                elseif mob.behavior == "skittish" then
                    mob:move_along_walls(self.player)
                elseif mob.behavior == "neutral" then
                    mob:do_nothing(self.player)
                elseif mob.behavior == "friendly" then
                    mob:do_nothing(self.player)
                else
                    print(mob.name .. " does not have behavior.")
                end
            end
        end
    end

    G_gs:change("world_turn_state", {map = self.map, player = self.player, log=self.log})
    return
end

function MobTurnState:render_log()
    local x = 0
    local y = SCREEN_HEIGHT - 100
    love.graphics.setColor(0, 0, 0, .5)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH / 4, SCREEN_HEIGHT)
    love.graphics.setColor(1, 1, 1)
    for i = #self.log, 1, -1 do
        love.graphics.printf(self.log[i], x, y, SCREEN_WIDTH / 4)
        if #self.log[i] > 30 then
            y = y - 24
        else
            y = y - 12
        end
    end
end

function MobTurnState:render()
    love.graphics.push()
        self.player:camera()
        self.map:render()
        self.player:render()
    love.graphics.pop()
    self:render_log()
    love.graphics.draw(G_portraitsheet, self.player.portrait, 0, SCREEN_HEIGHT - 64, 0, 2)
    love.graphics.print("Health: " .. self.player.stats["health"], 66, SCREEN_HEIGHT - 64)
    love.graphics.print("Magic: " .. self.player.stats["magic"], 66, SCREEN_HEIGHT - 52)

end

function MobTurnState:exit()

end