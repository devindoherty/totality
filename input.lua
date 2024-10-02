require("mob")
require("actions")

function G_player_input(key)    
    if G_gamestate.current_mode == "conversing" then
        function love.textinput(t)
            G_gamestate.response.active = G_gamestate.response.active .. t
        end
    
        if key == "return" then
            G_gamestate.response.entered = G_gamestate.response.active
            G_gamestate.response.active = ""
        end
    
    end
    
    if G_gamestate.current_mode == "dialoging" then
        if key == "return" then
            G_gamestate:change_mode(2)
        end
    end
end

