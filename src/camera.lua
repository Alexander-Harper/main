local Camera = {}
Camera.__index = Camera

function Camera:new()
    local this = {x = 0, y = 0}
    setmetatable(this, self)
    return this
end

function Camera:follow(player)
    self.x = player.x - 400
    self.y = player.y - 300
end

return Camera