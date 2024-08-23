function G_print_debug()
    local player = G_entities["player"]
    for _i, entity in pairs(G_entities) do
        if entity.is_creature then
            print(entity.name .. " X: " .. entity.x)
            print(entity.name .. " Y: " .. entity.y)
        end
    end

    print("Mouse X: " .. G_gamestate.mouse.x, "Mouse Y: " .. G_gamestate.mouse.y)
    print(G_gamestate.nearby_interactible)

    print("END OF TURN ".. G_gamestate.turn)
    print("####################")
end

