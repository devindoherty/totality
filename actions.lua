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
    -- for i, _j in pairs(G_gamestate.attack_queue) do
    --     G_gamestate.attack_queue[i] = nil
    -- end
    
    for _i, entity in pairs(G_entities) do
        if entity.is_creature then
            if entity.is_attacking then
                local defender = entity.target
                defender:inflict_damage(5)
                print(entity.name .. " is attacking " .. defender.name)
                print(defender.name, defender.stats["health"] .. " health")
                entity.is_attacking = false
                entity.target = nil
                local drawn_attack_x = defender.x
                local drawn_attack_y = defender.y
                local slash = Entity:new("slash", G_sprites[540], drawn_attack_x, drawn_attack_y, false)
                slash.is_effect = true
                slash.animation_frame = 1
                table.insert(G_gamestate.attack_queue, slash)
                return true
            end
        end
    end

end

function G_draw_attacks()
    if G_gamestate.update_attacks_animation then
        for _i, attack in pairs(G_gamestate.attack_queue) do
            love.graphics.draw(G_spritesheet, attack.sprite, attack.x * DRAW_FACTOR, attack.y * DRAW_FACTOR, 0, attack.animation_frame)
        end
    end
end

function G_open_item(x, y)
    G_tilemap[y][x] = 'O'
end

-- TODO
function G_close_item(x, y)
    G_tilemap[y][x] = 'D'
end