State = {}

function State:new(params)
    local state = {}
    setmetatable(state, self)
    self.__index = self
    return state
end

function State:init() end
function State:enter() end
function State:input(key) end
function State:update(dt) end
function State:render() end
function State:exit() end

