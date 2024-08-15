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

function G_attack(attacker, defender)
    print(attacker.name .. " attacked " .. defender.name)
end

function G_draw_attack()

end

function G_open_item(x, y)
    G_tilemap[y][x] = 'O'
end