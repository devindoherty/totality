G_gamestate = {}
MODES = {"dialoging", "player_turn", "enemy_turn"}

function G_gamestate:init()
    self.current_mode = MODES[1]
    self.turn = 0
    self.end_turn = false
    self.player_moved = false
    self.attack_queue = {}
    self.action_queue = {}
    self.current_dialog = "intro"
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