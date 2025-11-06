local Player = {}
Player.__index = Player

function Player:new(x, y)
    local this = {
        x = x, y = y,
        width = 40, height = 60,
        speed = 200,
        yVelocity = 0,
        jumpHeight = -400,
        gravity = -800,
        onGround = false,
        image = love.graphics.newImage("sprites/char/guard2.png")
    }
    setmetatable(this, self)
    return this
end

function Player:update(dt, platforms)
    self.yVelocity = self.yVelocity - self.gravity * dt
    self.y = self.y + self.yVelocity * dt

    self.onGround = false
    for _, p in ipairs(platforms) do
        if self.y + self.height > p.y and
           self.x + self.width > p.x and
           self.x < p.x + p.width then
            self.y = p.y - self.height
            self.yVelocity = 0
            self.onGround = true
        end
    end

    if love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    elseif love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    end
end

function Player:keypressed(key)
    if key == "space" and self.onGround then
        self.yVelocity = self.jumpHeight
        self.onGround = false
    end
end

function Player:draw()
    love.graphics.circle("line", self.x + self.width / 2, self.y + self.height / 2, math.max(self.width, self.height) / 2)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Player
