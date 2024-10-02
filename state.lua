State = {}

function State:new(name)
    local state = {}
    setmetatable(state, self)
    self.__index = self
    self.name = name
    return state
end

function State:init() end
function State:enter() end
function State:input() end
function State:update(dt) end
function State:render() end
function State:exit() end

function G_gamestate:init()
    self.turn = 0
    self.end_turn = false
    self.player_moved = false
    self.nearby_interactible = {
        ["creature"] = false,
        ["item"] = false,
        target = nil
    }
    self.attack_queue = {}
    self.action_queue = {}
    self.log = {}
    self.current_dialog = "intro"
    self.mouse = {
        x = 0,
        y = 0
    }
    self.response = {
        active = "",
        entered = "intro",
        answer = ""
    }
end

function G_gamestate:start_round()
    print("START OF TURN " .. self.turn)
    print("Mode: " .. self.current_mode)
end

function G_gamestate:end_round()
    self.turn = self.turn + 1
    self.player_moved = false
    self.end_turn = false
end

function G_gamestate:change_mode(mode)
    self.current_mode = MODES[mode]
end

G_blocker = {}
G_blocker.x = 0
G_blocker.y = 0

function G_update_mouse_position()
    local mx, my = love.mouse.getPosition()
    G_gamestate.mouse.x, G_gamestate.mouse.y = math.floor(mx / 64), math.floor(my / 64)
end

function G_draw_tile_cursor()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setLineWidth(5)
    love.graphics.rectangle("line", G_gamestate.mouse.x * DRAW_FACTOR, G_gamestate.mouse.y * DRAW_FACTOR, 64, 64)
    love.graphics.setLineWidth(1)
    love.graphics.setColor(1, 1, 1)
end