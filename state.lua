G_gamestate = {}
G_blocker = {}
G_blocker.x = 0
G_blocker.y = 0

function G_gamestate:init()
    self.turn = 0
    self.end_turn = false
    self.player_moved = false
    self.attack_queue = {} -- TODO for attack rewrite
    self.update_attacks_animation = false
end

function G_gamestate:start_round()
    print("START OF TURN " .. self.turn)
end

function G_gamestate:end_round()
    self.turn = self.turn + 1
    self.player_moved = false
    self.end_turn = false
end

