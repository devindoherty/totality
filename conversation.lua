Conversation = {}
function Conversation:new()
    local conversation = {}
    setmetatable(conversation, self)
    self.__index = self
    self.nodes = {}
end