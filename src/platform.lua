local Platform = {}
Platform.__index = Platform

function Platform:new(x, y, width, height)
    local this = {x = x, y = y, width = width, height = height}
    setmetatable(this, self)
    return this
end

function Platform:draw()
    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1)
end

return Platform
