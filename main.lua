require("attack")
require("bug")
require("constants")
require("dialog")
require("gamestate")
require("interact")
require("item")
require("map")
require("menu_selection")
require("mob")
require("player")
require("sprite")
require("tile")

require("states/state")
require("states/start_state")
require("states/character_creation_state")
require("states/player_turn_state")
require("states/player_dialog_state")
require("states/map_editor_state")
require("states/mob_turn_state")
require("states/world_turn_state")
require("states/game_over_state")

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
    
    Spritesheet.load_sprites()
    Spritesheet.load_portraits()
    G_start_screen_splash = love.graphics.newImage("assets/start_screen_splash.png")
    G_gs = Gamestate:new({
        ["start_state"] = function() return StartState end,
        ["character_creation_state"] = function() return CharacterCreationState end,
        ["player_turn_state"] = function() return PlayerTurnState end,
        ["player_dialog_state"] = function () return PlayerDialogState end,
        ["map_editor_state"] = function () return MapEditorState end,
        ["mob_turn_state"] = function() return MobTurnState end,
        ["world_turn_state"] = function() return WorldTurnState end,
        ["game_over_state"] = function() return GameOverState end,
    })
    G_gs:change("start_state")
end

--------------------------------Input--------------------------------
function love.keypressed(key, scancode, isrepeat)
    if key == "q" or key == "escape" then
        love.event.quit(0)
    end

    G_gs:input(key)
    -- G_player_input(key)
end

function love.textinput(t)
    G_gs:update(dt, t)
end

function love.keyreleased(key)
    -- Pass for now
end

 function love.mousereleased(x, y, button, istouch)
    if button == 1 then
    --    print("Left mouse button pressed at ", math.floor(x / 64) , math.floor(y / 64) )
    end
 end

 --------------------------------Update-----------------------------
function love.update(dt)
    G_gs:update(dt)
end

--------------------------------Draw--------------------------------
function love.draw()
    G_gs:render()
end

-------------------------------Exit---------------------------------
function love.quit()
    print("Thanks for playing! Come back soon!")
end