Player = {}

function Player:new()
    local player = {}
    setmetatable(player, self)
    self.__index = self
    player.name = "Player"
    player.x = 6
    player.y = 4
    player.sprite = G_sprites[26]
    player.hostile = true
    player.stats = {
        ["health"] = 100,
        ["magic"] = 100,
        ["defense"] = 10,
        ["might"] = 10,
        ["grace"] = 10,
        ["mind"] = 10,
        ["soul"] = 10,
    }
    player.inventory = {
        ["lunes"] = 0,
    }
    return player
end

function Player:render()
    love.graphics.draw(G_spritesheet, self.sprite, (self.x-1) * DRAW_FACTOR, (self.y-1) * DRAW_FACTOR, 0, SCALE_FACTOR)
end

function Player:camera()
    love.graphics.translate((-self.x * DRAW_FACTOR) + (SCREEN_WIDTH / 2) -32, (-self.y * DRAW_FACTOR) + (SCREEN_HEIGHT / 2) - 16)
end

function Player:render_stats()
    local health = self.stats["health"]
    local defense = self.stats["defense"]
    
    -- love.math.colorFromBytes(0,191,255)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", 0, SCREEN_HEIGHT - 64, 128, 64) -- TODO MAKE WORD
    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle("line", 0, SCREEN_HEIGHT - 64, 128, 64)
    love.graphics.setColor(1, 1, 1)

    love.graphics.print("Health: " .. health, 3, SCREEN_HEIGHT - 60)
    love.graphics.print("Defense: " .. defense, 3, SCREEN_HEIGHT - 50)
end

function Player:inflict_damage(damage)
    self.stats.health = self.stats.health - damage
end

function Player:die()
    if self.stats["health"] <= 0 then
        return true
    end
end

function Player:give_coins(number)
    self.inventory["lunes"] = self.inventory["lunes"] + number
end