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

function G_update_attacks()
    for _i, entity in pairs(G_entities) do
        if entity.is_creature then
            if entity.is_attacking then
                local defender = entity.target
                defender:inflict_damage(5)
                entity.is_attacking = false
                entity.target = nil
                print(defender.name, defender.stats["health"])
            end
        end
    end
end

function G_draw_attack()

end

function G_open_item(x, y)
    G_tilemap[y][x] = 'O'
end

-- TODO
function G_close_item(x, y)
    G_tilemap[y][x] = 'D'
end