MobTurnState = State:new()

function MobTurnState:init(params)

end

function MobTurnState:enter(params)
    self.map = params.map
    self.player = params.player
    self.map.player = self.player
end

function MobTurnState:input(key)
    -- pass
end

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

    G_gs:change("world_turn_state", {map = self.map, player = self.player})
end


function MobTurnState:render()
    self.player:camera()
    self.map:render()
    self.player:render()
end

function MobTurnState:exit()

end