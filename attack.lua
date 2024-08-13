function G_attack(attacker, defender)
    if math.abs(attacker.x - defender.x) == 1 or
    math.abs(attacker.y - defender.y) == 1 then
        print(attacker.name .. "attacked" .. defender.name)
    end
end