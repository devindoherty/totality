require("bug")
require("dialog")
require("entity")
require("entities")
require("input")
require("map")
require("sprite")
require("state")

-- 1920 X 1080 / 2
SCREEN_WIDTH = 960
SCREEN_HEIGHT = 540

DRAW_FACTOR = 64
SCALE_FACTOR = 4
DEBUG = true

function love.load()
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.window.setTitle("Totality")
    local icon = love.image.newImageData("assets/eclipse.png")
    love.window.setIcon(icon)
    
    G_screen_canvas = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    G_gamestate:init()
    G_load_sprites()
    G_init_entities()
    G_init_map()
    
    G_dialogs = {}
    G_dialogs["intro"] = Dialog:new("You followed the old astronomer's advice and took the mountain pass into the eclipse-cursed lands. \n\nIn the twilight of the unnatural night, your foot caught on a twig and you tumbled into the darkness. You've awakened in an old farmhouse. \n\nPress ENTER to continue...")

    G_conversations = {}
end

--------------------------------Input--------------------------------
function love.keypressed(key, scancode, isrepeat)
    if key == "q" or key == "escape" then
        love.event.quit(0)
    end

    G_player_input(key)
end

function love.keyreleased(key)
    if key == 'b' then
       print(key .. "was realease")
    end
 end

 function love.mousereleased(x, y, button, istouch)
    if button == 1 then
       print("Left mouse button pressed at ", math.floor(x / 64) , math.floor(y / 64) )
    end
 end
--------------------------------Update--------------------------------
function love.update(dt)
    local player = G_entities["player"]
    
    -- Check for dead
    G_update_dead_creatures()

    G_update_mouse_position()

    ---------Turn Update----------
    if G_gamestate.player_moved or G_gamestate.end_turn or player.is_attacking then
        G_gamestate:start_round()

        -- Mobs act on even turns (For now)
        if G_gamestate.turn % 2 == 0 then
            G_mob_turn()
        end
        
        -- Attacks
        G_update_attacks()

        if DEBUG then G_print_debug() end

        G_gamestate:end_round()

    end
    ---------End Turn Update----------

    -- Animation Updates
    G_update_attack_draws(dt)

end

--------------------------------Draw--------------------------------
function love.draw()
    local player = G_entities["player"]
    love.graphics.setCanvas(G_screen_canvas)
    love.graphics.clear()

    love.graphics.push()
    G_player_camera()
    G_draw_map()
    G_draw_items()
    G_draw_creatures()
    G_draw_attacks()
    if DEBUG then G_draw_all_lines_of_sight() end --TODO: player y < observer and player x < observer glitching
    
    if G_get_distance_between_two_points(player, G_entities["yarl"]) < 4 then
        G_entities["yarl"]:draw_quip("hello")
    end
    love.graphics.pop()
    
    love.graphics.setCanvas()
    love.graphics.draw(G_screen_canvas)

    if G_gamestate.current_mode == "dialoging" then
        G_dialogs[G_gamestate.current_dialog]:draw()
    end
    if G_gamestate.current_mode == "player_turn" then
        G_draw_tile_cursor()
    end

    player:draw_stats()
    

end

function love.quit()
    print("Thanks for playing! Come back soon!")
end