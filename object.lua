Object = {}

function Object:new()
    local object = {}
    setmetatable(object, self)
    self.__index = self
    return object
end