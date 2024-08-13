require("input")
require("spritesheet")
require("map")
require("entity")
require("bug")


GAMESTATES = {"player_turn", "enemy_turn"}

DRAW_FACTOR = 64
SCALE_FACTOR = 4
DEBUG = true

function love.load()
    love.window.setMode(1920 / 2, 1080 / 2)
    love.window.setTitle("Totality")
    local icon = love.image.newImageData("assets/eclipse.png")
    love.window.setIcon(icon)
    love.graphics.setDefaultFilter("nearest", "nearest")
    G_load_sprites()
    G_load_entities()
    G_load_map()
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

    if G_gamestate.player_moved or G_gamestate.end_turn then

        if G_gamestate.turn % 2 == 0 then
            G_mob_turn()
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
    local rat = G_entities["rat"]
    local croc = G_entities["croc"]
    G_draw_map()
    -- love.graphics.draw(G_spritesheet, rat.sprite, rat.x * DRAW_FACTOR, rat.y * DRAW_FACTOR, 0, SCALE_FACTOR)
    -- love.graphics.draw(G_spritesheet, player.sprite, player.x * DRAW_FACTOR, player.y * DRAW_FACTOR, 0, SCALE_FACTOR)
    -- love.graphics.draw(G_spritesheet, croc.sprite, croc.x * DRAW_FACTOR, croc.y * DRAW_FACTOR, 0, SCALE_FACTOR)
    G_draw_creatures()
    G_draw_line_of_sight(rat, player)
end

function love.quit()
    print("Thanks for playing! Come back soon!")
  end