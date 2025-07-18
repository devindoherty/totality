-- Loops through all mobs and decides what they're going to do

MobTurnState = State:new()

function MobTurnState:init(params)
    self.attacks = nil
end

function MobTurnState:enter(params)
    self.map = params.map
    self.player = params.player
    self.map.player = params.player
    self.log = params.log
    print("position of player on mob turn start: " .. self.player.x .. " " .. self.player.y)
end

function MobTurnState:input(key)
    -- pass
end

-- Loops through mobs according to behaviour and then decides on basic AI pathfinding or attacking
function MobTurnState:update(dt)
    local mob_turn_complete = false
    
    for _i, mob in pairs(self.map.mobs) do
        if math.abs(self.player.x - mob.x) <= AWARENESS_X 
        and math.abs(self.player.y - mob.y) <= AWARENESS_Y then
            if mob:line_of_sight(self.player) and mob.acted == false then
                if mob.behavior == "aggressive" and mob.attack == nil then
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
                    if DEBUG then print(mob.name .. " does not have behavior.") end
                end
            end
            mob.acted = true
        else
            mob.acted = true
        end
        if mob.attack then
            -- Set mob back to not having acted if the attack animation isn't done yet
            mob.acted = false
            mob.attack:update(dt)
            if mob.attack.frame >= mob.attack.max_frame then
                mob.attack = nil
                mob.acted = true
            end
        end
    end

    for _i, mob in pairs(self.map.mobs) do
        if mob.acted == false then
            mob_turn_complete = false
            break
        else
            mob_turn_complete = true
        end
    end

    if mob_turn_complete == true then
        G_gs:change("world_turn_state", {map = self.map, player = self.player, log=self.log})
    end
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
    for _i, mob in pairs(self.map.mobs) do
        mob.acted = false
    end
end