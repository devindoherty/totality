require("bug")
require("entity")
require("input")
require("map")
require("sprite")
require("state")

GAMESTATES = {"player_turn", "enemy_turn"}

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

end

--------------------------------Input--------------------------------
function love.keypressed(key, scancode, isrepeat)
    if key == "q" or key == "escape" then
        love.event.quit(0)
    end

    G_player_input(key)
end


-- function love.keyreleased(key)
--     if key == 'b' then
--        print(key .. "was realease")
--     end
--  end

 function love.mousereleased(x, y, button, istouch)
    if button == 1 then
       print("Left mouse button pressed at ".. math.floor(x) / 64 .. math.floor(y) / 64)
    end
 end
--------------------------------Update--------------------------------
function love.update(dt)
    
    local player = G_entities["player"]
    
    -- Check for dead
    G_update_dead_creatures()

    -- Turn Update
    if G_gamestate.player_moved or G_gamestate.end_turn or player.is_attacking then
        G_gamestate:start_round()

        print("spacebar test")

        -- Mobs act on even turns
        if G_gamestate.turn % 2 == 0 then
            G_mob_turn()
        end

        print("spacebar test2")
        -- Attacking
        G_update_attacks(dt)

        print("spacebar test3")

        if DEBUG then G_print_debug() end

        G_gamestate:end_round()
    end

    -- Animation Updates
    for i, attack in pairs(G_gamestate.attack_queue) do
        print("Updating Attack " .. attack.name, attack.animation_frame)
        print("Number of attacks " .. #G_gamestate.attack_queue)
        attack.animation_frame = attack.animation_frame + 10 * dt
        if attack.animation_frame >= 4 then
            G_gamestate.attack_queue[i] = nil
        end
    end
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
    if DEBUG then G_draw_all_lines_of_sight() end --TODO: Figure out why lines don't stop at first blocker
    love.graphics.pop()
    
    love.graphics.setCanvas()
    love.graphics.draw(G_screen_canvas)

    player:draw_stats()

end

function love.quit()
    print("Thanks for playing! Come back soon!")
  end