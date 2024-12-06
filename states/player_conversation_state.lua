PlayerConversationState = State:new()

function PlayerConversationState:init() end
function PlayerConversationState:enter() end
function PlayerConversationState:input(key)
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
function PlayerConversationState:update(dt) end
function PlayerConversationState:render() end
function PlayerConversationState:exit() end

