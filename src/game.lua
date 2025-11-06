local State = require("src.state")
local Game = {}
local Player = require("src.player")
local Camera = require("src.camera")
local Platform = require("src.platform")

function Game:load()
    self.state = State:new("menu")
    self.player = Player:new(100, 500)
    self.camera = Camera:new()
    self.platforms = { Platform:new(-500, 560, 21000, 40) }
end

function Game:update(dt)
    if self.state:is("menu") then
        -- Press Enter to start the game
        if love.keyboard.isDown("return") then
            self.state:set("game")
        end
        return
    end

    if self.state:is("game") then
        self.player:update(dt, self.platforms)
        self.camera:follow(self.player)
    end
end

function Game:draw()
    if self.state:is("menu") then
        love.graphics.printf("Press ENTER to Start", 0, 300, love.graphics.getWidth(), "center")
        return
    end

    love.graphics.push()
    love.graphics.translate(-self.camera.x, -self.camera.y)
    for _, p in ipairs(self.platforms) do p:draw() end
    self.player:draw()
    love.graphics.pop()
end

function Game:keypressed(key)
    self.player:keypressed(key)
end

return Game


