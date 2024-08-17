function G_set_attacking(attacker, defender)
    if attacker == defender then
        return
    elseif defender.is_friendly then
        return
    else
        
        attacker.is_attacking = true
        attacker.target = defender
    end
end

function G_update_attacks(dt)
    for _i, entity in pairs(G_entities) do
        if entity.is_creature then
            if entity.is_attacking then
                local defender = entity.target
                defender:inflict_damage(5)
                entity.is_attacking = false
                entity.target = nil
                print(defender.name, defender.stats["health"], "health")
                G_gamestate.drawn_attack.x = defender.x
                G_gamestate.drawn_attack.y = defender.y
                return true
            end
        end
    end

end

function G_draw_attack()
    if G_gamestate.attack_update then
        love.graphics.draw(G_spritesheet, G_entities["slash"].sprite, G_gamestate.drawn_attack.x * DRAW_FACTOR, G_gamestate.drawn_attack.y * DRAW_FACTOR, 0, G_entities["slash"].animation_frame)
    end
end

function G_open_item(x, y)
    G_tilemap[y][x] = 'O'
end

-- TODO
function G_close_item(x, y)
    G_tilemap[y][x] = 'D'
end