Conversation = {}
function Conversation:new(entity)
    local conversation = {}
    setmetatable(conversation, self)
    self.__index = self
    self.quips = entity.quips
    self.response = ""
end

function Conversation:get_response()
    self.response = love.textinput
end

