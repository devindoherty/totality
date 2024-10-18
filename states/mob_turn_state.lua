MobTurnState = State:new()

function MobTurnState:init(params)
end

function MobTurnState:enter()

end

function MobTurnState:input(key)

end

function MobTurnState:update(dt)
    local player = G_entities["player"]
    for _i, mob in pairs(self.area.mobs) do
        if mob.is_creature and mob.name ~= "player" then
            if not mob:line_of_sight(player) then
                mob.last_seen.x = G_blocker.x -- TODO: Rework LOS to return x, y
                mob.last_seen.y = G_blocker.y
            else
                mob.last_seen.x = nil
                mob.last_seen.y = nil
            end
            if mob.behavior == "aggressive" then
                mob:move_toward_target(player)
            elseif mob.behavior == "loitering" then
                mob:move_idly()
            elseif mob.behavior == "skittish" then
                mob:move_along_walls()
            elseif mob.behavior == "neutral" then
                mob:do_nothing()
            else
                print(mob.name .. " does not have behavior.")
            end
        end
    end
end


function MobTurnState:render()

end

function MobTurnState:exit()

end