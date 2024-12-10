PlayerConversationState = State:new()

function PlayerConversationState:init()
    
end
function PlayerConversationState:enter(params)
    self.map = params.map
    self.player = params.player
    self.conversant 

    self.menu = Menu:new(0, 0)
end

function PlayerConversationState:input(key)

end

function PlayerConversationState:update(dt)
    
end

function PlayerConversationState:render()
    
end

function PlayerConversationState:exit()
    
end

