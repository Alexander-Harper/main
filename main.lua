function love.load()
    love.window.setTitle("My First LÖVE Game!")
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
    message = "Hello, LÖVE!"
end

function love.update(dt)
    -- Game logic goes here
end

function love.draw()
    love.graphics.print(message, 300, 200)
end
