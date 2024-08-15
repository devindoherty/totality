function G_set_attacking(attacker, defender)
    if attacker == defender then
        return
    else
        print(attacker.name .. " attacked " .. defender.name)
        attacker.is_attacking = true
        attacker.target = defender
    end
end

function G_attack(attacker, defender)

end

function G_draw_attack()

end