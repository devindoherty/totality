require("input")
require("spritesheet")
require("map")
require("entity")
-- require("player")
require("bug")


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
    
    screen_canvas = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    G_load_sprites()
    G_init_entities()
    G_init_map()

    G_gamestate = {}
    G_gamestate.turn = 0
    G_gamestate.end_turn = false
    G_gamestate.player_moved = false
    
    G_blocker = {}
    G_blocker.x = 0
    G_blocker.y = 0
end

--------------------------------Input--------------------------------
function love.keypressed(key, scancode, isrepeat)
    if key == "q" or key == "escape" then
        love.event.quit(0)
    end

    G_move_player(key)
end


function love.keyreleased(key)
    if key == 'b' then
       print(key .. "was realease")
    end
 end

 function love.mousereleased(x, y, button, istouch)
    if button == 1 then
       print("Left mouse button pressed")
    end
 end
--------------------------------Update--------------------------------
function love.update(dt)
    local player = G_entities["player"]

    -- Check for dead
    for _i, entity in pairs(G_entities) do
        if entity.is_creature then
            if entity.stats["health"] <= 0 then
                G_entities[entity.name] = nil
            end
        end
    end

    if G_gamestate.player_moved or G_gamestate.end_turn or player.is_attacking then

        if G_gamestate.turn % 2 == 0 then
            G_mob_turn()
        end
        
        -- Attacking
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

        G_gamestate.turn = G_gamestate.turn + 1
        G_gamestate.player_moved = false
        G_gamestate.end_turn = false
        
        if DEBUG then
            G_print_debug()
        end
    end
end

--------------------------------Draw--------------------------------
function love.draw()

    local player = G_entities["player"]
    love.graphics.setCanvas(screen_canvas)
    love.graphics.clear()

    love.graphics.push()
    G_player_camera()
    G_draw_map()
    G_draw_items()
    G_draw_creatures()
    G_draw_all_lines_of_sight() --TODO: Figure out why bugged on rat death
    love.graphics.pop()
    
    love.graphics.setCanvas()
    player:draw_stats()

    love.graphics.draw(screen_canvas)
end

function love.quit()
    print("Thanks for playing! Come back soon!")
  end