-- New game character creation state

CharacterCreationState = State:new()

function CharacterCreationState:init() 
    -- Main stat menu
    self.menu = Menu:new(SCREEN_WIDTH / 2 - 30, 10, SCREEN_WIDTH, SCREEN_HEIGHT,
        {
            Selection:new("  Might  ", function() end),
            Selection:new("  Grace  ", function() end),
            Selection:new("  Mind  ", function() end),
            Selection:new("  Soul  ", function() end),
            Selection:new(" Portrait ", function() end),
        },
        {
            background=false,
            font = 20,
            spacing = 80
        }
    )

    self.action=""
    self.points = 10
end

function CharacterCreationState:enter(params) 
    self.map = params.map
    self.player = params.player
end

-- Controls input for stat menu
function CharacterCreationState:input(key) 
    if key == "w" or key == "up" or key == "kp8" then
        self.action = "menu_up"
    elseif key == "s" or key == "down" or key == "kp2" then
        self.action = "menu_down"
    elseif key == "enter" or key == "return" then
        self.action = "done"
    elseif key == "a" or key == "left" then
        self.action = "decrement"
    elseif key == "d" or key == "right" then
        self.action = "increment"
    end
end

-- Controls both menu and stat updates
function CharacterCreationState:update(dt) 
    self.menu:update(self.action)

    if self.action == "done" then
        G_gs:change("player_turn_state", {player=self.player, map=self.map})
        return
    end

    if self.action == "decrement" and self.menu.selected == 5 then
        if self.player.portrait_idx > 1 then
            self.player.portrait_idx = self.player.portrait_idx - 1
            self.player:update_portrait()
            self.action = ""
        end
        return
    elseif self.action == "increment" and self.menu.selected == 5 then
        if self.player.portrait_idx < 25 then
            self.player.portrait_idx = self.player.portrait_idx + 1
            self.player:update_portrait()
            self.action = ""
        end
        return
    end

    if self.points > 0 and self.points <= 50 then
        if self.action == "increment" then
            if self.menu.selected == 1 then
                self.player.stats["might"] = self.player.stats.might + 1
            elseif self.menu.selected == 2 then
                self.player.stats["grace"] = self.player.stats.grace + 1
            elseif self.menu.selected == 3 then
                self.player.stats["mind"] = self.player.stats.mind + 1
            elseif self.menu.selected == 4 then
                self.player.stats["soul"] = self.player.stats.soul + 1
            end
            self.points = self.points - 1
        elseif self.action == "decrement" then
            if self.menu.selected == 1 then
                self.player.stats["might"] = self.player.stats.might - 1
            elseif self.menu.selected == 2 then
                self.player.stats["grace"] = self.player.stats.grace - 1
            elseif self.menu.selected == 3 then
                self.player.stats["mind"] = self.player.stats.mind - 1
            elseif self.menu.selected == 4 then
                self.player.stats["soul"] = self.player.stats.soul - 1
            end
            self.points = self.points + 1
        end
    end

    self.action=""
end

function CharacterCreationState:render() 
    self.menu:render()
    local old_font = love.graphics.getFont()
    local new_font = love.graphics.newFont(16)
    love.graphics.printf({GREEN, "Up and down to select different character options. Left and right to change selection. Enter to confirm choices."}, 10, 10, 200)
    love.graphics.printf({WHITE, "Points Remaining: ", self.points}, 10, 200, 200)
    love.graphics.setFont(new_font)
    love.graphics.print("< " .. self.player.stats["might"] .. " >", (SCREEN_WIDTH / 2) - 12, 50) 
    love.graphics.print("< " .. self.player.stats["grace"] .. " >", (SCREEN_WIDTH / 2) - 12, 130)
    love.graphics.print("< " .. self.player.stats["mind"] .. " >", (SCREEN_WIDTH / 2) - 12, 230)
    love.graphics.print("< " .. self.player.stats["soul"] .. " >", (SCREEN_WIDTH / 2) - 12, 330)
    love.graphics.draw(G_portraitsheet, self.player.portrait, (SCREEN_WIDTH / 2) - 20, 425, 0, 2)
    love.graphics.setFont(old_font)
end

function CharacterCreationState:exit() end