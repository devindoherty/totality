Item = {}

function Item:new()
    local item = {}
    setmetatable(item, self)
    self.__index = self
    return item
end