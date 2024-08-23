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
                local log_text = entity.name .. " attacked " .. defender.name
                local drawn_attack_x = defender.x
                local drawn_attack_y = defender.y
                local slash = Entity:new("slash", G_sprites[540], drawn_attack_x, drawn_attack_y, false)
                slash.is_effect = true
                slash.animation_frame = 1
                table.insert(G_gamestate.attack_queue, slash)

                entity.is_attacking = false
                entity.target = nil
            end
        end
    end
end

function G_update_attack_draws(dt)
    for i, attack in pairs(G_gamestate.attack_queue) do
        print("Updating Attack " .. attack.name, attack.animation_frame)
        print("Number of attacks " .. #G_gamestate.attack_queue)
        attack.animation_frame = attack.animation_frame + 10 * dt
        if attack.animation_frame >= 4 then
            G_gamestate.attack_queue[i] = nil
        end
    end
end

function G_draw_attacks()
    for _i, attack in pairs(G_gamestate.attack_queue) do
        print("Drawing: " .. attack.name, attack.animation_frame)
        love.graphics.draw(G_spritesheet, attack.sprite, attack.x * DRAW_FACTOR, attack.y * DRAW_FACTOR, 0, attack.animation_frame)
    end
    
end

function G_open_item(x, y)
    G_tilemap[y][x] = 'O'
end

-- TODO
function G_close_item(x, y)
    G_tilemap[y][x] = 'D'
end

function G_detect_interactible(interactor)
    for x = interactor.x - 1, interactor.x + 1 do
        for y = interactor.y -1, interactor.y + 1 do
            for _i, entity in pairs(G_entities) do
                if entity.x == x and entity.y == y and entity.name ~= "player" then
                    print(entity.name .. " is interactible!")
                    if entity.is_creature and entity.is_friendly then
                        G_gamestate.nearby_interactible["creature"] = true
                        return
                    elseif entity.is_item then
                        G_gamestate.nearby_interactible["item"] = true
                        return
                    end
                else
                    for i, state in pairs(G_gamestate.nearby_interactible) do
                        G_gamestate.nearby_interactible[i] = false
                    end
                end
            end
        end
    end
end

function G_draw_interactible_detection()
    if G_gamestate.nearby_interactible["creature"] then
        love.graphics.print("Press E to Talk", SCREEN_HEIGHT / 2, SCREEN_WIDTH / 2, 0, 2)
    elseif G_gamestate.nearby_interactible["item"] then
        love.graphics.print("Press E to Interact", SCREEN_HEIGHT / 2, SCREEN_WIDTH / 2, 0, 2)
    end
end

function G_set_interacting(interactor, interactible)
    if interactible.is_creature and interactible.is_friendly then
        interactor.is_conversing = true
        interactor.target = interactible
    end

end

function G_interact()
end