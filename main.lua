require("attack")
require("bug")
require("constants")
require("dialog")
require("gamestate")
require("interact")
require("item")
require("map")
require("mob")
require("player")
require("sprite")
require("tile")


require("states/state")
require("states/start_state")
require("states/character_creation_state")
require("states/player_turn_state")
require("states/player_conversation_state")
require("states/mob_turn_state")
require("states/world_turn_state")

require("data/dialogs")
require("data/mobs")
require("data/items")
require("data/tiles")
require("data/maps")

function love.load()
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.window.setTitle("Path of Totality")
    local icon = love.image.newImageData("assets/eclipse.png")
    love.window.setIcon(icon)
    
    -- G_screen_canvas = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    G_load_sprites()

    G_gs = Gamestate:new({
        ["start_state"] = function() return StartState end,
        ["character_creation_state"] = function() return CharacterCreationState end,
        ["player_turn_state"] = function() return PlayerTurnState end,
        ["player_conversation_state"] = function () return PlayerConversationState end,
        ["mob_turn_state"] = function() return MobTurnState end,
        ["world_turn_state"] = function() return WorldTurnState end,
    })
    G_gs:change("start_state")

    G_blocker = {}
    G_blocker.x = 0
    G_blocker.y = 0
end

--------------------------------Input--------------------------------
function love.keypressed(key, scancode, isrepeat)
    if key == "q" or key == "escape" then
        love.event.quit(0)
    end

    G_gs:input(key)
    -- G_player_input(key)
end

function love.keyreleased(key)

end

 function love.mousereleased(x, y, button, istouch)
    if button == 1 then
    --    print("Left mouse button pressed at ", math.floor(x / 64) , math.floor(y / 64) )
    end
 end
--------------------------------Update--------------------------------
function love.update(dt)
    G_gs:update(dt)
    -- local player = G_entities["player"]
    -- G_update_mouse_position()

    -- -- Check for dead
    -- G_update_dead_creatures()

    -- ---------Turn Update----------
    -- if G_gamestate.player_moved or G_gamestate.end_turn or player.is_attacking then
    --     G_gamestate:start_round()

    --     G_detect_interactible(player)
    --     -- Mobs act on even turns (For now)
    --     if G_gamestate.turn % 2 == 0 then
    --         G_mob_turn()
    --     end
        
    --     -- Attacks
    --     G_update_attacks()

    --     if DEBUG then G_print_debug() end

    --     G_gamestate:end_round()
    -- end
    -- ---------End Turn Update----------

    -- -- Animation Updates
    -- G_update_attack_draws(dt)

    -- if player.is_conversing then
    --     G_update_interact()
    -- end
end

--------------------------------Draw--------------------------------
function love.draw()
    G_gs:render()

    -- local player = G_entities["player"]
    -- love.graphics.setCanvas(G_screen_canvas)
    -- love.graphics.clear()

    -- love.graphics.push()
    --     G_player_camera()
    --     G_draw_map()
    --     G_draw_items()
    --     G_draw_creatures()
    --     G_draw_attacks()
    --     if DEBUG then G_draw_all_lines_of_sight() end --TODO: player y < observer and player x < observer glitching

    --     -- if G_get_distance_between_two_points(player, G_entities["yarl"]) < 4 and G_gamestate.current_mode == "player_turn" then
    --     --     G_entities["yarl"]:draw_quip("intro")
    --     -- end
    -- love.graphics.pop()
    
    -- love.graphics.setCanvas()
    -- love.graphics.draw(G_screen_canvas)

    -- if G_gamestate.current_mode == "dialoging" then
    --     G_dialogs[G_gamestate.current_dialog]:draw()
    -- end
    -- if G_gamestate.current_mode == "player_turn" then
    --     G_draw_tile_cursor()
    --     G_draw_interactible_detection()
    --     G_draw_attacks_log()
    --     player:draw_stats()
    -- end
    -- if G_gamestate.current_mode == "conversing" then
    --     G_draw_interact()
    -- end
end

function love.quit()
    print("Thanks for playing! Come back soon!")
end

