-- That is how to get functions from other files in Love2D
local Game = require("src.game")

-- This is how to create functions, see that 
-- it ends with "end" always
-- Lua first loads this function once at the start of the game
function love.load()
    -- This is how to call functions from other files
    -- see that you use "Game" the name you set earlier than : than the name of the function
    Game:load()
end

-- This function runs every frame, dt is the time since last frame
function love.update(dt)
    Game:update(dt)
end

-- This function draws everything on the screen every frame
function love.draw()
    Game:draw()
end

-- This function runs when a key is pressed
function love.keypressed(key)
    Game:keypressed(key)
end

-- love.load -> love.update -> love.draw -> love.update -> love.draw -> love.update