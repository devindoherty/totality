MobTurnState = State:new()

function MobTurnState:init(params)


end

function MobTurnState:enter(params)
    self.map = params.map
    self.player = params.player
end

function MobTurnState:input(key)

end

function MobTurnState:update(dt)
    for _i, mob in pairs(self.map.mobs) do
        -- if not mob:line_of_sight(self.player) then
        --     mob.last_seen.x = G_blocker.x -- TODO: Rework LOS to return x, y
        --     mob.last_seen.y = G_blocker.y
        -- else
        --     mob.last_seen.x = nil
        --     mob.last_seen.y = nil
        -- end
        if mob.behavior == "aggressive" then
            mob:move_toward_target(self.player)
        elseif mob.behavior == "loitering" then
            mob:move_idly()
        elseif mob.behavior == "skittish" then
            mob:move_along_walls()
        elseif mob.behavior == "neutral" then
            mob:do_nothing()
        elseif mob.behavior == "friendly" then
            mob:do_nothing()
        else
            print(mob.name .. " does not have behavior.")
        end
    end

    G_gs:change("world_turn_state", {
        map = self.map,
        player = self.player
    })
end


function MobTurnState:render()
    self.player:camera()
    self.map:render()
    self.player:render()
end

function MobTurnState:exit()

end