Conversation = {}
function Conversation:new(entity)
    local conversation = {}
    setmetatable(conversation, self)
    self.__index = self
    self.quips = entity.quips
end

